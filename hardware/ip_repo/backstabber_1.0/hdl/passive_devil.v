`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 01:45:53 PM
// Design Name: 
// Module Name: passive_devil
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

module passive_devil #(
        parameter integer C_S_AXI_DATA_WIDTH    = 32, 
        parameter integer C_ACE_DATA_WIDTH      = 128,
        parameter integer C_ACE_ADDR_WIDTH      = 44,
        parameter integer CTRL_IN_SIGNAL_WIDTH  = 1, 
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
        
        input  wire                        [3:0] i_snoop_state,
        output wire       [DEVIL_STATE_SIZE-1:0] o_fsm_devil_state_passive,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_control_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_read_status_reg,
        output wire     [C_S_AXI_DATA_WIDTH-1:0] o_write_status_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_delay_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_acsnoop_reg,  
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_base_addr_reg,  
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_addr_size_reg,  
        output wire                              o_end,
        input  wire                              i_trigger_passive,
        output wire                              o_trigger_active,
        output wire                              o_reply,
        output wire                              o_busy,
        input  wire       [C_ACE_ADDR_WIDTH-1:0] i_acaddr_snapshot,
        input  wire                        [3:0] i_acsnoop_snapshot,
        output wire                              o_responding,
        input wire                               i_active_end,
        output wire                              o_action_taken, 

        // Internal Signals, from Devil Passive to Devil Active
        output wire                        [3:0] o_internal_func, 
        output wire       [C_ACE_ADDR_WIDTH-1:0] o_internal_araddr,
        output wire                        [3:0] o_internal_arsnoop,
        output wire       [C_ACE_ADDR_WIDTH-1:0] o_internal_awaddr,
        output wire                        [2:0] o_internal_awsnoop,
        output wire                        [1:0] o_internal_ardomain,
        output wire                              o_internal_adl_en,
        output wire                              o_internal_adt_en,
        output wire                              o_external_mode,

        // Internal Signals, from devil controller to devil passive
        input wire    [CTRL_IN_SIGNAL_WIDTH-1:0] i_controller_signals,
        input wire    [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line_2_monitor, 
        input wire                               i_reply_type,

        // Internal Signals, Controller In/Out Cache Line
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line, 

        output wire                       [63:0] o_counter // test porpuses
    );

//------------------------------------------------------------------------------
// FSM STATES AND DEFINES
//------------------------------------------------------------------------------
    parameter [DEVIL_STATE_SIZE-1:0]    DEVIL_IDLE                  = 0,
                                        DEVIL_ONE_SHOT_DELAY        = 1,
                                        DEVIL_CONTINUOS_DELAY       = 2,
                                        DEVIL_RESPONSE              = 3,
                                        DEVIL_DELAY                 = 4,
                                        DEVIL_FILTER                = 5,
                                        DEVIL_FUNCTION              = 6,
                                        DEVIL_END_OP                = 7,
                                        DEVIL_DUMMY_REPLY           = 8,
                                        DEVIL_END_REPLY             = 9,
                                        DEVIL_REPLY                 = 10,
                                        DEVIL_MONITOR_TRANS         = 11,
                                        DEVIL_TAKE_ACTIONS          = 12,
                                        DEVIL_SNOOP_RESPONSE        = 13, 
                                        DEVIL_MONITOR_TRANS_WAIT    = 14;

    `define WRAP                2'b10
    `define INCR                2'b01

//------------------------------------------------------------------------------
// WIRES
//------------------------------------------------------------------------------
    wire        w_ac_filter;
    wire        w_addr_filter;
    wire  [7:0] w_arlen;
    
//------------------------------------------------------------------------------
// REGISTERS
//------------------------------------------------------------------------------
    reg [C_S_AXI_DATA_WIDTH-1:0] r_status_reg;
    reg   [DEVIL_STATE_SIZE-1:0] fsm_devil_state_passive;          
    reg                    [4:0] r_crresp;
    reg                          r_crvalid;
    reg                          r_cdvalid;
    reg                          r_cdlast;
    reg   [C_ACE_DATA_WIDTH-1:0] r_rdata;
    reg                   [63:0] r_counter; 
    reg                          r_end_op;
    reg                          r_reply;
    reg   [DEVIL_STATE_SIZE-1:0] r_return;
    reg                    [7:0] r_burst_cnt;
    reg                          r_trigger_active;
    reg                          r_action_taken;
    reg                    [3:0] r_active_func;
    reg                          r_internal_adl_en;
    reg                          r_internal_adt_en;
    reg   [C_ACE_ADDR_WIDTH-1:0] r_araddr;
    reg                    [3:0] r_arsnoop;
    reg   [C_ACE_ADDR_WIDTH-1:0] r_awaddr;
    reg                    [2:0] r_awsnoop;
    reg                    [1:0] r_ardomain;

//------------------------------------------------------------------------------
// ACE INTERFACE 
//------------------------------------------------------------------------------
    // ACE AC Channel (Snoop)
    // (Not used for now!)
    assign o_acready    = 0;

    // ACE CD Channel (Snoop data)
    assign o_cddata     = r_rdata;
    assign o_cdlast     = r_cdlast;
    assign o_cdvalid    = r_cdvalid;

    // ACE CR Channel (Snoop response)
    assign o_crresp     = r_crresp;
    assign o_crvalid    = r_crvalid;

    // Set to 7'h3 for 4 bursts of 16B (128 bits) to match 64B cache line size
    assign w_arlen      = 8'h3; 

//------------------------------------------------------------------------------
// DEVIL-IN-THE-FPGA CONTROL REGISTERS
//------------------------------------------------------------------------------
    // Devil-in-the-fpga Control Reg parameters/bits
    // TODO: Put this in a common file with the bits in 
    wire       w_en;
    wire [4:0] w_crresp;
    wire       w_acf_lt;    
    wire       w_addr_flt;    
    wire       w_adl_en; // Active Data Leak Enable    
    wire       w_adt_en; // Active Data Tampering Enable   
    wire       w_one_shot; // Passive Data Tampering Enable
    wire       w_mon_en; // Enable Transactions Monitor

    assign w_en = i_control_reg[0];
    assign w_crresp = i_control_reg[13:9];
    assign w_acf_lt = i_control_reg[14];
    assign w_addr_flt = i_control_reg[15];
    assign w_adl_en = i_control_reg[18]; // Active Data Leak Enable   
    assign w_adt_en = i_control_reg[19]; // Active Data Tampering Enable
    assign w_one_shot = i_control_reg[20]; 
    assign w_mon_en = i_control_reg[21]; 

//------------------------------------------------------------------------------
// GENERIC OUTPUT SIGNALS
//------------------------------------------------------------------------------
    assign o_fsm_devil_state_passive    = fsm_devil_state_passive;  
    assign o_write_status_reg           = r_status_reg;
    assign o_internal_araddr            = r_araddr;
    assign o_internal_arsnoop           = r_arsnoop;
    assign o_internal_awaddr            = r_awaddr;
    assign o_internal_awsnoop           = r_awsnoop;
    assign o_internal_ardomain          = r_ardomain; 
    assign o_end                        = r_end_op;

    assign o_counter    = r_counter;
    assign o_reply      = r_reply;
    assign o_busy       = (fsm_devil_state_passive != DEVIL_IDLE);
    assign o_responding = (fsm_devil_state_passive == DEVIL_SNOOP_RESPONSE || fsm_devil_state_passive == DEVIL_REPLY);

    assign o_internal_func      = r_active_func;
    assign o_trigger_active     = r_trigger_active;
    assign o_action_taken       = r_action_taken;
    assign o_external_mode      = (w_adl_en || w_adt_en); // Informes when an action is trigger by PS 
    assign o_internal_adl_en    = r_internal_adl_en;
    assign o_internal_adt_en    = r_internal_adt_en;

    // ac and addr filters are applied to the acaddr and acsnoop at the time of
    //the achandshake, bacause once the handshake happens, a new snoop is generated
    assign w_ac_filter      = (i_acsnoop_snapshot[3:0] == i_acsnoop_reg[3:0]) ? 1 : 0;
    assign w_addr_filter    = (i_acaddr_snapshot[31:0] >= i_base_addr_reg[31:0]) && (i_acaddr_snapshot[31:0] < (i_base_addr_reg[31:0] + i_addr_size_reg[31:0])) ? 1 : 0;

//------------------------------------------------------------------------------
// INPUT/OUTPUT SIGNALS - DEVIL CONTROLLER
//-----------------------------------------------------------------------------
    `include "devil_ctrl_interfaces.vh"

