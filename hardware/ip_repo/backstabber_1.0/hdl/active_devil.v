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
        // ACE AC Channel (Snoop)
        input  wire       [C_ACE_ADDR_WIDTH-1:0] i_acaddr,
        input  wire                        [2:0] i_acprot,
        output wire                              o_acready,
        input  wire                        [3:0] i_acsnoop,
        input  wire                              i_acvalid,
        // ACE CD Channel (Snoop data)
        output wire       [C_ACE_DATA_WIDTH-1:0] o_cddata,
        output wire                              o_cdlast,
        input  wire                              i_cdready,
        output wire                              o_cdvalid,
        // ACE CR Channel (Snoop response)
        input  wire                              i_crready,
        output wire                        [4:0] o_crresp,
        output wire                              o_crvalid,
        // ACE AR Channel (Read address phase)
        output wire       [C_ACE_ADDR_WIDTH-1:0] o_araddr,
        output wire                        [1:0] o_arbar,
        output wire                        [1:0] o_arburst,
        output wire                        [3:0] o_arcache,
        output wire                        [1:0] o_ardomain,
        output wire                        [5:0] o_arid,
        output wire                        [7:0] o_arlen,
        output wire                              o_arlock,
        output wire                        [2:0] o_arprot,
        output wire                        [3:0] o_arqos,
        input  wire                              i_arready,
        output wire                        [3:0] o_arregion,
        output wire                        [2:0] o_arsize,
        output wire                        [3:0] o_arsnoop,
        output wire                       [15:0] o_aruser,
        output wire                              o_arvalid,
        // ACE R Channel (Read data phase)
        output wire                              o_rack,
        input  wire       [C_ACE_DATA_WIDTH-1:0] i_rdata,
        input  wire                        [5:0] i_rid,
        input  wire                              i_rlast,
        output wire                              o_rready,
        input  wire                        [3:0] i_rresp,
        input  wire                              i_ruser,
        input  wire                              i_rvalid,
        // ACE AW channel (Write address phase)
        output wire       [C_ACE_ADDR_WIDTH-1:0] o_awaddr,
        output wire                        [1:0] o_awbar,
        output wire                        [1:0] o_awburst,
        output wire                        [3:0] o_awcache,
        output wire                        [1:0] o_awdomain,
        output wire                        [5:0] o_awid,
        output wire                        [7:0] o_awlen,
        output wire                              o_awlock,
        output wire                        [2:0] o_awprot,
        output wire                        [3:0] o_awqos,
        input  wire                              i_awready,
        output wire                        [3:0] o_awregion,
        output wire                        [2:0] o_awsize,
        output wire                        [2:0] o_awsnoop,
        output wire                       [15:0] o_awuser,
        output wire                              o_awvalid,
        // ACE W channel (Write data phase)
        output wire                              o_wack,
        output wire       [C_ACE_DATA_WIDTH-1:0] o_wdata,
        output wire                        [5:0] o_wid,
        output wire                              o_wlast,
        input  wire                              i_wready,
        output wire                       [15:0] o_wstrb,
        output wire                              o_wuser,
        output wire                              o_wvalid,
        // ACE B channel (Write response)
        input  wire                        [5:0] i_bid,
        output wire                              o_bready,
        input  wire                        [1:0] i_bresp,
        input  wire                              i_buser,
        input  wire                              i_bvalid,

        input  wire                        [3:0] i_snoop_state,
        output wire       [DEVIL_STATE_SIZE-1:0] o_fsm_devil_state_active,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_control_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_read_status_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_delay_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_acsnoop_reg,  
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_base_addr_reg,  
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_addr_size_reg,  
        output wire                              o_end,
        input  wire                              i_trigger_active,
        output wire                              o_reply,
        output wire                              o_busy,
        input  wire       [C_ACE_ADDR_WIDTH-1:0] i_acaddr_snapshot,
        input  wire                        [3:0] i_acsnoop_snapshot,

        // Internal Signals, from Devil Passive to Devil Active
        input wire                         [3:0] i_func,
        input wire                               i_internal_adl_en,
        input wire                               i_internal_adt_en,
        input wire        [C_ACE_ADDR_WIDTH-1:0] i_internal_araddr,
        input wire        [C_ACE_ADDR_WIDTH-1:0] i_external_araddr,
        input wire                         [3:0] i_internal_arsnoop,
        input wire                         [3:0] i_external_arsnoop,
        input wire                         [1:0] i_internal_ardomain,
        input wire                         [1:0] i_external_ardomain,
        input wire                               i_trigger_from_passive,
        input wire        [C_ACE_ADDR_WIDTH-1:0] i_internal_awaddr,
        input wire        [C_ACE_ADDR_WIDTH-1:0] i_external_awaddr,
        input wire                         [2:0] i_internal_awsnoop,
        input wire                         [2:0] i_external_awsnoop,

        output wire   [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line, 
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line

    );

