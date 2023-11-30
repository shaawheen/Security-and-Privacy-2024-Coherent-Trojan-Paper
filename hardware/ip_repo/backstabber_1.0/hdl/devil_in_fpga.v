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

    // parameter [DEVIL_STATE_SIZE-1:0]    DEVIL_IDLE                  = 0,
    //                                     DEVIL_ONE_SHOT_DELAY        = 1,
    //                                     DEVIL_CONTINUOS_DELAY       = 2,
    //                                     DEVIL_RESPONSE              = 3,
    //                                     DEVIL_DELAY                 = 4,
    //                                     DEVIL_FILTER                = 5,
    //                                     DEVIL_FUNCTION              = 6,
    //                                     DEVIL_END_OP                = 7,
    //                                     DEVIL_DUMMY_REPLY           = 8,
    //                                     DEVIL_END_REPLY             = 9,
    //                                     DEVIL_ACTIVE_DATA_LEAK      = 10, // migrate to active FSM
    //                                     DEVIL_ACTIVE_DATA_TAMP      = 11, // migrate to active FSM
    //                                     DEVIL_PASSIVE_DATA_TAMP     = 12,
    //                                     // Active Path States 
    //                                     DEVIL_AR_PHASE              = 13,
    //                                     DEVIL_R_PHASE               = 14,
    //                                     DEVIL_RACK                  = 15,
    //                                     DEVIL_AW_PHASE              = 16,
    //                                     DEVIL_W_PHASE               = 17,
    //                                     DEVIL_B_PHASE               = 18,
    //                                     DEVIL_WACK                  = 19;


//     reg [C_S_AXI_DATA_WIDTH-1:0] r_status_reg;
//     reg   [DEVIL_STATE_SIZE-1:0] fsm_devil_state_passive;        
//     reg   [DEVIL_STATE_SIZE-1:0] fsm_devil_state_active;        
//     reg                    [4:0] r_crresp;
//     reg                          r_crvalid;
//     reg                          r_cdvalid;
//     reg                          r_cdlast;
//     reg   [C_ACE_DATA_WIDTH-1:0] r_rdata;
//     reg                   [63:0] r_counter; 
//     reg                          r_end_op;
//     reg                          r_end_op_active;
//     reg                          r_reply;
//     reg                          r_reply_active;
//     reg                    [3:0] r_return;
//     reg                    [7:0] r_burst_cnt;
//     reg                  [127:0] r_buff[3:0]; // 4 elements of 16 bytes
//     reg                    [1:0] r_index_active;

//     assign o_cache_line = {r_buff[3], r_buff[2], r_buff[1], r_buff[0]};
//     assign o_wdata = r_index_active == 1 ? i_cache_line[127+128*1:0+128*1]: 
//                      r_index_active == 2 ? i_cache_line[127+128*2:0+128*2]: 
//                      r_index_active == 3 ? i_cache_line[127+128*3:0+128*3]: 
//                      i_cache_line[127+128*0:0+128*0]; // 128 bits

//     // Devil-in-the-fpga snoop request handshake
//     // wire handshake;
//     // wire w_acready;
//     // assign w_acready = (fsm_devil_state_passive == DEVIL_RESPONSE) || (fsm_devil_state_passive == DEVIL_DUMMY_REPLY);
//     // assign w_acready = (fsm_devil_state_passive == DEVIL_IDLE);
//     // assign handshake = w_acready && i_acvalid;

//     assign o_fsm_devil_state = fsm_devil_state_passive; 
//     assign o_fsm_devil_state_active = fsm_devil_state_active; 
//     assign o_write_status_reg = r_status_reg;
//     assign o_crresp = r_crresp;
//     assign o_crvalid = r_crvalid;
//     assign o_cdvalid = r_cdvalid;
//     assign o_cdlast = r_cdlast;
//     assign o_rdata = r_rdata;
//     assign o_end = r_end_op;
//     // assign o_acready = w_acready;
//     assign o_counter = r_counter;
//     assign o_reply = (r_reply || r_reply_active);
//     assign o_busy = (fsm_devil_state_passive != DEVIL_IDLE);

//     `define NUM_OF_CYCLES   1 // 7 ns  -> 1/150Mhz
//     // `define NUM_OF_CYCLES   150 // 1 us 
//     `define OKAY                2'b00

//     // Read and Write channel Flags (Active Path)
//     assign o_ar_phase   = (fsm_devil_state_active == DEVIL_AR_PHASE)   ? 1:0;
//     assign o_r_phase    = (fsm_devil_state_active == DEVIL_R_PHASE)    ? 1:0;
//     assign o_rack_phase = (fsm_devil_state_active == DEVIL_RACK)       ? 1:0;
//     assign o_aw_phase   = (fsm_devil_state_active == DEVIL_AW_PHASE)   ? 1:0;
//     assign o_w_phase    = (fsm_devil_state_active == DEVIL_W_PHASE)    ? 1:0;
//     assign o_b_phase    = (fsm_devil_state_active == DEVIL_B_PHASE)    ? 1:0;
//     assign o_wack_phase = (fsm_devil_state_active == DEVIL_WACK)       ? 1:0;

