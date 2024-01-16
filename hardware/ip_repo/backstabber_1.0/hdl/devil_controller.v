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


module devil_controller#(
        parameter integer C_S_AXI_DATA_WIDTH    = 32, 
        parameter integer C_ACE_DATA_WIDTH      = 128,
        parameter integer C_ACE_ADDR_WIDTH      = 44,
        parameter integer DEVIL_STATE_SIZE      = 5 // 32 states
        )
        (
        input  wire                             ace_aclk,
        input  wire                             ace_aresetn,
        input  wire                       [3:0] i_cmd,
        input  wire                             i_trigger,
        output wire      [DEVIL_STATE_SIZE-1:0] o_fsm_devil_controller,
        output wire  [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line_2_monitor,
        input  wire                             i_pattern_match
    );

//------------------------------------------------------------------------------
// INPUTS/OUTPUTS
//------------------------------------------------------------------------------
    assign o_fsm_devil_controller = fsm_devil_controller;
//------------------------------------------------------------------------------
// FSM STATES AND DEFINES
//------------------------------------------------------------------------------
    parameter [DEVIL_STATE_SIZE-1:0]    DEVIL_IDLE              = 0,
                                        DEVIL_CHOOSE_CMD        = 1,
                                        DEVIL_CMD_REROUTING     = 2, 
                                        DEVIL_CMD_LEAK          = 3,
                                        DEVIL_CMD_POISON        = 4, 
                                        DEVIL_END_OP            = 5;

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
 
//------------------------------------------------------------------------------
// REGISTERS
//------------------------------------------------------------------------------ 
    reg   [DEVIL_STATE_SIZE-1:0] fsm_devil_controller;        

//------------------------------------------------------------------------------
// FSM
//------------------------------------------------------------------------------
    always @(posedge ace_aclk)
    begin
    if(~ace_aresetn)
        begin
        fsm_devil_controller <= DEVIL_IDLE;
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
                    fsm_devil_controller <= DEVIL_END_OP;                                                  
                end
            DEVIL_CMD_LEAK:  
                begin 
                    if(i_pattern_match)
                    begin
                        // issue the read snoop, for the passive devil to take action
                        // and issue a read cache line to active devil
                        // addr = X
                        // snoop = Y
                        fsm_devil_controller <= DEVIL_END_OP; 
                    end
                    else
                        fsm_devil_controller <= fsm_devil_controller;                                               
                end
            DEVIL_CMD_POISON:  
                begin 
                    fsm_devil_controller <= DEVIL_END_OP;                                                  
                end
            DEVIL_END_OP:  
                begin 
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
