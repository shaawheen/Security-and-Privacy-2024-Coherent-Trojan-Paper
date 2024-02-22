`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2024 03:56:21 PM
// Design Name: 
// Module Name: devil_controller
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

module devil_controller#(
        parameter integer C_S_AXI_DATA_WIDTH    = 32, 
        parameter integer C_ACE_DATA_WIDTH      = 128,
        parameter integer C_ACE_ADDR_WIDTH      = 44,
        parameter integer C_ACE_ACSNOOP_WIDTH   = 4,
        parameter integer DEVIL_STATE_SIZE      = 5, // 32 states
        parameter integer CTRL_OUT_SIGNAL_WIDTH = 1
        )
        (
        input  wire                             ace_aclk,
        input  wire                             ace_aresetn,
        input  wire                       [3:0] i_cmd,
        input  wire                             i_trigger,
        input  wire      [C_ACE_ADDR_WIDTH-1:0] i_acaddr_snapshot,
        input  wire   [C_ACE_ACSNOOP_WIDTH-1:0] i_acsnoop_snapshot,
        output wire      [DEVIL_STATE_SIZE-1:0] o_fsm_devil_controller,
        output wire  [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line_2_monitor,

        // Internal Signals, from devil to devil controller 
        input  wire                             i_end_active_devil,
        input  wire                             i_end_passive_devil,
        input  wire                             i_end_reply,
        input  wire  [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line_active_devil,
        output wire  [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line_active_devil,
        output wire  [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line_passive_devil,
        output wire                             o_internal_adl_en,
        output wire                             o_internal_adt_en,
        output wire                             o_trigger_active, 

        // External Signals, from register file / PS
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_external_cache_line, 
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_external_cache_line_pattern, 
        input  wire                        [3:0] i_external_arsnoop_Data,
        input  wire                        [2:0] i_external_awsnoop_Data,
        input  wire                       [31:0] i_external_l_araddr_Data,
        input  wire                       [31:0] i_external_l_awaddr_Data,

        // Internal Signals, from devil controller to devil passive
        output wire   [CTRL_OUT_SIGNAL_WIDTH-1:0] o_controller_signals
    );

//------------------------------------------------------------------------------
// FSM STATES AND DEFINES
//------------------------------------------------------------------------------
    parameter [DEVIL_STATE_SIZE-1:0]    DEVIL_IDLE              = 0,
                                        DEVIL_SEARCH_PATTERN    = 1,
                                        DEVIL_CHOOSE_CMD        = 2, 
                                        DEVIL_LEAK_ACTION       = 3,
                                        DEVIL_POISON_ACTION     = 4,
                                        DEVIL_REPLY             = 5,
                                        DEVIL_END_OP            = 6,
                                        DEVIL_PARTIAL_MATCH     = 7,
                                        DEVIL_READ_NEXT_CL      = 8;

    `define CMD_LEAK        0
    `define CMD_POISON      1

//------------------------------------------------------------------------------
// WIRES
//------------------------------------------------------------------------------
    wire    w_full_match;
    wire    w_partial_match;
    wire    [3:0] w_match_offset;
    wire    w_op_end;
    
//------------------------------------------------------------------------------
// REGISTERS
//------------------------------------------------------------------------------ 
    reg       [DEVIL_STATE_SIZE-1:0] fsm_devil_controller;       
    reg       [C_ACE_ADDR_WIDTH-1:0] r_controller_araddr;
    reg                        [3:0] r_controller_arsnoop;
    reg       [C_ACE_ADDR_WIDTH-1:0] r_controller_awaddr;
    reg                        [2:0] r_controller_awsnoop;
    reg                        [1:0] r_controller_ardomain;
    reg                        [3:0] r_active_func;
    reg                              r_reply;    
    reg   [(C_ACE_DATA_WIDTH*4)-1:0] r_save_cache_line; 
    reg   [(C_ACE_DATA_WIDTH*4)-1:0] r_write_cache_line_passive; 
    reg   [(C_ACE_DATA_WIDTH*4)-1:0] r_write_cache_line_active; 
    reg                              r_internal_adl_en;
    reg                              r_internal_adt_en;
    reg                              r_trigger_active;
    reg   [(C_ACE_DATA_WIDTH*4)-1:0] r_pattern;
    reg                        [4:0] r_pattern_size;
    reg                        [4:0] r_pattern_size_save;
    reg                        [3:0] r_match_offset;
    reg                              r_match_pattern_trigger;

//------------------------------------------------------------------------------
// INPUTS/OUTPUTS
//------------------------------------------------------------------------------
    assign o_fsm_devil_controller   = fsm_devil_controller;

    `include "devil_ctrl_defines.vh"
    
    assign o_controller_signals[CTRL_SIGNAL1_WIDTH-1:0]                   = r_controller_araddr;
    assign o_controller_signals[CTRL_SIGNAL2_WIDTH-1:CTRL_SIGNAL1_WIDTH]  = r_controller_arsnoop;
    assign o_controller_signals[CTRL_SIGNAL3_WIDTH-1:CTRL_SIGNAL2_WIDTH]  = r_controller_awaddr;
    assign o_controller_signals[CTRL_SIGNAL4_WIDTH-1:CTRL_SIGNAL3_WIDTH]  = r_controller_awsnoop;
    assign o_controller_signals[CTRL_SIGNAL5_WIDTH-1:CTRL_SIGNAL4_WIDTH]  = r_controller_ardomain;
    assign o_controller_signals[CTRL_SIGNAL6_WIDTH-1:CTRL_SIGNAL5_WIDTH]  = r_active_func;
    assign o_controller_signals[CTRL_SIGNAL7_WIDTH-1:CTRL_SIGNAL6_WIDTH]  = r_reply;

    assign o_cache_line_active_devil = r_write_cache_line_active;
    assign o_cache_line_passive_devil = r_write_cache_line_passive;

    assign o_internal_adl_en = r_internal_adl_en;
    assign o_internal_adt_en = r_internal_adt_en;
    assign o_trigger_active  = r_trigger_active;

    assign o_cache_line_2_monitor[31+32*0:0+32*0]   = i_external_cache_line_pattern[31+32*0:0+32*0];
    assign o_cache_line_2_monitor[31+32*1:0+32*1]   = i_external_cache_line_pattern[31+32*1:0+32*1];
    assign o_cache_line_2_monitor[31+32*2:0+32*2]   = i_external_cache_line_pattern[31+32*2:0+32*2];
    assign o_cache_line_2_monitor[31+32*3:0+32*3]   = i_external_cache_line_pattern[31+32*3:0+32*3];
    assign o_cache_line_2_monitor[31+32*4:0+32*4]   = i_external_cache_line_pattern[31+32*4:0+32*4];
    assign o_cache_line_2_monitor[31+32*5:0+32*5]   = i_external_cache_line_pattern[31+32*5:0+32*5];
    assign o_cache_line_2_monitor[31+32*6:0+32*6]   = i_external_cache_line_pattern[31+32*6:0+32*6];
    assign o_cache_line_2_monitor[31+32*7:0+32*7]   = i_external_cache_line_pattern[31+32*7:0+32*7];
    assign o_cache_line_2_monitor[31+32*8:0+32*8]   = i_external_cache_line_pattern[31+32*8:0+32*8];
    assign o_cache_line_2_monitor[31+32*9:0+32*9]   = i_external_cache_line_pattern[31+32*9:0+32*9];
    assign o_cache_line_2_monitor[31+32*10:0+32*10] = i_external_cache_line_pattern[31+32*10:0+32*10];
    assign o_cache_line_2_monitor[31+32*11:0+32*11] = i_external_cache_line_pattern[31+32*11:0+32*11];
    assign o_cache_line_2_monitor[31+32*12:0+32*12] = i_external_cache_line_pattern[31+32*12:0+32*12];
    assign o_cache_line_2_monitor[31+32*13:0+32*13] = i_external_cache_line_pattern[31+32*13:0+32*13];
    assign o_cache_line_2_monitor[31+32*14:0+32*14] = i_external_cache_line_pattern[31+32*14:0+32*14];
    assign o_cache_line_2_monitor[31+32*15:0+32*15] = i_external_cache_line_pattern[31+32*15:0+32*15];
