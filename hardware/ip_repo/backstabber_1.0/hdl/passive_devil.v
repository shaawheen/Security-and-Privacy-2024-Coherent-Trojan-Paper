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
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line, 
        output wire                              o_action_taken,
        output wire                              o_trans_monitored, 

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

        output wire                       [63:0] o_counter // test porpuses
    );

//------------------------------------------------------------------------------
// FSM STATES AND DEFINES
//------------------------------------------------------------------------------
    parameter [DEVIL_STATE_SIZE-1:0]    DEVIL_IDLE              = 0,
                                        DEVIL_ONE_SHOT_DELAY    = 1,
                                        DEVIL_CONTINUOS_DELAY   = 2,
                                        DEVIL_RESPONSE          = 3,
                                        DEVIL_DELAY             = 4,
                                        DEVIL_FILTER            = 5,
                                        DEVIL_FUNCTION          = 6,
                                        DEVIL_END_OP            = 7,
                                        DEVIL_DUMMY_REPLY       = 8,
                                        DEVIL_END_REPLY         = 9,
                                        DEVIL_REPLY             = 10,
                                        DEVIL_MONITOR_TRANS     = 11,
                                        DEVIL_TAKE_ACTIONS      = 12,
                                        DEVIL_SNOOP_RESPONSE    = 13, 
                                        DEVIL_TEST_MONITOR      = 14;

    `define WRAP                2'b10
    `define INCR                2'b01