//     // Read Channel Signals

//     // Write Channel Signals
//     assign o_wlast = (r_index_active == 3);

//     // Devil-in-the-fpga Functions
//     `define OSH    4'b0000 
//     `define CON    4'b0001 
//     `define ADL    4'b0010 
//     `define ADT    4'b0011 
//     `define PDT    4'b0100 

//     // Devil-in-the-fpga Tests
//     `define FUZZING                   4'b0000
//     `define REPLY_WITH_DELAY_CRVALID  4'b0001
//     `define REPLY_WITH_DELAY_CDVALID  4'b0010
//     `define REPLY_WITH_DELAY_CDLAST   4'b0011   

//     // Filters
//     `define NO_FILTER       2'b00
//     `define AC_FILTER       2'b01
//     `define ADDR_FILTER     2'b10
//     `define AC_ADDR_FILTER  2'b11  

//     wire w_ac_filter;
//     wire w_addr_filter;
//     // ac and addr filters are applied to the acaddr and acsnoop at the time of
//     //the achandshake, bacause once the handshake happens, a new snoop is generated
//     assign w_ac_filter      = (i_acsnoop_snapshot[3:0] == i_acsnoop_reg[3:0]) ? 1 : 0;
//     assign w_addr_filter    = (i_acaddr_snapshot[31:0] >= i_base_addr_reg[31:0]) && (i_acaddr_snapshot[31:0] < (i_base_addr_reg[31:0] + i_addr_size_reg[31:0])) ? 1 : 0;