//------------------------------------------------------------------------------
// FSM
//------------------------------------------------------------------------------
    always @(posedge ace_aclk)
    begin
    if(~ace_aresetn)
        begin
        fsm_devil_controller <= DEVIL_IDLE;
        r_reply <= 0;
        r_pattern <= 0;
        r_active_func <= 0;
        r_match_offset <= 0;
        r_pattern_size <= 0;
        r_trigger_active <= 0;
        r_internal_adl_en <= 0;
        r_internal_adt_en <= 0;
        r_save_cache_line <= 0;
        r_pattern_size_save <= 0;
        r_controller_araddr <= 0;
        r_controller_awaddr <= 0;
        r_controller_arsnoop <= 0;
        r_controller_awsnoop <= 0;
        r_controller_ardomain <= 0;
        r_match_pattern_trigger <= 0;
        r_write_cache_line_active <= 0;
        r_write_cache_line_passive <= 0;
        end 
    else
        begin
            case (fsm_devil_controller)                                                                                                                                 
            DEVIL_IDLE: // 0
                begin
                    if(i_trigger)
                        fsm_devil_controller <= DEVIL_SEARCH_PATTERN;     
                    else 
                        fsm_devil_controller <= DEVIL_IDLE;              
                end
            DEVIL_SEARCH_PATTERN: // 1
                begin 
                    if (i_end_active_devil)
                    begin 
                        r_save_cache_line <= i_cache_line_active_devil;
                        r_pattern <= i_external_cache_line_pattern;
                        r_pattern_size <= 16;
                        r_match_pattern_trigger <= 1;
                        if(w_op_end) begin
                            r_match_pattern_trigger <= 0;
                            if(w_full_match) 
                                fsm_devil_controller <= DEVIL_CHOOSE_CMD;
                            else if(w_partial_match) 
                                begin
                                    fsm_devil_controller <= DEVIL_READ_NEXT_CL;
                                    r_match_offset <=  w_match_offset;
                                    r_pattern_size_save <= r_pattern_size;
                                end
                            else
                                fsm_devil_controller <= DEVIL_REPLY;
                        end
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_READ_NEXT_CL: // 8
                begin 
                    // Read Snoop
                    r_controller_araddr   <= (i_acaddr_snapshot+32'h40); // next CL
                    // ReadNoSnoop , ardomain = 2'b00 and arsnoop = 4'b0000
                    r_controller_arsnoop  <= 4'b0000; // ReadNoSnoop
                    r_controller_ardomain <= 2'b00; // outer shareable

                    // Trigger Read Snoop
                    r_active_func <= `ADL; // Read snoop

                    // Enable Read Snoop
                    r_internal_adl_en <= 1; 
                    r_trigger_active <= 1;

                    if(i_end_active_devil & r_trigger_active)
                        fsm_devil_controller <= DEVIL_PARTIAL_MATCH; 
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_PARTIAL_MATCH: // 7
                begin 
                    // Compare the remaining pattern 
                    r_pattern <= r_pattern >> ((r_pattern_size_save-r_match_offset)*32);
                    r_pattern_size <= r_match_offset;
                    r_match_pattern_trigger <= 1;
                    if(w_op_end) begin
                        r_match_pattern_trigger <= 0;
                        if(w_full_match) 
                            fsm_devil_controller <= DEVIL_CHOOSE_CMD;
                        else
                            fsm_devil_controller <= DEVIL_REPLY;
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_CHOOSE_CMD:  // 2
                begin
                    case (i_cmd[3:0])
                        `CMD_LEAK  : 
                        begin
                            fsm_devil_controller <= DEVIL_LEAK_ACTION;
                        end
                        `CMD_POISON  : 
                        begin
                            fsm_devil_controller <= DEVIL_POISON_ACTION;
                        end
                        default : fsm_devil_controller <= DEVIL_END_OP; 
                    endcase                                                      
                end
            DEVIL_LEAK_ACTION:  // 3 (Don't Tested!!)
                begin 

                    // Read Snoop
                    r_controller_araddr   <= i_external_l_araddr_Data;
                    r_controller_arsnoop  <= i_external_arsnoop_Data; // READ_ONCE
                    r_controller_ardomain <= 2'b10; // outer shareable

                    // trigger read snoop
                    r_active_func <= `ADL; // Write Snoop

                    // Enable Read Snoop
                    r_internal_adl_en <= 1; 
                    r_trigger_active <= 1;

                    if(i_end_active_devil && r_trigger_active)
                        fsm_devil_controller <= DEVIL_REPLY; 
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_POISON_ACTION:  // 4
                begin 
                    // Write Snoop Data
                    r_write_cache_line_active <= i_external_cache_line;  // (just to test)

                    // config write snoop
                    r_controller_awaddr <= i_external_l_awaddr_Data;
                    r_controller_awsnoop <= i_external_awsnoop_Data;
                    r_controller_ardomain <= 2'b10; // outer shareable

                    // trigger write snoop
                    r_active_func <= `ADT; // Write Snoop

                    r_internal_adt_en <= 1; // En Write Snoop
                    r_trigger_active <= 1;

                    if(i_end_active_devil && r_trigger_active)
                        fsm_devil_controller <= DEVIL_REPLY; 
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_REPLY:  // 5
                begin 
                    r_trigger_active <=  0;
                    r_internal_adt_en <= 0;
                    r_reply <= 1;
                    r_write_cache_line_passive <= r_save_cache_line; 

                    if(i_end_reply && r_reply)
                        fsm_devil_controller <= DEVIL_END_OP; 
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_END_OP:  
                begin 
                    r_reply <= 0;
                    fsm_devil_controller <= DEVIL_IDLE;                                                  
                end
            default :                                                                
                begin                                                                  
                    fsm_devil_controller <= DEVIL_IDLE;                                     
                end                                                                    
            endcase            
        end
    end        

//------------------------------------------------------------------------------
// Just for test porpuses
//------------------------------------------------------------------------------
// wire [(C_ACE_DATA_WIDTH*4)-1:0] w_test_i_cache_line_active_devil;

// assign w_test_i_cache_line_active_devil[31+32*0:0+32*0]   = 32'ha0a0a0a0; // pattern[0]
// assign w_test_i_cache_line_active_devil[31+32*1:0+32*1]   = 32'ha0a0a0a0; // pattern[1] 
// assign w_test_i_cache_line_active_devil[31+32*2:0+32*2]   = 32'hd54783c2; // pattern[2] 
// assign w_test_i_cache_line_active_devil[31+32*3:0+32*3]   = 32'hdcd5db54; // pattern[3]
// assign w_test_i_cache_line_active_devil[31+32*4:0+32*4]   = 32'hbbaf7e47; // pattern[4]
// assign w_test_i_cache_line_active_devil[31+32*5:0+32*5]   = 32'hfe16863c; // pattern[5]
// assign w_test_i_cache_line_active_devil[31+32*6:0+32*6]   = 32'hd206ceac; // pattern[6]
// assign w_test_i_cache_line_active_devil[31+32*7:0+32*7]   = 32'hd260d0b8; // pattern[7]
// assign w_test_i_cache_line_active_devil[31+32*8:0+32*8]   = 32'hf65b9c92; // pattern[8]
// assign w_test_i_cache_line_active_devil[31+32*9:0+32*9]   = 32'hcd197260; // pattern[9]
// assign w_test_i_cache_line_active_devil[31+32*10:0+32*10] = 32'hfcb01399; // pattern[10]
// assign w_test_i_cache_line_active_devil[31+32*11:0+32*11] = 32'h1443e896; // pattern[11]
// assign w_test_i_cache_line_active_devil[31+32*12:0+32*12] = 32'h893d8de5; // pattern[12]
// assign w_test_i_cache_line_active_devil[31+32*13:0+32*13] = 32'h1cd9b232; // pattern[13]
// assign w_test_i_cache_line_active_devil[31+32*14:0+32*14] = 32'hc8772659; // pattern[14]
// assign w_test_i_cache_line_active_devil[31+32*15:0+32*15] = 32'h1ec5cf46; // pattern[15]


// assign w_test_i_cache_line_active_devil[31+32*0:0+32*0]   = 32'hd54783c2; // pattern[0]
// assign w_test_i_cache_line_active_devil[31+32*1:0+32*1]   = 32'hdcd5db54; // pattern[1] 
// assign w_test_i_cache_line_active_devil[31+32*2:0+32*2]   = 32'hbbaf7e47; // pattern[2] 
// assign w_test_i_cache_line_active_devil[31+32*3:0+32*3]   = 32'hfe16863c; // pattern[3]
// assign w_test_i_cache_line_active_devil[31+32*4:0+32*4]   = 32'hd206ceac; // pattern[4]
// assign w_test_i_cache_line_active_devil[31+32*5:0+32*5]   = 32'hd260d0b8; // pattern[5]
// assign w_test_i_cache_line_active_devil[31+32*6:0+32*6]   = 32'hf65b9c92; // pattern[6]
// assign w_test_i_cache_line_active_devil[31+32*7:0+32*7]   = 32'hcd197260; // pattern[7]
// assign w_test_i_cache_line_active_devil[31+32*8:0+32*8]   = 32'hfcb01399; // pattern[8]
// assign w_test_i_cache_line_active_devil[31+32*9:0+32*9]   = 32'h1443e896; // pattern[9]
// assign w_test_i_cache_line_active_devil[31+32*10:0+32*10] = 32'h893d8de5; // pattern[10]
// assign w_test_i_cache_line_active_devil[31+32*11:0+32*11] = 32'h1cd9b232; // pattern[11]
// assign w_test_i_cache_line_active_devil[31+32*12:0+32*12] = 32'hc8772659; // pattern[12]
// assign w_test_i_cache_line_active_devil[31+32*13:0+32*13] = 32'h1ec5cf46; // pattern[13]
// assign w_test_i_cache_line_active_devil[31+32*14:0+32*14] = 32'hff78efa1; // pattern[14]
// assign w_test_i_cache_line_active_devil[31+32*15:0+32*15] = 32'heb624e0d; // pattern[15]

// assign w_test_i_cache_line_active_devil[31+32*0:0+32*0]   = 32'hDEEDBEEF; // pattern[0]
// assign w_test_i_cache_line_active_devil[31+32*1:0+32*1]   = 32'h1FFFFFFF; // pattern[1] 
// assign w_test_i_cache_line_active_devil[31+32*2:0+32*2]   = 32'hDEEDBEEF; // pattern[2] 
// assign w_test_i_cache_line_active_devil[31+32*3:0+32*3]   = 32'h2FFFFFFF; // pattern[3]
// assign w_test_i_cache_line_active_devil[31+32*4:0+32*4]   = 32'hDEEDBEEF; // pattern[4]
// assign w_test_i_cache_line_active_devil[31+32*5:0+32*5]   = 32'h3FFFFFFF; // pattern[5]
// assign w_test_i_cache_line_active_devil[31+32*6:0+32*6]   = 32'hDEEDBEEF; // pattern[6]
// assign w_test_i_cache_line_active_devil[31+32*7:0+32*7]   = 32'h4FFFFFFF; // pattern[7]
// assign w_test_i_cache_line_active_devil[31+32*8:0+32*8]   = 32'hDEEDBEEF; // pattern[8]
// assign w_test_i_cache_line_active_devil[31+32*9:0+32*9]   = 32'h5FFFFFFF; // pattern[9]
// assign w_test_i_cache_line_active_devil[31+32*10:0+32*10] = 32'hDEEDBEEF; // pattern[10]
// assign w_test_i_cache_line_active_devil[31+32*11:0+32*11] = 32'h6FFFFFFF; // pattern[11]
// assign w_test_i_cache_line_active_devil[31+32*12:0+32*12] = 32'hDEEDBEEF; // pattern[12]
// assign w_test_i_cache_line_active_devil[31+32*13:0+32*13] = 32'h7FFFFFFF; // pattern[13]
// assign w_test_i_cache_line_active_devil[31+32*14:0+32*14] = 32'hDEEDBEEF; // pattern[14]
// assign w_test_i_cache_line_active_devil[31+32*15:0+32*15] = 32'h8FFFFFFF; // pattern[15]
//------------------------------------------------------------------------------

// Instantiation Passive devil module
    match_pattern #(
		.CL_SIZE(64)
    ) match_pattern_inst(
        .i_pattern(r_pattern),
        .i_pattern_size(r_pattern_size),
        // .i_cache_line(w_test_i_cache_line_active_devil),
        .i_cache_line(i_cache_line_active_devil),
        .i_trigger(r_match_pattern_trigger),
        .o_full_match(w_full_match),
        .o_partial_match(w_partial_match),
        .o_match_offset(w_match_offset),
        .o_op_end(w_op_end)
    );

endmodule
