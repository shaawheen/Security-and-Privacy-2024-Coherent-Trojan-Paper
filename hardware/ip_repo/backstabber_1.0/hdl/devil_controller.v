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
        parameter integer DEVIL_STATE_SIZE      = 5, // 32 states
        parameter integer CTRL_OUT_SIGNAL_WIDTH = 1
        )
        (
        input  wire                             ace_aclk,
        input  wire                             ace_aresetn,
        input  wire                       [3:0] i_cmd,
        input  wire                             i_trigger,
        output wire      [DEVIL_STATE_SIZE-1:0] o_fsm_devil_controller,
        output wire  [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line_2_monitor,

        // Internal Signals, from devil to devil controller 
        input  wire                             i_end_active_devil,
        input  wire                             i_end_passive_devil,
        input  wire                             i_end_reply,
        input  wire  [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line_active_devil,
        output wire  [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line_active_devil,
        output wire  [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line_passive_devil,

        // Internal Signals, from devil controller to devil passive
        output wire   [CTRL_OUT_SIGNAL_WIDTH-1:0] o_controller_signals,
        input  wire                               i_pattern_match
    );

//------------------------------------------------------------------------------
// FSM STATES AND DEFINES
//------------------------------------------------------------------------------
    parameter [DEVIL_STATE_SIZE-1:0]    DEVIL_IDLE              = 0,
                                        DEVIL_CHOOSE_CMD        = 1,
                                        DEVIL_CMD_REROUTING     = 2, 
                                        DEVIL_CMD_LEAK          = 3,
                                        DEVIL_CMD_LEAK_ACTION   = 4,
                                        DEVIL_CMD_LEAK_REPLY    = 5,
                                        DEVIL_CMD_POISON        = 6, 
                                        DEVIL_END_OP            = 7;

    `define CMD_REROUTING   0
    `define CMD_LEAK        1
    `define CMD_POISON      2

//------------------------------------------------------------------------------
// WIRES
//------------------------------------------------------------------------------

    // just for test porpuses (pattern to search for)
    // wire   [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line_2_monitor;
    // assign o_cache_line_2_monitor[31+32*0:0+32*0] = 32'hDEEDBEEF;  
    // assign o_cache_line_2_monitor[31+32*1:0+32*1] = 32'h1FFFFFFF; 
    // assign o_cache_line_2_monitor[31+32*2:0+32*2] = 32'hDEEDBEEF;
    // assign o_cache_line_2_monitor[31+32*3:0+32*3] = 32'h2FFFFFFF;
    // assign o_cache_line_2_monitor[31+32*4:0+32*4] = 32'hDEEDBEEF; 
    // assign o_cache_line_2_monitor[31+32*5:0+32*5] = 32'h3FFFFFFF; 
    // assign o_cache_line_2_monitor[31+32*6:0+32*6] = 32'hDEEDBEEF;
    // assign o_cache_line_2_monitor[31+32*7:0+32*7] = 32'h4FFFFFFF; 
    // assign o_cache_line_2_monitor[31+32*8:0+32*8] = 32'hDEEDBEEF; 
    // assign o_cache_line_2_monitor[31+32*9:0+32*9] = 32'h5FFFFFFF; 
    // assign o_cache_line_2_monitor[31+32*10:0+32*10] = 32'hDEEDBEEF;
    // assign o_cache_line_2_monitor[31+32*11:0+32*11] = 32'h6FFFFFFF;
    // assign o_cache_line_2_monitor[31+32*12:0+32*12] = 32'hDEEDBEEF; 
    // assign o_cache_line_2_monitor[31+32*13:0+32*13] = 32'h7FFFFFFF; 
    // assign o_cache_line_2_monitor[31+32*14:0+32*14] = 32'hDEEDBEEF;
    // assign o_cache_line_2_monitor[31+32*15:0+32*15] = 32'h8FFFFFFF;

    // Values to be used on the simulaion -> Devil-in-fpga-DUT
    // //fe16863c bbaf7e47 dcd5db54 d54783c2
    assign o_cache_line_2_monitor[31+32*0:0+32*0]   = 32'hd54783c2;  
    assign o_cache_line_2_monitor[31+32*1:0+32*1]   = 32'hdcd5db54; 
    assign o_cache_line_2_monitor[31+32*2:0+32*2]   = 32'hbbaf7e47;
    assign o_cache_line_2_monitor[31+32*3:0+32*3]   = 32'hfe16863c;
    // //cd197260 f65b9c92 d260d0b8 d206ceac
    assign o_cache_line_2_monitor[31+32*4:0+32*4]   = 32'hd206ceac; 
    assign o_cache_line_2_monitor[31+32*5:0+32*5]   = 32'hd260d0b8; 
    assign o_cache_line_2_monitor[31+32*6:0+32*6]   = 32'hf65b9c92;
    assign o_cache_line_2_monitor[31+32*7:0+32*7]   = 32'hcd197260; 
    // //1cd9b232 893d8de5 1443e896 fcb01399
    assign o_cache_line_2_monitor[31+32*8:0+32*8]   = 32'hfcb01399; 
    assign o_cache_line_2_monitor[31+32*9:0+32*9]   = 32'h1443e896; 
    assign o_cache_line_2_monitor[31+32*10:0+32*10] = 32'h893d8de5;
    assign o_cache_line_2_monitor[31+32*11:0+32*11] = 32'h1cd9b232;
    // //eb624e0d ff78efa1 1ec5cf46 c8772659
    assign o_cache_line_2_monitor[31+32*12:0+32*12] = 32'hc8772659; 
    assign o_cache_line_2_monitor[31+32*13:0+32*13] = 32'h1ec5cf46; 
    assign o_cache_line_2_monitor[31+32*14:0+32*14] = 32'hff78efa1;
    assign o_cache_line_2_monitor[31+32*15:0+32*15] = 32'heb624e0d;

    assign w_write_cl_valid_passive = (fsm_devil_controller == DEVIL_CMD_LEAK_REPLY || 
                                       fsm_devil_controller == DEVIL_CMD_REROUTING) ? 
                                       1'b1 : 1'b0;
    assign w_write_cl_valid_active =   (fsm_devil_controller == DEVIL_CMD_LEAK_ACTION) ? 
                                       1'b1 : 1'b0;
 
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
    

//------------------------------------------------------------------------------
// INPUTS/OUTPUTS
//------------------------------------------------------------------------------
    assign o_fsm_devil_controller   = fsm_devil_controller;

    // TODO: Put this parameters in a header file shared among all the modules
    //       Internal Signals, from devil controller to devil passive (Output)
    //
    // NOTE: I need to update the top module CTRL_OUT_SIGNAL_WIDTH every time I had a 
    // new signal, for the width of the signal to accomodate the new signal 
    // -> width = C_ACE_ADDR_WIDTH + 4 + C_ACE_ADDR_WIDTH + 3 + 2 + 4 + 1 
    
    parameter CTRL_SIGNAL1_WIDTH = C_ACE_ADDR_WIDTH;
    parameter CTRL_SIGNAL2_WIDTH = (CTRL_SIGNAL1_WIDTH + 4);
    parameter CTRL_SIGNAL3_WIDTH = (CTRL_SIGNAL2_WIDTH + C_ACE_ADDR_WIDTH);
    parameter CTRL_SIGNAL4_WIDTH = (CTRL_SIGNAL3_WIDTH + 3);
    parameter CTRL_SIGNAL5_WIDTH = (CTRL_SIGNAL4_WIDTH + 2);
    parameter CTRL_SIGNAL6_WIDTH = (CTRL_SIGNAL5_WIDTH + 4);
    parameter CTRL_SIGNAL7_WIDTH = (CTRL_SIGNAL6_WIDTH + 1);
    
    assign o_controller_signals[CTRL_SIGNAL1_WIDTH-1:0]                   = r_controller_araddr;
    assign o_controller_signals[CTRL_SIGNAL2_WIDTH-1:CTRL_SIGNAL1_WIDTH]  = r_controller_arsnoop;
    assign o_controller_signals[CTRL_SIGNAL3_WIDTH-1:CTRL_SIGNAL2_WIDTH]  = r_controller_awaddr;
    assign o_controller_signals[CTRL_SIGNAL4_WIDTH-1:CTRL_SIGNAL3_WIDTH]  = r_controller_awsnoop;
    assign o_controller_signals[CTRL_SIGNAL5_WIDTH-1:CTRL_SIGNAL4_WIDTH]  = r_controller_ardomain;
    assign o_controller_signals[CTRL_SIGNAL6_WIDTH-1:CTRL_SIGNAL5_WIDTH]  = r_active_func;
    assign o_controller_signals[CTRL_SIGNAL7_WIDTH-1:CTRL_SIGNAL6_WIDTH]  = r_reply;

    assign o_cache_line_active_devil = r_write_cache_line_active;
    assign o_cache_line_passive_devil = r_write_cache_line_passive;

    


//------------------------------------------------------------------------------
// FSM
//------------------------------------------------------------------------------
    always @(posedge ace_aclk)
    begin
    if(~ace_aresetn)
        begin
        fsm_devil_controller <= DEVIL_IDLE;
        r_reply <= 0;
        r_active_func <= 0;
        r_save_cache_line <= 0;
        r_controller_araddr <= 0;
        r_controller_awaddr <= 0;
        r_controller_arsnoop <= 0;
        r_controller_awsnoop <= 0;
        r_controller_ardomain <= 0;
        r_write_cache_line_active <= 0;
        r_write_cache_line_passive <= 0;
        end 
    else
        begin
            case (fsm_devil_controller)                                                                                                                                 
            DEVIL_IDLE: 
                begin
                    if(i_trigger)
                        fsm_devil_controller <= DEVIL_CHOOSE_CMD;     
                    else 
                        fsm_devil_controller <= DEVIL_IDLE;              
                end
            DEVIL_CHOOSE_CMD: 
                begin
                    case (i_cmd[3:0])
                        `CMD_REROUTING  : 
                        begin
                            fsm_devil_controller <= DEVIL_CMD_REROUTING;
                        end
                        `CMD_LEAK  : 
                        begin
                            fsm_devil_controller <= DEVIL_CMD_LEAK;
                        end
                        `CMD_POISON  :
                        begin
                            fsm_devil_controller <= DEVIL_CMD_POISON;
                        end
                        default : fsm_devil_controller <= DEVIL_END_OP; 
                    endcase                                                      
                end
            DEVIL_CMD_REROUTING:  
                begin 
                    r_reply <= 1;
                    r_write_cache_line_passive <= i_cache_line_active_devil; 
                    fsm_devil_controller <= DEVIL_END_OP;                                                  
                end
            DEVIL_CMD_LEAK: // 3
                begin 
                    if (i_end_active_devil)
                    begin 
                        if(o_cache_line_2_monitor == i_cache_line_active_devil) 
                        begin
                            r_save_cache_line <= i_cache_line_active_devil;
                            fsm_devil_controller <= DEVIL_CMD_LEAK_ACTION;
                        end
                        else
                            fsm_devil_controller <= DEVIL_CMD_REROUTING;
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_CMD_LEAK_ACTION:  // 4
                begin 

                    // Read Snoop
                    // r_controller_araddr <= 32'h40000100;
                    // r_controller_arsnoop <= 4'b0001; // READ_ONCE
                    // r_controller_ardomain <= 2'b10; // outer shareable
                    // r_active_func <= `ADL; // Read Snoop

                    // Write Snoop
                    // r_controller_awaddr <= 32'h40000100;
                    // r_controller_awsnoop <= 3'b001; // WRITE_LINE_UNIQUE
                    // r_controller_ardomain <= 2'b10; // outer shareable
                    // r_active_func <= `ADT; // Write Snoop
                    // r_write_cache_line_active <= 0;  // clean all the cache line (just to test)

                    // if(i_end_active_devil)
                        fsm_devil_controller <= DEVIL_CMD_LEAK_REPLY; 
                    // else
                        // fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_CMD_LEAK_REPLY:  // 5
                begin 

                    r_reply <= 1;
                    r_write_cache_line_passive <= r_save_cache_line; 

                    if(i_end_reply)
                        fsm_devil_controller <= DEVIL_END_OP; 
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_CMD_POISON:  
                begin 
                    fsm_devil_controller <= DEVIL_END_OP;                                                  
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

endmodule
