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
        parameter integer C_ACE_ADDR_WIDTH      = 44,
        parameter integer DEVIL_EN              = 10
        )
        (
        input  wire                              ace_aclk,
        input  wire                              ace_aresetn,
        input  wire                        [3:0] acsnoop,
        input  wire       [C_ACE_ADDR_WIDTH-1:0] acaddr,
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
        output wire                              o_cdlast,
        output wire                              o_end,
        input  wire                              i_acvalid,
        input  wire                              i_crready,
        output wire                              o_acready, 
        output wire                              o_reply,
        output wire                       [63:0] o_counter // test porpuses
    );

    parameter [3:0] DEVIL_IDLE               = 0,
                    DEVIL_ONE_SHOT_DELAY     = 1,
                    DEVIL_CONTINUOS_DELAY    = 2,
                    DEVIL_RESPONSE           = 3,
                    DEVIL_DELAY              = 4,
                    DEVIL_FILTER             = 5,
                    DEVIL_FUNCTION           = 6,
                    DEVIL_END_OP             = 7,
                    DEVIL_DUMMY_REPLY        = 8,
                    DEVIL_END_REPLY          = 9;


    reg [C_S_AXI_DATA_WIDTH-1:0] r_status_reg;
    reg                    [3:0] fsm_devil_state;        
    reg                    [4:0] r_crresp;
    reg                          r_crvalid;
    reg                          r_cdvalid;
    reg                          r_cdlast;
    reg   [C_ACE_DATA_WIDTH-1:0] r_rdata;
    reg                   [63:0] r_counter; 
    reg                          r_end_op;
    reg                          r_reply;
    reg                    [3:0] r_return;

    // Devil-in-the-fpga snoop request handshake
    wire handshake;
    wire w_acready;
    assign w_acready = (fsm_devil_state == DEVIL_IDLE) ? 1 : 0;
    assign handshake = w_acready && i_acvalid ? 1 : 0;

    assign o_fsm_devil_state = fsm_devil_state;
    assign o_write_status_reg = r_status_reg;
    assign o_crresp = r_crresp;
    assign o_crvalid = r_crvalid;
    assign o_cdvalid = r_cdvalid;
    assign o_cdlast = r_cdlast;
    assign o_rdata = r_rdata;
    assign o_end = r_end_op;
    assign o_acready = w_acready;
    assign o_counter = r_counter;
    assign o_reply = r_reply;

    `define NUM_OF_CYCLES   150 // 1 us 

// Devil-in-the-fpga Functions
    `define OSH    4'b0000 
    `define CON    4'b0001 

// Devil-in-the-fpga Tests
    `define FUZZING                   4'b0000
    `define REPLY_WITH_DELAY_CRVALID  4'b0001
    `define REPLY_WITH_DELAY_CDVALID  4'b0010
    `define REPLY_WITH_DELAY_CDLAST   4'b0011   

// Filters
    `define NO_FILTER       2'b00
    `define AC_FILTER       2'b01
    `define ADDR_FILTER     2'b10
    `define AC_ADDR_FILTER  2'b11  

    wire w_ac_filter;
    wire w_addr_filter;
    assign w_ac_filter      = (acsnoop[3:0] == i_acsnoop_reg[3:0]) ? 1 : 0;
    assign w_addr_filter    = (acaddr[31:0] >= i_base_addr_reg[31:0]) && (acaddr[31:0] < (i_base_addr_reg[31:0] + i_addr_size_reg[31:0])) ? 1 : 0;

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

    always @(posedge ace_aclk)
    begin
    if(~ace_aresetn)
        begin
        r_reply <= 0;
        r_end_op <= 0;
        r_cdlast <= 0;
        r_crresp <= 0;
        r_rdata  <= 0;
        r_crvalid <= 0;
        r_cdvalid <= 0;
        r_counter <= 0;
        r_status_reg <= 0;
        fsm_devil_state <= DEVIL_IDLE;
        end 
    else
        begin
            case (fsm_devil_state)                                                                                                                                 
            DEVIL_IDLE: 
                begin
                    r_reply <= 0;
                    if (i_snoop_state == DEVIL_EN && !r_end_op && handshake)
                        fsm_devil_state <= DEVIL_FILTER;     
                    else 
                        fsm_devil_state <= DEVIL_IDLE;   

                    if(r_status_reg[0] == 1 && !w_osh_en)
                    begin
                        // Clean the osh_end bit when the user disbales OSH func
                        r_status_reg[0] <= 0;    
                    end 

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
                        `NO_FILTER  : fsm_devil_state <= DEVIL_FUNCTION;
                        `AC_FILTER  : 
                        begin
                            if(w_ac_filter)
                                fsm_devil_state <= DEVIL_FUNCTION;  
                            else
                                fsm_devil_state <= DEVIL_DUMMY_REPLY;
                        end
                        `ADDR_FILTER  : 
                        begin
                            if(w_addr_filter)
                                fsm_devil_state <= DEVIL_FUNCTION;  
                            else
                                fsm_devil_state <= DEVIL_DUMMY_REPLY;
                        end
                        `AC_ADDR_FILTER  : 
                        begin
                            if(w_addr_filter && w_ac_filter)
                                fsm_devil_state <= DEVIL_FUNCTION;  
                            else
                                fsm_devil_state <= DEVIL_DUMMY_REPLY;
                        end
                        default : fsm_devil_state <= DEVIL_DUMMY_REPLY; 
                    endcase                                                     
                end
            DEVIL_FUNCTION: // 6
                begin
                    case (w_func[3:0])
                        `OSH  : 
                        begin
                            if (r_status_reg[0] == 0 && w_osh_en)
                                fsm_devil_state <= DEVIL_ONE_SHOT_DELAY; 
                            else 
                                fsm_devil_state <= DEVIL_DUMMY_REPLY;
                        end
                        `CON  : 
                        begin
                            if (w_con_en)
                                fsm_devil_state <= DEVIL_CONTINUOS_DELAY;  
                            else
                                fsm_devil_state <= DEVIL_DUMMY_REPLY;
                        end
                        default : fsm_devil_state <= DEVIL_DUMMY_REPLY; 
                    endcase                                                      
                end
            DEVIL_DUMMY_REPLY: // 8
                begin
                    if (i_crready)
                    begin
                        r_crresp <= 0;
                        r_rdata <= 0;
                        r_crvalid <= 1;
                        fsm_devil_state  <= DEVIL_END_REPLY;
                    end                           
                    else
                        fsm_devil_state <= fsm_devil_state;
                end
            DEVIL_ONE_SHOT_DELAY: // 1
                begin
                    if (r_status_reg[0] == 0 && i_crready) // just one reply with delay                                      
                    begin                                                            
                        fsm_devil_state  <= DEVIL_RESPONSE;
                        r_return <= DEVIL_END_OP;                              
                    end  
                    else if(r_status_reg[0] && i_crready) // normal reply                                                         
                    begin                          
                        fsm_devil_state  <= DEVIL_DUMMY_REPLY;                                
                    end 
                    else          
                        fsm_devil_state <= fsm_devil_state;                                                                                  
                end
            DEVIL_CONTINUOS_DELAY: //2
                begin
                      if (!w_con_en && i_crready)                                      
                    begin                                                   // just one reply with delay            
                        fsm_devil_state  <= DEVIL_RESPONSE;  
                        r_return <= DEVIL_END_OP; // last reply      
                    end  
                    else if(i_crready) 
                    begin         
                        fsm_devil_state  <= DEVIL_RESPONSE;                                     
                        r_return <= DEVIL_END_REPLY;      
                    end                                                                                               
                    else
                        fsm_devil_state <= fsm_devil_state;
                end
            DEVIL_RESPONSE: // 3
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
                            // r_cdvalid <= 1; 
                            // r_cdlast <= 1;
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
            DEVIL_DELAY: // 4
                begin
                    // wait some cycles to respond
                    if(r_counter == `NUM_OF_CYCLES*i_delay_reg[31:0] )
                    begin
                        r_counter <= 0;
                        case (w_test[3:0])
                            `REPLY_WITH_DELAY_CRVALID: 
                            begin
                                // r_crvalid <= 1;
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
            DEVIL_END_OP: // State to signal the End of the FSM operation
                begin
                    r_crvalid <= 0;
                    r_cdvalid <= 0;
                    r_cdlast <= 0;
                    r_end_op <= 1;
                    r_reply <= 1;
                    fsm_devil_state <= DEVIL_IDLE;                                                  
                end
            DEVIL_END_REPLY: // State to signal the End of a reply
                begin
                    r_crvalid <= 0;
                    r_cdvalid <= 0;
                    r_cdlast <= 0;
                    r_reply <= 1;
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