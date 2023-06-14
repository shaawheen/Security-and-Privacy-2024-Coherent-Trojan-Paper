`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2023 03:22:36 PM
// Design Name: 
// Module Name: devil_in_fpga
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
 
    module devil_in_fpga #(
        parameter integer C_S_AXI_DATA_WIDTH    = 32, 
        parameter integer C_ACE_DATA_WIDTH      = 128,
        parameter integer DEVIL_EN              = 10
        )
        (
        input  wire                              ace_aclk,
        input  wire                              ace_aresetn,
        input  wire                        [3:0] i_snoop_state,
        output wire                        [3:0] o_fsm_devil_state,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_control_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_read_status_reg,
        output wire     [C_S_AXI_DATA_WIDTH-1:0] o_write_status_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_delay_reg,
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_acsnoop_reg,  
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_base_addr_reg,  
        input  wire     [C_S_AXI_DATA_WIDTH-1:0] i_addr_size_reg,  
        output wire       [C_ACE_DATA_WIDTH-1:0] o_rdata,
        output wire                        [4:0] o_crresp,
        output wire                              o_crvalid,
        output wire                              o_cdvalid,
        output wire                              o_cdlast
    );

    reg [C_S_AXI_DATA_WIDTH-1:0] r_status_reg;
    reg                    [3:0] fsm_devil_state;        
    reg                    [4:0] r_crresp;
    reg                          r_crvalid;
    reg                          r_cdvalid;
    reg                          r_cdlast;
    reg   [C_ACE_DATA_WIDTH-1:0] r_rdata;
    reg                   [63:0] r_counter; 

    assign o_fsm_devil_state = fsm_devil_state;
    assign o_write_status_reg = r_status_reg;
    assign o_crresp = r_crresp;
    assign o_crvalid = r_crvalid;
    assign o_cdvalid = r_cdvalid;
    assign o_cdlast = r_cdlast;
    assign o_rdata = r_rdata;

    `define NUM_OF_CYCLES   150 // 1 us 

// Devil-in-the-fpga Functions
    `define OSH    4'b0000 
    `define CON    4'b0001 

// Devil-in-the-fpga Tests
    `define FUZZING                   4'b0000
    `define REPLY_WITH_DELAY_CRVALID  4'b0001
    `define REPLY_WITH_DELAY_CDVALID  4'b0010
    `define REPLY_WITH_DELAY_CDLAST   4'b0011   

// Devil-in-the-fpga Control Reg parameters/bits
    wire       w_en;
    wire [3:0] w_test;
    wire [3:0] w_func;
    wire [4:0] w_crresp;
    wire       w_acf_lt;    
    wire       w_addr_flt;    
    wire       w_con_en;    
    assign w_en = i_control_reg[0];
    assign w_test = i_control_reg[4:1];
    assign w_func = i_control_reg[8:5];
    assign w_crresp = i_control_reg[13:9];
    assign w_acf_lt = i_control_reg[14];
    assign w_addr_flt = i_control_reg[15];
    assign w_osh_en = i_control_reg[16];
    assign w_con_en = i_control_reg[17];