// // Devil-in-the-fpga Control Reg parameters/bits
//     wire       w_en;
//     wire [3:0] w_test;
//     wire [3:0] w_func;
//     wire [4:0] w_crresp;
//     wire       w_acf_lt;    
//     wire       w_addr_flt;    
//     wire       w_con_en;    
//     wire       w_osh_en;    
//     wire       w_adl_en; // Active Data Leak Enable    
//     wire       w_adt_en; // Active Data Tampering Enable   
//     wire       w_pdt_en; // Passive Data Tampering Enable
//     assign w_en = i_control_reg[0];
//     assign w_test = i_control_reg[4:1];
//     assign w_func = i_control_reg[8:5];
//     assign w_crresp = i_control_reg[13:9];
//     assign w_acf_lt = i_control_reg[14];
//     assign w_addr_flt = i_control_reg[15];
//     assign w_osh_en = i_control_reg[16];
//     assign w_con_en = i_control_reg[17];
//     assign w_adl_en = i_control_reg[18]; // Active Data Leak Enable   
//     assign w_adt_en = i_control_reg[19]; // Active Data Tampering Enable
//     assign w_pdt_en = i_control_reg[20]; // Passive Data Tampering Enable


    wire       [DEVIL_STATE_SIZE-1:0] w_fsm_devil_state;
    wire       [DEVIL_STATE_SIZE-1:0] w_fsm_devil_state_active;
    wire     [C_S_AXI_DATA_WIDTH-1:0] w_write_status_reg;
    wire       [C_ACE_DATA_WIDTH-1:0] w_rdata;
    wire                        [4:0] w_crresp;
    wire                              w_crvalid;
    wire                              w_cdvalid;
    wire                              w_cdlast;
    wire                              w_end;
    wire                              w_reply;
    wire                              w_reply_active;
    wire                              w_busy;
    wire                              w_ar_phase;
    wire                              w_r_phase;
    wire                              w_rack_phase;
    wire                              w_aw_phase;
    wire                              w_w_phase;
    wire                              w_b_phase;
    wire                              w_wack_phase;
    wire                              w_wlast;
    wire       [C_ACE_DATA_WIDTH-1:0] w_wdata;
    wire   [(C_ACE_DATA_WIDTH*4)-1:0] w_read_cache_line;
    wire                       [63:0] w_counter;

    assign o_fsm_devil_state =  w_fsm_devil_state;
    assign o_fsm_devil_state_active =  w_fsm_devil_state_active;
    assign o_write_status_reg =  w_write_status_reg;
    assign o_rdata =  w_rdata;
    assign o_crresp =  w_crresp;
    assign o_crvalid =  w_crvalid;
    assign o_cdvalid =  w_cdvalid;
    assign o_cdlast =  w_cdlast;
    assign o_end =  w_end;
    assign o_reply =  (w_reply || w_reply_active);;
    assign o_busy =  w_busy;
    assign o_ar_phase =  w_ar_phase;
    assign o_r_phase =  w_r_phase;
    assign o_rack_phase =  w_rack_phase;
    assign o_aw_phase =  w_aw_phase;
    assign o_w_phase =  w_w_phase;
    assign o_b_phase =  w_b_phase;
    assign o_wack_phase =  w_wack_phase;
    assign o_wlast =  w_wlast;
    assign o_wdata =  w_wdata;
    assign o_cache_line =  w_read_cache_line;
    assign o_counter =  w_counter;

    // Instantiation Passive devil module
    passive_devil #(
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .C_ACE_DATA_WIDTH(C_ACE_DATA_WIDTH),
        .C_ACE_ADDR_WIDTH(C_ACE_ADDR_WIDTH),
        .DEVIL_EN(DEVIL_EN)
    ) passive_devil_inst(
        .ace_aclk(ace_aclk),
        .ace_aresetn(ace_aresetn),
        .acsnoop(acsnoop),
        .acaddr(acaddr),
        .i_arlen(i_arlen),
        .i_snoop_state(i_snoop_state),
        .o_fsm_devil_state(w_fsm_devil_state),
        .i_control_reg(i_control_reg),
        .i_read_status_reg(i_read_status_reg), // The Value that User Writes to Status Reg
        .o_write_status_reg(w_write_status_reg), // The Value that the this IP Writes to Status Reg 
        .i_delay_reg(i_delay_reg),
        .i_acsnoop_reg(i_acsnoop_reg),
        .i_base_addr_reg(i_base_addr_reg),
        .i_addr_size_reg(i_addr_size_reg),
        .o_rdata(w_rdata),
        .o_crresp(w_crresp),
        .o_crvalid(w_crvalid),
        .o_cdvalid(w_cdvalid),
        .o_cdlast(w_cdlast),
        .o_end(w_end),
        .i_trigger_passive_path(i_trigger_passive_path),
        .i_trigger_active_path(i_trigger_active_path),
        .i_crready(i_crready),
        .o_reply(w_reply),
        .o_busy(w_busy),
        .i_cdready(i_cdready),
        .i_acaddr_snapshot(i_acaddr_snapshot),
        .i_acsnoop_snapshot(i_acsnoop_snapshot),
        .i_arready(i_arready),
        .i_rready(i_rready),
        .i_rvalid(i_rvalid),
        .i_rdata(i_rdata),
        .i_rlast(i_rlast),
        .i_awready(i_awready),
        .i_wready(i_wready),
        .i_wvalid(i_wvalid),
        .i_wlast(i_wlast),
        .i_bresp(i_bresp),
        .i_bvalid(i_bvalid),
        .i_bready(i_bready),
        .i_cache_line(i_cache_line),
        .o_counter(w_counter) // test porpuses
    );

    // Instantiation Active devil module
    active_devil #(
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .C_ACE_DATA_WIDTH(C_ACE_DATA_WIDTH),
        .C_ACE_ADDR_WIDTH(C_ACE_ADDR_WIDTH),
        .DEVIL_EN(DEVIL_EN)
    ) active_devil_inst(
        .ace_aclk(ace_aclk),
        .ace_aresetn(ace_aresetn),
        .acsnoop(acsnoop),
        .acaddr(acaddr),
        .i_arlen(i_arlen),
        .i_snoop_state(i_snoop_state),
        .o_fsm_devil_state_active(w_fsm_devil_state_active),
        .i_control_reg(i_control_reg),
        .i_read_status_reg(i_read_status_reg), // The Value that User Writes to Status Reg
        .i_delay_reg(i_delay_reg),
        .i_acsnoop_reg(i_acsnoop_reg),
        .i_base_addr_reg(i_base_addr_reg),
        .i_addr_size_reg(i_addr_size_reg),
// .o_end(w_devil_end), //To implement
        .i_trigger_passive_path(i_trigger_passive_path),
        .i_trigger_active_path(i_trigger_active_path),
        .i_crready(i_crready),
        .o_reply(w_reply_active),
// .o_busy(w_devil_busy), //To implement
        .i_cdready(i_cdready),
        .i_acaddr_snapshot(i_acaddr_snapshot),
        .i_acsnoop_snapshot(i_acsnoop_snapshot),
        .o_ar_phase(w_devil_ar_phase),
        .o_r_phase(w_devil_r_phase),
        .o_rack_phase(w_devil_rack_phase),
        .o_aw_phase(w_devil_aw_phase),
        .o_w_phase(w_devil_w_phase),
        .o_b_phase(w_devil_b_phase),
        .o_wack_phase(w_devil_wack_phase),
        .o_wlast(w_wlast),
        .o_wdata(w_wdata),
        .i_arready(i_arready),
        .i_rready(i_rready),
        .i_rvalid(i_rvalid),
        .i_rdata(i_rdata),
        .i_rlast(i_rlast),
        .i_awready(i_awready),
        .i_wready(i_wready),
        .i_wvalid(i_wvalid),
        .i_wlast(i_wlast),
        .i_bresp(i_bresp),
        .i_bvalid(i_bvalid),
        .i_bready(i_bready),
        .o_cache_line(w_read_cache_line),       
        .i_cache_line(i_cache_line)
    );
                           

    endmodule