//------------------------------------------------------------------------------
// FSM
//------------------------------------------------------------------------------
    always @(posedge ace_aclk)
    begin
    if(~ace_aresetn)
        begin
        r_active_func <= 0;
        r_reply <= 0;
        r_end_op <= 0;
        r_cdlast <= 0;
        r_crresp <= 0;
        r_rdata  <= 0;
        r_araddr <= 0;
        r_awaddr <= 0;
        r_crvalid <= 0;
        r_cdvalid <= 0;
        r_counter <= 0;
        r_arsnoop <= 0;
        r_awsnoop <= 0;
        r_ardomain <= 0;
        r_burst_cnt <= 0;
        r_status_reg <= 0;
        r_action_taken <= 0; 
        r_trigger_active <= 0;
        r_internal_adl_en <= 0;
        r_internal_adt_en <= 0;
        fsm_devil_state_passive <= DEVIL_IDLE;
        end 
    else
        begin
            case (fsm_devil_state_passive)                                                                                                                                 
            DEVIL_IDLE: 
                begin
                    r_reply <= 0;
                    
                    if(i_trigger_passive)
                        fsm_devil_state_passive <= DEVIL_FILTER;     
                    else 
                        fsm_devil_state_passive <= DEVIL_IDLE;

                    if(r_end_op && !w_en)
                    begin
                        // Clean the end bit when the user disbales the IP
                        // Forces the user to set the end bit to 0 before using
                        // the IP again
                        r_end_op <= 0;    
                    end                  
                end
            DEVIL_FILTER: // 5
                begin
                    case ({w_addr_flt, w_acf_lt})
                        `NO_FILTER  : 
                        begin
                            fsm_devil_state_passive <= DEVIL_TAKE_ACTIONS;
                        end
                        `AC_FILTER  : 
                        begin
                            if(w_ac_filter)
                                fsm_devil_state_passive <= DEVIL_TAKE_ACTIONS;
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        `ADDR_FILTER  : 
                        begin
                            if(w_addr_filter)
                                fsm_devil_state_passive <= DEVIL_TAKE_ACTIONS;  
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        `AC_ADDR_FILTER  : 
                        begin
                            if(w_addr_filter && w_ac_filter)
                                fsm_devil_state_passive <= DEVIL_TAKE_ACTIONS;  
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        default : fsm_devil_state_passive <= DEVIL_DUMMY_REPLY; 
                    endcase                                                     
                end
            DEVIL_TAKE_ACTIONS:
                begin
                    // wait for the devil controller signal to keep going
                    // Devil Control is what controls the progress of the snoop
                    // response, regardeless of the operation mode of the Trojan
                    // i.e., monitor enabled or not
                    if(w_reply) 
                        if(i_reply_type == `DATA_REPLY )
                            fsm_devil_state_passive <= DEVIL_SNOOP_RESPONSE;
                        else 
                            fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                    else
                        fsm_devil_state_passive <= fsm_devil_state_passive;

                    // end
                end
            DEVIL_DUMMY_REPLY: // 8
                begin
                    if (i_crready)
                    begin
                            r_crresp <= 0;
                            r_rdata <= 0;
                            r_crvalid <= 1;
                            fsm_devil_state_passive  <= DEVIL_END_REPLY;
                    end                           
                    else
                        fsm_devil_state_passive <= fsm_devil_state_passive;
                end
            DEVIL_SNOOP_RESPONSE: // D (13)
                begin
                    if (i_crready) 
                    begin                                     
                        r_crvalid <= 1;
                        r_crresp <= w_crresp[4:0];
                        fsm_devil_state_passive <= DEVIL_REPLY;
                    end else 
                        fsm_devil_state_passive <= fsm_devil_state_passive;
                end
            DEVIL_REPLY: // A (10)
                begin
                    if (i_crready)                                      
                    begin                            
                        r_crvalid <= 0;
                        r_crresp <= 0;
                        r_cdvalid <= 1; 
                        if(i_cdready) begin // cdvalid/ data must not change until cdready is asserted   
                            r_burst_cnt <= r_burst_cnt + 1;
                            r_rdata <=  r_burst_cnt == 1 ? i_cache_line[127+128*1:0+128*1]: 
                                        r_burst_cnt == 2 ? i_cache_line[127+128*2:0+128*2]: 
                                        r_burst_cnt == 3 ? i_cache_line[127+128*3:0+128*3]: 
                                        i_cache_line[127+128*0:0+128*0]; 
                            if( (w_arlen == 0) || (r_burst_cnt == w_arlen)) 
                            begin // last reply
                                r_cdlast <= 1;   
                                if(w_one_shot)                        
                                    fsm_devil_state_passive  <= DEVIL_END_OP;  
                                else
                                    fsm_devil_state_passive  <= DEVIL_END_REPLY;  
                            end
                            else
                                fsm_devil_state_passive <= fsm_devil_state_passive;
                        end
                        else
                            fsm_devil_state_passive <= fsm_devil_state_passive;
                    end  
                    else
                        fsm_devil_state_passive <= fsm_devil_state_passive;
                end
            DEVIL_END_OP: // 7 State to signal the End of the FSM operation
                begin
                    r_crresp <= 0;
                    r_crvalid <= 0;
                    r_cdvalid <= 0;
                    r_cdlast <= 0;
                    r_burst_cnt <= 0;
                    r_status_reg[0] <= 0;    
                    r_end_op <= 1;
                    r_reply <= 1;
                    r_action_taken <= 0; 
                    fsm_devil_state_passive <= DEVIL_IDLE;                                                  
                end
            DEVIL_END_REPLY: // 9 State to signal the End of a reply
                begin
                    r_crresp <= 0;
                    r_crvalid <= 0;
                    r_cdvalid <= 0;
                    r_cdlast <= 0;
                    r_burst_cnt <= 0;
                    r_status_reg[0] <= 0;    
                    r_reply <= 1;
                    r_action_taken <= 0; 
                    fsm_devil_state_passive <= DEVIL_IDLE;                                                  
                end
            default :                                                                
                begin                                                                  
                    fsm_devil_state_passive <= DEVIL_IDLE;                                     
                end                                                                    
            endcase            
        end
    end      

endmodule