//------------------------------------------------------------------------------
// FSM STATES AND DEFINES
//------------------------------------------------------------------------------
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

    `define WRAP                2'b10
    `define INCR                2'b01

//------------------------------------------------------------------------------
// WIRES
//------------------------------------------------------------------------------
    wire                        w_ar_phase;
    wire                        w_r_phase;
    wire                        w_rack_phase;
    wire                        w_aw_phase;
    wire                        w_w_phase;
    wire                        w_b_phase;
    wire                        w_wack_phase;
    wire [C_ACE_DATA_WIDTH-1:0] w_wdata;
    wire                        w_snooping;
    wire                        w_rready;
    wire                        w_wvalid;
    wire                        w_wlast;
    wire                        w_bready;

//------------------------------------------------------------------------------
// REGISTERS
//------------------------------------------------------------------------------
    reg [C_S_AXI_DATA_WIDTH-1:0] r_status_reg;     
    reg   [DEVIL_STATE_SIZE-1:0] fsm_devil_state_active;        
    reg                          r_end_op_active;
    reg                          r_reply_active;
    reg                  [127:0] r_buff[3:0]; // 4 elements of 16 bytes
    reg                    [1:0] r_index_active;

//------------------------------------------------------------------------------
// ACE INTERFACE 
//------------------------------------------------------------------------------
     // ACE AC Channel (Snoop)
    // (Not used for now!)
    assign o_acready    = 0;

    // ACE CD Channel (Snoop data)
    // (Not used for now!)
    assign o_cddata     = 0;
    assign o_cdlast     = 0;
    assign o_cdvalid    = 0;

    // ACE CR Channel (Snoop response)
    // (Not used for now!)
    assign o_crresp     = 0;
    assign o_crvalid    = 0;
    
    // ACE AR Channel (Read address phase)
    assign o_araddr     = (w_ar_phase && i_arready) ? ( i_trigger_from_passive ? i_internal_araddr : i_external_araddr ) : 0;
    assign o_arbar      = 2'b0;
    assign o_arburst    = `WRAP;
    assign o_arcache    = 4'h3; // Read-Allocate //Refer to page 64 of manual. 
    // TODO: Change this -> o_ardomain
    assign o_ardomain   = (w_ar_phase && i_arready) ? ( i_trigger_from_passive ? i_internal_ardomain : i_external_ardomain ) : 0;
    assign o_arid       = 0;
    assign o_arlen      = (w_ar_phase && i_arready) || (w_snooping) ? 8'h3: 8'h0; // Set to 7'h3 for 4 bursts of 16B (128 bits) to match 64B cache line size
    assign o_arlock     = 0;
    assign o_arprot     = 3'b011; // [2] Instruction access, [1] Non-secure access, [0] Privileged 
    assign o_arqos      = 0;
    assign o_arregion   = 0;
    assign o_arsize     = 3'b100; //Size of each burst is 16B
    assign o_arsnoop    = (w_ar_phase && i_arready) ? ( i_trigger_from_passive ? i_internal_arsnoop : i_external_arsnoop ) : 0;
    assign o_aruser     = 0;
    assign o_arvalid    = (w_ar_phase && i_arready);

    // ACE R Channel (Read data phase)
    assign o_rack =  w_rack_phase;
    assign o_rready = w_rready;
    assign w_rready = w_ar_phase  || w_r_phase;

    // ACE AW channel (Write address phase)
    assign o_awaddr = (w_aw_phase && i_awready) ? ( i_trigger_from_passive ? i_internal_awaddr : i_external_awaddr ) : 0;
    assign o_awbar    = 2'b0;
    assign o_awburst  = `INCR;  
    assign o_awcache  = 4'b1111; // Write-back Write-allocate, Refer to page 65 of manual. 
    assign o_awdomain = (w_aw_phase && i_awready) ? 2'b10 : 2'b00; // outer shareable  
    assign o_awid     = 0;
    assign o_awlen    = (w_aw_phase && i_awready) ? 8'h3: 8'h0; // Set to 7'h3 for 4 bursts of 16B (128 bits) to match 64B cache line size
    assign o_awlock   = 0;
    assign o_awprot   = 3'b011; // [2] Instruction access, [1] Non-secure access, [0] Privileged
    assign o_awqos    = 0;
    assign o_awregion = 0;
    assign o_awsize   = 3'b100; //Size of each burst is 16B (data-bus of 128 bits )
    assign o_awsnoop  = (w_aw_phase && i_awready) ? (i_trigger_from_passive ? i_internal_awsnoop : i_external_awsnoop ) : 0;
    assign o_awuser   = 0;
    assign o_awvalid  = w_aw_phase && i_awready; 

    // ACE W channel (Write data phase)
    assign o_wack   = w_wack_phase;
    assign o_wdata  =  w_w_phase ? w_wdata : 0; // Writing 16B (128bits) 4x times
    assign o_wid    = 0;
    assign o_wlast  = w_wlast;
    assign w_wlast  =  (r_index_active == 3);
    assign o_wstrb  = 16'hffff; // Activate all strobes, we have a data-bus of 128 bits
    assign o_wuser  = 0;
    assign o_wvalid = w_wvalid;
    assign w_wvalid = w_w_phase;

    // ACE B channel (Write response)
    assign o_bready = w_bready;
    assign w_bready = w_b_phase;
    

