//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Shahin Roozkhosh
//
// Create Date: 03/04/2022 04:57:49 PM
// Design Name:
// Module Name: Back Stabber
// Project Name: Backstabbing
// Target Devices: zcu102 with ACE port
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
`timescale 1 ns / 1 ps

	module backstabber_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line
		parameter integer QUEUE_DEPTH              = 256, //048, //modify later
        // Paremeters of ACE Interface
        parameter integer C_ACE_ADDR_WIDTH	        = 44,
        parameter integer C_ACE_DATA_WIDTH          = 128,
        parameter integer C_ACE_ACSNOOP_WIDTH       = 4,
        // Parameters of Axi Slave Bus Interface Config_AXI
        parameter integer C_Config_AXI_ID_WIDTH     = 16,
        parameter integer C_Config_AXI_DATA_WIDTH   = 128,
        parameter integer C_Config_AXI_ADDR_WIDTH   = 40,
        parameter integer C_Config_AXI_AWUSER_WIDTH = 0,
        parameter integer C_Config_AXI_ARUSER_WIDTH = 0,
        parameter integer C_Config_AXI_WUSER_WIDTH  = 0,
        parameter integer C_Config_AXI_RUSER_WIDTH  = 0,
        parameter integer C_Config_AXI_BUSER_WIDTH  = 0,
        parameter integer BUS_WIDTH	                = 128,
        parameter integer CACHE_LINE_WIDTH_BITS     = 512,
        // Parameters of Axi Slave Bus Interface M00_AXI
        parameter integer C_M00_AXI_ID_WIDTH        = 16,
        parameter integer C_M00_AXI_BURST_LEN       = 4,
        parameter integer C_M00_AXI_ADDR_WIDTH      = 40,
        parameter integer C_M00_AXI_DATA_WIDTH      = 128,
        parameter integer C_M00_AXI_AWUSER_WIDTH    = 0,
        parameter integer C_M00_AXI_ARUSER_WIDTH    = 0,
        parameter integer C_M00_AXI_WUSER_WIDTH     = 0,
        parameter integer C_M00_AXI_RUSER_WIDTH     = 0,
        parameter integer C_M00_AXI_BUSER_WIDTH     = 0,
        // Parameters of Axi Slave Bus Interface S00_AXI
        parameter integer C_S00_AXI_ID_WIDTH        = 16,
        parameter integer C_S00_AXI_BURST_LEN       = 4,
        parameter integer C_S00_AXI_ADDR_WIDTH      = 40,
        parameter integer C_S00_AXI_DATA_WIDTH      = 128,
        parameter integer C_S00_AXI_AWUSER_WIDTH    = 0,
        parameter integer C_S00_AXI_ARUSER_WIDTH    = 0,
        parameter integer C_S00_AXI_WUSER_WIDTH     = 0,
        parameter integer C_S00_AXI_RUSER_WIDTH     = 0,
        parameter integer C_S00_AXI_BUSER_WIDTH     = 0,
        // Parameters of Axi Slave Bus Interface s01_AXI
		parameter integer C_S01_AXI_DATA_WIDTH	= 32,
		parameter integer C_S01_AXI_ADDR_WIDTH	= 8,
        // Generic
        parameter integer WRITER                    = 1
	)
	(
		// Ports of Axi Slave Bus Interface Config_AXI
        input  wire                                          config_axi_aclk,
        input  wire                                          config_axi_aresetn,
        input  wire            [C_Config_AXI_ID_WIDTH-1 : 0] config_axi_awid,
        input  wire          [C_Config_AXI_ADDR_WIDTH-1 : 0] config_axi_awaddr,
        input  wire                                  [7 : 0] config_axi_awlen,
        input  wire                                  [2 : 0] config_axi_awsize,
        input  wire                                  [1 : 0] config_axi_awburst,
        input  wire                                          config_axi_awlock,
        input  wire                                  [3 : 0] config_axi_awcache,
        input  wire                                  [2 : 0] config_axi_awprot,
        input  wire                                  [3 : 0] config_axi_awqos,
        input  wire                                  [3 : 0] config_axi_awregion,
        input  wire        [C_Config_AXI_AWUSER_WIDTH-1 : 0] config_axi_awuser,
        input  wire                                          config_axi_awvalid,
        output wire                                          config_axi_awready,
        input  wire          [C_Config_AXI_DATA_WIDTH-1 : 0] config_axi_wdata,
        input  wire      [(C_Config_AXI_DATA_WIDTH/8)-1 : 0] config_axi_wstrb,
        input  wire                                          config_axi_wlast,
        input  wire                                          config_axi_wvalid,
        output wire                                          config_axi_wready,
        output wire            [C_Config_AXI_ID_WIDTH-1 : 0] config_axi_bid,
        output wire                                  [1 : 0] config_axi_bresp,
        output wire                                          config_axi_bvalid,
        input  wire                                          config_axi_bready,
        input  wire            [C_Config_AXI_ID_WIDTH-1 : 0] config_axi_arid,
        input  wire          [C_Config_AXI_ADDR_WIDTH-1 : 0] config_axi_araddr,
        input  wire                                  [7 : 0] config_axi_arlen,
        input  wire                                  [2 : 0] config_axi_arsize,
        input  wire                                  [1 : 0] config_axi_arburst,
        input  wire                                          config_axi_arlock,
        input  wire                                  [3 : 0] config_axi_arcache,
        input  wire                                  [2 : 0] config_axi_arprot,
        input  wire                                  [3 : 0] config_axi_arqos,
        input  wire                                  [3 : 0] config_axi_arregion,
        input  wire        [C_Config_AXI_ARUSER_WIDTH-1 : 0] config_axi_aruser,
        input  wire                                          config_axi_arvalid,
        output wire                                          config_axi_arready,
        output wire            [C_Config_AXI_ID_WIDTH-1 : 0] config_axi_rid,
        output wire          [C_Config_AXI_DATA_WIDTH-1 : 0] config_axi_rdata,
        output wire                                  [1 : 0] config_axi_rresp,
        output wire                                          config_axi_rlast,
        output wire                                          config_axi_rvalid,
        input  wire                                          config_axi_rready,
        // Ports of ACE Interface with PL
        input  wire                                          ace_aclk,
        input  wire                                          ace_aresetn,
        input  wire                   [C_ACE_ADDR_WIDTH-1:0] acaddr,
        input  wire                                    [2:0] acprot,
        output wire                                          acready,
        input  wire                [C_ACE_ACSNOOP_WIDTH-1:0] acsnoop,
        input  wire                                          acvalid,
        input  wire                                          crready,
        output wire                                    [4:0] crresp,
        output wire                                          crvalid,
        output wire                   [C_ACE_DATA_WIDTH-1:0] cddata,
        output wire                                          cdlast,
        input  wire                                          cdready,
        output wire                                          cdvalid,
        output wire                   [C_ACE_ADDR_WIDTH-1:0] araddr,
        output wire                                    [1:0] arbar,
        output wire                                    [1:0] arburst,
        output wire                                    [3:0] arcache,
        output wire                                    [1:0] ardomain,
        output wire                                    [5:0] arid,
        output wire                                    [7:0] arlen,
        output wire                                          arlock,
        output wire                                    [2:0] arprot,
        output wire                                    [3:0] arqos,
        input  wire                                          arready,
        output wire                                    [3:0] arregion,
        output wire                                    [2:0] arsize,
        output wire                                    [3:0] arsnoop,
        output wire                                   [15:0] aruser,
        output wire                                          arvalid,
        output wire                   [C_ACE_ADDR_WIDTH-1:0] awaddr,
        output wire                                    [1:0] awbar,
        output wire                                    [1:0] awburst,
        output wire                                    [3:0] awcache,
        output wire                                    [1:0] awdomain,
        output wire                                    [5:0] awid,
        output wire                                    [7:0] awlen,
        output wire                                          awlock,
        output wire                                    [2:0] awprot,
        output wire                                    [3:0] awqos,
        input  wire                                          awready,
        output wire                                    [3:0] awregion,
        output wire                                    [2:0] awsize,
        output wire                                    [2:0] awsnoop,
        output wire                                   [15:0] awuser,
        output wire                                          awvalid,
        input  wire                                    [5:0] bid,
        output wire                                          bready,
        input  wire                                    [1:0] bresp,
        input  wire                                          buser,
        input  wire                                          bvalid,
        output wire                                          rack,
        input  wire                   [C_ACE_DATA_WIDTH-1:0] rdata,
        input  wire                                    [5:0] rid,
        input  wire                                          rlast,
        output wire                                          rready,
        input  wire                                    [3:0] rresp,
        input  wire                                          ruser,
        input  wire                                          rvalid,
        output wire                                          wack,
        output wire                   [C_ACE_DATA_WIDTH-1:0] wdata,
        output wire                                    [5:0] wid,
        output wire                                          wlast,
        input  wire                                          wready,
        output wire                                   [15:0] wstrb,
        output wire                                          wuser,
        output wire                                          wvalid,
        // Ports of Axi Master Bus Interface M00_AXI
        input  wire                                          m00_axi_aclk,
        input  wire                                          m00_axi_aresetn,
        output wire               [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_awid,
        output wire             [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr,
        output wire                                  [7 : 0] m00_axi_awlen,
        output wire                                  [2 : 0] m00_axi_awsize,
        output wire                                  [1 : 0] m00_axi_awburst,
        output wire                                          m00_axi_awlock,
        output wire                                  [3 : 0] m00_axi_awcache,
        output wire                                  [2 : 0] m00_axi_awprot,
        output wire                                  [3 : 0] m00_axi_awqos,
        output wire           [C_M00_AXI_AWUSER_WIDTH-1 : 0] m00_axi_awuser,
        output wire                                          m00_axi_awvalid,
        input  wire                                          m00_axi_awready,
        output wire             [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata,
        output wire           [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb,
        output wire                                          m00_axi_wlast,
        output wire            [C_M00_AXI_WUSER_WIDTH-1 : 0] m00_axi_wuser,
        output wire                                          m00_axi_wvalid,
        input  wire                                          m00_axi_wready,
        input  wire               [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_bid,
        input  wire                                  [1 : 0] m00_axi_bresp,
        input  wire            [C_M00_AXI_BUSER_WIDTH-1 : 0] m00_axi_buser,
        input  wire                                          m00_axi_bvalid,
        output wire                                          m00_axi_bready,
        output wire               [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid,
        output wire             [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr,
        output wire                                  [7 : 0] m00_axi_arlen,
        output wire                                  [2 : 0] m00_axi_arsize,
        output wire                                  [1 : 0] m00_axi_arburst,
        output wire                                          m00_axi_arlock,
        output wire                                  [3 : 0] m00_axi_arcache,
        output wire                                  [2 : 0] m00_axi_arprot,
        output wire                                  [3 : 0] m00_axi_arqos,
        output wire           [C_M00_AXI_ARUSER_WIDTH-1 : 0] m00_axi_aruser,
        output wire                                          m00_axi_arvalid,
        input  wire                                          m00_axi_arready,
        input  wire               [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid,
        input  wire             [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata,
        input  wire                                  [1 : 0] m00_axi_rresp,
        input  wire                                          m00_axi_rlast,
        input  wire            [C_M00_AXI_RUSER_WIDTH-1 : 0] m00_axi_ruser,
        input  wire                                          m00_axi_rvalid,
        output wire                                          m00_axi_rready,
        // Ports of Axi Slave Bus Interface S00_AXI
        input  wire                                          s00_axi_aclk,
        input  wire                                          s00_axi_aresetn,
        input  wire               [C_S00_AXI_ID_WIDTH-1 : 0] s00_axi_awid,
        input  wire             [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
        input  wire                                  [7 : 0] s00_axi_awlen,
        input  wire                                  [2 : 0] s00_axi_awsize,
        input  wire                                  [1 : 0] s00_axi_awburst,
        input  wire                                          s00_axi_awlock,
        input  wire                                  [3 : 0] s00_axi_awcache,
        input  wire                                  [2 : 0] s00_axi_awprot,
        input  wire                                  [3 : 0] s00_axi_awqos,
        input  wire           [C_S00_AXI_AWUSER_WIDTH-1 : 0] s00_axi_awuser,
        input  wire                                          s00_axi_awvalid,
        output wire                                          s00_axi_awready,
        input  wire             [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
        input  wire           [C_S00_AXI_DATA_WIDTH/8-1 : 0] s00_axi_wstrb,
        input  wire                                          s00_axi_wlast,
        input  wire            [C_S00_AXI_WUSER_WIDTH-1 : 0] s00_axi_wuser,
        input  wire                                          s00_axi_wvalid,
        output wire                                          s00_axi_wready,
        output wire               [C_S00_AXI_ID_WIDTH-1 : 0] s00_axi_bid,
        output wire                                  [1 : 0] s00_axi_bresp,
        output wire            [C_S00_AXI_BUSER_WIDTH-1 : 0] s00_axi_buser,
        output wire                                          s00_axi_bvalid,
        input  wire                                          s00_axi_bready,
        input  wire               [C_S00_AXI_ID_WIDTH-1 : 0] s00_axi_arid,
        input  wire             [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
        input  wire                                  [7 : 0] s00_axi_arlen,
        input  wire                                  [2 : 0] s00_axi_arsize,
        input  wire                                  [1 : 0] s00_axi_arburst,
        input  wire                                          s00_axi_arlock,
        input  wire                                  [3 : 0] s00_axi_arcache,
        input  wire                                  [2 : 0] s00_axi_arprot,
        input  wire                                  [3 : 0] s00_axi_arqos,
        input  wire           [C_S00_AXI_ARUSER_WIDTH-1 : 0] s00_axi_aruser,
        input  wire                                          s00_axi_arvalid,
        output wire                                          s00_axi_arready,
        output wire               [C_S00_AXI_ID_WIDTH-1 : 0] s00_axi_rid,
        output wire             [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
        output wire                                  [1 : 0] s00_axi_rresp,
        output wire                                          s00_axi_rlast,
        output wire            [C_S00_AXI_RUSER_WIDTH-1 : 0] s00_axi_ruser,
        output wire                                          s00_axi_rvalid,
        input  wire                                          s00_axi_rready,
        // Ports of Axi Slave Bus Interface s01_AXI
		input wire                                           s01_axi_aclk,
		input wire                                           s01_axi_aresetn,
		input wire              [C_S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_awaddr,
		input wire                                   [2 : 0] s01_axi_awprot,
		input wire                                           s01_axi_awvalid,
		output wire                                          s01_axi_awready,
		input wire              [C_S01_AXI_DATA_WIDTH-1 : 0] s01_axi_wdata,
		input wire          [(C_S01_AXI_DATA_WIDTH/8)-1 : 0] s01_axi_wstrb,
		input wire                                           s01_axi_wvalid,
		output wire                                          s01_axi_wready,
		output wire                                  [1 : 0] s01_axi_bresp,
		output wire                                          s01_axi_bvalid,
		input wire                                           s01_axi_bready,
		input wire              [C_S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_araddr,
		input wire                                   [2 : 0] s01_axi_arprot,
		input wire                                           s01_axi_arvalid,
		output wire                                          s01_axi_arready,
		output wire             [C_S01_AXI_DATA_WIDTH-1 : 0] s01_axi_rdata,
		output wire                                  [1 : 0] s01_axi_rresp,
		output wire                                          s01_axi_rvalid,
		input wire                                           s01_axi_rready,
        // Debug (temporary) IO
        output wire                                    [4:0] debug_snoop_state,
        output wire                                    [4:0] debug_devil_state,
        output wire                                    [4:0] debug_devil_state_active,
        output wire                                   [63:0] debug_counter,
        output wire                                   [31:0] debug_delay_reg,
        output wire                                   [31:0] debug_status,
        output wire                 [C_ACE_DATA_WIDTH-1 : 0] debug_buff_0,
        output wire                 [C_ACE_DATA_WIDTH-1 : 0] debug_buff_1,
        output wire                 [C_ACE_DATA_WIDTH-1 : 0] debug_buff_2,
        output wire                 [C_ACE_DATA_WIDTH-1 : 0] debug_buff_3
	);

	wire                          ac_handshake;
    wire                          r_handshake;
    wire                          dvm_operation_last_condition;
    wire                          dvm_operation_multi_condition;
    wire                          dvm_sync_last_condition;
    wire                          dvm_sync_multi_condition;
    wire                          reply_condition;
    wire                          non_reply_condition;
    wire                          queue_push_condition;
    wire                          queue_pop_condition;
    wire                          queue_empty;
    wire                          queue_full;
    wire [C_ACE_ADDR_WIDTH-1 : 0] read_addr;
    wire                          lying_condition;

    // AXI outputs
    // AW channel
    if (WRITER == 1)
    begin
        assign m00_axi_awid    = s00_axi_awid;
        assign m00_axi_awaddr  = s00_axi_awaddr;
        assign m00_axi_awlen   = s00_axi_awlen;
        assign m00_axi_awsize  = s00_axi_awsize;
        assign m00_axi_awburst = s00_axi_awburst;
        assign m00_axi_awlock  = s00_axi_awlock;
        assign m00_axi_awcache = s00_axi_awcache;
        assign m00_axi_awprot  = s00_axi_awprot;
        assign m00_axi_awqos   = s00_axi_awqos;
        assign m00_axi_awuser  = s00_axi_awuser;
        assign m00_axi_awvalid = s00_axi_awvalid;
        assign s00_axi_awready = m00_axi_awready;
        assign m00_axi_wdata   = s00_axi_wdata;
        assign m00_axi_wstrb   = s00_axi_wstrb;
        assign m00_axi_wlast   = s00_axi_wlast;
        assign s00_axi_wuser   = m00_axi_wuser;
        assign m00_axi_wvalid  = s00_axi_wvalid;
        assign s00_axi_wready  = m00_axi_wready;
        assign s00_axi_bid     = m00_axi_bid;
        assign s00_axi_bresp   = m00_axi_bresp;
        assign s00_axi_buser   = m00_axi_buser;
        assign s00_axi_bvalid  = m00_axi_bvalid;
        assign m00_axi_bready  = s00_axi_bready;
        assign s00_axi_arready = 0;
        assign s00_axi_rid     = 0;
        assign s00_axi_rdata   = 0;
        assign s00_axi_rresp   = 0;
        assign s00_axi_rlast   = 0;
        assign s00_axi_ruser   = 0;
        assign s00_axi_rvalid  = 0;
    end
    else
    begin
        assign m00_axi_awid    = 0;
        assign m00_axi_awaddr  = 0;
        assign m00_axi_awlen   = 0;
        assign m00_axi_awsize  = 0;
        assign m00_axi_awburst = 0;
        assign m00_axi_awlock  = 0;
        assign m00_axi_awcache = 0;
        assign m00_axi_awprot  = 0;
        assign m00_axi_awqos   = 0;
        assign m00_axi_awuser  = 0;
        assign m00_axi_awvalid = 0;
        assign s00_axi_awready = 0;
        assign m00_axi_wdata   = 0;
        assign m00_axi_wstrb   = 0;
        assign s00_axi_wlast   = 0;
        assign s00_axi_wuser   = 0;
        assign s00_axi_wvalid  = 0;
        assign m00_axi_wready  = 0;
        assign s00_axi_bid     = 0;
        assign s00_axi_bresp   = 0;
        assign s00_axi_buser   = 0;
        assign s00_axi_bvalid  = 0;
        assign m00_axi_bready  = 0;
        assign s00_axi_arready = 0;
        assign s00_axi_rid     = 0;
        assign s00_axi_rdata   = 0;
        assign s00_axi_rresp   = 0;
        assign s00_axi_rlast   = 0;
        assign s00_axi_ruser   = 0;
        assign s00_axi_rvalid  = 0;
    end
    // AR channel
    assign m00_axi_arid    = 0;       // Kept same for enforcing in-order in slave
    assign m00_axi_araddr  = read_addr;
    assign m00_axi_arlen   = 3;
    assign m00_axi_arsize  = 3'b100;  // 16 Bytes in burst
    assign m00_axi_arburst = (|read_addr[5 : 0]) ?  2'b10 : 2'b01;   // WRAP or INCR
    assign m00_axi_arlock  = 2'b00;
    assign m00_axi_arcache = 4'b1110; // READ ALLOCATE
    assign m00_axi_arprot  = acprot;
    assign m00_axi_arqos   = 0;       // No priority
    assign m00_axi_aruser  = 0;
    assign m00_axi_arvalid = ~queue_empty;
    // R channel
    assign m00_axi_rready  = cdready;
    
//******************************************************************************
// Devil-in-the-fpga
//******************************************************************************
    `define READ_ONCE           4'b0000
    `define WRITE_LINE_UNIQUE   3'b001
    `define CLEAN_INVALID       4'b1001
    `define DVM_COMPLETE        4'b1110
    `define DVM_MESSAGE         4'b1111
    `define OKAY                2'b00
    `define WRAP                2'b10
    `define INCR                2'b01
    
// Devil-in-the-fpga AXI-Lite
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_control_reg;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_write_status_reg;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_read_status_reg;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_delay_reg;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_acsnoop_reg;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_base_addr_reg;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_addr_size_reg;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_arsnoop_Data;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_l_araddr_Data;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_h_araddr_Data;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_awsnoop_Data;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_l_awaddr_Data;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_h_awaddr_Data;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_wdata_0_data;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_wdata_1_data;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_wdata_2_data;
    wire [C_S01_AXI_DATA_WIDTH-1:0] w_wdata_3_data;
    wire     [C_ACE_DATA_WIDTH-1:0] w_rdata;
    wire                      [4:0] w_crresp;
    wire                            w_crvalid;
    wire                            w_cdvalid;
    wire                            w_cdlast;
    wire                      [4:0] w_snoop_state;
    wire                      [4:0] w_fsm_devil_state;
    wire                      [4:0] w_fsm_devil_state_active;
    wire                            w_devil_end;
    wire                            w_acready;
    wire                            w_devil_reply;
    wire                            w_devil_busy;
    wire                            w_wlast; 
    wire     [C_ACE_DATA_WIDTH-1:0] w_wdata;
    wire                     [63:0] w_counter; // test porpuses
    wire     [C_ACE_DATA_WIDTH-1:0] w_buff_0;
    wire     [C_ACE_DATA_WIDTH-1:0] w_buff_1;
    wire     [C_ACE_DATA_WIDTH-1:0] w_buff_2;
    wire     [C_ACE_DATA_WIDTH-1:0] w_buff_3;      
    wire [(C_ACE_DATA_WIDTH*4)-1:0] w_read_cache_line;
    wire [(C_ACE_DATA_WIDTH*4)-1:0] w_write_cache_line;                      

    wire   w_en;
    assign w_en = w_control_reg[0];

    wire w_devil_ar_phase;
    wire w_devil_r_phase;
    wire w_devil_rack_phase;
    wire w_devil_aw_phase;
    wire w_devil_w_phase;
    wire w_devil_b_phase;
    wire w_devil_wack_phase;
                      
//******************************************************************************
//******************************************************************************

	localparam BURST_LEN = CACHE_LINE_WIDTH_BITS/BUS_WIDTH;

	// Raw data from the configuration port
    wire [((C_Config_AXI_DATA_WIDTH/8)*32)-1 : 0] buffer;
    wire                               [64-1 : 0] config_port_to_backstabber_liar_crresp;
    wire                               [64-1 : 0] config_port_to_backstabber_address_range_begin;
    wire                               [64-1 : 0] config_port_to_backstabber_address_range_end;

    localparam IDLE                     = 0;
    localparam NON_REPLY_OR_DVM_OP_LAST = 1;
    localparam DVM_SYNC_MP              = 2;
    localparam DVM_SYNC_WAIT            = 3;
    localparam DVM_SYNC_LAST            = 4;
    localparam DVM_SYNC_READ            = 5;
    localparam DVM_SYNC_RACK            = 6;
    localparam DVM_OP_MP                = 7;
    localparam DVM_OP_WAIT              = 8;
    localparam REPLY                    = 9; 
    localparam DEVIL_EN                 = 10; 
    // localparam DEVIL_AR_PHASE           = 11; 
    // localparam DEVIL_R_PHASE            = 12; 
    // localparam DEVIL_RACK               = 13;
    // localparam DEVIL_AW_PHASE           = 14;
    // localparam DEVIL_W_PHASE            = 15;
    // localparam DEVIL_B_PHASE            = 16;
    // localparam DEVIL_WACK               = 17;
    

    reg   [4 : 0] snoop_state;
    assign w_snoop_state = snoop_state;

    reg [C_ACE_ADDR_WIDTH-1:0]      r_acaddr_snapshot;
    reg [C_ACE_ACSNOOP_WIDTH-1:0]   r_acsnoop_snapshot;
    wire [C_ACE_ADDR_WIDTH-1:0]      w_acaddr_snapshot;
    wire [C_ACE_ACSNOOP_WIDTH-1:0]   w_acsnoop_snapshot;
    assign w_acaddr_snapshot =  r_acaddr_snapshot;
    assign w_acsnoop_snapshot = r_acsnoop_snapshot;

    reg r_trigger_passive_path;
    reg r_trigger_active_path;
    reg r_one_shot;

    // wire [127:0] w_buff; // 4 elements of 16 bytes

    wire w_trigger_passive_path;
    wire w_trigger_active_path;
    assign w_trigger_passive_path = r_trigger_passive_path;
    assign w_trigger_active_path = r_trigger_active_path;


    assign queue_push_condition         = (snoop_state == IDLE) && reply_condition && ~queue_full && crready; //(snoop_state == REPLY) && ~queue_full && crready;
    assign queue_pop_condition          = m00_axi_arvalid && m00_axi_arready; // 'm00_axi_arvalid' is '~queue_empty'
	assign lying_condition              = (|config_port_to_backstabber_liar_crresp) &&
	                                      (acaddr >= config_port_to_backstabber_address_range_begin) &&
	                                      (config_port_to_backstabber_address_range_end >= acaddr);

	assign config_port_to_backstabber_liar_crresp         = buffer[0 +: 64];
    assign config_port_to_backstabber_address_range_begin = buffer[64 +: 64];
	assign config_port_to_backstabber_address_range_end   = buffer[128 +: 64];

	//assign crresp   = (is_in_range & ace_enable) ? 5'b01001 : 5'b00000; //Alyaws accept if is in range - DataTransfer & IsShared;

    // assign crresp   = (snoop_state == REPLY) ? 5'b00001 : 0; //if in a reply state, pass_data & pass_dirty & was_unique;
    assign crresp   =  w_crresp;
    // assign crresp   = (snoop_state == REPLY) ? config_port_to_backstabber_liar_crresp[4 : 0] : 0; //if in a reply state, pass_data & pass_dirty & was_unique;
    assign acready  =  (~queue_full && ((snoop_state == IDLE) ||
                       (snoop_state == DVM_SYNC_WAIT) ||
                       (snoop_state == DVM_OP_WAIT))) ;
                       
    assign crvalid  = ((snoop_state == NON_REPLY_OR_DVM_OP_LAST) && crready) ||
                      ((w_crvalid == 1) && (snoop_state == DEVIL_EN) && crready) || 
                      ((snoop_state == DVM_SYNC_MP) && crready) ||
                      ((snoop_state == DVM_OP_MP) && crready) ||
                      ((snoop_state == DVM_SYNC_LAST) && crready && arready) ||
                      ((snoop_state == REPLY) && crready);
    
    // ACE AR Channel (Read address phase)
    assign araddr   = (w_devil_ar_phase && arready) ? {w_h_araddr_Data[7:0], w_l_araddr_Data} : 0;
    assign arbar    = 1'b0;
    assign arburst  = (w_control_ADLEN | w_control_ADTEN | w_control_PDTEN) ?  `WRAP : `INCR; //Should be calculated based on the acaddr inc or wrap?
    assign arcache  = 4'h3; // Read-Allocate //Refer to page 64 of manual. 
    assign ardomain = (w_devil_ar_phase && arready) ? 2'b10 : 2'b00; // outer shareable  
    assign arid     = 0;
    assign arlen    = (w_devil_ar_phase && arready) | (w_control_ADLEN | w_control_ADTEN | w_control_PDTEN) ? 7'h3: 7'h0; // Set to 7'h3 for 4 bursts of 16B (128 bits) to match 64B cache line size
    assign arlock   = 0;
    assign arprot   = 3'b011; // [2] Instruction access, [1] Non-secure access, [0] Privileged
    assign arqos    = 0;
    assign arregion = 0;
    assign arsize   = 4'b100; //Size of each burst is 16B
    assign arsnoop  = ((snoop_state == DVM_SYNC_LAST) && crready && arready) ? `DVM_COMPLETE : ((w_devil_ar_phase && arready) ? w_arsnoop_Data : 0); //Means arbar and ardomain have to be 0
    assign aruser   = 0;
    assign arvalid  = ((snoop_state == DVM_SYNC_LAST) && crready && arready) || (w_devil_ar_phase && arready); //acvalid & is_in_range & ace_enable;

    // ACE R Channel (Read data phase)
    assign rready       = (snoop_state == DVM_SYNC_READ) || w_devil_ar_phase  || w_devil_r_phase;
    assign rack         = (snoop_state == DVM_SYNC_READ) || w_devil_rack_phase;
    assign r_handshake  = rready && rvalid && rlast;

    // ACE AW channel (Write address phase)
    assign awaddr   = (w_devil_aw_phase && awready) ? {w_h_awaddr_Data[7:0], w_l_awaddr_Data} : 0;
    assign awbar    = 1'b0;
    assign awburst  = `INCR;  
    assign awcache  = 4'b1111; // Write-back Write-allocate, Refer to page 65 of manual. 
    assign awdomain = (w_devil_aw_phase && awready) ? 2'b10 : 2'b00; // outer shareable  
    assign awid     = 0;
    assign awlen    = (w_devil_aw_phase && awready) ? 7'h3: 7'h0; // Set to 7'h3 for 4 bursts of 16B (128 bits) to match 64B cache line size
    assign awlock   = 0;
    assign awprot   = 3'b011; // [2] Instruction access, [1] Non-secure access, [0] Privileged
    assign awqos    = 0;
    assign awregion = 0;
    assign awsize   = 4'b100; //Size of each burst is 16B (data-bus of 128 bits )
    assign awsnoop  = (w_devil_aw_phase && awready) ? w_awsnoop_Data : 0; //Refer to page 166 of manual. 
    assign awuser   = 0;
    assign awvalid  = w_devil_aw_phase && awready; 

    // ACE W channel (Write data phase)
    assign wdata    = w_devil_w_phase ? w_wdata : 0; // Writing 16B (128bits) 4x times
    assign wlast    = w_wlast;//(r_index == 3);
    assign wstrb    = 16'hffff; // Activate all strobes, we have a data-bus of 128 bits 
    assign wuser    = 0;
    assign wvalid   = w_devil_w_phase;
    assign wack     = w_devil_wack_phase;

    // ACE B channel (Write response)
    assign bready   = w_devil_b_phase;

    // assign cddata   = m00_axi_rdata;
    // assign cdlast   = m00_axi_rlast;
    // assign cdvalid  = m00_axi_rvalid;
    assign cddata   = w_rdata;
    assign cdlast   = w_cdlast;
    assign cdvalid  = w_cdvalid;
    assign ac_handshake                   = acready && acvalid;
    
    assign reply_condition                = ac_handshake && (acsnoop != `DVM_MESSAGE) && lying_condition;
    assign non_reply_condition            = ac_handshake && (acsnoop != `DVM_MESSAGE) && ~lying_condition;
    assign dvm_operation_last_condition   = ac_handshake && (acsnoop == `DVM_MESSAGE) && (acaddr[15:12] != 4'b1100) && (acaddr[0] == 0);
    assign dvm_operation_multi_condition  = ac_handshake && (acsnoop == `DVM_MESSAGE) && (acaddr[15:12] != 4'b1100) && (acaddr[0] == 1);
    assign dvm_sync_last_condition        = ac_handshake && (acsnoop == `DVM_MESSAGE) && (acaddr[15:12] == 4'b1100) && (acaddr[0] == 0);
    assign dvm_sync_multi_condition       = ac_handshake && (acsnoop == `DVM_MESSAGE) && (acaddr[15:12] == 4'b1100) && (acaddr[0] == 1);

    assign debug_snoop_state        = snoop_state;
    assign debug_devil_state        = w_fsm_devil_state;
    assign debug_devil_state_active = w_fsm_devil_state_active;
    assign debug_counter            = w_counter;
    assign debug_delay_reg          = w_delay_reg;
    assign debug_status             = w_write_status_reg;
    assign debug_buff_0             = w_buff_0;
    assign debug_buff_1             = w_buff_1;
    assign debug_buff_2             = w_buff_2;
    assign debug_buff_3             = w_buff_3;

	//main state-machine
	always @(posedge ace_aclk)
    begin
        if(~ace_aresetn)
        begin
            snoop_state <= IDLE;
            r_trigger_passive_path <= 0; 
            r_trigger_active_path <= 0; 
            r_one_shot <= 0;
            r_acaddr_snapshot <= 0;
            r_acsnoop_snapshot <= 0;
        end
        else if (snoop_state == IDLE)
        begin
            if(w_en)
                r_one_shot <= 1;
            else
                r_one_shot <= 0;

            if((acsnoop != `DVM_MESSAGE) && w_en && !w_devil_end && ac_handshake) 
            begin
                r_acaddr_snapshot <= acaddr; // acaddr at the time of the handshake (used by DEVIL_FILTER)
                r_acsnoop_snapshot <= acsnoop; // acsnoop at the time of the handshake (used by DEVIL_FILTER)
                snoop_state <= DEVIL_EN;
                //Force to be mutual exclusive
                r_trigger_passive_path <= 1; // Respond to a snoop
                r_trigger_active_path <= 0; // Issue a snoop

            end
            else if((acsnoop != `DVM_MESSAGE) && w_en && !r_one_shot) 
            begin
                // snoop_state <= DEVIL_AR_PHASE;
                // snoop_state <= DEVIL_AW_PHASE;
               snoop_state <= DEVIL_EN;
               //Force to be mutual exclusive
               r_trigger_passive_path <= 0; // Respond to a snoop
               r_trigger_active_path <= 1; // Issue a snoop
            end
            else if(non_reply_condition || dvm_operation_last_condition)
                snoop_state <= NON_REPLY_OR_DVM_OP_LAST;
            else if (dvm_sync_multi_condition)
                snoop_state <= DVM_SYNC_MP;
            else if (dvm_sync_last_condition)
                snoop_state <= DVM_SYNC_LAST;
            else if (dvm_operation_multi_condition)
                snoop_state <= DVM_OP_MP;
            else if (reply_condition && ~queue_full)
                snoop_state <= REPLY;
            else begin
                snoop_state <= snoop_state;
                r_trigger_passive_path <= r_trigger_passive_path; 
                r_trigger_active_path <= r_trigger_active_path;
            end
        end
        // DEVIL
        else if (snoop_state == DEVIL_EN) // Wait for devil to finish
        begin
            r_trigger_passive_path <= 0; // Clean trigger
            r_trigger_active_path <= 0; // Clean trigger
            if (w_devil_reply) 
                snoop_state <= IDLE;
            else
                snoop_state <= snoop_state;
        end


        // else if (snoop_state == DEVIL_AR_PHASE) 
        // begin
        //     if (arready)  
        //         snoop_state <= DEVIL_R_PHASE;
        //     else
        //         snoop_state <= snoop_state;
        // end
        // else if (snoop_state == DEVIL_R_PHASE) 
        // begin
        //     if (rready && rvalid) begin 
        //         r_index <= r_index + 1;
        //         r_buff[r_index] <= rdata;
        //     end

        //     if (rready && rvalid && rlast) 
        //         snoop_state <= DEVIL_RACK;
        //     else
        //         snoop_state <= snoop_state;
        // end
        // else if (snoop_state == DEVIL_RACK) 
        // begin
        //         snoop_state <= IDLE;
        // end


        // else if (snoop_state == DEVIL_AW_PHASE) 
        // begin
        //     if (awready)  
        //         snoop_state <= DEVIL_W_PHASE;
        //     else
        //         snoop_state <= snoop_state;
        // end
        // else if (snoop_state == DEVIL_W_PHASE) 
        // begin
        //     if (wready && wvalid) begin 
        //         r_index <= r_index + 1;
        //         if(r_index == 3) // to assert wlast for 1 clock
        //             r_index <= 0;
        //     end

        //     if (wready && wvalid && wlast) 
        //         snoop_state <= DEVIL_B_PHASE;
        //     else
        //         snoop_state <= snoop_state;
        // end
        // else if (snoop_state == DEVIL_B_PHASE) 
        // begin
        //     if ((bresp == `OKAY) && bvalid && bready) 
        //         snoop_state <= DEVIL_WACK;
        //     else
        //         snoop_state <= snoop_state;
        // end
        // else if (snoop_state == DEVIL_WACK) 
        // begin
        //         snoop_state <= IDLE;
        // end

        // Backstabber
        else if (snoop_state == NON_REPLY_OR_DVM_OP_LAST)
        begin
            if (crready)
                snoop_state <= IDLE;
            else
                snoop_state <= snoop_state;
        end
        else if (snoop_state == DVM_SYNC_MP)
        begin
             if (crready)
                 snoop_state <= DVM_SYNC_WAIT;
             else
                 snoop_state <= snoop_state;
        end
        else if (snoop_state == DVM_SYNC_WAIT)
        begin
             if (ac_handshake)// && (acsnoop == 4'hF))
                 snoop_state <= DVM_SYNC_LAST;
             else
                 snoop_state <= snoop_state;
        end
        else if (snoop_state == DVM_SYNC_LAST)
        begin
             if (arready && crready)
                 snoop_state <= DVM_SYNC_READ;
             else
                 snoop_state <= snoop_state;
        end
//        else if (snoop_state == DVM_SYNC_READ)
//        begin
//             if (r_handshake)
//                 snoop_state <= DVM_SYNC_RACK;
//             else
//                 snoop_state <= snoop_state;
//        end
        //else if (snoop_state == DVM_SYNC_RACK)
        else if (snoop_state == DVM_SYNC_READ)
        begin
             snoop_state <= IDLE;
        end
        else if (snoop_state == DVM_OP_MP)
        begin
             if (crready)
                 snoop_state <= DVM_OP_WAIT;
             else
                 snoop_state <= snoop_state;
        end
        else if (snoop_state == DVM_OP_WAIT)
        begin
             if (ac_handshake)// && (acsnoop == 4'hF))
                 snoop_state <= NON_REPLY_OR_DVM_OP_LAST;
             else
                 snoop_state <= snoop_state;
        end

        else if (snoop_state == REPLY)
        begin
             if (crready)
                 snoop_state <= IDLE;
             else
                 snoop_state <= snoop_state;
        end


    end

    Queue #(
        .DATA_SIZE(C_ACE_ADDR_WIDTH),
        .QUEUE_LENGTH(QUEUE_DEPTH)
    ) contexts (
        .clock(ace_aclk),
        .reset(~ace_aresetn),
        .valueIn(acaddr),
        .valueInValid(queue_push_condition),
        .consumed(queue_pop_condition),
        .valueOut(read_addr),
        .empty(queue_empty),
        .full(queue_full)
    );

    // Instantiation of Axi Bus Interface Config_AXI
    ConfigurationPort # (
        .C_S_AXI_ID_WIDTH(C_Config_AXI_ID_WIDTH),
        .C_S_AXI_DATA_WIDTH(C_Config_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_Config_AXI_ADDR_WIDTH),
        .C_S_AXI_AWUSER_WIDTH(C_Config_AXI_AWUSER_WIDTH),
        .C_S_AXI_ARUSER_WIDTH(C_Config_AXI_ARUSER_WIDTH)
    ) configuration_port (
        .S_AXI_ACLK(config_axi_aclk),
        .S_AXI_ARESETN(config_axi_aresetn),
        .S_AXI_AWID(config_axi_awid),
        .S_AXI_AWADDR(config_axi_awaddr),
        .S_AXI_AWLEN(config_axi_awlen),
        .S_AXI_AWSIZE(config_axi_awsize),
        .S_AXI_AWBURST(config_axi_awburst),
        .S_AXI_AWLOCK(config_axi_awlock),
        .S_AXI_AWCACHE(config_axi_awcache),
        .S_AXI_AWPROT(config_axi_awprot),
        .S_AXI_AWQOS(config_axi_awqos),
        .S_AXI_AWREGION(config_axi_awregion),
        .S_AXI_AWUSER(config_axi_awuser),
        .S_AXI_AWVALID(config_axi_awvalid),
        .S_AXI_AWREADY(config_axi_awready),
        .S_AXI_WDATA(config_axi_wdata),
        .S_AXI_WSTRB(config_axi_wstrb),
        .S_AXI_WLAST(config_axi_wlast),
        .S_AXI_WVALID(config_axi_wvalid),
        .S_AXI_WREADY(config_axi_wready),
        .S_AXI_BID(config_axi_bid),
        .S_AXI_BRESP(config_axi_bresp),
        .S_AXI_BVALID(config_axi_bvalid),
        .S_AXI_BREADY(config_axi_bready),
        .S_AXI_ARID(config_axi_arid),
        .S_AXI_ARADDR(config_axi_araddr),
        .S_AXI_ARLEN(config_axi_arlen),
        .S_AXI_ARSIZE(config_axi_arsize),
        .S_AXI_ARBURST(config_axi_arburst),
        .S_AXI_ARLOCK(config_axi_arlock),
        .S_AXI_ARCACHE(config_axi_arcache),
        .S_AXI_ARPROT(config_axi_arprot),
        .S_AXI_ARQOS(config_axi_arqos),
        .S_AXI_ARREGION(config_axi_arregion),
        .S_AXI_ARUSER(config_axi_aruser),
        .S_AXI_ARVALID(config_axi_arvalid),
        .S_AXI_ARREADY(config_axi_arready),
        .S_AXI_RID(config_axi_rid),
        .S_AXI_RDATA(config_axi_rdata),
        .S_AXI_RRESP(config_axi_rresp),
        .S_AXI_RLAST(config_axi_rlast),
        .S_AXI_RVALID(config_axi_rvalid),
        .S_AXI_RREADY(config_axi_rready),
        .memory_out(buffer)
    );

    // // Instantiation of Axi-Lite Bus Interface s01_AXI
	// fuzzing_ACE_v1_0_S01_AXI # ( 
	// 	.C_S_AXI_DATA_WIDTH(C_S01_AXI_DATA_WIDTH),
	// 	.C_S_AXI_ADDR_WIDTH(C_S01_AXI_ADDR_WIDTH)
	// ) fuzzing_ACE_v1_0_s01_AXI_inst (
	// 	.S_AXI_ACLK(s01_axi_aclk),
	// 	.S_AXI_ARESETN(s01_axi_aresetn),
	// 	.S_AXI_AWADDR(s01_axi_awaddr),
	// 	.S_AXI_AWPROT(s01_axi_awprot),
	// 	.S_AXI_AWVALID(s01_axi_awvalid),
	// 	.S_AXI_AWREADY(s01_axi_awready),
	// 	.S_AXI_WDATA(s01_axi_wdata),
	// 	.S_AXI_WSTRB(s01_axi_wstrb),
	// 	.S_AXI_WVALID(s01_axi_wvalid),
	// 	.S_AXI_WREADY(s01_axi_wready),
	// 	.S_AXI_BRESP(s01_axi_bresp),
	// 	.S_AXI_BVALID(s01_axi_bvalid),
	// 	.S_AXI_BREADY(s01_axi_bready),
	// 	.S_AXI_ARADDR(s01_axi_araddr),
	// 	.S_AXI_ARPROT(s01_axi_arprot),
	// 	.S_AXI_ARVALID(s01_axi_arvalid),
	// 	.S_AXI_ARREADY(s01_axi_arready),
	// 	.S_AXI_RDATA(s01_axi_rdata),
	// 	.S_AXI_RRESP(s01_axi_rresp),
	// 	.S_AXI_RVALID(s01_axi_rvalid),
	// 	.S_AXI_RREADY(s01_axi_rready),
    //     .o_control_reg(w_control_reg),
    //     .i_status_reg(w_write_status_reg), // The Value that the this IP Writes to Status Reg 
    //     .o_status_reg(w_read_status_reg), // The Value that User Writes to Status Reg
    //     .o_delay_reg(w_delay_reg),
    //     .o_acsnoop_reg(w_acsnoop_reg),
    //     .o_base_addr_reg(w_base_addr_reg),
    //     .o_addr_size_reg(w_addr_size_reg)
	// );

    wire w_control_EN;
    wire [3:0] w_control_TEST;
    wire [3:0] w_control_FUNC;
    wire [4:0] w_control_CRRESP;
    wire w_control_ACFLT;
    wire w_control_ADDRFLT;
    wire w_control_OSHEN;
    wire w_control_CONEN;
    wire w_control_ADLEN;
    wire w_control_ADTEN;
    wire w_control_PDTEN;
    wire w_status_OSH_END;
    wire w_status_OSH_END_hw_set;
    wire [31:0] w_delay_data;
    wire [3:0] w_acsnoop_type;
    wire [31:0] w_base_addr_Data;
    wire [31:0] w_mem_size_Data;
    wire [31:0] w_wdata_0_data;
    wire [31:0] w_wdata_1_data;
    wire [31:0] w_wdata_2_data;
    wire [31:0] w_wdata_3_data;
    wire [31:0] w_wdata_4_data;
    wire [31:0] w_wdata_5_data;
    wire [31:0] w_wdata_6_data;
    wire [31:0] w_wdata_7_data;
    wire [31:0] w_wdata_8_data;
    wire [31:0] w_wdata_9_data;
    wire [31:0] w_wdata_10_data;
    wire [31:0] w_wdata_11_data;
    wire [31:0] w_wdata_12_data;
    wire [31:0] w_wdata_13_data;
    wire [31:0] w_wdata_14_data;
    wire [31:0] w_wdata_15_data;

    assign w_control_reg = {w_control_PDTEN,    // bit 20
                            w_control_ADTEN,    // bit 19
                            w_control_ADLEN,    // bit 18
                            w_control_CONEN,    // bit 17 
                            w_control_OSHEN,    // bit 16
                            w_control_ADDRFLT,  // bit 15
                            w_control_ACFLT,    // bit 14
                            w_control_CRRESP,   // bit 13:9
                            w_control_FUNC,     // bit 8:5
                            w_control_TEST,     // bit 4:1
                            w_control_EN};      // bit 0

    // Instantiation of devil register file 
    devil_register_file #(
        .ADDRESS_WIDTH(C_S01_AXI_ADDR_WIDTH) 
    )devil_register_file_inst(
    .i_clk(s01_axi_aclk),
    .i_rst_n(s01_axi_aresetn),
    .i_awvalid(s01_axi_awvalid),
    .o_awready(s01_axi_awready),
    .i_awid(0),
    .i_awaddr(s01_axi_awaddr),
    .i_awprot(s01_axi_awprot),
    .i_wvalid(s01_axi_wvalid),
    .o_wready(s01_axi_wready),
    .i_wdata(s01_axi_wdata),
    .i_wstrb(s01_axi_wstrb),
    .o_bvalid(s01_axi_bvalid),
    .i_bready(s01_axi_bready),
    .o_bresp(s01_axi_bresp),
    .i_arvalid(s01_axi_arvalid),
    .o_arready(s01_axi_arready),
    .i_arid(0),
    .i_araddr(s01_axi_araddr),
    .i_arprot(s01_axi_arprot),
    .o_rvalid(s01_axi_rvalid),
    .i_rready(s01_axi_rready),
    .o_rdata(s01_axi_rdata),
    .o_rresp(s01_axi_rresp),
    .o_control_EN(w_control_EN),
    .o_control_TEST(w_control_TEST),
    .o_control_FUNC(w_control_FUNC),
    .o_control_CRRESP(w_control_CRRESP),
    .o_control_ACFLT(w_control_ACFLT),
    .o_control_ADDRFLT(w_control_ADDRFLT),
    .o_control_OSHEN(w_control_OSHEN),
    .o_control_CONEN(w_control_CONEN),
    .o_control_ADLEN(w_control_ADLEN),
    .o_control_ADTEN(w_control_ADTEN),
    .o_control_PDTEN(w_control_PDTEN),
    .o_status_OSH_END(w_read_status_reg),
    .i_status_OSH_END_hw_set(w_write_status_reg),
    .i_status_BUSY_hw_set(w_devil_busy),
    .i_status_BUSY_hw_clear(~w_devil_busy),
    .o_delay_data(w_delay_reg),
    .o_acsnoop_type(w_acsnoop_reg),
    .o_base_addr_Data(w_base_addr_reg),
    .o_mem_size_Data(w_addr_size_reg),
    .o_arsnoop_Data(w_arsnoop_Data),
    .o_l_araddr_Data(w_l_araddr_Data),
    .o_h_araddr_Data(w_h_araddr_Data),
    .o_awsnoop_Data(w_awsnoop_Data),
    .o_l_awaddr_Data(w_l_awaddr_Data),
    .o_h_awaddr_Data(w_h_awaddr_Data),
    // Cache line data (Read)
     .i_rdata_0_data(w_read_cache_line[31+32*0:0+32*0]),
     .i_rdata_1_data(w_read_cache_line[31+32*1:0+32*1]),
     .i_rdata_2_data(w_read_cache_line[31+32*2:0+32*2]),
     .i_rdata_3_data(w_read_cache_line[31+32*3:0+32*3]),
     .i_rdata_4_data(w_read_cache_line[31+32*4:0+32*4]),
     .i_rdata_5_data(w_read_cache_line[31+32*5:0+32*5]),
     .i_rdata_6_data(w_read_cache_line[31+32*6:0+32*6]),
     .i_rdata_7_data(w_read_cache_line[31+32*7:0+32*7]),
     .i_rdata_8_data(w_read_cache_line[31+32*8:0+32*8]),
     .i_rdata_9_data(w_read_cache_line[31+32*9:0+32*9]),
    .i_rdata_10_data(w_read_cache_line[31+32*10:0+32*10]),
    .i_rdata_11_data(w_read_cache_line[31+32*11:0+32*11]),
    .i_rdata_12_data(w_read_cache_line[31+32*12:0+32*12]),
    .i_rdata_13_data(w_read_cache_line[31+32*13:0+32*13]),
    .i_rdata_14_data(w_read_cache_line[31+32*14:0+32*14]),
    .i_rdata_15_data(w_read_cache_line[31+32*15:0+32*15]),
    // Cache line data (Write)
     .o_wdata_0_data(w_write_cache_line[31+32*0:0+32*0]),
     .o_wdata_1_data(w_write_cache_line[31+32*1:0+32*1]),
     .o_wdata_2_data(w_write_cache_line[31+32*2:0+32*2]),
     .o_wdata_3_data(w_write_cache_line[31+32*3:0+32*3]),
     .o_wdata_4_data(w_write_cache_line[31+32*4:0+32*4]),
     .o_wdata_5_data(w_write_cache_line[31+32*5:0+32*5]),
     .o_wdata_6_data(w_write_cache_line[31+32*6:0+32*6]),
     .o_wdata_7_data(w_write_cache_line[31+32*7:0+32*7]),
     .o_wdata_8_data(w_write_cache_line[31+32*8:0+32*8]),
     .o_wdata_9_data(w_write_cache_line[31+32*9:0+32*9]),
    .o_wdata_10_data(w_write_cache_line[31+32*10:0+32*10]),
    .o_wdata_11_data(w_write_cache_line[31+32*11:0+32*11]),
    .o_wdata_12_data(w_write_cache_line[31+32*12:0+32*12]),
    .o_wdata_13_data(w_write_cache_line[31+32*13:0+32*13]),
    .o_wdata_14_data(w_write_cache_line[31+32*14:0+32*14]),
    .o_wdata_15_data(w_write_cache_line[31+32*15:0+32*15])
    );

    // Instantiation of devil-in-fpgs module
    devil_in_fpga #(
		.C_S_AXI_DATA_WIDTH(C_S01_AXI_DATA_WIDTH),
        .C_ACE_DATA_WIDTH(C_ACE_DATA_WIDTH),
        .C_ACE_ADDR_WIDTH(C_ACE_ADDR_WIDTH),
        .DEVIL_EN(DEVIL_EN)
    ) devil_in_fpga_inst(
        .ace_aclk(ace_aclk),
        .ace_aresetn(ace_aresetn),
        .acsnoop(acsnoop),
        .acaddr(acaddr),
        .i_arlen(arlen),
        .i_snoop_state(w_snoop_state),
        .o_fsm_devil_state(w_fsm_devil_state),
        .o_fsm_devil_state_active(w_fsm_devil_state_active),
        .i_control_reg(w_control_reg),
        .i_read_status_reg(w_read_status_reg), // The Value that User Writes to Status Reg
        .o_write_status_reg(w_write_status_reg), // The Value that the this IP Writes to Status Reg 
        .i_delay_reg(w_delay_reg),
        .i_acsnoop_reg(w_acsnoop_reg),
        .i_base_addr_reg(w_base_addr_reg),
        .i_addr_size_reg(w_addr_size_reg),
        .o_rdata(w_rdata),
        .o_crresp(w_crresp),
        .o_crvalid(w_crvalid),
        .o_cdvalid(w_cdvalid),
        .o_cdlast(w_cdlast),
        .o_end(w_devil_end),
        .i_trigger_passive_path(w_trigger_passive_path),
        .i_trigger_active_path(w_trigger_active_path),
        .i_crready(crready),
        .o_reply(w_devil_reply),
        .o_busy(w_devil_busy),
        .i_cdready(cdready),
        .i_acaddr_snapshot(w_acaddr_snapshot),
        .i_acsnoop_snapshot(w_acsnoop_snapshot),
        .o_ar_phase(w_devil_ar_phase),
        .o_r_phase(w_devil_r_phase),
        .o_rack_phase(w_devil_rack_phase),
        .o_aw_phase(w_devil_aw_phase),
        .o_w_phase(w_devil_w_phase),
        .o_b_phase(w_devil_b_phase),
        .o_wack_phase(w_devil_wack_phase),
        .o_wlast(w_wlast),
        .o_wdata(w_wdata),
        .i_arready(arready),
        .i_rready(rready),
        .i_rvalid(rvalid),
        .i_rdata(rdata),
        .i_rlast(rlast),
        .i_awready(awready),
        .i_wready(wready),
        .i_wvalid(wvalid),
        .i_wlast(wlast),
        .i_bresp(bresp),
        .i_bvalid(bvalid),
        .i_bready(bready),
        .o_cache_line(w_read_cache_line),
        .i_cache_line(w_write_cache_line),
        .o_counter(w_counter) // test porpuses
    );

	endmodule
