 








// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

`timescale 1ns/1ps

module design_1_zynq_ultra_ps_e_0_0 (
maxihpm0_fpd_aclk, 
maxigp0_awid, 
maxigp0_awaddr, 
maxigp0_awlen, 
maxigp0_awsize, 
maxigp0_awburst, 
maxigp0_awlock, 
maxigp0_awcache, 
maxigp0_awprot, 
maxigp0_awvalid, 
maxigp0_awuser, 
maxigp0_awready, 
maxigp0_wdata, 
maxigp0_wstrb, 
maxigp0_wlast, 
maxigp0_wvalid, 
maxigp0_wready, 
maxigp0_bid, 
maxigp0_bresp, 
maxigp0_bvalid, 
maxigp0_bready, 
maxigp0_arid, 
maxigp0_araddr, 
maxigp0_arlen, 
maxigp0_arsize, 
maxigp0_arburst, 
maxigp0_arlock, 
maxigp0_arcache, 
maxigp0_arprot, 
maxigp0_arvalid, 
maxigp0_aruser, 
maxigp0_arready, 
maxigp0_rid, 
maxigp0_rdata, 
maxigp0_rresp, 
maxigp0_rlast, 
maxigp0_rvalid, 
maxigp0_rready, 
maxigp0_awqos, 
maxigp0_arqos, 
maxihpm0_lpd_aclk, 
maxigp2_awid, 
maxigp2_awaddr, 
maxigp2_awlen, 
maxigp2_awsize, 
maxigp2_awburst, 
maxigp2_awlock, 
maxigp2_awcache, 
maxigp2_awprot, 
maxigp2_awvalid, 
maxigp2_awuser, 
maxigp2_awready, 
maxigp2_wdata, 
maxigp2_wstrb, 
maxigp2_wlast, 
maxigp2_wvalid, 
maxigp2_wready, 
maxigp2_bid, 
maxigp2_bresp, 
maxigp2_bvalid, 
maxigp2_bready, 
maxigp2_arid, 
maxigp2_araddr, 
maxigp2_arlen, 
maxigp2_arsize, 
maxigp2_arburst, 
maxigp2_arlock, 
maxigp2_arcache, 
maxigp2_arprot, 
maxigp2_arvalid, 
maxigp2_aruser, 
maxigp2_arready, 
maxigp2_rid, 
maxigp2_rdata, 
maxigp2_rresp, 
maxigp2_rlast, 
maxigp2_rvalid, 
maxigp2_rready, 
maxigp2_awqos, 
maxigp2_arqos, 
saxihpc0_fpd_aclk, 
saxigp0_aruser, 
saxigp0_awuser, 
saxigp0_awid, 
saxigp0_awaddr, 
saxigp0_awlen, 
saxigp0_awsize, 
saxigp0_awburst, 
saxigp0_awlock, 
saxigp0_awcache, 
saxigp0_awprot, 
saxigp0_awvalid, 
saxigp0_awready, 
saxigp0_wdata, 
saxigp0_wstrb, 
saxigp0_wlast, 
saxigp0_wvalid, 
saxigp0_wready, 
saxigp0_bid, 
saxigp0_bresp, 
saxigp0_bvalid, 
saxigp0_bready, 
saxigp0_arid, 
saxigp0_araddr, 
saxigp0_arlen, 
saxigp0_arsize, 
saxigp0_arburst, 
saxigp0_arlock, 
saxigp0_arcache, 
saxigp0_arprot, 
saxigp0_arvalid, 
saxigp0_arready, 
saxigp0_rid, 
saxigp0_rdata, 
saxigp0_rresp, 
saxigp0_rlast, 
saxigp0_rvalid, 
saxigp0_rready, 
saxigp0_awqos, 
saxigp0_arqos, 
sacefpd_aclk, 
sacefpd_wuser, 
sacefpd_buser, 
sacefpd_ruser, 
sacefpd_awuser, 
sacefpd_awsnoop, 
sacefpd_awsize, 
sacefpd_awregion, 
sacefpd_awqos, 
sacefpd_awprot, 
sacefpd_awlen, 
sacefpd_awid, 
sacefpd_awdomain, 
sacefpd_awcache, 
sacefpd_awburst, 
sacefpd_awbar, 
sacefpd_awaddr, 
sacefpd_awlock, 
sacefpd_awvalid, 
sacefpd_awready, 
sacefpd_wstrb, 
sacefpd_wdata, 
sacefpd_wlast, 
sacefpd_wvalid, 
sacefpd_wready, 
sacefpd_bresp, 
sacefpd_bid, 
sacefpd_bvalid, 
sacefpd_bready, 
sacefpd_aruser, 
sacefpd_arsnoop, 
sacefpd_arsize, 
sacefpd_arregion, 
sacefpd_arqos, 
sacefpd_arprot, 
sacefpd_arlen, 
sacefpd_arid, 
sacefpd_ardomain, 
sacefpd_arcache, 
sacefpd_arburst, 
sacefpd_arbar, 
sacefpd_araddr, 
sacefpd_arlock, 
sacefpd_arvalid, 
sacefpd_arready, 
sacefpd_rresp, 
sacefpd_rid, 
sacefpd_rdata, 
sacefpd_rlast, 
sacefpd_rvalid, 
sacefpd_rready, 
sacefpd_acsnoop, 
sacefpd_acprot, 
sacefpd_acaddr, 
sacefpd_acvalid, 
sacefpd_acready, 
sacefpd_cddata, 
sacefpd_cdlast, 
sacefpd_cdvalid, 
sacefpd_cdready, 
sacefpd_crresp, 
sacefpd_crvalid, 
sacefpd_crready, 
sacefpd_wack, 
sacefpd_rack, 
pl_ps_irq0, 
pl_resetn0, 
pl_clk0 
);
input maxihpm0_fpd_aclk;
output [15 : 0] maxigp0_awid;
output [39 : 0] maxigp0_awaddr;
output [7 : 0] maxigp0_awlen;
output [2 : 0] maxigp0_awsize;
output [1 : 0] maxigp0_awburst;
output maxigp0_awlock;
output [3 : 0] maxigp0_awcache;
output [2 : 0] maxigp0_awprot;
output maxigp0_awvalid;
output [15 : 0] maxigp0_awuser;
input maxigp0_awready;
output [127 : 0] maxigp0_wdata;
output [15 : 0] maxigp0_wstrb;
output maxigp0_wlast;
output maxigp0_wvalid;
input maxigp0_wready;
input [15 : 0] maxigp0_bid;
input [1 : 0] maxigp0_bresp;
input maxigp0_bvalid;
output maxigp0_bready;
output [15 : 0] maxigp0_arid;
output [39 : 0] maxigp0_araddr;
output [7 : 0] maxigp0_arlen;
output [2 : 0] maxigp0_arsize;
output [1 : 0] maxigp0_arburst;
output maxigp0_arlock;
output [3 : 0] maxigp0_arcache;
output [2 : 0] maxigp0_arprot;
output maxigp0_arvalid;
output [15 : 0] maxigp0_aruser;
input maxigp0_arready;
input [15 : 0] maxigp0_rid;
input [127 : 0] maxigp0_rdata;
input [1 : 0] maxigp0_rresp;
input maxigp0_rlast;
input maxigp0_rvalid;
output maxigp0_rready;
output [3 : 0] maxigp0_awqos;
output [3 : 0] maxigp0_arqos;
input maxihpm0_lpd_aclk;
output [15 : 0] maxigp2_awid;
output [39 : 0] maxigp2_awaddr;
output [7 : 0] maxigp2_awlen;
output [2 : 0] maxigp2_awsize;
output [1 : 0] maxigp2_awburst;
output maxigp2_awlock;
output [3 : 0] maxigp2_awcache;
output [2 : 0] maxigp2_awprot;
output maxigp2_awvalid;
output [15 : 0] maxigp2_awuser;
input maxigp2_awready;
output [127 : 0] maxigp2_wdata;
output [15 : 0] maxigp2_wstrb;
output maxigp2_wlast;
output maxigp2_wvalid;
input maxigp2_wready;
input [15 : 0] maxigp2_bid;
input [1 : 0] maxigp2_bresp;
input maxigp2_bvalid;
output maxigp2_bready;
output [15 : 0] maxigp2_arid;
output [39 : 0] maxigp2_araddr;
output [7 : 0] maxigp2_arlen;
output [2 : 0] maxigp2_arsize;
output [1 : 0] maxigp2_arburst;
output maxigp2_arlock;
output [3 : 0] maxigp2_arcache;
output [2 : 0] maxigp2_arprot;
output maxigp2_arvalid;
output [15 : 0] maxigp2_aruser;
input maxigp2_arready;
input [15 : 0] maxigp2_rid;
input [127 : 0] maxigp2_rdata;
input [1 : 0] maxigp2_rresp;
input maxigp2_rlast;
input maxigp2_rvalid;
output maxigp2_rready;
output [3 : 0] maxigp2_awqos;
output [3 : 0] maxigp2_arqos;
input saxihpc0_fpd_aclk;
input saxigp0_aruser;
input saxigp0_awuser;
input [5 : 0] saxigp0_awid;
input [48 : 0] saxigp0_awaddr;
input [7 : 0] saxigp0_awlen;
input [2 : 0] saxigp0_awsize;
input [1 : 0] saxigp0_awburst;
input saxigp0_awlock;
input [3 : 0] saxigp0_awcache;
input [2 : 0] saxigp0_awprot;
input saxigp0_awvalid;
output saxigp0_awready;
input [127 : 0] saxigp0_wdata;
input [15 : 0] saxigp0_wstrb;
input saxigp0_wlast;
input saxigp0_wvalid;
output saxigp0_wready;
output [5 : 0] saxigp0_bid;
output [1 : 0] saxigp0_bresp;
output saxigp0_bvalid;
input saxigp0_bready;
input [5 : 0] saxigp0_arid;
input [48 : 0] saxigp0_araddr;
input [7 : 0] saxigp0_arlen;
input [2 : 0] saxigp0_arsize;
input [1 : 0] saxigp0_arburst;
input saxigp0_arlock;
input [3 : 0] saxigp0_arcache;
input [2 : 0] saxigp0_arprot;
input saxigp0_arvalid;
output saxigp0_arready;
output [5 : 0] saxigp0_rid;
output [127 : 0] saxigp0_rdata;
output [1 : 0] saxigp0_rresp;
output saxigp0_rlast;
output saxigp0_rvalid;
input saxigp0_rready;
input [3 : 0] saxigp0_awqos;
input [3 : 0] saxigp0_arqos;
input sacefpd_aclk;
input sacefpd_wuser;
output sacefpd_buser;
output sacefpd_ruser;
input [15 : 0] sacefpd_awuser;
input [2 : 0] sacefpd_awsnoop;
input [2 : 0] sacefpd_awsize;
input [3 : 0] sacefpd_awregion;
input [3 : 0] sacefpd_awqos;
input [2 : 0] sacefpd_awprot;
input [7 : 0] sacefpd_awlen;
input [5 : 0] sacefpd_awid;
input [1 : 0] sacefpd_awdomain;
input [3 : 0] sacefpd_awcache;
input [1 : 0] sacefpd_awburst;
input [1 : 0] sacefpd_awbar;
input [43 : 0] sacefpd_awaddr;
input sacefpd_awlock;
input sacefpd_awvalid;
output sacefpd_awready;
input [15 : 0] sacefpd_wstrb;
input [127 : 0] sacefpd_wdata;
input sacefpd_wlast;
input sacefpd_wvalid;
output sacefpd_wready;
output [1 : 0] sacefpd_bresp;
output [5 : 0] sacefpd_bid;
output sacefpd_bvalid;
input sacefpd_bready;
input [15 : 0] sacefpd_aruser;
input [3 : 0] sacefpd_arsnoop;
input [2 : 0] sacefpd_arsize;
input [3 : 0] sacefpd_arregion;
input [3 : 0] sacefpd_arqos;
input [2 : 0] sacefpd_arprot;
input [7 : 0] sacefpd_arlen;
input [5 : 0] sacefpd_arid;
input [1 : 0] sacefpd_ardomain;
input [3 : 0] sacefpd_arcache;
input [1 : 0] sacefpd_arburst;
input [1 : 0] sacefpd_arbar;
input [43 : 0] sacefpd_araddr;
input sacefpd_arlock;
input sacefpd_arvalid;
output sacefpd_arready;
output [3 : 0] sacefpd_rresp;
output [5 : 0] sacefpd_rid;
output [127 : 0] sacefpd_rdata;
output sacefpd_rlast;
output sacefpd_rvalid;
input sacefpd_rready;
output [3 : 0] sacefpd_acsnoop;
output [2 : 0] sacefpd_acprot;
output [43 : 0] sacefpd_acaddr;
output sacefpd_acvalid;
input sacefpd_acready;
input [127 : 0] sacefpd_cddata;
input sacefpd_cdlast;
input sacefpd_cdvalid;
output sacefpd_cdready;
input [4 : 0] sacefpd_crresp;
input sacefpd_crvalid;
output sacefpd_crready;
input sacefpd_wack;
input sacefpd_rack;
input [0 : 0] pl_ps_irq0;
output pl_resetn0;
output pl_clk0;
wire pl_clk_t[3:0] ;

wire saxihpc0_fpd_rclk_temp;
wire saxihpc0_fpd_wclk_temp;
wire saxihpc1_fpd_rclk_temp;
wire saxihpc1_fpd_wclk_temp;
wire saxihp0_fpd_rclk_temp;
wire saxihp0_fpd_wclk_temp;
wire saxihp1_fpd_rclk_temp;
wire saxihp1_fpd_wclk_temp;
wire saxihp2_fpd_rclk_temp;
wire saxihp2_fpd_wclk_temp;
wire saxihp3_fpd_rclk_temp;
wire saxihp3_fpd_wclk_temp;
wire saxi_lpd_rclk_temp;
wire saxi_lpd_wclk_temp;


assign pl_clk0 = pl_clk_t[0] ;

 assign  pl_clk1 = 1'b0 ;

 assign  pl_clk2 = 1'b0 ;

 assign  pl_clk3 = 1'b0 ;

     assign saxihpc0_fpd_rclk_temp  =  saxihpc0_fpd_aclk ;
	assign saxihpc0_fpd_wclk_temp  =  saxihpc0_fpd_aclk ;
  
   
   
   
   
   


  


  zynq_ultra_ps_e_vip_v1_0_12 #(
    .C_USE_M_AXI_GP0(1),
    .C_USE_M_AXI_GP1(0),
    .C_USE_M_AXI_GP2(1),
    .C_USE_S_AXI_GP0(1),
    .C_USE_S_AXI_GP1(0),
    .C_USE_S_AXI_GP2(0),
    .C_USE_S_AXI_GP3(0),
    .C_USE_S_AXI_GP4(0),
    .C_USE_S_AXI_GP5(0),
    .C_USE_S_AXI_GP6(0),
    .C_USE_S_AXI_ACP(0),
    .C_USE_S_AXI_ACE(1),
    .C_M_AXI_GP0_DATA_WIDTH(128),
    .C_M_AXI_GP1_DATA_WIDTH(128),
    .C_M_AXI_GP2_DATA_WIDTH(128),
    .C_S_AXI_GP0_DATA_WIDTH(128),
    .C_S_AXI_GP1_DATA_WIDTH(128),
    .C_S_AXI_GP2_DATA_WIDTH(128),
    .C_S_AXI_GP3_DATA_WIDTH(128),
    .C_S_AXI_GP4_DATA_WIDTH(128),
    .C_S_AXI_GP5_DATA_WIDTH(128),
    .C_S_AXI_GP6_DATA_WIDTH(128),
    .C_FCLK_CLK0_FREQ(149.985016),
    .C_FCLK_CLK1_FREQ(100),
    .C_FCLK_CLK2_FREQ(100),
    .C_FCLK_CLK3_FREQ(100)
  ) inst (
    .MAXIGP0ARVALID(maxigp0_arvalid),
    .MAXIGP0AWVALID(maxigp0_awvalid),
    .MAXIGP0BREADY(maxigp0_bready),
    .MAXIGP0RREADY(maxigp0_rready),
    .MAXIGP0WLAST(maxigp0_wlast),
    .MAXIGP0WVALID(maxigp0_wvalid),
    .MAXIGP0ARID(maxigp0_arid),
    .MAXIGP0ARUSER(maxigp0_aruser),
    .MAXIGP0AWID(maxigp0_awid),
    .MAXIGP0ARBURST(maxigp0_arburst),
    .MAXIGP0ARLOCK(maxigp0_arlock),
    .MAXIGP0ARSIZE(maxigp0_arsize),
    .MAXIGP0AWBURST(maxigp0_awburst),
    .MAXIGP0AWLOCK(maxigp0_awlock),
    .MAXIGP0AWSIZE(maxigp0_awsize),
    .MAXIGP0ARPROT(maxigp0_arprot),
    .MAXIGP0AWPROT(maxigp0_awprot),
    .MAXIGP0ARADDR(maxigp0_araddr),
    .MAXIGP0AWADDR(maxigp0_awaddr),
    .MAXIGP0WDATA(maxigp0_wdata),
    .MAXIGP0AWUSER(maxigp0_awuser),
    .MAXIGP0ARCACHE(maxigp0_arcache),
    .MAXIGP0ARLEN(maxigp0_arlen),
    .MAXIGP0ARQOS(maxigp0_arqos),
    .MAXIGP0AWCACHE(maxigp0_awcache),
    .MAXIGP0AWLEN(maxigp0_awlen),
    .MAXIGP0AWQOS(maxigp0_awqos),
    .MAXIGP0WSTRB(maxigp0_wstrb),
    .MAXIGP0ACLK(maxihpm0_fpd_aclk),
    .MAXIGP0ARREADY(maxigp0_arready),
    .MAXIGP0AWREADY(maxigp0_awready),
    .MAXIGP0BVALID(maxigp0_bvalid),
    .MAXIGP0RLAST(maxigp0_rlast),
    .MAXIGP0RVALID(maxigp0_rvalid),
    .MAXIGP0WREADY(maxigp0_wready),
    .MAXIGP0BID(maxigp0_bid),
    .MAXIGP0RID(maxigp0_rid),
    .MAXIGP0BRESP(maxigp0_bresp),
    .MAXIGP0RRESP(maxigp0_rresp),
    .MAXIGP0RDATA(maxigp0_rdata),
    .MAXIGP1ARVALID(),
    .MAXIGP1AWVALID(),
    .MAXIGP1BREADY(),
    .MAXIGP1RREADY(),
    .MAXIGP1WLAST(),
    .MAXIGP1WVALID(),
    .MAXIGP1ARID(),
    .MAXIGP1ARUSER(),
    .MAXIGP1AWID(),
    .MAXIGP1ARBURST(),
    .MAXIGP1ARLOCK(),
    .MAXIGP1ARSIZE(),
    .MAXIGP1AWBURST(),
    .MAXIGP1AWLOCK(),
    .MAXIGP1AWSIZE(),
    .MAXIGP1ARPROT(),
    .MAXIGP1AWPROT(),
    .MAXIGP1ARADDR(),
    .MAXIGP1AWADDR(),
    .MAXIGP1WDATA(),
    .MAXIGP1AWUSER(),
    .MAXIGP1ARCACHE(),
    .MAXIGP1ARLEN(),
    .MAXIGP1ARQOS(),
    .MAXIGP1AWCACHE(),
    .MAXIGP1AWLEN(),
    .MAXIGP1AWQOS(),
    .MAXIGP1WSTRB(),
    .MAXIGP1ACLK(1'B0),
    .MAXIGP1ARREADY(1'B0),
    .MAXIGP1AWREADY(1'B0),
    .MAXIGP1BVALID(1'B0),
    .MAXIGP1RLAST(1'B0),
    .MAXIGP1RVALID(1'B0),
    .MAXIGP1WREADY(1'B0),
    .MAXIGP1BID(12'B0),
    .MAXIGP1RID(12'B0),
    .MAXIGP1BRESP(2'B0),
    .MAXIGP1RRESP(2'B0),
    .MAXIGP1RDATA(32'B0),

    .MAXIGP2ARVALID(maxigp2_arvalid),
    .MAXIGP2AWVALID(maxigp2_awvalid),
    .MAXIGP2BREADY(maxigp2_bready),
    .MAXIGP2RREADY(maxigp2_rready),
    .MAXIGP2WLAST(maxigp2_wlast),
    .MAXIGP2WVALID(maxigp2_wvalid),
    .MAXIGP2ARID(maxigp2_arid),
    .MAXIGP2ARUSER(maxigp2_aruser),
    .MAXIGP2AWID(maxigp2_awid),
    .MAXIGP2ARBURST(maxigp2_arburst),
    .MAXIGP2ARLOCK(maxigp2_arlock),
    .MAXIGP2ARSIZE(maxigp2_arsize),
    .MAXIGP2AWBURST(maxigp2_awburst),
    .MAXIGP2AWLOCK(maxigp2_awlock),
    .MAXIGP2AWSIZE(maxigp2_awsize),
    .MAXIGP2ARPROT(maxigp2_arprot),
    .MAXIGP2AWPROT(maxigp2_awprot),
    .MAXIGP2ARADDR(maxigp2_araddr),
    .MAXIGP2AWADDR(maxigp2_awaddr),
    .MAXIGP2WDATA(maxigp2_wdata),
    .MAXIGP2AWUSER(maxigp2_awuser),
    .MAXIGP2ARCACHE(maxigp2_arcache),
    .MAXIGP2ARLEN(maxigp2_arlen),
    .MAXIGP2ARQOS(maxigp2_arqos),
    .MAXIGP2AWCACHE(maxigp2_awcache),
    .MAXIGP2AWLEN(maxigp2_awlen),
    .MAXIGP2AWQOS(maxigp2_awqos),
    .MAXIGP2WSTRB(maxigp2_wstrb),
    .MAXIGP2ACLK(maxihpm0_lpd_aclk),
    .MAXIGP2ARREADY(maxigp2_arready),
    .MAXIGP2AWREADY(maxigp2_awready),
    .MAXIGP2BVALID(maxigp2_bvalid),
    .MAXIGP2RLAST(maxigp2_rlast),
    .MAXIGP2RVALID(maxigp2_rvalid),
    .MAXIGP2WREADY(maxigp2_wready),
    .MAXIGP2BID(maxigp2_bid),
    .MAXIGP2RID(maxigp2_rid),
    .MAXIGP2BRESP(maxigp2_bresp),
    .MAXIGP2RRESP(maxigp2_rresp),
    .MAXIGP2RDATA(maxigp2_rdata),

    .SAXIGP0RCLK(saxihpc0_fpd_rclk_temp),
    .SAXIGP0WCLK(saxihpc0_fpd_wclk_temp),
    .SAXIGP0ARUSER(saxigp0_aruser),
    .SAXIGP0AWUSER(saxigp0_awuser),
    .SAXIGP0RACOUNT(saxigp0_racount),
    .SAXIGP0WACOUNT(saxigp0_wacount),
    .SAXIGP0RCOUNT(saxigp0_rcount),
    .SAXIGP0WCOUNT(saxigp0_wcount),
    .SAXIGP0ARREADY(saxigp0_arready),
    .SAXIGP0AWREADY(saxigp0_awready),
    .SAXIGP0BVALID(saxigp0_bvalid),
    .SAXIGP0RLAST(saxigp0_rlast),
    .SAXIGP0RVALID(saxigp0_rvalid),
    .SAXIGP0WREADY(saxigp0_wready),
    .SAXIGP0BRESP(saxigp0_bresp),
    .SAXIGP0RRESP(saxigp0_rresp),
    .SAXIGP0RDATA(saxigp0_rdata),
    .SAXIGP0BID(saxigp0_bid),
    .SAXIGP0RID(saxigp0_rid),
    .SAXIGP0ARVALID(saxigp0_arvalid),
    .SAXIGP0AWVALID(saxigp0_awvalid),
    .SAXIGP0BREADY(saxigp0_bready),
    .SAXIGP0RREADY(saxigp0_rready),
    .SAXIGP0WLAST(saxigp0_wlast),
    .SAXIGP0WVALID(saxigp0_wvalid),
    .SAXIGP0ARBURST(saxigp0_arburst),
    .SAXIGP0ARLOCK(saxigp0_arlock),
    .SAXIGP0ARSIZE(saxigp0_arsize),
    .SAXIGP0AWBURST(saxigp0_awburst),
    .SAXIGP0AWLOCK(saxigp0_awlock),
    .SAXIGP0AWSIZE(saxigp0_awsize),
    .SAXIGP0ARPROT(saxigp0_arprot),
    .SAXIGP0AWPROT(saxigp0_awprot),
    .SAXIGP0ARADDR(saxigp0_araddr),
    .SAXIGP0AWADDR(saxigp0_awaddr),
    .SAXIGP0WDATA(saxigp0_wdata),
    .SAXIGP0ARCACHE(saxigp0_arcache),
    .SAXIGP0ARLEN(saxigp0_arlen),
    .SAXIGP0ARQOS(saxigp0_arqos),
    .SAXIGP0AWCACHE(saxigp0_awcache),
    .SAXIGP0AWLEN(saxigp0_awlen),
    .SAXIGP0AWQOS(saxigp0_awqos),
    .SAXIGP0WSTRB(saxigp0_wstrb),
    .SAXIGP0ARID(saxigp0_arid),
    .SAXIGP0AWID(saxigp0_awid),
    .SAXIGP1RCLK(),
    .SAXIGP1WCLK(),
    .SAXIGP1ARUSER(),
    .SAXIGP1AWUSER(),
    .SAXIGP1RACOUNT(),
    .SAXIGP1WACOUNT(),
    .SAXIGP1RCOUNT(),
    .SAXIGP1WCOUNT(),
    .SAXIGP1ARREADY(),
    .SAXIGP1AWREADY(),
    .SAXIGP1BVALID(),
    .SAXIGP1RLAST(),
    .SAXIGP1RVALID(),
    .SAXIGP1WREADY(),
    .SAXIGP1BRESP(),
    .SAXIGP1RRESP(),
    .SAXIGP1RDATA(),
    .SAXIGP1BID(),
    .SAXIGP1RID(),
    .SAXIGP1ARVALID(1'B0),
    .SAXIGP1AWVALID(1'B0),
    .SAXIGP1BREADY(1'B0),
    .SAXIGP1RREADY(1'B0),
    .SAXIGP1WLAST(1'B0),
    .SAXIGP1WVALID(1'B0),
    .SAXIGP1ARBURST(2'B0),
    .SAXIGP1ARLOCK(2'B0),
    .SAXIGP1ARSIZE(3'B0),
    .SAXIGP1AWBURST(2'B0),
    .SAXIGP1AWLOCK(2'B0),
    .SAXIGP1AWSIZE(3'B0),
    .SAXIGP1ARPROT(3'B0),
    .SAXIGP1AWPROT(3'B0),
    .SAXIGP1ARADDR(32'B0),
    .SAXIGP1AWADDR(32'B0),
    .SAXIGP1WDATA(32'B0),
    .SAXIGP1ARCACHE(4'B0),
    .SAXIGP1ARLEN(4'B0),
    .SAXIGP1ARQOS(4'B0),
    .SAXIGP1AWCACHE(4'B0),
    .SAXIGP1AWLEN(4'B0),
    .SAXIGP1AWQOS(4'B0),
    .SAXIGP1WSTRB(4'B0),
    .SAXIGP1ARID(6'B0),
    .SAXIGP1AWID(6'B0),
    .SAXIGP2RCLK(),
    .SAXIGP2WCLK(),
    .SAXIGP2ARUSER(),
    .SAXIGP2AWUSER(),
    .SAXIGP2RACOUNT(),
    .SAXIGP2WACOUNT(),
    .SAXIGP2RCOUNT(),
    .SAXIGP2WCOUNT(),
    .SAXIGP2ARREADY(),
    .SAXIGP2AWREADY(),
    .SAXIGP2BVALID(),
    .SAXIGP2RLAST(),
    .SAXIGP2RVALID(),
    .SAXIGP2WREADY(),
    .SAXIGP2BRESP(),
    .SAXIGP2RRESP(),
    .SAXIGP2RDATA(),
    .SAXIGP2BID(),
    .SAXIGP2RID(),
    .SAXIGP2ARVALID(1'B0),
    .SAXIGP2AWVALID(1'B0),
    .SAXIGP2BREADY(1'B0),
    .SAXIGP2RREADY(1'B0),
    .SAXIGP2WLAST(1'B0),
    .SAXIGP2WVALID(1'B0),
    .SAXIGP2ARBURST(2'B0),
    .SAXIGP2ARLOCK(2'B0),
    .SAXIGP2ARSIZE(3'B0),
    .SAXIGP2AWBURST(2'B0),
    .SAXIGP2AWLOCK(2'B0),
    .SAXIGP2AWSIZE(3'B0),
    .SAXIGP2ARPROT(3'B0),
    .SAXIGP2AWPROT(3'B0),
    .SAXIGP2ARADDR(32'B0),
    .SAXIGP2AWADDR(32'B0),
    .SAXIGP2WDATA(32'B0),
    .SAXIGP2ARCACHE(4'B0),
    .SAXIGP2ARLEN(4'B0),
    .SAXIGP2ARQOS(4'B0),
    .SAXIGP2AWCACHE(4'B0),
    .SAXIGP2AWLEN(4'B0),
    .SAXIGP2AWQOS(4'B0),
    .SAXIGP2WSTRB(4'B0),
    .SAXIGP2ARID(6'B0),
    .SAXIGP2AWID(6'B0),
    .SAXIGP3RCLK(),
    .SAXIGP3WCLK(),
    .SAXIGP3ARUSER(),
    .SAXIGP3AWUSER(),
    .SAXIGP3RACOUNT(),
    .SAXIGP3WACOUNT(),
    .SAXIGP3RCOUNT(),
    .SAXIGP3WCOUNT(),
    .SAXIGP3ARREADY(),
    .SAXIGP3AWREADY(),
    .SAXIGP3BVALID(),
    .SAXIGP3RLAST(),
    .SAXIGP3RVALID(),
    .SAXIGP3WREADY(),
    .SAXIGP3BRESP(),
    .SAXIGP3RRESP(),
    .SAXIGP3RDATA(),
    .SAXIGP3BID(),
    .SAXIGP3RID(),
    .SAXIGP3ARVALID(1'B0),
    .SAXIGP3AWVALID(1'B0),
    .SAXIGP3BREADY(1'B0),
    .SAXIGP3RREADY(1'B0),
    .SAXIGP3WLAST(1'B0),
    .SAXIGP3WVALID(1'B0),
    .SAXIGP3ARBURST(2'B0),
    .SAXIGP3ARLOCK(2'B0),
    .SAXIGP3ARSIZE(3'B0),
    .SAXIGP3AWBURST(2'B0),
    .SAXIGP3AWLOCK(2'B0),
    .SAXIGP3AWSIZE(3'B0),
    .SAXIGP3ARPROT(3'B0),
    .SAXIGP3AWPROT(3'B0),
    .SAXIGP3ARADDR(32'B0),
    .SAXIGP3AWADDR(32'B0),
    .SAXIGP3WDATA(32'B0),
    .SAXIGP3ARCACHE(4'B0),
    .SAXIGP3ARLEN(4'B0),
    .SAXIGP3ARQOS(4'B0),
    .SAXIGP3AWCACHE(4'B0),
    .SAXIGP3AWLEN(4'B0),
    .SAXIGP3AWQOS(4'B0),
    .SAXIGP3WSTRB(4'B0),
    .SAXIGP3ARID(6'B0),
    .SAXIGP3AWID(6'B0),
    .SAXIGP4RCLK(),
    .SAXIGP4WCLK(),
    .SAXIGP4ARUSER(),
    .SAXIGP4AWUSER(),
    .SAXIGP4RACOUNT(),
    .SAXIGP4WACOUNT(),
    .SAXIGP4RCOUNT(),
    .SAXIGP4WCOUNT(),
    .SAXIGP4ARREADY(),
    .SAXIGP4AWREADY(),
    .SAXIGP4BVALID(),
    .SAXIGP4RLAST(),
    .SAXIGP4RVALID(),
    .SAXIGP4WREADY(),
    .SAXIGP4BRESP(),
    .SAXIGP4RRESP(),
    .SAXIGP4RDATA(),
    .SAXIGP4BID(),
    .SAXIGP4RID(),
    .SAXIGP4ARVALID(1'B0),
    .SAXIGP4AWVALID(1'B0),
    .SAXIGP4BREADY(1'B0),
    .SAXIGP4RREADY(1'B0),
    .SAXIGP4WLAST(1'B0),
    .SAXIGP4WVALID(1'B0),
    .SAXIGP4ARBURST(2'B0),
    .SAXIGP4ARLOCK(2'B0),
    .SAXIGP4ARSIZE(3'B0),
    .SAXIGP4AWBURST(2'B0),
    .SAXIGP4AWLOCK(2'B0),
    .SAXIGP4AWSIZE(3'B0),
    .SAXIGP4ARPROT(3'B0),
    .SAXIGP4AWPROT(3'B0),
    .SAXIGP4ARADDR(32'B0),
    .SAXIGP4AWADDR(32'B0),
    .SAXIGP4WDATA(32'B0),
    .SAXIGP4ARCACHE(4'B0),
    .SAXIGP4ARLEN(4'B0),
    .SAXIGP4ARQOS(4'B0),
    .SAXIGP4AWCACHE(4'B0),
    .SAXIGP4AWLEN(4'B0),
    .SAXIGP4AWQOS(4'B0),
    .SAXIGP4WSTRB(4'B0),
    .SAXIGP4ARID(6'B0),
    .SAXIGP4AWID(6'B0),
    .SAXIGP5RCLK(),
    .SAXIGP5WCLK(),
    .SAXIGP5ARUSER(),
    .SAXIGP5AWUSER(),
    .SAXIGP5RACOUNT(),
    .SAXIGP5WACOUNT(),
    .SAXIGP5RCOUNT(),
    .SAXIGP5WCOUNT(),
    .SAXIGP5ARREADY(),
    .SAXIGP5AWREADY(),
    .SAXIGP5BVALID(),
    .SAXIGP5RLAST(),
    .SAXIGP5RVALID(),
    .SAXIGP5WREADY(),
    .SAXIGP5BRESP(),
    .SAXIGP5RRESP(),
    .SAXIGP5RDATA(),
    .SAXIGP5BID(),
    .SAXIGP5RID(),
    .SAXIGP5ARVALID(1'B0),
    .SAXIGP5AWVALID(1'B0),
    .SAXIGP5BREADY(1'B0),
    .SAXIGP5RREADY(1'B0),
    .SAXIGP5WLAST(1'B0),
    .SAXIGP5WVALID(1'B0),
    .SAXIGP5ARBURST(2'B0),
    .SAXIGP5ARLOCK(2'B0),
    .SAXIGP5ARSIZE(3'B0),
    .SAXIGP5AWBURST(2'B0),
    .SAXIGP5AWLOCK(2'B0),
    .SAXIGP5AWSIZE(3'B0),
    .SAXIGP5ARPROT(3'B0),
    .SAXIGP5AWPROT(3'B0),
    .SAXIGP5ARADDR(32'B0),
    .SAXIGP5AWADDR(32'B0),
    .SAXIGP5WDATA(32'B0),
    .SAXIGP5ARCACHE(4'B0),
    .SAXIGP5ARLEN(4'B0),
    .SAXIGP5ARQOS(4'B0),
    .SAXIGP5AWCACHE(4'B0),
    .SAXIGP5AWLEN(4'B0),
    .SAXIGP5AWQOS(4'B0),
    .SAXIGP5WSTRB(4'B0),
    .SAXIGP5ARID(6'B0),
    .SAXIGP5AWID(6'B0),
    .SAXIGP6RCLK(),
    .SAXIGP6WCLK(),
    .SAXIGP6ARUSER(),
    .SAXIGP6AWUSER(),
    .SAXIGP6RACOUNT(),
    .SAXIGP6WACOUNT(),
    .SAXIGP6RCOUNT(),
    .SAXIGP6WCOUNT(),
    .SAXIGP6ARREADY(),
    .SAXIGP6AWREADY(),
    .SAXIGP6BVALID(),
    .SAXIGP6RLAST(),
    .SAXIGP6RVALID(),
    .SAXIGP6WREADY(),
    .SAXIGP6BRESP(),
    .SAXIGP6RRESP(),
    .SAXIGP6RDATA(),
    .SAXIGP6BID(),
    .SAXIGP6RID(),
    .SAXIGP6ARVALID(1'B0),
    .SAXIGP6AWVALID(1'B0),
    .SAXIGP6BREADY(1'B0),
    .SAXIGP6RREADY(1'B0),
    .SAXIGP6WLAST(1'B0),
    .SAXIGP6WVALID(1'B0),
    .SAXIGP6ARBURST(2'B0),
    .SAXIGP6ARLOCK(2'B0),
    .SAXIGP6ARSIZE(3'B0),
    .SAXIGP6AWBURST(2'B0),
    .SAXIGP6AWLOCK(2'B0),
    .SAXIGP6AWSIZE(3'B0),
    .SAXIGP6ARPROT(3'B0),
    .SAXIGP6AWPROT(3'B0),
    .SAXIGP6ARADDR(32'B0),
    .SAXIGP6AWADDR(32'B0),
    .SAXIGP6WDATA(32'B0),
    .SAXIGP6ARCACHE(4'B0),
    .SAXIGP6ARLEN(4'B0),
    .SAXIGP6ARQOS(4'B0),
    .SAXIGP6AWCACHE(4'B0),
    .SAXIGP6AWLEN(4'B0),
    .SAXIGP6AWQOS(4'B0),
    .SAXIGP6WSTRB(4'B0),
    .SAXIGP6ARID(6'B0),
    .SAXIGP6AWID(6'B0),
    .SAXIACPARREADY(),
    .SAXIACPAWREADY(),
    .SAXIACPBVALID(),
    .SAXIACPRLAST(),
    .SAXIACPRVALID(),
    .SAXIACPWREADY(),
    .SAXIACPBRESP(),
    .SAXIACPRRESP(),
    .SAXIACPBID(),
    .SAXIACPRID(),
    .SAXIACPRDATA(),
    .SAXIACPACLK(1'B0),
    .SAXIACPARVALID(1'B0),
    .SAXIACPAWVALID(1'B0),
    .SAXIACPBREADY(1'B0),
    .SAXIACPRREADY(1'B0),
    .SAXIACPWLAST(1'B0),
    .SAXIACPWVALID(1'B0),
    .SAXIACPARID(3'B0),
    .SAXIACPARPROT(3'B0),
    .SAXIACPAWID(3'B0),
    .SAXIACPAWPROT(3'B0),
    .SAXIACPARADDR(32'B0),
    .SAXIACPAWADDR(32'B0),
    .SAXIACPARCACHE(4'B0),
    .SAXIACPARLEN(4'B0),
    .SAXIACPARQOS(4'B0),
    .SAXIACPAWCACHE(4'B0),
    .SAXIACPAWLEN(4'B0),
    .SAXIACPAWQOS(4'B0),
    .SAXIACPARBURST(2'B0),
    .SAXIACPARLOCK(2'B0),
    .SAXIACPARSIZE(3'B0),
    .SAXIACPAWBURST(2'B0),
    .SAXIACPAWLOCK(2'B0),
    .SAXIACPAWSIZE(3'B0),
    .SAXIACPARUSER(5'B0),
    .SAXIACPAWUSER(5'B0),
    .SAXIACPWDATA(64'B0),
    .SAXIACPWSTRB(8'B0),
.SACEFPDACREADY(sacefpd_acready),
.SACEFPDARLOCK(sacefpd_arlock),
.SACEFPDARVALID(sacefpd_arvalid),
.SACEFPDAWLOCK(sacefpd_awlock),
.SACEFPDAWVALID(sacefpd_awvalid),
.SACEFPDBREADY(sacefpd_bready),
.SACEFPDCDLAST(sacefpd_cdlast),
.SACEFPDCDVALID(sacefpd_cdvalid),
.SACEFPDCRVALID(sacefpd_crvalid),
.SACEFPDRACK(sacefpd_rack),
.SACEFPDRREADY(sacefpd_rready),
.SACEFPDWACK(sacefpd_wack),
.SACEFPDWLAST(sacefpd_wlast),
.SACEFPDWUSER(sacefpd_wuser),
.SACEFPDWVALID(sacefpd_wvalid),
.SACEFPDCDDATA(sacefpd_cddata),
.SACEFPDWDATA(sacefpd_wdata),
.SACEFPDARUSER(sacefpd_aruser),
.SACEFPDAWUSER(sacefpd_awuser),
.SACEFPDWSTRB(sacefpd_wstrb),
.SACEFPDARBAR(sacefpd_arbar),
.SACEFPDARBURST(sacefpd_arburst),
.SACEFPDARDOMAIN(sacefpd_ardomain),
.SACEFPDAWBAR(sacefpd_awbar),
.SACEFPDAWBURST(sacefpd_awburst),
.SACEFPDAWDOMAIN(sacefpd_awdomain),
.SACEFPDARPROT(sacefpd_arprot),
.SACEFPDARSIZE(sacefpd_arsize),
.SACEFPDAWPROT(sacefpd_awprot),
.SACEFPDAWSIZE(sacefpd_awsize),
.SACEFPDAWSNOOP(sacefpd_awsnoop),
.SACEFPDARCACHE(sacefpd_arcache),
.SACEFPDARQOS(sacefpd_arqos),
.SACEFPDARREGION(sacefpd_arregion),
.SACEFPDARSNOOP(sacefpd_arsnoop),
.SACEFPDAWCACHE(sacefpd_awcache),
.SACEFPDAWQOS(sacefpd_awqos),
.SACEFPDAWREGION(sacefpd_awregion),
.SACEFPDARADDR(sacefpd_araddr),
.SACEFPDAWADDR(sacefpd_awaddr),
.SACEFPDCRRESP(sacefpd_crresp),
.SACEFPDARID(sacefpd_arid),
.SACEFPDAWID(sacefpd_awid),
.SACEFPDARLEN(sacefpd_arlen),
.SACEFPDAWLEN(sacefpd_awlen),
.SACEFPDACVALID(sacefpd_acvalid),
.SACEFPDARREADY(sacefpd_arready),
.SACEFPDAWREADY(sacefpd_awready),
.SACEFPDBUSER(sacefpd_buser),
.SACEFPDBVALID(sacefpd_bvalid),
.SACEFPDCDREADY(sacefpd_cdready),
.SACEFPDCRREADY(sacefpd_crready),
.SACEFPDRLAST(sacefpd_rlast),
.SACEFPDRUSER(sacefpd_ruser),
.SACEFPDRVALID(sacefpd_rvalid),
.SACEFPDWREADY(sacefpd_wready),
.SACEFPDRDATA(sacefpd_rdata),
.SACEFPDBRESP(sacefpd_bresp),
.SACEFPDACPROT(sacefpd_acprot),
.SACEFPDACSNOOP(sacefpd_acsnoop),
.SACEFPDRRESP(sacefpd_rresp),
.SACEFPDACADDR(sacefpd_acaddr),
.SACEFPDBID(sacefpd_bid),
.SACEFPDRID(sacefpd_rid),

.PLPSIRQ0(pl_ps_irq0),

.PL_RESETN0(pl_resetn0),
.PLCLK({pl_clk_t[3],pl_clk_t[2],pl_clk_t[1],pl_clk_t[0]})
  );

endmodule