//------------------------------------------------------------------------------
// GENERIC OUTPUT SIGNALS
//------------------------------------------------------------------------------
    // Read and Write channel Flags (Active Path)
    assign w_ar_phase   = (fsm_devil_state_active == DEVIL_AR_PHASE)   ? 1:0;
    assign w_r_phase    = (fsm_devil_state_active == DEVIL_R_PHASE)    ? 1:0;
    assign w_rack_phase = (fsm_devil_state_active == DEVIL_RACK)       ? 1:0;
    assign w_aw_phase   = (fsm_devil_state_active == DEVIL_AW_PHASE)   ? 1:0;
    assign w_w_phase    = (fsm_devil_state_active == DEVIL_W_PHASE)    ? 1:0;
    assign w_b_phase    = (fsm_devil_state_active == DEVIL_B_PHASE)    ? 1:0;
    assign w_wack_phase = (fsm_devil_state_active == DEVIL_WACK)       ? 1:0;
    
    // ACE W Channel Write Data 
    assign w_wdata = r_index_active == 1 ? i_cache_line[127+128*1:0+128*1]: 
                     r_index_active == 2 ? i_cache_line[127+128*2:0+128*2]: 
                     r_index_active == 3 ? i_cache_line[127+128*3:0+128*3]: 
                     i_cache_line[127+128*0:0+128*0]; // 128 bits

    assign o_cache_line             = { r_buff[3], 
                                        r_buff[2], 
                                        r_buff[1], 
                                        r_buff[0]};
   
    assign o_fsm_devil_state_active = fsm_devil_state_active; 
    assign o_end                    = r_end_op_active;
    assign o_reply                  = r_reply_active;
    assign o_busy                   = (fsm_devil_state_active != DEVIL_IDLE);
    
    assign w_snooping   =   (fsm_devil_state_active != DEVIL_IDLE)
                        &&  (fsm_devil_state_active != DEVIL_FUNCTION)
                        &&  (fsm_devil_state_active != DEVIL_END_OP );

//------------------------------------------------------------------------------
// DEVIL-IN-THE-FPGA CONTROL REGISTERS
//------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------
// FSM
//------------------------------------------------------------------------------

    // Active FSM -> To Issue Write and Read Snoops
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
                            if (w_adl_en || i_internal_adl_en) 
                                fsm_devil_state_active <= DEVIL_READ_SNOOP;  
                            else
                                fsm_devil_state_active <= DEVIL_END_OP;
                        end
                        `ADT  :
                        begin
                            if (w_adt_en || i_internal_adt_en)
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
                    if (w_rready && i_rvalid) begin 
                        r_index_active <= r_index_active + 1;
                        r_buff[r_index_active] <= i_rdata;
                    end

                    if (w_rready && i_rvalid && i_rlast) 
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
                    if (i_wready && w_wvalid) begin 
                        r_index_active <= r_index_active + 1;
                        if(r_index_active == 3) // to assert wlast for 1 clock
                            r_index_active <= 0;
                    end

                    if (i_wready && w_wvalid && w_wlast) 
                        fsm_devil_state_active <= DEVIL_B_PHASE;
                    else
                        fsm_devil_state_active <= fsm_devil_state_active;
                end
            DEVIL_B_PHASE: //18
                begin
                    if ((i_bresp == `OKAY) && i_bvalid && w_bready) 
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

