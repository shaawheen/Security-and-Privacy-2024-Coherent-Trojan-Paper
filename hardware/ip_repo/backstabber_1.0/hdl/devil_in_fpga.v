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
        parameter integer DEVIL_EN              = 10,
        parameter integer DEVIL_STATE_SIZE      = 5 // 32 states
        )
        (
        input  wire                              ace_aclk,
        input  wire                              ace_aresetn,
        input  wire                        [3:0] acsnoop,
        input  wire       [C_ACE_ADDR_WIDTH-1:0] acaddr,
        input  wire                        [7:0] i_arlen,
        input  wire                        [3:0] i_snoop_state,
        output wire       [DEVIL_STATE_SIZE-1:0] o_fsm_devil_state,
        output wire       [DEVIL_STATE_SIZE-1:0] o_fsm_devil_state_active,
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
        input  wire                              i_crready,
        input  wire                              i_trigger_passive_path,
        input  wire                              i_trigger_active_path,
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
        input wire                               i_bresp,
        input wire                               i_bvalid,
        input wire                               i_bready,
        output wire   [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line, 
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line, 
        output wire                       [63:0] o_counter // test porpuses
    );

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
                                        DEVIL_ACTIVE_DATA_LEAK      = 10, // migrate to active FSM
                                        DEVIL_ACTIVE_DATA_TAMP      = 11, // migrate to active FSM
                                        DEVIL_PASSIVE_DATA_TAMP     = 12,
                                        // Active Path States 
                                        DEVIL_AR_PHASE              = 13,
                                        DEVIL_R_PHASE               = 14,
                                        DEVIL_RACK                  = 15,
                                        DEVIL_AW_PHASE              = 16,
                                        DEVIL_W_PHASE               = 17,
                                        DEVIL_B_PHASE               = 18,
                                        DEVIL_WACK                  = 19;


    reg [C_S_AXI_DATA_WIDTH-1:0] r_status_reg;
    reg   [DEVIL_STATE_SIZE-1:0] fsm_devil_state_passive;        
    reg   [DEVIL_STATE_SIZE-1:0] fsm_devil_state_active;        
    reg                    [4:0] r_crresp;
    reg                          r_crvalid;
    reg                          r_cdvalid;
    reg                          r_cdlast;
    reg   [C_ACE_DATA_WIDTH-1:0] r_rdata;
    reg                   [63:0] r_counter; 
    reg                          r_end_op;
    reg                          r_end_op_active;
    reg                          r_reply;
    reg                          r_reply_active;
    reg                    [3:0] r_return;
    reg                    [7:0] r_burst_cnt;
    reg                  [127:0] r_buff[3:0]; // 4 elements of 16 bytes
    reg                    [1:0] r_index_active;

    assign o_cache_line = {r_buff[3], r_buff[2], r_buff[1], r_buff[0]};
    assign o_wdata = r_index_active == 1 ? i_cache_line[127+128*1:0+128*1]: 
                     r_index_active == 2 ? i_cache_line[127+128*2:0+128*2]: 
                     r_index_active == 3 ? i_cache_line[127+128*3:0+128*3]: 
                     i_cache_line[127+128*0:0+128*0]; // 128 bits

    // Devil-in-the-fpga snoop request handshake
    // wire handshake;
    // wire w_acready;
    // assign w_acready = (fsm_devil_state_passive == DEVIL_RESPONSE) || (fsm_devil_state_passive == DEVIL_DUMMY_REPLY);
    // assign w_acready = (fsm_devil_state_passive == DEVIL_IDLE);
    // assign handshake = w_acready && i_acvalid;

    assign o_fsm_devil_state = fsm_devil_state_passive; 
    assign o_fsm_devil_state_active = fsm_devil_state_active; 
    assign o_write_status_reg = r_status_reg;
    assign o_crresp = r_crresp;
    assign o_crvalid = r_crvalid;
    assign o_cdvalid = r_cdvalid;
    assign o_cdlast = r_cdlast;
    assign o_rdata = r_rdata;
    assign o_end = r_end_op;
    // assign o_acready = w_acready;
    assign o_counter = r_counter;
    assign o_reply = (r_reply || r_reply_active);
    assign o_busy = (fsm_devil_state_passive != DEVIL_IDLE);

    `define NUM_OF_CYCLES   1 // 7 ns  -> 1/150Mhz
    // `define NUM_OF_CYCLES   150 // 1 us 
    `define OKAY                2'b00

    // Read and Write channel Flags (Active Path)
    assign o_ar_phase   = (fsm_devil_state_active == DEVIL_AR_PHASE)   ? 1:0;
    assign o_r_phase    = (fsm_devil_state_active == DEVIL_R_PHASE)    ? 1:0;
    assign o_rack_phase = (fsm_devil_state_active == DEVIL_RACK)       ? 1:0;
    assign o_aw_phase   = (fsm_devil_state_active == DEVIL_AW_PHASE)   ? 1:0;
    assign o_w_phase    = (fsm_devil_state_active == DEVIL_W_PHASE)    ? 1:0;
    assign o_b_phase    = (fsm_devil_state_active == DEVIL_B_PHASE)    ? 1:0;
    assign o_wack_phase = (fsm_devil_state_active == DEVIL_WACK)       ? 1:0;

    // Read Channel Signals

    // Write Channel Signals
    assign o_wlast = (r_index_active == 3);

    // Devil-in-the-fpga Functions
    `define OSH    4'b0000 
    `define CON    4'b0001 
    `define ADL    4'b0010 
    `define ADT    4'b0011 
    `define PDT    4'b0100 

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
    // ac and addr filters are applied to the acaddr and acsnoop at the time of
    //the achandshake, bacause once the handshake happens, a new snoop is generated
    assign w_ac_filter      = (i_acsnoop_snapshot[3:0] == i_acsnoop_reg[3:0]) ? 1 : 0;
    assign w_addr_filter    = (i_acaddr_snapshot[31:0] >= i_base_addr_reg[31:0]) && (i_acaddr_snapshot[31:0] < (i_base_addr_reg[31:0] + i_addr_size_reg[31:0])) ? 1 : 0;

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
    assign w_func = i_control_reg[8:5];
    assign w_crresp = i_control_reg[13:9];
    assign w_acf_lt = i_control_reg[14];
    assign w_addr_flt = i_control_reg[15];
    assign w_osh_en = i_control_reg[16];
    assign w_con_en = i_control_reg[17];
    assign w_adl_en = i_control_reg[18]; // Active Data Leak Enable   
    assign w_adt_en = i_control_reg[19]; // Active Data Tampering Enable
    assign w_pdt_en = i_control_reg[20]; // Passive Data Tampering Enable

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
        r_burst_cnt <= 0;
        r_status_reg <= 0;
        fsm_devil_state_passive <= DEVIL_IDLE;
        end 
    else
        begin
            case (fsm_devil_state_passive)                                                                                                                                 
            DEVIL_IDLE: 
                begin
                    r_reply <= 0;
                    
                    if(i_trigger_passive_path)
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
                        `NO_FILTER  : fsm_devil_state_passive <= DEVIL_FUNCTION;
                        `AC_FILTER  : 
                        begin
                            if(w_ac_filter)
                                fsm_devil_state_passive <= DEVIL_FUNCTION;  
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        `ADDR_FILTER  : 
                        begin
                            if(w_addr_filter)
                                fsm_devil_state_passive <= DEVIL_FUNCTION;  
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        `AC_ADDR_FILTER  : 
                        begin
                            if(w_addr_filter && w_ac_filter)
                                fsm_devil_state_passive <= DEVIL_FUNCTION;  
                            else
                                fsm_devil_state_passive <= DEVIL_DUMMY_REPLY;
                        end
                        default : fsm_devil_state_passive <= DEVIL_DUMMY_REPLY; 
                    endcase                                                     
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
                                fsm_devil_state_passive <= DEVIL_PASSIVE_DATA_TAMP;  
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
            DEVIL_PASSIVE_DATA_TAMP: // 12
                begin
                    if (i_crready)                                      
                    begin                            
                        r_crresp <= w_crresp[4:0];
                        r_crvalid <= 1;
                        r_cdvalid <= 1; 
                        if(i_cdready) begin // cdvalid/ data must not change until cdready is asserted   
                            r_burst_cnt <= r_burst_cnt + 1;
                            r_rdata <=  r_burst_cnt == 1 ? i_cache_line[127+128*1:0+128*1]: 
                                        r_burst_cnt == 2 ? i_cache_line[127+128*2:0+128*2]: 
                                        r_burst_cnt == 3 ? i_cache_line[127+128*3:0+128*3]: 
                                        i_cache_line[127+128*0:0+128*0]; 
                            if( (i_arlen == 0) || (r_burst_cnt == i_arlen)) 
                            begin // last reply
                                r_cdlast <= 1;                                
                                fsm_devil_state_passive  <= DEVIL_END_OP;  
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
                        r_rdata <= w_crresp[4:0]; // outputing w_crresp just to check if it is right

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
                    fsm_devil_state_passive <= DEVIL_IDLE;                                                  
                end
            default :                                                                
                begin                                                                  
                    fsm_devil_state_passive <= DEVIL_IDLE;                                     
                end                                                                    
            endcase            
        end
    end      


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

                    if(i_trigger_active_path)
                        fsm_devil_state_active <= DEVIL_FUNCTION;     
                    else 
                        fsm_devil_state_active <= DEVIL_IDLE;

                    if(r_end_op_active && !w_en)
                    begin
                        // Clean the end bit when the user disbales the IP
                        // Forces the user to set the end bit to 0 before using
                        // the IP again
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
                                fsm_devil_state_active <= DEVIL_ACTIVE_DATA_LEAK;  
                            else
                                fsm_devil_state_active <= DEVIL_END_OP;
                        end
                        `ADT  :
                        begin
                            if (w_adt_en)
                                fsm_devil_state_active <= DEVIL_ACTIVE_DATA_TAMP;  
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
            DEVIL_ACTIVE_DATA_LEAK: // 10
                begin
                    fsm_devil_state_active <= DEVIL_AR_PHASE;                                                  
                    // TO IMPLEMENT
                end
            DEVIL_ACTIVE_DATA_TAMP: // 11
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
