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

	module writebooster_v1_0 #
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
        parameter integer C_S00_AXI_BUSER_WIDTH     = 0
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
        // Ports of Axi Master Bus Interface M00_AXI
        input  wire                                          m01_axi_aclk,
        input  wire                                          m01_axi_aresetn,
        output wire               [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_awid,
        output wire             [C_M00_AXI_ADDR_WIDTH-1 : 0] m01_axi_awaddr,
        output wire                                  [7 : 0] m01_axi_awlen,
        output wire                                  [2 : 0] m01_axi_awsize,
        output wire                                  [1 : 0] m01_axi_awburst,
        output wire                                          m01_axi_awlock,
        output wire                                  [3 : 0] m01_axi_awcache,
        output wire                                  [2 : 0] m01_axi_awprot,
        output wire                                  [3 : 0] m01_axi_awqos,
        output wire           [C_M00_AXI_AWUSER_WIDTH-1 : 0] m01_axi_awuser,
        output wire                                          m01_axi_awvalid,
        input  wire                                          m01_axi_awready,
        output wire             [C_M00_AXI_DATA_WIDTH-1 : 0] m01_axi_wdata,
        output wire           [C_M00_AXI_DATA_WIDTH/8-1 : 0] m01_axi_wstrb,
        output wire                                          m01_axi_wlast,
        output wire            [C_M00_AXI_WUSER_WIDTH-1 : 0] m01_axi_wuser,
        output wire                                          m01_axi_wvalid,
        input  wire                                          m01_axi_wready,
        input  wire               [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_bid,
        input  wire                                  [1 : 0] m01_axi_bresp,
        input  wire            [C_M00_AXI_BUSER_WIDTH-1 : 0] m01_axi_buser,
        input  wire                                          m01_axi_bvalid,
        output wire                                          m01_axi_bready,
        output wire               [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_arid,
        output wire             [C_M00_AXI_ADDR_WIDTH-1 : 0] m01_axi_araddr,
        output wire                                  [7 : 0] m01_axi_arlen,
        output wire                                  [2 : 0] m01_axi_arsize,
        output wire                                  [1 : 0] m01_axi_arburst,
        output wire                                          m01_axi_arlock,
        output wire                                  [3 : 0] m01_axi_arcache,
        output wire                                  [2 : 0] m01_axi_arprot,
        output wire                                  [3 : 0] m01_axi_arqos,
        output wire           [C_M00_AXI_ARUSER_WIDTH-1 : 0] m01_axi_aruser,
        output wire                                          m01_axi_arvalid,
        input  wire                                          m01_axi_arready,
        input  wire               [C_M00_AXI_ID_WIDTH-1 : 0] m01_axi_rid,
        input  wire             [C_M00_AXI_DATA_WIDTH-1 : 0] m01_axi_rdata,
        input  wire                                  [1 : 0] m01_axi_rresp,
        input  wire                                          m01_axi_rlast,
        input  wire            [C_M00_AXI_RUSER_WIDTH-1 : 0] m01_axi_ruser,
        input  wire                                          m01_axi_rvalid,
        output wire                                          m01_axi_rready,
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
        // Debug (temporary) IO
        output wire                                    [3:0] debug_state
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
    
    wire wbu_hit;
    wire [$clog2(QUEUE_DEPTH)-1: 0] wbu_hit_index;
    wire   [(4*C_M00_AXI_DATA_WIDTH)-1 : 0] wdata_out;
    wire [(4*C_M00_AXI_DATA_WIDTH/8)-1 : 0] wstrb_out;
    reg [1 : 0] hit_state; // 0: idle, 1: wait, 2: processing

    // AXI outputs
    // AW channel
    reg         axi_awready;
    reg [7 : 0] axi_awlen;
    reg [2 : 0] axi_awsize;
    reg         axi_aw_w_handshake;
    reg [1 : 0] axi_awburst;
    assign s00_axi_awready = axi_awready;
    assign  s00_axi_wready = axi_aw_w_handshake;
    
    reg                            axi_bvalid;
    reg [C_M00_AXI_ID_WIDTH-1 : 0] axi_bid;
    assign  s00_axi_bvalid = axi_bvalid;
    assign   s00_axi_bresp = 0;
    assign     s00_axi_bid = axi_bid;
    assign  m01_axi_bready = 1;

    wire write_queue_push_condition;
    wire write_queue_pop_condition;
    wire write_empty;
    wire write_full;
    
    wire aw_handshake;
    wire w_done;
    wire w_handshake;
    wire b_handshake;
    
    assign write_queue_push_condition = w_done;
    
    assign aw_handshake = s00_axi_awvalid && s00_axi_awready;
    assign  w_handshake = s00_axi_wvalid && s00_axi_wready;
    assign       w_done = w_handshake && s00_axi_wlast;
    assign  b_handshake = axi_bvalid && s00_axi_bready;
    
    reg       [C_M00_AXI_ADDR_WIDTH-1 : 0] awaddr_buf;
    reg   [(4*C_M00_AXI_DATA_WIDTH)-1 : 0] wdata_buf;
    reg [(4*C_M00_AXI_DATA_WIDTH/8)-1 : 0] wstrb_buf;
    reg                  [$clog2(4)-1 : 0] write_counter;
    
          
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn)
        begin
            awaddr_buf <= 0;
            axi_bid <= 0;
            axi_awlen <= 0;
            axi_awsize <= 0;
            axi_awburst <= 0;
        end
        else if (aw_handshake)
        begin
            awaddr_buf <= s00_axi_awaddr;
            axi_bid <= s00_axi_awid;
            axi_awlen <= s00_axi_awlen;
            axi_awsize <= s00_axi_awsize;
            axi_awburst <= s00_axi_awburst;
        end
    end
    
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn)
        begin
            wdata_buf <= 0;
            wstrb_buf <= 0;
        end
        else if (w_handshake)
        begin
            wdata_buf <= (wdata_buf << C_M00_AXI_DATA_WIDTH) | {{(3*C_M00_AXI_DATA_WIDTH){1'b0}}, s00_axi_wdata};
            wstrb_buf <= (wstrb_buf << (C_M00_AXI_DATA_WIDTH/8)) | {{(3*(C_M00_AXI_DATA_WIDTH/8)){1'b0}}, s00_axi_wstrb};
        end
    end
    
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn)
            axi_awready <= 0;
        else if (~axi_awready && s00_axi_awvalid && ~axi_aw_w_handshake && ~write_full)
            axi_awready <= 1;
        else
            axi_awready <= 0;
    end
    
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn)
            axi_aw_w_handshake <= 0;
        else if (aw_handshake)
            axi_aw_w_handshake <= 1;
        else if (w_done)
            axi_aw_w_handshake <= 0;
    end
    
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn)
            axi_bvalid <= 0;
        else if (axi_bvalid && s00_axi_bready)
            axi_bvalid <= 0;
        else if (w_done)
            axi_bvalid <= 1;
    end
    
    wire m_w_done;
    
    QueueLUTRAM #(
        .DATA_SIZE(C_M00_AXI_ADDR_WIDTH),
        .QUEUE_LENGTH(QUEUE_DEPTH),
        .ADDR_WIDTH(C_M00_AXI_ADDR_WIDTH)
    ) write_addresses (
        .clock(ace_aclk),
        .reset(~ace_aresetn),
        .valueIn(awaddr_buf),
        .valueInValid(write_queue_push_condition),
        .consumed(m_w_done),
        .valueOut(m01_axi_awaddr),
        .empty(), // Relies on context queue integrity
        .full(),  // Relies on context queue integrity
        .poke(~write_empty),
        .pokeAddr(read_addr),
        .hit(wbu_hit),
        .hitIndex(wbu_hit_index)
    );
    
    QueueBRAM #(
        .DATA_SIZE(8+3+2+4*(C_M00_AXI_DATA_WIDTH+(C_M00_AXI_DATA_WIDTH/8))),
        .QUEUE_LENGTH(QUEUE_DEPTH)
    ) write_contexts (
        .clock(ace_aclk),
        .reset(~ace_aresetn),
        .valueIn({axi_awlen, axi_awsize, axi_awburst, s00_axi_wdata, wdata_buf[383 : 0], s00_axi_wstrb, wstrb_buf[47 : 0]}),
        .valueInValid(write_queue_push_condition),
        .consumed(m_w_done),
        .valueOut({m01_axi_awlen, m01_axi_awsize, m01_axi_awburst, wdata_out, wstrb_out}),
        .empty(write_empty),
        .full(write_full),
        .hit(wbu_hit),
        .hitIndex(wbu_hit_index)
    );
    
    reg  m_axi_aw_w_handshake;
    wire m_aw_handshake;
    wire m_w_handshake;
    
    reg m_axi_awvalid;
    assign m01_axi_awvalid = m_axi_awvalid;
    assign m01_axi_wvalid = m_axi_aw_w_handshake;
    assign m_aw_handshake = m_axi_awvalid && m01_axi_awready;
    assign m_w_handshake = m01_axi_wvalid && m01_axi_wready;
    assign m_w_done = m_w_handshake && m01_axi_wlast;
            
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn)
            m_axi_awvalid <= 0;
        else if (~m_axi_awvalid && m01_axi_awready && ~m_axi_aw_w_handshake && ~write_empty)
            m_axi_awvalid <= 1;
        else
            m_axi_awvalid <= 0;
    end
    
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn)
            m_axi_aw_w_handshake <= 0;
        else if (m_aw_handshake)
            m_axi_aw_w_handshake <= 1;
        else if (m_w_done)
            m_axi_aw_w_handshake <= 0;
    end
    
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn)
            write_counter <= 0;
        else if (m_w_handshake)
            write_counter <= write_counter + 1;
        else
            write_counter <= write_counter;
    end
    
    assign m01_axi_wdata = (write_counter == 0)? wdata_out[2*C_M00_AXI_DATA_WIDTH +: C_M00_AXI_DATA_WIDTH] :
                           (write_counter == 1)? wdata_out[1*C_M00_AXI_DATA_WIDTH +: C_M00_AXI_DATA_WIDTH] :
                           (write_counter == 2)? wdata_out[0*C_M00_AXI_DATA_WIDTH +: C_M00_AXI_DATA_WIDTH] :
                           wdata_out[3*C_M00_AXI_DATA_WIDTH +: C_M00_AXI_DATA_WIDTH];
    
    assign m01_axi_wstrb = (write_counter == 0)? wstrb_out[2*C_M00_AXI_DATA_WIDTH/8 +: C_M00_AXI_DATA_WIDTH/8] :
                           (write_counter == 1)? wstrb_out[1*C_M00_AXI_DATA_WIDTH/8 +: C_M00_AXI_DATA_WIDTH/8] :
                           (write_counter == 2)? wstrb_out[0*C_M00_AXI_DATA_WIDTH/8 +: C_M00_AXI_DATA_WIDTH/8] :
                           wstrb_out[3*C_M00_AXI_DATA_WIDTH/8 +: C_M00_AXI_DATA_WIDTH/8];
                           
    assign m01_axi_awcache = 0;
    assign m01_axi_awprot  = 0;
    assign m01_axi_awqos   = 0;
    assign m01_axi_awid    = 0;
    assign m01_axi_awlock  = 0;
    assign m01_axi_wlast   = (write_counter == 3);
    
    // Write channels
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
    assign m00_axi_wdata   = 0;
    assign m00_axi_wstrb   = 0;
    assign m00_axi_wlast   = 0;
    assign m00_axi_wuser   = 0;
    assign m00_axi_wvalid  = 0;
