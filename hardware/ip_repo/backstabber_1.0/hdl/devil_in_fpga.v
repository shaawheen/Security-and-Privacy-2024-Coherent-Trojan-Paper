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
        parameter integer CTRL_IN_SIGNAL_WIDTH  = 1 ,
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

        // Internal Signals, from devil controller to devil passive
        input  wire   [CTRL_IN_SIGNAL_WIDTH-1:0] i_controller_signals,
        input  wire                              i_trigger_from_ctr,
        input  wire                              i_reply_type,

        // Internal Signals, from Devil to Devil Controller
        output wire [(C_ACE_DATA_WIDTH*4)-1:0] o_devil_cache_line,
        output wire                            o_active_r_phase,
        input  wire [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line_active_devil,
        input  wire [(C_ACE_DATA_WIDTH*4)-1:0] i_cache_line_passive_devil,
        input  wire                            i_internal_adl_en,
        input  wire                            i_internal_adt_en,
        input  wire                            i_trigger_active,

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
        input  wire                              i_trigger_passive,
        output wire                              o_reply,
        input  wire       [C_ACE_ADDR_WIDTH-1:0] i_acaddr_snapshot,
        input  wire                        [3:0] i_acsnoop_snapshot,
        input wire        [C_ACE_ADDR_WIDTH-1:0] i_external_araddr,
        input wire                         [3:0] i_external_arsnoop,
        input wire        [C_ACE_ADDR_WIDTH-1:0] i_external_awaddr,
        input wire                         [2:0] i_external_awsnoop,
        input  wire   [(C_ACE_DATA_WIDTH*4)-1:0] i_external_cache_line, 
        output wire                              o_end_active,
        output wire                              o_busy_active,
        output wire                              o_end_passive,
        output wire                              o_busy_passive,
        output wire                              o_external_mode,
        output wire                       [63:0] o_counter // test porpuses
    );

