`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 01:45:53 PM
// Design Name: 
// Module Name: active_devil
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "devil_in_fpga.vh"

module active_devil #(
        parameter integer C_S_AXI_DATA_WIDTH    = 32, 
        parameter integer C_ACE_DATA_WIDTH      = 128,
        parameter integer C_ACE_ADDR_WIDTH      = 44,
        parameter integer DEVIL_STATE_SIZE      = 5 // 32 states
        )
        (
        input  wire                              ace_aclk,
        input  wire                              ace_aresetn,
        input  wire                        [3:0] acsnoop,
        input  wire       [C_ACE_ADDR_WIDTH-1:0] acaddr,
        input  wire                        [7:0] i_arlen,
        input  wire                        [3:0] i_snoop_state,
        output wire       [DEVIL_STATE_SIZE-1:0] o_fsm_devil_state_active,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_control_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_read_status_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_delay_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_acsnoop_reg,  
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_base_addr_reg,  
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_addr_size_reg,  
        output wire                              o_end,
        input  wire                              i_crready,
        input  wire                              i_trigger_active,
        output wire                              o_reply,
        output wire                              o_busy,
        input  wire                              i_cdready,
        input  wire       [C_ACE_ADDR_WIDTH-1:0] i_acaddr_snapshot,
        input  wire                        [3:0] i_acsnoop_snapshot,
        output wire                              o_ar_phase,
        output wire                              o_r_phase,
        output wire                              o_rack_phase,
        output wire                              o_aw_phase,
        output wire                              o_w_phase,
        output wire                              o_b_phase,
        output wire                              o_wack_phase,
        output wire                              o_wlast,
        output wire       [C_ACE_DATA_WIDTH-1:0] o_wdata,
        input wire                               i_arready,
        input wire                               i_rready,
        input wire                               i_rvalid,
        input wire        [C_ACE_DATA_WIDTH-1:0] i_rdata,
        input wire                               i_rlast,
        input wire                               i_awready,
        input wire                               i_wready,
        input wire                               i_wvalid,
        input wire                               i_wlast,
        input wire                         [1:0] i_bresp,
        input wire                               i_bvalid,
        input wire                               i_bready,
        input wire                         [3:0] i_func,
        output wire                              o_snooping,
        output wire   [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line, 
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line
    );

    parameter [DEVIL_STATE_SIZE-1:0]    DEVIL_IDLE              = 0,
                                        DEVIL_FUNCTION          = 1,
                                        DEVIL_END_OP            = 2,
                                        DEVIL_READ_SNOOP        = 3, 
                                        DEVIL_WRITE_SNOOP       = 4, 
                                        DEVIL_AR_PHASE          = 5,
                                        DEVIL_R_PHASE           = 6,
                                        DEVIL_RACK              = 7,
                                        DEVIL_AW_PHASE          = 8,
                                        DEVIL_W_PHASE           = 9,
                                        DEVIL_B_PHASE           = 10,
                                        DEVIL_WACK              = 11;



    // Internal Registers
    reg [C_S_AXI_DATA_WIDTH-1:0] r_status_reg;     
    reg   [DEVIL_STATE_SIZE-1:0] fsm_devil_state_active;        
    reg                          r_end_op_active;
    reg                          r_reply_active;
    reg                  [127:0] r_buff[3:0]; // 4 elements of 16 bytes
    reg                    [1:0] r_index_active;

    assign o_cache_line = {r_buff[3], r_buff[2], r_buff[1], r_buff[0]};
    assign o_wdata = r_index_active == 1 ? i_cache_line[127+128*1:0+128*1]: 
                     r_index_active == 2 ? i_cache_line[127+128*2:0+128*2]: 
                     r_index_active == 3 ? i_cache_line[127+128*3:0+128*3]: 
                     i_cache_line[127+128*0:0+128*0]; // 128 bits

    assign o_fsm_devil_state_active = fsm_devil_state_active; 
    assign o_end = r_end_op_active;
    // assign o_acready = w_acready;
    assign o_reply = r_reply_active;
    assign o_busy = (fsm_devil_state_active != DEVIL_IDLE);

    // Read and Write channel Flags (Active Path)
    assign o_ar_phase   = (fsm_devil_state_active == DEVIL_AR_PHASE)   ? 1:0;
    assign o_r_phase    = (fsm_devil_state_active == DEVIL_R_PHASE)    ? 1:0;
    assign o_rack_phase = (fsm_devil_state_active == DEVIL_RACK)       ? 1:0;
    assign o_aw_phase   = (fsm_devil_state_active == DEVIL_AW_PHASE)   ? 1:0;
    assign o_w_phase    = (fsm_devil_state_active == DEVIL_W_PHASE)    ? 1:0;
    assign o_b_phase    = (fsm_devil_state_active == DEVIL_B_PHASE)    ? 1:0;
    assign o_wack_phase = (fsm_devil_state_active == DEVIL_WACK)       ? 1:0;

    assign o_snooping   =   (fsm_devil_state_active != DEVIL_IDLE)
                        &&  (fsm_devil_state_active != DEVIL_FUNCTION)
                        &&  (fsm_devil_state_active != DEVIL_END_OP );
    // Write Channel Signals
    assign o_wlast = (r_index_active == 3);

// Devil-in-the-fpga Control Reg parameters/bits
    wire       w_en;
    wire [3:0] w_test;
    wire [3:0] w_func;
    wire [4:0] w_crresp;
    wire       w_acf_lt;    
    wire       w_addr_flt;    
    wire       w_con_en;    
    wire       w_osh_en;    
    wire       w_adl_en; // Active Data Leak Enable    
    wire       w_adt_en; // Active Data Tampering Enable   
    wire       w_pdt_en; // Passive Data Tampering Enable

    assign w_en = i_control_reg[0];
    assign w_test = i_control_reg[4:1];
    assign w_func = i_func;
    // assign w_func = i_control_reg[8:5];
    assign w_crresp = i_control_reg[13:9];
    assign w_acf_lt = i_control_reg[14];
    assign w_addr_flt = i_control_reg[15];
    assign w_osh_en = i_control_reg[16];
    assign w_con_en = i_control_reg[17];
    assign w_adl_en = i_control_reg[18]; // Active Data Leak Enable   
    assign w_adt_en = i_control_reg[19]; // Active Data Tampering Enable
    assign w_pdt_en = i_control_reg[20]; // Passive Data Tampering Enable

    // Active Path -> Issue Write and Read Snoops
    always @(posedge ace_aclk)
    begin
    if(~ace_aresetn)
        begin
        r_index_active <= 0;
        r_reply_active <= 0;
        r_end_op_active <= 0;
        fsm_devil_state_active <= DEVIL_IDLE;
        end 
    else
        begin
            case (fsm_devil_state_active)                                                                                                                                 
            DEVIL_IDLE: 
                begin
                    r_reply_active <= 0;
                    r_index_active <= 0; 

                    if(i_trigger_active && !r_end_op_active)
                        fsm_devil_state_active <= DEVIL_FUNCTION;     
                    else 
                        fsm_devil_state_active <= DEVIL_IDLE;

                    if(!i_trigger_active)
                    begin
                        // To avoid retriggring the module
                        r_end_op_active <= 0;    
                    end                  
                end
            DEVIL_FUNCTION: // 6
                begin
                    case (w_func[3:0])
                        `OSH  : 
                        begin
                            fsm_devil_state_active <= DEVIL_END_OP;
                        end
                        `CON  : 
                        begin
                            fsm_devil_state_active <= DEVIL_END_OP;
                        end
                        `ADL  :
                        begin
                            if (w_adl_en)
                                fsm_devil_state_active <= DEVIL_READ_SNOOP;  
                            else
                                fsm_devil_state_active <= DEVIL_END_OP;
                        end
                        `ADT  :
                        begin
                            if (w_adt_en)
                                fsm_devil_state_active <= DEVIL_WRITE_SNOOP;  
                            else
                                fsm_devil_state_active <= DEVIL_END_OP;
                        end
                        `PDT  :
                        begin
                            fsm_devil_state_active <= DEVIL_END_OP;
                        end
                        default : fsm_devil_state_active <= DEVIL_END_OP; 
                    endcase                                                      
                end
            DEVIL_READ_SNOOP: // 10
                begin
                    fsm_devil_state_active <= DEVIL_AR_PHASE;                                                  
                    // TO IMPLEMENT
                end
            DEVIL_WRITE_SNOOP: // 11
                begin
                    fsm_devil_state_active <= DEVIL_AW_PHASE;                                                  
                    // TO IMPLEMENT
                end
            DEVIL_AR_PHASE: //13
                begin
                    if (i_arready)  
                        fsm_devil_state_active <= DEVIL_R_PHASE;
                    else
                        fsm_devil_state_active <= fsm_devil_state_active;
                end
            DEVIL_R_PHASE: //14
                begin
                    if (i_rready && i_rvalid) begin 
                        r_index_active <= r_index_active + 1;
                        r_buff[r_index_active] <= i_rdata;
                    end

                    if (i_rready && i_rvalid && i_rlast) 
                        fsm_devil_state_active <= DEVIL_RACK;
                    else
                        fsm_devil_state_active <= fsm_devil_state_active;
                end
            DEVIL_RACK: //15
                begin
                    fsm_devil_state_active <= DEVIL_END_OP;
                end
            DEVIL_AW_PHASE: //16
                begin
                    if (i_awready)  
                        fsm_devil_state_active <= DEVIL_W_PHASE;
                    else
                        fsm_devil_state_active <= fsm_devil_state_active;
                        end
            DEVIL_W_PHASE: //17
                begin
                    if (i_wready && i_wvalid) begin 
                        r_index_active <= r_index_active + 1;
                        if(r_index_active == 3) // to assert wlast for 1 clock
                            r_index_active <= 0;
                    end

                    if (i_wready && i_wvalid && i_wlast) 
                        fsm_devil_state_active <= DEVIL_B_PHASE;
                    else
                        fsm_devil_state_active <= fsm_devil_state_active;
                end
            DEVIL_B_PHASE: //18
                begin
                    if ((i_bresp == `OKAY) && i_bvalid && i_bready) 
                        fsm_devil_state_active <= DEVIL_WACK;
                    else
                        fsm_devil_state_active <= fsm_devil_state_active;
                end
            DEVIL_WACK: //19
                begin
                    fsm_devil_state_active <= DEVIL_END_OP;
                end
            DEVIL_END_OP: // 7 
                begin 
                    r_end_op_active <= 1;
                    r_reply_active <= 1;
                    fsm_devil_state_active <= DEVIL_IDLE;                                                  
                end
            default :                                                                
                begin                                                                  
                    fsm_devil_state_active <= DEVIL_IDLE;                                     
                end                                                                    
            endcase            
        end
    end        

endmodule