//    assign s00_axi_wready  = 0;
//    assign s00_axi_bid     = 0;
//    assign s00_axi_bresp   = 0;
    assign s00_axi_buser   = 0;
//    assign s00_axi_bvalid  = 0;
    assign m00_axi_bready  = 1;
        
    // AR channel
    assign m00_axi_arid    = 0;       // Kept same for enforcing in-order in slave
    assign m00_axi_araddr  = read_addr;
    assign m00_axi_arlen   = 3;
    assign m00_axi_arsize  = 3'b100;  // 16 Bytes in burst
    assign m00_axi_arburst = 2'b01;   // INCR
    assign m00_axi_arlock  = 2'b00;
    assign m00_axi_arcache = 4'b1110; // READ ALLOCATE
    assign m00_axi_arprot  = acprot;
    assign m00_axi_arqos   = 0;       // No priority
    assign m00_axi_aruser  = 0;
    assign m00_axi_arvalid = ((~queue_empty) && ((hit_state == 0) && ~wbu_hit));
    // R channel
    assign m00_axi_rready  = cdready;
    
    // AR channel
    assign m01_axi_arid    = s00_axi_arid;       // Kept same for enforcing in-order in slave
    assign m01_axi_araddr  = s00_axi_araddr;
    assign m01_axi_arlen   = s00_axi_arlen;
    assign m01_axi_arsize  = s00_axi_arsize;  // 16 Bytes in burst
    assign m01_axi_arburst = s00_axi_arburst;   // INCR
    assign m01_axi_arlock  = s00_axi_arlock;
    assign m01_axi_arcache = s00_axi_arcache; // READ ALLOCATE
    assign m01_axi_arprot  = s00_axi_arprot;
    assign m01_axi_arqos   = s00_axi_arqos;       // No priority
    assign m01_axi_aruser  = s00_axi_aruser;
    assign m01_axi_arvalid = s00_axi_arvalid;
    assign s00_axi_arready = m01_axi_arready;
    // R channel
    assign m01_axi_rready  = s00_axi_rready;
    assign s00_axi_rvalid  = m01_axi_rvalid;
    assign s00_axi_rdata   = m01_axi_rdata;
    assign s00_axi_rlast   = m01_axi_rlast;
    assign s00_axi_rresp   = m01_axi_rresp;
    assign s00_axi_rid     = m01_axi_rid;
    
    assign m01_axi_awuser  = 0;
    assign m01_axi_wuser   = 0;

	localparam BURST_LEN = CACHE_LINE_WIDTH_BITS/BUS_WIDTH;
	
	reg [32-1 : 0] reads_in_progress;
	wire ar_handshake;
	assign ar_handshake = m00_axi_arvalid && m00_axi_arready;
	
	always @(posedge s00_axi_aclk)
	begin
	   if (~s00_axi_aresetn)
	       reads_in_progress <= 0;
	   else if (ar_handshake && (m00_axi_rready && m00_axi_rvalid && m00_axi_rlast))
	       reads_in_progress <= reads_in_progress;
	   else if (ar_handshake)
	       reads_in_progress <= reads_in_progress+1;
       else if (m00_axi_rready && m00_axi_rvalid && m00_axi_rlast)
           reads_in_progress <= reads_in_progress-1;
	end

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
    reg   [3 : 0] snoop_state;

    assign queue_push_condition         = (snoop_state == IDLE) && reply_condition && ~queue_full && crready; //(snoop_state == REPLY) && ~queue_full && crready;
    assign queue_pop_condition          = ((hit_state == 2) && cdlast) |(m00_axi_arvalid && m00_axi_arready); // 'm00_axi_arvalid' is '~queue_empty'
	assign lying_condition              = (|config_port_to_backstabber_liar_crresp) &&
	                                      (acaddr >= config_port_to_backstabber_address_range_begin) &&
	                                      (config_port_to_backstabber_address_range_end >= acaddr);

	assign config_port_to_backstabber_liar_crresp         = buffer[0 +: 64];
    assign config_port_to_backstabber_address_range_begin = buffer[64 +: 64];
	assign config_port_to_backstabber_address_range_end   = buffer[128 +: 64];

	//assign crresp   = (is_in_range & ace_enable) ? 5'b01001 : 5'b00000; //Alyaws accept if is in range - DataTransfer & IsShared;
    assign crresp   = (snoop_state == REPLY) ? config_port_to_backstabber_liar_crresp[4 : 0] : 0; //if in a reply state, pass_data & pass_dirty & was_unique;
    assign acready  =  ~queue_full && ((snoop_state == IDLE)          ||
                       (snoop_state == DVM_SYNC_WAIT) ||
                       (snoop_state == DVM_OP_WAIT));
    assign crvalid  = ((snoop_state == NON_REPLY_OR_DVM_OP_LAST) && crready) ||
                      ((snoop_state == DVM_SYNC_MP) && crready) ||
                      ((snoop_state == DVM_OP_MP) && crready) ||
                      ((snoop_state == DVM_SYNC_LAST) && crready && arready) ||
                      ((snoop_state == REPLY) && crready);
    assign araddr   = 0;
    assign arbar    = 1'b0;
    assign arburst  = 2'b01; //Should be calculated based on the acaddr inc or wrap?
    assign arcache  = 4'h3;//Refer to page 64 of manual. What is the effect of ARCACHE[1]?
    assign ardomain = 2'b00;
    assign arid     = 0;
    assign arlen    = 0; // Set to 3 for Four bursts to fill 64B (CL size)
    assign arlock   = 0;
    assign arprot   = 3'b011; //Data, Privileged, Non-secure access
    assign arqos    = 0;
    assign arregion = 0;
    assign arsize   = 4'b100; //Size of each burst is 16B
    assign arsnoop  = ((snoop_state == DVM_SYNC_LAST) && crready && arready) ? 4'he : 0; //Means arbar and ardomain have to be 0
    assign aruser   = 0;
    assign arvalid  = ((snoop_state == DVM_SYNC_LAST) && crready && arready); //acvalid & is_in_range & ace_enable;
    assign awaddr   = 0;
    assign awbar    = 0;
    assign awburst  = 0;
    assign awcache  = 0;
    assign awdomain = 0;
    assign awid     = 0;
    assign awlen    = 0;
    assign awlock   = 0;
    assign awprot   = 0;
    assign awqos    = 0;
    assign awregion = 0;
    assign awsize   = 0;
    assign awsnoop  = 0;
    assign awuser   = 0;
    assign awvalid  = 0;
    assign bready   = 0;
    assign wack     = 0;
    assign wdata    = 0;
    assign wlast    = 0;
    assign wstrb    = 0;
    assign wuser    = 0;
    assign wvalid   = 0;
    
    reg [1 : 0] read_counter;
    reg [511 : 0] wbu_data;
    
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn)
            hit_state <= 0;
        else
        begin
            if (hit_state == 0)
            begin
                if (wbu_hit)
                begin
                    hit_state <= 1; // wait
                    wbu_data <= wdata_out;
                end
            end
            else if (hit_state == 1)
            begin
                if (reads_in_progress == 0)
                begin
                    hit_state <= 2;
                end
            end
            else if (hit_state == 2)
            begin
                if (cdlast)
                begin
                    hit_state <= 0;
                end
            end
        end
    end
    
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn)
            read_counter <= 0;
        else if ((hit_state == 2) && cdvalid && cdready)
            read_counter <= read_counter+1;
        else if ((hit_state == 2) && cdvalid && cdready && cdlast)
            read_counter <= 0;
        else 
            read_counter <= read_counter;
    end
    
    assign cddata = (~(hit_state == 2))? m00_axi_rdata :
                    (read_counter == 0)? wbu_data[2*C_M00_AXI_DATA_WIDTH +: C_M00_AXI_DATA_WIDTH] :
                    (read_counter == 1)? wbu_data[1*C_M00_AXI_DATA_WIDTH +: C_M00_AXI_DATA_WIDTH] :
                    (read_counter == 2)? wbu_data[0*C_M00_AXI_DATA_WIDTH +: C_M00_AXI_DATA_WIDTH] :
                    wbu_data[3*C_M00_AXI_DATA_WIDTH +: C_M00_AXI_DATA_WIDTH];
    
    assign cdlast  = (~(hit_state == 2))? m00_axi_rlast : (read_counter == 3);
    assign cdvalid = (~(hit_state == 2))? m00_axi_rvalid : 1;
    
    assign rready   = (snoop_state == DVM_SYNC_READ);
    assign rack     = (snoop_state == DVM_SYNC_READ);
    assign ac_handshake                   = acready && acvalid;
    assign r_handshake                    = rready && rvalid && rlast;
    assign reply_condition                = ac_handshake && (acsnoop != 4'hf) && lying_condition;
    assign non_reply_condition            = ac_handshake && (acsnoop != 4'hf) && ~lying_condition;
    assign dvm_operation_last_condition   = ac_handshake && (acsnoop == 4'hf) && (acaddr[15:12] != 4'b1100) && (acaddr[0] == 0);
    assign dvm_operation_multi_condition  = ac_handshake && (acsnoop == 4'hf) && (acaddr[15:12] != 4'b1100) && (acaddr[0] == 1);
    assign dvm_sync_last_condition        = ac_handshake && (acsnoop == 4'hf) && (acaddr[15:12] == 4'b1100) && (acaddr[0] == 0);
    assign dvm_sync_multi_condition       = ac_handshake && (acsnoop == 4'hf) && (acaddr[15:12] == 4'b1100) && (acaddr[0] == 1);

    assign debug_state                    = snoop_state;


	//main state-machine
	always @(posedge ace_aclk)
    begin
        if(~ace_aresetn)
            snoop_state <= IDLE;
        else if (snoop_state == IDLE)
        begin
            if(non_reply_condition || dvm_operation_last_condition)
                snoop_state <= NON_REPLY_OR_DVM_OP_LAST;
            else if (dvm_sync_multi_condition)
                snoop_state <= DVM_SYNC_MP;
            else if (dvm_sync_last_condition)
                snoop_state <= DVM_SYNC_LAST;
            else if (dvm_operation_multi_condition)
                snoop_state <= DVM_OP_MP;
            else if (reply_condition && ~queue_full)
                snoop_state <= REPLY;
            else
                snoop_state <= snoop_state;
        end
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


	endmodule