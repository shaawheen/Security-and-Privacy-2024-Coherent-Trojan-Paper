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

        // Internal Signals, from Devil to Devil Controller
        output wire [(C_ACE_DATA_WIDTH*4)-1:0] o_devil_cache_line,
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
        output wire   [(C_ACE_DATA_WIDTH*4)-1:0] o_cache_line, 
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

    wire w_ace_passive_module;
    wire w_ace_active_module;

    assign w_ace_passive_module = w_busy_passive && !w_busy_active;
    assign w_ace_active_module = w_busy_active;

    // ACE AC Channel (Snoop)
    wire       [C_ACE_ADDR_WIDTH-1:0] w_active_acaddr, w_passive_acaddr;
    wire                        [2:0] w_active_acprot, w_passive_acprot;
    wire                              w_active_acready, w_passive_acready;
    wire                        [3:0] w_active_acsnoop, w_passive_acsnoop;
    wire                              w_active_acvalid, w_passive_acvalid;

    // ACE CD Channel (Snoop data)
    wire       [C_ACE_DATA_WIDTH-1:0] w_active_cddata,  w_passive_cddata;
    wire                              w_active_cdlast,  w_passive_cdlast;
    wire                              w_active_cdready, w_passive_cdready;
    wire                              w_active_cdvalid, w_passive_cdvalid;

    // ACE CR Channel (Snoop response)
    wire                              w_active_crready, w_passive_crready;
    wire                        [4:0] w_active_crresp,  w_passive_crresp;
    wire                              w_active_crvalid, w_passive_crvalid;

    // ACE AR Channel (Read address phase)
    wire       [C_ACE_ADDR_WIDTH-1:0] w_active_araddr,   w_passive_araddr;
    wire                        [1:0] w_active_arbar,    w_passive_arbar;
    wire                        [1:0] w_active_arburst,  w_passive_arburst;
    wire                        [3:0] w_active_arcache,  w_passive_arcache;
    wire                        [1:0] w_active_ardomain, w_passive_ardomain;
    wire                        [5:0] w_active_arid,     w_passive_arid;
    wire                        [7:0] w_active_arlen,    w_passive_arlen;
    wire                              w_active_arlock,   w_passive_arlock;
    wire                        [2:0] w_active_arprot,   w_passive_arprot;
    wire                        [3:0] w_active_arqos,    w_passive_arqos;
    wire                              w_active_arready,  w_passive_arready;
    wire                        [3:0] w_active_arregion, w_passive_arregion;
    wire                        [2:0] w_active_arsize,   w_passive_arsize;
    wire                        [3:0] w_active_arsnoop,  w_passive_arsnoop;
    wire                       [15:0] w_active_aruser,   w_passive_aruser;
    wire                              w_active_arvalid,  w_passive_arvalid;

    // ACE R Channel (Read data phase)
    wire                              w_active_rack,    w_passive_rack;
    wire       [C_ACE_DATA_WIDTH-1:0] w_active_rdata,   w_passive_rdata;
    wire                        [5:0] w_active_rid,     w_passive_rid;
    wire                              w_active_rlast,   w_passive_rlast;
    wire                              w_active_rready,  w_passive_rready;
    wire                        [3:0] w_active_rresp,   w_passive_rresp;
    wire                              w_active_ruser,   w_passive_ruser;
    wire                              w_active_rvalid,  w_passive_rvalid;

    // ACE AW channel (Write address phase)
    wire       [C_ACE_ADDR_WIDTH-1:0] w_active_awaddr,      w_passive_awaddr;
    wire                        [1:0] w_active_awbar,       w_passive_awbar;
    wire                        [1:0] w_active_awburst,     w_passive_awburst;
    wire                        [3:0] w_active_awcache,     w_passive_awcache;
    wire                        [1:0] w_active_awdomain,    w_passive_awdomain;
    wire                        [5:0] w_active_awid,        w_passive_awid;
    wire                        [7:0] w_active_awlen,       w_passive_awlen;
    wire                              w_active_awlock,      w_passive_awlock;
    wire                        [2:0] w_active_awprot,      w_passive_awprot;
    wire                        [3:0] w_active_awqos,       w_passive_awqos;
    wire                              w_active_awready,     w_passive_awready;
    wire                        [3:0] w_active_awregion,    w_passive_awregion;
    wire                        [2:0] w_active_awsize,      w_passive_awsize;
    wire                        [2:0] w_active_awsnoop,     w_passive_awsnoop;
    wire                       [15:0] w_active_awuser,      w_passive_awuser;
    wire                              w_active_awvalid,     w_passive_awvalid;

    // ACE W channel (Write data phase)
    wire                              w_active_wack,    w_passive_wack;
    wire       [C_ACE_DATA_WIDTH-1:0] w_active_wdata,   w_passive_wdata;
    wire                        [5:0] w_active_wid,     w_passive_wid;
    wire                              w_active_wlast,   w_passive_wlast;
    wire                              w_active_wready,  w_passive_wready;
    wire                       [15:0] w_active_wstrb,   w_passive_wstrb;
    wire                              w_active_wuser,   w_passive_wuser;
    wire                              w_active_wvalid,  w_passive_wvalid;

    // ACE B channel (Write response)
    wire                        [5:0] w_active_bid,     w_passive_bid;
    wire                              w_active_bready,  w_passive_bready;
    wire                        [1:0] w_active_bresp,   w_passive_bresp;
    wire                              w_active_buser,   w_passive_buser;
    wire                              w_active_bvalid,  w_passive_bvalid;

    // ACE AC Channel (Snoop)
    assign o_acready = w_ace_passive_module ? w_passive_acready : (w_ace_active_module ? w_active_acready  : 0);
   
    // ACE CD Channel (Snoop data)
    assign o_cddata  = w_ace_passive_module ? w_passive_cddata  : (w_ace_active_module ? w_active_cddata  : 0);
    assign o_cdlast  = w_ace_passive_module ? w_passive_cdlast  : (w_ace_active_module ? w_active_cdlast  : 0);
    assign o_cdvalid = w_ace_passive_module ? w_passive_cdvalid : (w_ace_active_module ? w_active_cdvalid : 0);

    // ACE CR Channel (Snoop response)
    assign o_crresp  = w_ace_passive_module ? w_passive_crresp : (w_ace_active_module ? w_active_crresp  : 0);
    assign o_crvalid = w_ace_passive_module ? w_passive_crvalid : (w_ace_active_module ? w_active_crvalid  : 0);

    // ACE AR Channel (Read address phase)
    assign o_araddr     = w_ace_passive_module ? w_passive_araddr   : (w_ace_active_module ? w_active_araddr    : 0);
    assign o_arbar      = w_ace_passive_module ? w_passive_arbar    : (w_ace_active_module ? w_active_arbar     : 0);
    assign o_arburst    = w_ace_passive_module ? w_passive_arburst  : (w_ace_active_module ? w_active_arburst   : 0);
    assign o_arcache    = w_ace_passive_module ? w_passive_arcache  : (w_ace_active_module ? w_active_arcache   : 0);
    assign o_ardomain   = w_ace_passive_module ? w_passive_ardomain : (w_ace_active_module ? w_active_ardomain  : 0);
    assign o_arid       = w_ace_passive_module ? w_passive_arid     : (w_ace_active_module ? w_active_arid      : 0);
    assign o_arlen      = w_ace_passive_module ? w_passive_arlen    : (w_ace_active_module ? w_active_arlen     : 0);
    assign o_arlock     = w_ace_passive_module ? w_passive_arlock   : (w_ace_active_module ? w_active_arlock    : 0);
    assign o_arprot     = w_ace_passive_module ? w_passive_arprot   : (w_ace_active_module ? w_active_arprot    : 0);
    assign o_arqos      = w_ace_passive_module ? w_passive_arqos    : (w_ace_active_module ? w_active_arqos     : 0);
    assign o_arregion   = w_ace_passive_module ? w_passive_arregion : (w_ace_active_module ? w_active_arregion  : 0);
    assign o_arsize     = w_ace_passive_module ? w_passive_arsize   : (w_ace_active_module ? w_active_arsize    : 0);
    assign o_arsnoop    = w_ace_passive_module ? w_passive_arsnoop  : (w_ace_active_module ? w_active_arsnoop   : 0);
    assign o_aruser     = w_ace_passive_module ? w_passive_aruser   : (w_ace_active_module ? w_active_aruser    : 0);
    assign o_arvalid    = w_ace_passive_module ? w_passive_arvalid  : (w_ace_active_module ? w_active_arvalid   : 0);

    // ACE R Channel (Read data phase)
    assign o_rack   = w_ace_passive_module  ? w_passive_rack  : (w_ace_active_module ? w_active_rack    : 0);
    assign o_rready = w_ace_passive_module ? w_passive_rready : (w_ace_active_module ? w_active_rready  : 0);

    // ACE AW channel (Write address phase)
    assign o_awaddr   = w_ace_passive_module ? w_passive_awaddr   : (w_ace_active_module ? w_active_awaddr    : 0);
    assign o_awbar    = w_ace_passive_module ? w_passive_awbar    : (w_ace_active_module ? w_active_awbar     : 0);
    assign o_awburst  = w_ace_passive_module ? w_passive_awburst  : (w_ace_active_module ? w_active_awburst   : 0);
    assign o_awcache  = w_ace_passive_module ? w_passive_awcache  : (w_ace_active_module ? w_active_awcache   : 0);
    assign o_awdomain = w_ace_passive_module ? w_passive_awdomain : (w_ace_active_module ? w_active_awdomain  : 0);
    assign o_awid     = w_ace_passive_module ? w_passive_awid     : (w_ace_active_module ? w_active_awid      : 0);
    assign o_awlen    = w_ace_passive_module ? w_passive_awlen    : (w_ace_active_module ? w_active_awlen     : 0);
    assign o_awlock   = w_ace_passive_module ? w_passive_awlock   : (w_ace_active_module ? w_active_awlock    : 0);
    assign o_awprot   = w_ace_passive_module ? w_passive_awprot   : (w_ace_active_module ? w_active_awprot    : 0);
    assign o_awqos    = w_ace_passive_module ? w_passive_awqos    : (w_ace_active_module ? w_active_awqos     : 0);
    assign o_awregion = w_ace_passive_module ? w_passive_awregion : (w_ace_active_module ? w_active_awregion  : 0);
    assign o_awsize   = w_ace_passive_module ? w_passive_awsize   : (w_ace_active_module ? w_active_awsize    : 0);
    assign o_awsnoop  = w_ace_passive_module ? w_passive_awsnoop  : (w_ace_active_module ? w_active_awsnoop   : 0);
    assign o_awuser   = w_ace_passive_module ? w_passive_awuser   : (w_ace_active_module ? w_active_awuser    : 0);
    assign o_awvalid  = w_ace_passive_module ? w_passive_awvalid  : (w_ace_active_module ? w_active_awvalid   : 0);

    // ACE W channel (Write data phase)
    assign o_wack   = w_ace_passive_module ? w_passive_wack   : (w_ace_active_module ? w_active_wack    : 0);
    assign o_wdata  = w_ace_passive_module ? w_passive_wdata  : (w_ace_active_module ? w_active_wdata   : 0);
    assign o_wid    = w_ace_passive_module ? w_passive_wid    : (w_ace_active_module ? w_active_wid     : 0);
    assign o_wlast  = w_ace_passive_module ? w_passive_wlast  : (w_ace_active_module ? w_active_wlast   : 0);
    assign o_wstrb  = w_ace_passive_module ? w_passive_wstrb  : (w_ace_active_module ? w_active_wstrb   : 0);
    assign o_wuser  = w_ace_passive_module ? w_passive_wuser  : (w_ace_active_module ? w_active_wuser   : 0);
    assign o_wvalid = w_ace_passive_module ? w_passive_wvalid : (w_ace_active_module ? w_active_wvalid  : 0);


    // ACE B channel (Write response)
    assign o_bready = w_ace_passive_module ? w_passive_bready : 
                       (w_ace_active_module ? w_active_bready  : 0);
                       

    // Output Siginals
    wire       [DEVIL_STATE_SIZE-1:0] w_fsm_devil_state;
    wire       [DEVIL_STATE_SIZE-1:0] w_fsm_devil_state_active;
    wire     [C_S_AXI_DATA_WIDTH-1:0] w_write_status_reg;

    wire                              w_end;
    wire                              w_reply_passive;
    wire                              w_reply_active;
    wire                              w_busy;
    wire   [(C_ACE_DATA_WIDTH*4)-1:0] w_read_cache_line;
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

    // Internal Signals
    wire                             w_trigger_active;
    wire                             w_trigger_from_passive; 
    wire  [(C_ACE_DATA_WIDTH*4)-1:0] w_cache_line;
    wire  [(C_ACE_DATA_WIDTH*4)-1:0] w_active_devil_cache_line;
    wire                             w_action_taken; // set signal on take action passive state
    wire                             w_trans_monitored; // set signal on monitor transaction passive state
    wire  [CTRL_IN_SIGNAL_WIDTH-1:0] w_to_ctrl_signals;

    assign o_fsm_devil_state        =  w_fsm_devil_state;
    assign o_fsm_devil_state_active =  w_fsm_devil_state_active;
    assign o_write_status_reg       =  w_write_status_reg;
    assign o_reply                  = (w_external_mode ? w_reply_active : w_reply_passive);   
    assign o_cache_line             =  w_read_cache_line;
    assign o_counter                =  w_counter;
    assign o_end_active             = w_end_active; 
    assign o_busy_active            = w_busy_active;
    assign o_end_passive            = w_end_passive; 
    assign o_busy_passive           = w_busy_passive;
    assign w_func                   = (w_trigger_from_passive ? w_internal_func : i_control_reg[8:5]);
    assign o_external_mode          = w_external_mode;
    assign o_controller_signals     = w_to_ctrl_signals;
    assign o_devil_cache_line       = w_active_devil_cache_line;

    assign w_trigger_active = i_trigger_active || w_trigger_from_passive ;
    // This line now is not used, the controller of the cache line to write is 
    // delegated to the controller of the devil
    // assign w_cache_line = (w_action_taken || w_trans_monitored) ? i_devil_cache_line : i_external_cache_line;

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
        // ACE AR Channel (Read address phase)
        .o_araddr(w_passive_araddr),
        .o_arbar(w_passive_arbar),
        .o_arburst(w_passive_arburst),
        .o_arcache(w_passive_arcache),
        .o_ardomain(w_passive_ardomain),
        .o_arid(w_passive_arid),
        .o_arlen(w_passive_arlen),
        .o_arlock(w_passive_arlock),
        .o_arprot(w_passive_arprot),
        .o_arqos(w_passive_arqos),
        .i_arready(i_arready),
        .o_arregion(w_passive_arregion),
        .o_arsize(w_passive_arsize),
        .o_arsnoop(w_passive_arsnoop),
        .o_aruser(w_passive_aruser),
        .o_arvalid(w_passive_arvalid),
        // ACE R Channel (Read data phase)
        .o_rack(w_passive_rack),
        .i_rdata(i_rdata),
        .i_rid(i_rid),
        .i_rlast(i_rlast),
        .o_rready(w_passive_rready),
        .i_rresp(i_rresp),
        .i_ruser(i_ruser),
        .i_rvalid(i_rvalid),
        // ACE AW channel (Write address phase)
        .o_awaddr(w_passive_awaddr),
        .o_awbar(w_passive_awbar),
        .o_awburst(w_passive_awburst),
        .o_awcache(w_passive_awcache),
        .o_awdomain(w_passive_awdomain),
        .o_awid(w_passive_awid),
        .o_awlen(w_passive_awlen),
        .o_awlock(w_passive_awlock),
        .o_awprot(w_passive_awprot),
        .o_awqos(w_passive_awqos),
        .i_awready(i_awready),
        .o_awregion(w_passive_awregion),
        .o_awsize(w_passive_awsize),
        .o_awsnoop(w_passive_awsnoop),
        .o_awuser(w_passive_awuser),
        .o_awvalid(w_passive_awvalid),
        // ACE W channel (Write data phase)
        .o_wack(w_passive_wack),
        .o_wdata(w_passive_wdata),
        .o_wid(w_passive_wid),
        .o_wlast(w_passive_wlast),
        .i_wready(i_wready),
        .o_wstrb(w_passive_wstrb),
        .o_wuser(w_passive_wuser),
        .o_wvalid(w_passive_wvalid),
        // ACE B channel (Write response)
        .i_bid(i_bid),
        .o_bready(w_passive_bready),
        .i_bresp(i_bresp),
        .i_buser(i_buser),
        .i_bvalid(i_bvalid),

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
        .o_trans_monitored(w_trans_monitored),
        
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

        // Internal Signalas, from devil controller to devil passive
        .i_controller_signals(i_controller_signals),

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
        // ACE AC Channel (Snoop)
        .i_acaddr(i_acaddr),
        .i_acprot(i_acprot),
        .o_acready(w_active_acready),
        .i_acsnoop(i_acsnoop),
        .i_acvalid(i_acvalid),
        // ACE CD Channel (Snoop data)
        .o_cddata(w_active_cddata),
        .o_cdlast(w_active_cdlast),
        .i_cdready(i_cdready),
        .o_cdvalid(w_active_cdvalid),
        // ACE CR Channel (Snoop response)
        .i_crready(i_crready),
        .o_crresp(w_active_crresp),
        .o_crvalid(w_active_crvalid),
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
        .i_func((i_trigger_active ? i_controller_signals[CTRL_SIGNAL6_WIDTH-1:CTRL_SIGNAL5_WIDTH] : w_func)),
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

        // Internal Signals, from devil controller to devil passive
        .i_controller_signals(i_controller_signals),

        // Internal Signals, Controller In/Out Cache Line
        .o_cache_line(w_active_devil_cache_line),       
        .i_cache_line(i_cache_line_active_devil)
    );                           

    endmodule