// Devil-in-the-fpga Control Reg parameters/bits
    wire    w_osh_end;
    assign  w_osh_end = i_read_status_reg[0];

    parameter [3:0] DEVIL_IDLE               = 0,
                    DEVIL_ONE_SHOT_DELAY     = 1,
                    DEVIL_CONTINUOS_DELAY    = 2,
                    DEVIL_RESPONSE           = 3,
                    DEVIL_DELAY              = 4,
                    DEVIL_END                = 5;

    reg [3:0] r_return;

    always @(posedge ace_aclk)
    begin
    if(~ace_aresetn)
        begin
        fsm_devil_state <= DEVIL_IDLE;
        r_status_reg <= 0;
        r_crresp <= 0;
        r_rdata  <= 32'hffff0000;
        r_crvalid <= 0;
        r_cdvalid <= 0;
        r_cdlast <= 0;
        r_counter <= 0;
        end 
    else
        begin
            case (fsm_devil_state)                                                                                                                                 
            DEVIL_IDLE: 
                begin
                    if (i_snoop_state == DEVIL_EN)
                    begin
                        case (w_func[3:0])
                            `OSH  : 
                            begin
                                if (r_status_reg[0] == 0 && w_osh_en)
                                    fsm_devil_state <= DEVIL_ONE_SHOT_DELAY; 
                                else if(r_status_reg[0] == 1 && !w_osh_en)
                                begin
                                    // Clean the osh_end bit when the user disbales OSH func
                                    r_status_reg[0] <= 0;   
                                    fsm_devil_state <= DEVIL_IDLE; 
                                end 
                                else
                                    fsm_devil_state <= DEVIL_IDLE;
                            end
                            `CON  : 
                            begin
                                if (w_con_en)
                                    fsm_devil_state <= DEVIL_CONTINUOS_DELAY;  
                                else
                                    fsm_devil_state <= DEVIL_IDLE;
                            end
                            default : fsm_devil_state <= DEVIL_IDLE; 
                        endcase      
                    end
                    else 
                        fsm_devil_state <= DEVIL_IDLE;                                
                end
            DEVIL_ONE_SHOT_DELAY:
                begin
                    if (r_status_reg[0] == 0 )                                      
                    begin                                                            
                        fsm_devil_state  <= DEVIL_RESPONSE;
                        r_return <= DEVIL_ONE_SHOT_DELAY;                              
                    end  
                    else if(r_status_reg[0] == 1)                                                             
                    begin                                                         
                        fsm_devil_state  <= DEVIL_END;                                      
                    end                                                                                               
                end
            DEVIL_CONTINUOS_DELAY:
                begin
                    if (!w_con_en)                                      
                    begin                                                            
                        fsm_devil_state  <= DEVIL_END;                                      
                    end  
                    else                                                       
                    begin                                                         
                        fsm_devil_state  <= DEVIL_RESPONSE;
                        r_return <= DEVIL_CONTINUOS_DELAY;      
                        r_crvalid <= 0;
                        r_cdvalid <= 0;
                        r_cdlast <= 0;                        
                    end                                                                                               
                end
            DEVIL_RESPONSE:
                begin
                    if(w_func[3:0] == `OSH)
                    begin
                        r_status_reg[0] <= 1; 
                    end
             
                    r_crresp <= w_crresp[4:0];
                    r_rdata <= w_crresp[4:0]; // outputing w_crresp just to check if it is right

                    case (w_test[3:0])
                        `FUZZING: 
                        begin
                            r_crvalid <= 1;
                            r_cdvalid <= 1; 
                            r_cdlast <= 1;
                            fsm_devil_state  <= r_return; 
                        end
                        `REPLY_WITH_DELAY_CRVALID: 
                        begin
                            // r_crvalid <= 1;
                            r_cdvalid <= 1; 
                            r_cdlast <= 1;
                            fsm_devil_state  <= DEVIL_DELAY;
                        end 
                        `REPLY_WITH_DELAY_CDVALID:  
                        begin
                            r_crvalid <= 1;
                            // r_cdvalid <= 1; 
                            r_cdlast <= 1;
                            fsm_devil_state  <= DEVIL_DELAY;
                        end 
                        `REPLY_WITH_DELAY_CDLAST:  
                        begin
                            r_crvalid <= 1;
                            r_cdvalid <= 1; 
                            // r_cdlast <= 1;
                            fsm_devil_state  <= DEVIL_DELAY;
                        end 
                        default : 
                        begin
                            r_crvalid <= r_crvalid;
                            r_cdvalid <= r_cdvalid; 
                            r_cdlast <= r_cdlast;
                            fsm_devil_state  <= r_return; 
                        end
                    endcase                                      
                end
            DEVIL_DELAY:
                begin
                    // wait some cycles to respond
                    if(r_counter == `NUM_OF_CYCLES*i_delay_reg[31:0] )
                    begin
                        r_counter <= 0;
                        case (w_test[3:0])
                            `REPLY_WITH_DELAY_CRVALID: 
                            begin
                                r_crvalid <= 1;
                                fsm_devil_state  <= r_return; 
                            end 
                            `REPLY_WITH_DELAY_CDVALID:  
                            begin
                                r_cdvalid <= 1; 
                                fsm_devil_state  <= r_return; 
                            end 
                            `REPLY_WITH_DELAY_CDLAST:  
                            begin
                                r_cdlast <= 1;
                                fsm_devil_state  <= r_return; 
                            end 
                            default : 
                            begin
                                r_crvalid <= r_crvalid;
                                r_cdvalid <= r_cdvalid; 
                                r_cdlast <= r_cdlast;
                                fsm_devil_state  <= r_return; 
                            end
                        endcase                
                    end
                    else
                    begin
                        r_counter <= r_counter + 1;
                        fsm_devil_state <= DEVIL_DELAY;
                    end                                
                end
            DEVIL_END: // State to signal the End of the FSM operation
                begin
                    r_crvalid <= 0;
                    r_cdvalid <= 0;
                    r_cdlast <= 0;
                    fsm_devil_state <= DEVIL_IDLE;                                                  
                end
            default :                                                                
                begin                                                                  
                    fsm_devil_state <= DEVIL_IDLE;                                     
                end                                                                    
            endcase            
        end
    end                                        

    endmodule