//------------------------------------------------------------------------------
// WIRES
//------------------------------------------------------------------------------
    wire        w_ac_filter;
    wire        w_addr_filter;
    wire  [7:0] w_arlen;

    // just for test porpuses (pattern to search for)
    wire   [(C_ACE_DATA_WIDTH*4)-1:0] w_cache_line_2_monitor;
    assign w_cache_line_2_monitor[31+32*0:0+32*0] = 32'hDEEDBEEF;  
    assign w_cache_line_2_monitor[31+32*1:0+32*1] = 32'h1FFFFFFF; 
    assign w_cache_line_2_monitor[31+32*2:0+32*2] = 32'hDEEDBEEF;
    assign w_cache_line_2_monitor[31+32*3:0+32*3] = 32'h2FFFFFFF;
    assign w_cache_line_2_monitor[31+32*4:0+32*4] = 32'hDEEDBEEF; 
    assign w_cache_line_2_monitor[31+32*5:0+32*5] = 32'h3FFFFFFF; 
    assign w_cache_line_2_monitor[31+32*6:0+32*6] = 32'hDEEDBEEF;
    assign w_cache_line_2_monitor[31+32*7:0+32*7] = 32'h4FFFFFFF; 
    assign w_cache_line_2_monitor[31+32*8:0+32*8] = 32'hDEEDBEEF; 
    assign w_cache_line_2_monitor[31+32*9:0+32*9] = 32'h5FFFFFFF; 
    assign w_cache_line_2_monitor[31+32*10:0+32*10] = 32'hDEEDBEEF;
    assign w_cache_line_2_monitor[31+32*11:0+32*11] = 32'h6FFFFFFF;
    assign w_cache_line_2_monitor[31+32*12:0+32*12] = 32'hDEEDBEEF; 
    assign w_cache_line_2_monitor[31+32*13:0+32*13] = 32'h7FFFFFFF; 
    assign w_cache_line_2_monitor[31+32*14:0+32*14] = 32'hDEEDBEEF;
    assign w_cache_line_2_monitor[31+32*15:0+32*15] = 32'h8FFFFFFF;

    // //fe16863c bbaf7e47 dcd5db54 d54783c2
    // assign w_cache_line_2_monitor[31+32*0:0+32*0]   = 32'hd54783c2;  
    // assign w_cache_line_2_monitor[31+32*1:0+32*1]   = 32'hdcd5db54; 
    // assign w_cache_line_2_monitor[31+32*2:0+32*2]   = 32'hbbaf7e47;
    // assign w_cache_line_2_monitor[31+32*3:0+32*3]   = 32'hfe16863c;
    // //cd197260 f65b9c92 d260d0b8 d206ceac
    // assign w_cache_line_2_monitor[31+32*4:0+32*4]   = 32'hd206ceac; 
    // assign w_cache_line_2_monitor[31+32*5:0+32*5]   = 32'hd260d0b8; 
    // assign w_cache_line_2_monitor[31+32*6:0+32*6]   = 32'hf65b9c92;
    // assign w_cache_line_2_monitor[31+32*7:0+32*7]   = 32'hcd197260; 
    // //1cd9b232 893d8de5 1443e896 fcb01399
    // assign w_cache_line_2_monitor[31+32*8:0+32*8]   = 32'hfcb01399; 
    // assign w_cache_line_2_monitor[31+32*9:0+32*9]   = 32'h1443e896; 
    // assign w_cache_line_2_monitor[31+32*10:0+32*10] = 32'h893d8de5;
    // assign w_cache_line_2_monitor[31+32*11:0+32*11] = 32'h1cd9b232;
    // //eb624e0d ff78efa1 1ec5cf46 c8772659
    // assign w_cache_line_2_monitor[31+32*12:0+32*12] = 32'hc8772659; 
    // assign w_cache_line_2_monitor[31+32*13:0+32*13] = 32'h1ec5cf46; 
    // assign w_cache_line_2_monitor[31+32*14:0+32*14] = 32'hff78efa1;
    // assign w_cache_line_2_monitor[31+32*15:0+32*15] = 32'heb624e0d;  
 
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
    reg                          r_trans_monitored;
    reg                    [3:0] r_func;
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
    
    // ACE AR Channel (Read address phase)
    // (Not used for now!)
    assign o_araddr     = 0; 
    assign o_arbar      = 0;
    assign o_arburst    = `WRAP;
    assign o_arcache    = 4'h3; // Read-Allocate //Refer to page 64 of manual. 
    assign o_ardomain   = 2'b10;  // outer shareable
    assign o_arid       = 0;
    assign o_arlen      = w_arlen; 
    assign w_arlen      = 8'h3; // Set to 7'h3 for 4 bursts of 16B (128 bits) to match 64B cache line size
    assign o_arlock     = 0;
    assign o_arprot     = 3'b011; // [2] Instruction access, [1] Non-secure access, [0] Privileged
    assign o_arqos      = 0;
    assign o_arregion   = 0;
    assign o_arsize     = 3'b100; //Size of each burst is 16B 
    assign o_arsnoop    = 0;
    assign o_aruser     = 0;
    assign o_arvalid    = 0;

    // ACE R Channel (Read data phase)
    // (Not used for now!)
    assign o_rack   = 0;
    assign o_rready = 0;

    // ACE AW channel (Wri0te address phase)
    // (Not used for now!)
    assign o_awaddr     = 0;
    assign o_awbar      = 0;
    assign o_awburst    = 0;
    assign o_awcache    = 0;
    assign o_awdomain   = 0;
    assign o_awid       = 0;
    assign o_awlen      = 0;
    assign o_awlock     = 0;
    assign o_awprot     = 0;
    assign o_awqos      = 0;
    assign o_awregion   = 0;
    assign o_awsize     = 0;
    assign o_awsnoop    = 0;
    assign o_awuser     = 0;
    assign o_awvalid    = 0;

    // ACE W channel (Write data phase)
    // (Not used for now!)
    assign o_wack   = 0;
    assign o_wdata  = 0;
    assign o_wid    = 0;
    assign o_wlast  = 0;
    assign o_wstrb  = 0;
    assign o_wuser  = 0;
    assign o_wvalid = 0;

    // ACE B channel (Write response) 
    // (Not used for now!)
    assign o_bready = 0;

//------------------------------------------------------------------------------
// DEVIL-IN-THE-FPGA CONTROL REGISTERS
//------------------------------------------------------------------------------
    // Devil-in-the-fpga Control Reg parameters/bits
    // TODO: Put this in a common file with the bits in 
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
    wire       w_mon_en; // Enable Transactions Monitor

    assign w_en = i_control_reg[0];
    assign w_test = i_control_reg[4:1];
    assign w_func = i_control_reg[8:5];
    assign w_crresp = i_control_reg[13:9];
    assign w_acf_lt = i_control_reg[14];
    assign w_addr_flt = i_control_reg[15];
    assign w_osh_en = i_control_reg[16];
    assign w_con_en = i_control_reg[17];
    assign w_adl_en = i_control_reg[18]; // Active Data Leak Enable   
    assign w_adt_en = i_control_reg[19]; // Active Data Tampering Enable
    assign w_pdt_en = i_control_reg[20]; // Passive Data Tampering Enable
    assign w_mon_en = i_control_reg[21]; // Passive Data Tampering Enable

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

    assign o_internal_func      = r_func;
    assign o_trigger_active     = r_trigger_active;
    assign o_action_taken       = r_action_taken;
    assign o_trans_monitored    = r_trans_monitored;
    assign o_external_mode      = (w_adl_en || w_adt_en); // Informes when an action is trigger by PS 
    assign o_internal_adl_en    = r_internal_adl_en;
    assign o_internal_adt_en    = r_internal_adt_en;

    // ac and addr filters are applied to the acaddr and acsnoop at the time of
    //the achandshake, bacause once the handshake happens, a new snoop is generated
    assign w_ac_filter      = (i_acsnoop_snapshot[3:0] == i_acsnoop_reg[3:0]) ? 1 : 0;
    assign w_addr_filter    = (i_acaddr_snapshot[31:0] >= i_base_addr_reg[31:0]) && (i_acaddr_snapshot[31:0] < (i_base_addr_reg[31:0] + i_addr_size_reg[31:0])) ? 1 : 0;

//------------------------------------------------------------------------------
// FSM
//------------------------------------------------------------------------------
    always @(posedge ace_aclk)
    begin
    if(~ace_aresetn)
        begin
        r_func <= 0;
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
        r_trans_monitored <= 0;
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
                            fsm_devil_state_passive <= w_mon_en ? DEVIL_MONITOR_TRANS : DEVIL_TAKE_ACTIONS;
                        end
                        `AC_FILTER  : 
                        begin
                            if(w_ac_filter)
                                fsm_devil_state_passive <= w_mon_en ? DEVIL_MONITOR_TRANS : DEVIL_TAKE_ACTIONS;
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        `ADDR_FILTER  : 
                        begin
                            if(w_addr_filter)
                                fsm_devil_state_passive <= w_mon_en ? DEVIL_MONITOR_TRANS : DEVIL_TAKE_ACTIONS;  
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        `AC_ADDR_FILTER  : 
                        begin
                            if(w_addr_filter && w_ac_filter)
                                fsm_devil_state_passive <= w_mon_en ? DEVIL_MONITOR_TRANS : DEVIL_TAKE_ACTIONS;  
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        default : fsm_devil_state_passive <= DEVIL_DUMMY_REPLY; 
                    endcase                                                     
                end
            DEVIL_MONITOR_TRANS:
                begin
                    r_araddr <= i_acaddr_snapshot;
                    r_arsnoop <= i_acsnoop_snapshot;
                    r_trigger_active <= 1;
                    r_trans_monitored <= 1;
                    r_internal_adl_en <= 1; // Enable Read Snoop (internal trigger)
                    // ReadNoSnoop , ardomain = 2'b00 and arsnoop = 4'b0000
                    r_ardomain <= 2'b00; 
                    r_arsnoop <= 4'b0000; 
                    // r_internal_adt_en <= 0; // En Write Snoop (internal trigger)
                    r_func <= `ADL; // Read snoop
                    if (i_active_end)
                    begin
                        r_trigger_active <= 0;
                        r_internal_adl_en <= 0;
                        if(w_cache_line_2_monitor == i_cache_line) // just for test porpuses
                            fsm_devil_state_passive  <= DEVIL_TEST_MONITOR; // just for test porpuses
                        else
                            fsm_devil_state_passive  <= DEVIL_TAKE_ACTIONS;
                    end                           
                    else
                        fsm_devil_state_passive <= fsm_devil_state_passive;
                end
            // just for test porpuses, to see that there was a match
            DEVIL_TEST_MONITOR:
                begin
                    fsm_devil_state_passive  <= DEVIL_TAKE_ACTIONS;  
                end
            DEVIL_TAKE_ACTIONS:
                begin
                    fsm_devil_state_passive  <= DEVIL_FUNCTION;  
                    r_araddr <= 0;
                    r_arsnoop <= 0;   
                    r_awsnoop <= 0;
                    r_ardomain <= 2'b10; // outer shareable
                    r_awaddr <= 0;  
                    // No action
                    r_action_taken <= 0; 
                    // TO IMPLEMENT
                end
            DEVIL_FUNCTION: // 6
                begin
                    case (w_func[3:0])
                        `OSH  : 
                        begin
                            if (i_read_status_reg[0] == 0 && w_osh_en)
                                fsm_devil_state_passive <= DEVIL_ONE_SHOT_DELAY; 
                            else 
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        `CON  : 
                        begin
                            if (w_con_en)
                                fsm_devil_state_passive <= DEVIL_CONTINUOS_DELAY;  
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        `ADL  :
                        begin
                            fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        `ADT  :
                        begin
                            fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        `PDT  :
                        begin
                            if (w_pdt_en)
                                fsm_devil_state_passive <= DEVIL_SNOOP_RESPONSE;  
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        default : fsm_devil_state_passive <= DEVIL_DUMMY_REPLY; 
                    endcase                                                      
                end
            DEVIL_ONE_SHOT_DELAY: // 1
                begin
                    if (i_read_status_reg[0] == 0 && i_crready) // just one reply with delay                                      
                    begin                                                            
                        fsm_devil_state_passive  <= DEVIL_RESPONSE;
                        r_return <= DEVIL_END_OP;                              
                    end  
                    else if(i_read_status_reg[0] && i_crready) // normal reply                                                         
                    begin                          
                        fsm_devil_state_passive  <= DEVIL_DUMMY_REPLY;                                
                    end 
                    else          
                        fsm_devil_state_passive <= fsm_devil_state_passive;                                                                                  
                end
            DEVIL_CONTINUOS_DELAY: //2
                begin
                    if (!w_con_en && i_crready)                                      
                    begin                                                   // just one reply with delay            
                        fsm_devil_state_passive  <= DEVIL_RESPONSE;  
                        r_return <= DEVIL_END_OP; // last reply      
                    end  
                    else if(i_crready) 
                    begin         
                        fsm_devil_state_passive  <= DEVIL_RESPONSE;                                     
                        r_return <= DEVIL_END_REPLY;      
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
                                if(!w_pdt_en) // Passive Data Tampering Disable                           
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
            DEVIL_RESPONSE: // 3
                begin
                    // if(handshake) begin
                        if(w_func[3:0] == `OSH)
                        begin
                            r_status_reg[0] <= 1; 
                        end

                        r_crresp <= w_crresp[4:0];
                        // r_rdata <= w_crresp[4:0]; // outputing w_crresp just to check if it is right

                        case (w_test[3:0])
                            `FUZZING: 
                            begin
                                r_crvalid <= 1;
                                r_cdvalid <= 1; 
                                r_cdlast <= 1;
                                fsm_devil_state_passive  <= r_return; 
                            end
                            `REPLY_WITH_DELAY_CRVALID: 
                            begin
                                // r_crvalid <= 1;
                                //r_cdvalid <= 1; 
                                //r_cdlast <= 1;
                                fsm_devil_state_passive  <= DEVIL_DELAY;
                            end 
                            `REPLY_WITH_DELAY_CDVALID:  
                            begin
                                r_crvalid <= 1;
                                // r_cdvalid <= 1; 
                                r_cdlast <= 1;
                                fsm_devil_state_passive  <= DEVIL_DELAY;
                            end 
                            `REPLY_WITH_DELAY_CDLAST:  
                            begin
                                r_crvalid <= 1;
                                r_cdvalid <= 1; 
                                // r_cdlast <= 1;
                                fsm_devil_state_passive  <= DEVIL_DELAY;
                            end 
                            default : 
                            begin
                                r_crvalid <= r_crvalid;
                                r_cdvalid <= r_cdvalid; 
                                r_cdlast <= r_cdlast;
                                fsm_devil_state_passive  <= r_return; 
                            end
                        endcase         
                    // end
                    // else
                    //     fsm_devil_state_passive <= DEVIL_RESPONSE;                             
                end
            DEVIL_DUMMY_REPLY: // 8
                begin
                    if (i_crready)
                    begin
                        // if(handshake) begin
                            r_crresp <= 0;
                            r_rdata <= 0;
                            r_crvalid <= 1;
                            fsm_devil_state_passive  <= DEVIL_END_REPLY;
                        // end
                        // else
                        //     fsm_devil_state_passive  <= DEVIL_DUMMY_REPLY;
                    end                           
                    else
                        fsm_devil_state_passive <= fsm_devil_state_passive;
                end
            DEVIL_DELAY: // 4
                begin
                    // wait some cycles to respond
                    if(r_counter == (i_delay_reg == 0 ? 0 :`NUM_OF_CYCLES << (i_delay_reg-1)) )
                    begin
                        r_counter <= 0;
                        case (w_test[3:0])
                            `REPLY_WITH_DELAY_CRVALID: 
                            begin
                                r_crvalid <= 1;
                                fsm_devil_state_passive  <= r_return; 
                            end 
                            `REPLY_WITH_DELAY_CDVALID:  
                            begin
                                r_cdvalid <= 1; 
                                fsm_devil_state_passive  <= r_return; 
                            end 
                            `REPLY_WITH_DELAY_CDLAST:  
                            begin
                                r_cdlast <= 1; 
                                fsm_devil_state_passive  <= r_return; 
                            end 
                            default : 
                            begin
                                r_crvalid <= r_crvalid;
                                r_cdvalid <= r_cdvalid; 
                                r_cdlast <= r_cdlast;
                                fsm_devil_state_passive  <= r_return; 
                            end
                        endcase                
                    end
                    else
                    begin
                        r_counter <= r_counter + 1;
                        fsm_devil_state_passive <= DEVIL_DELAY;
                    end                                
                end
            DEVIL_END_OP: // 7 State to signal the End of the FSM operation
                begin
                    r_crvalid <= 0;
                    r_cdvalid <= 0;
                    r_crresp <= 0;
                    r_cdlast <= 0;
                    r_burst_cnt <= 0;
                    r_status_reg[0] <= 0;    
                    r_end_op <= 1;
                    r_reply <= 1;
                    r_action_taken <= 0; 
                    r_trans_monitored <= 0;
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
                    r_trans_monitored <= 0;
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

