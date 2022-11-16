// (c) Copyright 1995-2022 Xilinx, Inc. All rights reserved.
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


// IP VLNV: user.org:user:byte_writer:1.0
// IP Revision: 20

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_byte_writer_0_0 (
  config_axi_aclk,
  config_axi_aresetn,
  config_axi_awid,
  config_axi_awaddr,
  config_axi_awlen,
  config_axi_awsize,
  config_axi_awburst,
  config_axi_awlock,
  config_axi_awcache,
  config_axi_awprot,
  config_axi_awqos,
  config_axi_awregion,
  config_axi_awuser,
  config_axi_awvalid,
  config_axi_awready,
  config_axi_wdata,
  config_axi_wstrb,
  config_axi_wlast,
  config_axi_wvalid,
  config_axi_wready,
  config_axi_bid,
  config_axi_bresp,
  config_axi_bvalid,
  config_axi_bready,
  config_axi_arid,
  config_axi_araddr,
  config_axi_arlen,
  config_axi_arsize,
  config_axi_arburst,
  config_axi_arlock,
  config_axi_arcache,
  config_axi_arprot,
  config_axi_arqos,
  config_axi_arregion,
  config_axi_aruser,
  config_axi_arvalid,
  config_axi_arready,
  config_axi_rid,
  config_axi_rdata,
  config_axi_rresp,
  config_axi_rlast,
  config_axi_rvalid,
  config_axi_rready,
  axi_init_axi_txn,
  axi_aclk,
  axi_aresetn,
  axi_awid,
  axi_awaddr,
  axi_awlen,
  axi_awsize,
  axi_awburst,
  axi_awlock,
  axi_awcache,
  axi_awprot,
  axi_awqos,
  axi_awvalid,
  axi_awready,
  axi_wdata,
  axi_wstrb,
  axi_wlast,
  axi_wvalid,
  axi_wready,
  axi_bid,
  axi_bresp,
  axi_bvalid,
  axi_bready,
  axi_arid,
  axi_araddr,
  axi_arlen,
  axi_arsize,
  axi_arburst,
  axi_arlock,
  axi_arcache,
  axi_arprot,
  axi_arqos,
  axi_arvalid,
  axi_arready,
  axi_rid,
  axi_rdata,
  axi_rresp,
  axi_rlast,
  axi_rvalid,
  axi_rready
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME config_axi_aclk, ASSOCIATED_RESET config_axi_aresetn, ASSOCIATED_BUSIF config_axi, FREQ_HZ 149985016, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 config_axi_aclk CLK" *)
input wire config_axi_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME config_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 config_axi_aresetn RST" *)
input wire config_axi_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWID" *)
input wire [15 : 0] config_axi_awid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWADDR" *)
input wire [39 : 0] config_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWLEN" *)
input wire [7 : 0] config_axi_awlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWSIZE" *)
input wire [2 : 0] config_axi_awsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWBURST" *)
input wire [1 : 0] config_axi_awburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWLOCK" *)
input wire config_axi_awlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWCACHE" *)
input wire [3 : 0] config_axi_awcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWPROT" *)
input wire [2 : 0] config_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWQOS" *)
input wire [3 : 0] config_axi_awqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWREGION" *)
input wire [3 : 0] config_axi_awregion;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWUSER" *)
input wire [15 : 0] config_axi_awuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWVALID" *)
input wire config_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi AWREADY" *)
output wire config_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi WDATA" *)
input wire [127 : 0] config_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi WSTRB" *)
input wire [15 : 0] config_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi WLAST" *)
input wire config_axi_wlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi WVALID" *)
input wire config_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi WREADY" *)
output wire config_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi BID" *)
output wire [15 : 0] config_axi_bid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi BRESP" *)
output wire [1 : 0] config_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi BVALID" *)
output wire config_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi BREADY" *)
input wire config_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARID" *)
input wire [15 : 0] config_axi_arid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARADDR" *)
input wire [39 : 0] config_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARLEN" *)
input wire [7 : 0] config_axi_arlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARSIZE" *)
input wire [2 : 0] config_axi_arsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARBURST" *)
input wire [1 : 0] config_axi_arburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARLOCK" *)
input wire config_axi_arlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARCACHE" *)
input wire [3 : 0] config_axi_arcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARPROT" *)
input wire [2 : 0] config_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARQOS" *)
input wire [3 : 0] config_axi_arqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARREGION" *)
input wire [3 : 0] config_axi_arregion;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARUSER" *)
input wire [15 : 0] config_axi_aruser;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARVALID" *)
input wire config_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi ARREADY" *)
output wire config_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi RID" *)
output wire [15 : 0] config_axi_rid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi RDATA" *)
output wire [127 : 0] config_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi RRESP" *)
output wire [1 : 0] config_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi RLAST" *)
output wire config_axi_rlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi RVALID" *)
output wire config_axi_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME config_axi, DATA_WIDTH 128, PROTOCOL AXI4, FREQ_HZ 149985016, ID_WIDTH 16, ADDR_WIDTH 40, AWUSER_WIDTH 16, ARUSER_WIDTH 16, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREAD\
S 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 config_axi RREADY" *)
input wire config_axi_rready;
input wire axi_init_axi_txn;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M00_AXI_CLK, ASSOCIATED_BUSIF M00_AXI, ASSOCIATED_RESET m00_axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0, XIL_INTERFACENAME axi_aclk, ASSOCIATED_BUSIF axi, ASSOCIATED_RESET axi_aresetn, FREQ_HZ 149985016, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 M00_AXI_CLK CLK, xilinx.com:signal:clock:1.0 axi_aclk CLK" *)
input wire axi_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0, XIL_INTERFACENAME axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 M00_AXI_RST RST, xilinx.com:signal:reset:1.0 axi_aresetn RST" *)
input wire axi_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWID" *)
output wire [0 : 0] axi_awid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWADDR" *)
output wire [31 : 0] axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWLEN" *)
output wire [7 : 0] axi_awlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWSIZE" *)
output wire [2 : 0] axi_awsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWBURST" *)
output wire [1 : 0] axi_awburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWLOCK" *)
output wire axi_awlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWCACHE" *)
output wire [3 : 0] axi_awcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWPROT" *)
output wire [2 : 0] axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWQOS" *)
output wire [3 : 0] axi_awqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWVALID" *)
output wire axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi AWREADY" *)
input wire axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi WDATA" *)
output wire [127 : 0] axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi WSTRB" *)
output wire [15 : 0] axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi WLAST" *)
output wire axi_wlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi WVALID" *)
output wire axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi WREADY" *)
input wire axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi BID" *)
input wire [0 : 0] axi_bid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi BRESP" *)
input wire [1 : 0] axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi BVALID" *)
input wire axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi BREADY" *)
output wire axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARID" *)
output wire [0 : 0] axi_arid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARADDR" *)
output wire [31 : 0] axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARLEN" *)
output wire [7 : 0] axi_arlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARSIZE" *)
output wire [2 : 0] axi_arsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARBURST" *)
output wire [1 : 0] axi_arburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARLOCK" *)
output wire axi_arlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARCACHE" *)
output wire [3 : 0] axi_arcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARPROT" *)
output wire [2 : 0] axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARQOS" *)
output wire [3 : 0] axi_arqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARVALID" *)
output wire axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi ARREADY" *)
input wire axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RID" *)
input wire [0 : 0] axi_rid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RDATA" *)
input wire [127 : 0] axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RRESP" *)
input wire [1 : 0] axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RLAST" *)
input wire axi_rlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RVALID" *)
input wire axi_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi, DATA_WIDTH 128, PROTOCOL AXI4, FREQ_HZ 149985016, ID_WIDTH 1, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_W\
RITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axi RREADY" *)
output wire axi_rready;

  byte_writer_v1_0 #(
    .C_AXI_TARGET_SLAVE_BASE_ADDR(32'H80000000),
    .C_AXI_BURST_LEN(1),
    .C_AXI_ID_WIDTH(1),
    .C_AXI_ADDR_WIDTH(32),
    .C_AXI_DATA_WIDTH(128),
    .C_AXI_AWUSER_WIDTH(0),
    .C_AXI_ARUSER_WIDTH(0),
    .C_AXI_WUSER_WIDTH(0),
    .C_AXI_RUSER_WIDTH(0),
    .C_AXI_BUSER_WIDTH(0),
    .C_Config_AXI_ID_WIDTH(0),
    .C_Config_AXI_DATA_WIDTH(128),
    .C_Config_AXI_ADDR_WIDTH(40),
    .C_Config_AXI_AWUSER_WIDTH(16),
    .C_Config_AXI_ARUSER_WIDTH(16),
    .C_Config_AXI_WUSER_WIDTH(0),
    .C_Config_AXI_RUSER_WIDTH(0),
    .C_Config_AXI_BUSER_WIDTH(0)
  ) inst (
    .config_axi_aclk(config_axi_aclk),
    .config_axi_aresetn(config_axi_aresetn),
    .config_axi_awid(config_axi_awid),
    .config_axi_awaddr(config_axi_awaddr),
    .config_axi_awlen(config_axi_awlen),
    .config_axi_awsize(config_axi_awsize),
    .config_axi_awburst(config_axi_awburst),
    .config_axi_awlock(config_axi_awlock),
    .config_axi_awcache(config_axi_awcache),
    .config_axi_awprot(config_axi_awprot),
    .config_axi_awqos(config_axi_awqos),
    .config_axi_awregion(config_axi_awregion),
    .config_axi_awuser(config_axi_awuser),
    .config_axi_awvalid(config_axi_awvalid),
    .config_axi_awready(config_axi_awready),
    .config_axi_wdata(config_axi_wdata),
    .config_axi_wstrb(config_axi_wstrb),
    .config_axi_wlast(config_axi_wlast),
    .config_axi_wvalid(config_axi_wvalid),
    .config_axi_wready(config_axi_wready),
    .config_axi_bid(config_axi_bid),
    .config_axi_bresp(config_axi_bresp),
    .config_axi_bvalid(config_axi_bvalid),
    .config_axi_bready(config_axi_bready),
    .config_axi_arid(config_axi_arid),
    .config_axi_araddr(config_axi_araddr),
    .config_axi_arlen(config_axi_arlen),
    .config_axi_arsize(config_axi_arsize),
    .config_axi_arburst(config_axi_arburst),
    .config_axi_arlock(config_axi_arlock),
    .config_axi_arcache(config_axi_arcache),
    .config_axi_arprot(config_axi_arprot),
    .config_axi_arqos(config_axi_arqos),
    .config_axi_arregion(config_axi_arregion),
    .config_axi_aruser(config_axi_aruser),
    .config_axi_arvalid(config_axi_arvalid),
    .config_axi_arready(config_axi_arready),
    .config_axi_rid(config_axi_rid),
    .config_axi_rdata(config_axi_rdata),
    .config_axi_rresp(config_axi_rresp),
    .config_axi_rlast(config_axi_rlast),
    .config_axi_rvalid(config_axi_rvalid),
    .config_axi_rready(config_axi_rready),
    .axi_init_axi_txn(axi_init_axi_txn),
    .axi_aclk(axi_aclk),
    .axi_aresetn(axi_aresetn),
    .axi_awid(axi_awid),
    .axi_awaddr(axi_awaddr),
    .axi_awlen(axi_awlen),
    .axi_awsize(axi_awsize),
    .axi_awburst(axi_awburst),
    .axi_awlock(axi_awlock),
    .axi_awcache(axi_awcache),
    .axi_awprot(axi_awprot),
    .axi_awqos(axi_awqos),
    .axi_awvalid(axi_awvalid),
    .axi_awready(axi_awready),
    .axi_wdata(axi_wdata),
    .axi_wstrb(axi_wstrb),
    .axi_wlast(axi_wlast),
    .axi_wvalid(axi_wvalid),
    .axi_wready(axi_wready),
    .axi_bid(axi_bid),
    .axi_bresp(axi_bresp),
    .axi_bvalid(axi_bvalid),
    .axi_bready(axi_bready),
    .axi_arid(axi_arid),
    .axi_araddr(axi_araddr),
    .axi_arlen(axi_arlen),
    .axi_arsize(axi_arsize),
    .axi_arburst(axi_arburst),
    .axi_arlock(axi_arlock),
    .axi_arcache(axi_arcache),
    .axi_arprot(axi_arprot),
    .axi_arqos(axi_arqos),
    .axi_arvalid(axi_arvalid),
    .axi_arready(axi_arready),
    .axi_rid(axi_rid),
    .axi_rdata(axi_rdata),
    .axi_rresp(axi_rresp),
    .axi_rlast(axi_rlast),
    .axi_rvalid(axi_rvalid),
    .axi_rready(axi_rready)
  );
endmodule