//------------------------------------------------------------------------------
// INPUT/OUTPUT SIGNALS - DEVIL CONTROLLER
//-----------------------------------------------------------------------------
    `include "devil_ctrl_interfaces.vh"

//-----------------------------------------------------------------------------

    // ACE AC Channel (Snoop)
    wire       [C_ACE_ADDR_WIDTH-1:0] w_passive_acaddr;
    wire                        [2:0] w_passive_acprot;
    wire                              w_passive_acready;
    wire                        [3:0] w_passive_acsnoop;
    wire                              w_passive_acvalid;

    // ACE CD Channel (Snoop data)
    wire       [C_ACE_DATA_WIDTH-1:0] w_passive_cddata;
    wire                              w_passive_cdlast;
    wire                              w_passive_cdready;
    wire                              w_passive_cdvalid;

    // ACE CR Channel (Snoop response)
    wire                              w_passive_crready;
    wire                        [4:0] w_passive_crresp;
    wire                              w_passive_crvalid;

    // ACE AR Channel (Read address phase)
    wire       [C_ACE_ADDR_WIDTH-1:0] w_active_araddr;
    wire                        [1:0] w_active_arbar;
    wire                        [1:0] w_active_arburst;
    wire                        [3:0] w_active_arcache;
    wire                        [1:0] w_active_ardomain;
    wire                        [5:0] w_active_arid;
    wire                        [7:0] w_active_arlen;
    wire                              w_active_arlock;
    wire                        [2:0] w_active_arprot;
    wire                        [3:0] w_active_arqos;
    wire                              w_active_arready;
    wire                        [3:0] w_active_arregion;
    wire                        [2:0] w_active_arsize;
    wire                        [3:0] w_active_arsnoop;
    wire                       [15:0] w_active_aruser;
    wire                              w_active_arvalid;

    // ACE R Channel (Read data phase)
    wire                              w_active_rack;
    wire       [C_ACE_DATA_WIDTH-1:0] w_active_rdata;
    wire                        [5:0] w_active_rid;
    wire                              w_active_rlast;
    wire                              w_active_rready;
    wire                        [3:0] w_active_rresp;
    wire                              w_active_ruser;
    wire                              w_active_rvalid;

    // ACE AW channel (Write address phase)
    wire       [C_ACE_ADDR_WIDTH-1:0] w_active_awaddr;
    wire                        [1:0] w_active_awbar;
    wire                        [1:0] w_active_awburst;
    wire                        [3:0] w_active_awcache;
    wire                        [1:0] w_active_awdomain;
    wire                        [5:0] w_active_awid;
    wire                        [7:0] w_active_awlen;
    wire                              w_active_awlock;
    wire                        [2:0] w_active_awprot;
    wire                        [3:0] w_active_awqos;
    wire                              w_active_awready;
    wire                        [3:0] w_active_awregion;
    wire                        [2:0] w_active_awsize;
    wire                        [2:0] w_active_awsnoop;
    wire                       [15:0] w_active_awuser;
    wire                              w_active_awvalid;

    // ACE W channel (Write data phase)
    wire                              w_active_wack;
    wire       [C_ACE_DATA_WIDTH-1:0] w_active_wdata;
    wire                        [5:0] w_active_wid;
    wire                              w_active_wlast;
    wire                              w_active_wready;
    wire                       [15:0] w_active_wstrb;
    wire                              w_active_wuser;
    wire                              w_active_wvalid;

    // ACE B channel (Write response)
    wire                        [5:0] w_active_bid;
    wire                              w_active_bready;
    wire                        [1:0] w_active_bresp;
    wire                              w_active_buser;
    wire                              w_active_bvalid;

    // ACE AC Channel (Snoop)
    assign o_acready = w_passive_acready;
   
    // ACE CD Channel (Snoop data)
    assign o_cddata  = w_passive_cddata;
    assign o_cdlast  = w_passive_cdlast;
    assign o_cdvalid = w_passive_cdvalid;

    // ACE CR Channel (Snoop response)
    assign o_crresp  = w_passive_crresp;
    assign o_crvalid = w_passive_crvalid;

    // ACE AR Channel (Read address phase)
    assign o_araddr     = w_active_araddr;
    assign o_arbar      = w_active_arbar;
    assign o_arburst    = w_active_arburst;
    assign o_arcache    = w_active_arcache;
    assign o_ardomain   = w_active_ardomain;
    assign o_arid       = w_active_arid;
    assign o_arlen      = w_active_arlen;
    assign o_arlock     = w_active_arlock;
    assign o_arprot     = w_active_arprot;
    assign o_arqos      = w_active_arqos;
    assign o_arregion   = w_active_arregion;
    assign o_arsize     = w_active_arsize;
    assign o_arsnoop    = w_active_arsnoop;
    assign o_aruser     = w_active_aruser;
    assign o_arvalid    = w_active_arvalid;

    // ACE R Channel (Read data phase)
    assign o_rack   = w_active_rack;
    assign o_rready = w_active_rready;

    // ACE AW channel (Write address phase)
    assign o_awaddr   = w_active_awaddr;
    assign o_awbar    = w_active_awbar;
    assign o_awburst  = w_active_awburst;
    assign o_awcache  = w_active_awcache;
    assign o_awdomain = w_active_awdomain;
    assign o_awid     = w_active_awid;
    assign o_awlen    = w_active_awlen;
    assign o_awlock   = w_active_awlock;
    assign o_awprot   = w_active_awprot;
    assign o_awqos    = w_active_awqos;
    assign o_awregion = w_active_awregion;
    assign o_awsize   = w_active_awsize;
    assign o_awsnoop  = w_active_awsnoop;
    assign o_awuser   = w_active_awuser;
    assign o_awvalid  = w_active_awvalid;

    // ACE W channel (Write data phase)
    assign o_wack   = w_active_wack;
    assign o_wdata  = w_active_wdata;
    assign o_wid    = w_active_wid;
    assign o_wlast  = w_active_wlast;
    assign o_wstrb  = w_active_wstrb;
    assign o_wuser  = w_active_wuser;
    assign o_wvalid = w_active_wvalid;

    // ACE B channel (Write response)
    assign o_bready = w_active_bready;
                       

    // Output Siginals
    wire       [DEVIL_STATE_SIZE-1:0] w_fsm_devil_state;
    wire       [DEVIL_STATE_SIZE-1:0] w_fsm_devil_state_active;
    wire     [C_S_AXI_DATA_WIDTH-1:0] w_write_status_reg;

    wire                              w_end;
    wire                              w_reply_passive;
    wire                              w_reply_active;
    wire                              w_busy;
    wire                       [63:0] w_counter;
    wire                              w_end_active; 
    wire                              w_busy_active;
    wire                              w_end_passive; 
    wire                              w_busy_passive;
    wire                              w_responding;
    wire       [C_ACE_ADDR_WIDTH-1:0] w_internal_araddr;
    wire                        [3:0] w_internal_arsnoop;
    wire       [C_ACE_ADDR_WIDTH-1:0] w_internal_awaddr;
    wire                        [2:0] w_internal_awsnoop;
    wire                        [1:0] w_internal_ardomain;
    wire                        [3:0] w_func; 
    wire                        [3:0] w_internal_func; 
    wire                              w_external_mode;
    wire                              w_internal_adl_en;
    wire                              w_internal_adt_en;
    wire                              w_active_r_phase;

    // Internal Signals
    wire                             w_trigger_active;
    wire                             w_trigger_from_passive; 
    wire  [(C_ACE_DATA_WIDTH*4)-1:0] w_cache_line;
    wire  [(C_ACE_DATA_WIDTH*4)-1:0] w_active_devil_cache_line;
    wire                             w_action_taken; // set signal on take action passive state
    wire  [CTRL_IN_SIGNAL_WIDTH-1:0] w_to_ctrl_signals;

    assign o_fsm_devil_state        = w_fsm_devil_state;
    assign o_fsm_devil_state_active = w_fsm_devil_state_active;
    assign o_write_status_reg       = w_write_status_reg;
    assign o_reply                  = w_reply_passive;   
    assign o_counter                = w_counter;
    assign o_end_active             = w_end_active; 
    assign o_busy_active            = w_busy_active;
    assign o_end_passive            = w_end_passive; 
    assign o_busy_passive           = w_busy_passive;
    assign w_func                   = (w_trigger_from_passive ? w_internal_func : i_control_reg[8:5]);
    assign o_external_mode          = w_external_mode;
    assign o_controller_signals     = w_to_ctrl_signals;
    assign o_devil_cache_line       = w_active_devil_cache_line;
    assign o_active_r_phase         = w_active_r_phase;

    assign w_trigger_active = i_trigger_active || w_trigger_from_passive ;

    // Instantiation Passive devil module
    passive_devil #(
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .C_ACE_DATA_WIDTH(C_ACE_DATA_WIDTH),
        .C_ACE_ADDR_WIDTH(C_ACE_ADDR_WIDTH),
        .CTRL_IN_SIGNAL_WIDTH(CTRL_IN_SIGNAL_WIDTH)
    ) passive_devil_inst(
        .ace_aclk(ace_aclk),
        .ace_aresetn(ace_aresetn),
        // ACE AC Channel (Snoop)
        .i_acaddr(i_acaddr),
        .i_acprot(i_acprot),
        .o_acready(w_passive_acready),
        .i_acsnoop(i_acsnoop),
        .i_acvalid(i_acvalid),
        // ACE CD Channel (Snoop data)
        .o_cddata(w_passive_cddata),
        .o_cdlast(w_passive_cdlast),
        .i_cdready(i_cdready),
        .o_cdvalid(w_passive_cdvalid),
        // ACE CR Channel (Snoop response)
        .i_crready(i_crready),
        .o_crresp(w_passive_crresp),
        .o_crvalid(w_passive_crvalid),
       
        .i_snoop_state(i_snoop_state),
        .o_fsm_devil_state_passive(w_fsm_devil_state),
        .i_control_reg(i_control_reg),
        .i_read_status_reg(i_read_status_reg), // The Value that User Writes to Status Reg
        .o_write_status_reg(w_write_status_reg), // The Value that the this IP Writes to Status Reg 
        .i_delay_reg(i_delay_reg),
        .i_acsnoop_reg(i_acsnoop_reg),
        .i_base_addr_reg(i_base_addr_reg),
        .i_addr_size_reg(i_addr_size_reg),
        .o_end(w_end_passive),
        .i_trigger_passive(i_trigger_passive),
        .o_trigger_active(w_trigger_from_passive),
        .o_reply(w_reply_passive),
        .o_busy(w_busy_passive),
        .i_acaddr_snapshot(i_acaddr_snapshot),
        .i_acsnoop_snapshot(i_acsnoop_snapshot),
        .o_responding(w_responding),
        .i_active_end(w_end_active),
        .o_action_taken(w_action_taken),
        
        // Internal Signals, from Devil Passive to Devil Active
        .o_internal_func(w_internal_func),
        .o_internal_arsnoop(w_internal_arsnoop),
        .o_internal_araddr(w_internal_araddr),
        .o_internal_awaddr(w_internal_awaddr),
        .o_internal_awsnoop(w_internal_awsnoop),
        .o_internal_ardomain(w_internal_ardomain),
        .o_internal_adl_en(w_internal_adl_en),
        .o_internal_adt_en(w_internal_adt_en),
        .o_external_mode(w_external_mode),

        // Internal Signals, from devil controller to devil passive
        .i_controller_signals(i_controller_signals),
        .i_reply_type(i_reply_type),

        // Internal Signals, Controller In/Out Cache Line
        .i_cache_line(i_cache_line_passive_devil),

        // test porpuses
        .o_counter(w_counter) 
    );
    
    // Instantiation Active devil module
    active_devil #(
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .C_ACE_DATA_WIDTH(C_ACE_DATA_WIDTH),
        .C_ACE_ADDR_WIDTH(C_ACE_ADDR_WIDTH),
        .CTRL_IN_SIGNAL_WIDTH(CTRL_IN_SIGNAL_WIDTH)
    ) active_devil_inst(
        .ace_aclk(ace_aclk),
        .ace_aresetn(ace_aresetn),
        // ACE AR Channel (Read address phase)
        .o_araddr(w_active_araddr),
        .o_arbar(w_active_arbar),
        .o_arburst(w_active_arburst),
        .o_arcache(w_active_arcache),
        .o_ardomain(w_active_ardomain),
        .o_arid(w_active_arid),
        .o_arlen(w_active_arlen),
        .o_arlock(w_active_arlock),
        .o_arprot(w_active_arprot),
        .o_arqos(w_active_arqos),
        .i_arready(i_arready),
        .i_acvalid(i_acvalid),
        .o_arregion(w_active_arregion),
        .o_arsize(w_active_arsize),
        .o_arsnoop(w_active_arsnoop),
        .o_aruser(w_active_aruser),
        .o_arvalid(w_active_arvalid),
        // ACE R Channel (Read data phase)
        .o_rack(w_active_rack),
        .i_rdata(i_rdata),
        .i_rid(i_rid),
        .i_rlast(i_rlast),
        .o_rready(w_active_rready),
        .i_rresp(i_rresp),
        .i_ruser(i_ruser),
        .i_rvalid(i_rvalid),
        // ACE AW channel (Write address phase)
        .o_awaddr(w_active_awaddr),
        .o_awbar(w_active_awbar),
        .o_awburst(w_active_awburst),
        .o_awcache(w_active_awcache),
        .o_awdomain(w_active_awdomain),
        .o_awid(w_active_awid),
        .o_awlen(w_active_awlen),
        .o_awlock(w_active_awlock),
        .o_awprot(w_active_awprot),
        .o_awqos(w_active_awqos),
        .i_awready(i_awready),
        .o_awregion(w_active_awregion),
        .o_awsize(w_active_awsize),
        .o_awsnoop(w_active_awsnoop),
        .o_awuser(w_active_awuser),
        .o_awvalid(w_active_awvalid),
        // ACE W channel (Write data phase)
        .o_wack(w_active_wack),
        .o_wdata(w_active_wdata),
        .o_wid(w_active_wid),
        .o_wlast(w_active_wlast),
        .i_wready(i_wready),
        .o_wstrb(w_active_wstrb),
        .o_wuser(w_active_wuser),
        .o_wvalid(w_active_wvalid),
        // ACE B channel (Write response)
        .i_bid(i_bid),
        .o_bready(w_active_bready),
        .i_bresp(i_bresp),
        .i_buser(i_buser),
        .i_bvalid(i_bvalid),

        .i_snoop_state(i_snoop_state),
        .o_fsm_devil_state_active(w_fsm_devil_state_active),
        .i_control_reg(i_control_reg),
        .i_read_status_reg(i_read_status_reg), // The Value that User Writes to Status Reg
        .i_delay_reg(i_delay_reg),
        .i_acsnoop_reg(i_acsnoop_reg),
        .i_base_addr_reg(i_base_addr_reg),
        .i_addr_size_reg(i_addr_size_reg),
        .o_end(w_end_active),  
        .i_trigger_active(w_trigger_active),
        .o_reply(w_reply_active),
        .o_busy(w_busy_active), 
        .i_acaddr_snapshot(i_acaddr_snapshot),
        .i_acsnoop_snapshot(i_acsnoop_snapshot),

        // Internal Signals, from Devil Passive to Devil Active
        .i_func(i_controller_signals[CTRL_SIGNAL6_WIDTH-1:CTRL_SIGNAL5_WIDTH]),
        .i_trigger_from_passive(w_trigger_from_passive),
        .i_trigger_from_ctr(i_trigger_from_ctr),
        .i_internal_adl_en((w_internal_adl_en || i_internal_adl_en )),
        .i_internal_adt_en((w_internal_adt_en || i_internal_adt_en )),
        .i_internal_araddr(w_internal_araddr),
        .i_external_araddr(i_external_araddr),
        .i_internal_arsnoop(w_internal_arsnoop),
        .i_external_arsnoop(i_external_arsnoop),
        .i_internal_awaddr(w_internal_awaddr),
        .i_external_awaddr(i_external_awaddr),
        .i_internal_awsnoop(w_internal_awsnoop),
        .i_external_awsnoop(i_external_awsnoop[2:0]),
        .i_internal_ardomain(w_internal_ardomain),
        .i_external_ardomain(2'b10), // outer-shareable by default

        // Internal Signals, from Devil Passive to Devil controller
        .o_r_phase(w_active_r_phase),

        // Internal Signals, from devil controller to devil passive
        .i_controller_signals(i_controller_signals),

        // Internal Signals, Controller In/Out Cache Line
        .o_cache_line(w_active_devil_cache_line),       
        .i_cache_line(i_cache_line_active_devil)
    );                           

    endmodule
