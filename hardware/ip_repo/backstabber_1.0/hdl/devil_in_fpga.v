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
        input  wire                              i_crready,
        input  wire                              i_trigger_passive_path,
        input  wire                              i_trigger_active_path,
        output wire                              o_reply,
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
        input wire                         [1:0] i_bresp,
        input wire                               i_bvalid,
        input wire                               i_bready,
        output wire   [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line, 
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line, 
        output wire                              o_end_active,
        output wire                              o_busy_active,
        output wire                              o_end_passive,
        output wire                              o_busy_passive,
        output wire                       [63:0] o_counter // test porpuses
    );

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
    wire                              w_end_active; 
    wire                              w_busy_active;
    wire                              w_end_passive; 
    wire                              w_busy_passive;


    assign o_fsm_devil_state =  w_fsm_devil_state;
    assign o_fsm_devil_state_active =  w_fsm_devil_state_active;
    assign o_write_status_reg =  w_write_status_reg;
    assign o_rdata =  w_rdata;
    assign o_crresp =  w_crresp;
    assign o_crvalid =  w_crvalid;
    assign o_cdvalid =  w_cdvalid;
    assign o_cdlast =  w_cdlast;
    assign o_reply =  (w_reply || w_reply_active);;
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
    assign o_end_active = w_end_active; 
    assign o_busy_active = w_busy_active;
    assign o_end_passive = w_end_passive; 
    assign o_busy_passive = w_busy_passive;


    // Instantiation Passive devil module
    passive_devil #(
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .C_ACE_DATA_WIDTH(C_ACE_DATA_WIDTH),
        .C_ACE_ADDR_WIDTH(C_ACE_ADDR_WIDTH)
    ) passive_devil_inst(
        .ace_aclk(ace_aclk),
        .ace_aresetn(ace_aresetn),
        .acsnoop(acsnoop),
        .acaddr(acaddr),
        .i_arlen(i_arlen),
        .i_snoop_state(i_snoop_state),
        .o_fsm_devil_state_passive(w_fsm_devil_state),
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
        .o_end(w_end_passive),
        .i_trigger_passive_path(i_trigger_passive_path),
        .i_trigger_active_path(i_trigger_active_path),
        .i_crready(i_crready),
        .o_reply(w_reply),
        .o_busy(w_busy_passive),
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
        .C_ACE_ADDR_WIDTH(C_ACE_ADDR_WIDTH)
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
        .o_end(w_end_active),  
        .i_trigger_passive_path(i_trigger_passive_path),
        .i_trigger_active_path(i_trigger_active_path),
        .i_crready(i_crready),
        .o_reply(w_reply_active),
        .o_busy(w_busy_active), 
        .i_cdready(i_cdready),
        .i_acaddr_snapshot(i_acaddr_snapshot),
        .i_acsnoop_snapshot(i_acsnoop_snapshot),
        .o_ar_phase(w_ar_phase),
        .o_r_phase(w_r_phase),
        .o_rack_phase(w_rack_phase),
        .o_aw_phase(w_aw_phase),
        .o_w_phase(w_w_phase),
        .o_b_phase(w_b_phase),
        .o_wack_phase(w_wack_phase),
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
