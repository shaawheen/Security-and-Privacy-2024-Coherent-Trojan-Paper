
`timescale 1 ns / 1 ps

	module test_register_file_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 6
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready,
		output wire w_control_EN,
		output wire [3:0] w_control_TEST,
		output wire [3:0] w_control_FUNC,
		output wire [4:0] w_control_CRRESP,
		output wire w_control_ACFLT,
		output wire w_control_ADDRFLT,
		output wire w_control_OSHEN,
		output wire w_control_CONEN,
		output wire w_status_OSH_END,
		output wire [31:0] w_delay_data,
		output wire [3:0] w_acsnoop_type,
		output wire [31:0] w_base_addr_Data,
		output wire [31:0] w_mem_size_Data,
		output wire  w_wvalid,
		output wire [C_S00_AXI_ADDR_WIDTH-1 : 0] w_awaddr,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] w_wdata
	);

	assign w_wvalid = s00_axi_wvalid;
	assign w_awaddr = s00_axi_awaddr;
	assign w_wdata = s00_axi_wdata;
// Instantiation of Axi Bus Interface S00_AXI
	// test_register_file_v1_0_S00_AXI # ( 
	// 	.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
	// 	.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	// ) test_register_file_v1_0_S00_AXI_inst (
	// 	.S_AXI_ACLK(s00_axi_aclk),
	// 	.S_AXI_ARESETN(s00_axi_aresetn),
	// 	.S_AXI_AWADDR(s00_axi_awaddr),
	// 	.S_AXI_AWPROT(s00_axi_awprot),
	// 	.S_AXI_AWVALID(s00_axi_awvalid),
	// 	.S_AXI_AWREADY(s00_axi_awready),
	// 	.S_AXI_WDATA(s00_axi_wdata),
	// 	.S_AXI_WSTRB(s00_axi_wstrb),
	// 	.S_AXI_WVALID(s00_axi_wvalid),
	// 	.S_AXI_WREADY(s00_axi_wready),
	// 	.S_AXI_BRESP(s00_axi_bresp),
	// 	.S_AXI_BVALID(s00_axi_bvalid),
	// 	.S_AXI_BREADY(s00_axi_bready),
	// 	.S_AXI_ARADDR(s00_axi_araddr),
	// 	.S_AXI_ARPROT(s00_axi_arprot),
	// 	.S_AXI_ARVALID(s00_axi_arvalid),
	// 	.S_AXI_ARREADY(s00_axi_arready),
	// 	.S_AXI_RDATA(s00_axi_rdata),
	// 	.S_AXI_RRESP(s00_axi_rresp),
	// 	.S_AXI_RVALID(s00_axi_rvalid),
	// 	.S_AXI_RREADY(s00_axi_rready)
	// );

	devil_register_file #(
        .ADDRESS_WIDTH(C_S00_AXI_ADDR_WIDTH) 
    )devil_register_file_inst(
    .i_clk(s00_axi_aclk),
    .i_rst_n(s00_axi_aresetn),
    .i_awvalid(s00_axi_awvalid),
    .o_awready(s00_axi_awready),
    .i_awid(0),
    .i_awaddr(s00_axi_awaddr),
    .i_awprot(s00_axi_awprot),
    .i_wvalid(s00_axi_wvalid),
    .o_wready(s00_axi_wready),
    .i_wdata(s00_axi_wdata),
    .i_wstrb(s00_axi_wstrb),
    .o_bvalid(s00_axi_bvalid),
    .i_bready(s00_axi_bready),
    .o_bresp(s00_axi_bresp),
    .i_arvalid(s00_axi_arvalid),
    .o_arready(s00_axi_arready),
    .i_arid(0),
    .i_araddr(s00_axi_araddr),
    .i_arprot(s00_axi_arprot),
    .o_rvalid(s00_axi_rvalid),
    .i_rready(s00_axi_rready),
    .o_rdata(s00_axi_rdata),
    .o_rresp(s00_axi_rresp),
    .o_control_EN(w_control_EN),
    .o_control_TEST(w_control_TEST),
    .o_control_FUNC(w_control_FUNC),
    .o_control_CRRESP(w_control_CRRESP),
    .o_control_ACFLT(w_control_ACFLT),
    .o_control_ADDRFLT(w_control_ADDRFLT),
    .o_control_OSHEN(w_control_OSHEN),
    .o_control_CONEN(w_control_CONEN),
    .o_status_OSH_END(w_status_OSH_END),
    .i_status_OSH_END_hw_set(w_control_OSHEN),
    .i_status_BUSY_hw_set(w_control_EN),
    .i_status_BUSY_hw_clear(~w_control_EN),
    .o_delay_data(w_delay_data),
    .o_acsnoop_type(w_acsnoop_type),
    .o_base_addr_Data(w_base_addr_Data),
    .o_mem_size_Data(w_mem_size_Data)
    );

	// Add user logic here

	// User logic ends

	endmodule
