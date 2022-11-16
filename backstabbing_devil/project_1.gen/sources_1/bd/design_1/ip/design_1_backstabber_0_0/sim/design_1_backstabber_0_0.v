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


// IP VLNV: user.org:user:backstabber:1.0
// IP Revision: 178

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_backstabber_0_0 (
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
  ace_aclk,
  ace_aresetn,
  acaddr,
  acprot,
  acready,
  acsnoop,
  acvalid,
  araddr,
  arbar,
  arburst,
  arcache,
  ardomain,
  arid,
  arlen,
  arlock,
  arprot,
  arqos,
  arready,
  arregion,
  arsize,
  arsnoop,
  aruser,
  arvalid,
  awaddr,
  awbar,
  awburst,
  awcache,
  awdomain,
  awid,
  awlen,
  awlock,
  awprot,
  awqos,
  awready,
  awregion,
  awsize,
  awsnoop,
  awuser,
  awvalid,
  bid,
  bready,
  bresp,
  buser,
  bvalid,
  cddata,
  cdlast,
  cdready,
  cdvalid,
  crready,
  crresp,
  crvalid,
  rack,
  rdata,
  rid,
  rlast,
  rready,
  rresp,
  ruser,
  rvalid,
  wack,
  wdata,
  wid,
  wlast,
  wready,
  wstrb,
  wuser,
  wvalid,
  m00_axi_aclk,
  m00_axi_aresetn,
  m00_axi_awid,
  m00_axi_awaddr,
  m00_axi_awlen,
  m00_axi_awsize,
  m00_axi_awburst,
  m00_axi_awlock,
  m00_axi_awcache,
  m00_axi_awprot,
  m00_axi_awqos,
  m00_axi_awuser,
  m00_axi_awvalid,
  m00_axi_awready,
  m00_axi_wdata,
  m00_axi_wstrb,
  m00_axi_wlast,
  m00_axi_wuser,
  m00_axi_wvalid,
  m00_axi_wready,
  m00_axi_bid,
  m00_axi_bresp,
  m00_axi_buser,
  m00_axi_bvalid,
  m00_axi_bready,
  m00_axi_arid,
  m00_axi_araddr,
  m00_axi_arlen,
  m00_axi_arsize,
  m00_axi_arburst,
  m00_axi_arlock,
  m00_axi_arcache,
  m00_axi_arprot,
  m00_axi_arqos,
  m00_axi_aruser,
  m00_axi_arvalid,
  m00_axi_arready,
  m00_axi_rid,
  m00_axi_rdata,
  m00_axi_rresp,
  m00_axi_rlast,
  m00_axi_ruser,
  m00_axi_rvalid,
  m00_axi_rready,
  s00_axi_aclk,
  s00_axi_aresetn,
  debug_state
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
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ace_aclk, ASSOCIATED_RESET ace_aresetn, FREQ_HZ 149985016, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ace_aclk CLK" *)
input wire ace_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ace_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ace_aresetn RST" *)
input wire ace_aresetn;
input wire [43 : 0] acaddr;
input wire [2 : 0] acprot;
output wire acready;
input wire [3 : 0] acsnoop;
input wire acvalid;
output wire [43 : 0] araddr;
output wire [1 : 0] arbar;
output wire [1 : 0] arburst;
output wire [3 : 0] arcache;
output wire [1 : 0] ardomain;
output wire [5 : 0] arid;
output wire [7 : 0] arlen;
output wire arlock;
output wire [2 : 0] arprot;
output wire [3 : 0] arqos;
input wire arready;
output wire [3 : 0] arregion;
output wire [2 : 0] arsize;
output wire [3 : 0] arsnoop;
output wire [15 : 0] aruser;
output wire arvalid;
output wire [43 : 0] awaddr;
output wire [1 : 0] awbar;
output wire [1 : 0] awburst;
output wire [3 : 0] awcache;
output wire [1 : 0] awdomain;
output wire [5 : 0] awid;
output wire [7 : 0] awlen;
output wire awlock;
output wire [2 : 0] awprot;
output wire [3 : 0] awqos;
input wire awready;
output wire [3 : 0] awregion;
output wire [2 : 0] awsize;
output wire [2 : 0] awsnoop;
output wire [15 : 0] awuser;
output wire awvalid;
input wire [5 : 0] bid;
output wire bready;
input wire [1 : 0] bresp;
input wire buser;
input wire bvalid;
output wire [127 : 0] cddata;
output wire cdlast;
input wire cdready;
output wire cdvalid;
input wire crready;
output wire [4 : 0] crresp;
output wire crvalid;
output wire rack;
input wire [127 : 0] rdata;
input wire [5 : 0] rid;
input wire rlast;
output wire rready;
input wire [3 : 0] rresp;
input wire ruser;
input wire rvalid;
output wire wack;
output wire [127 : 0] wdata;
output wire [5 : 0] wid;
output wire wlast;
input wire wready;
output wire [15 : 0] wstrb;
output wire wuser;
output wire wvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m00_axi_aclk, ASSOCIATED_RESET m00_axi_aresetn, ASSOCIATED_BUSIF m00_axi, FREQ_HZ 149985016, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 m00_axi_aclk CLK" *)
input wire m00_axi_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m00_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 m00_axi_aresetn RST" *)
input wire m00_axi_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWID" *)
output wire [15 : 0] m00_axi_awid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWADDR" *)
output wire [39 : 0] m00_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWLEN" *)
output wire [7 : 0] m00_axi_awlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWSIZE" *)
output wire [2 : 0] m00_axi_awsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWBURST" *)
output wire [1 : 0] m00_axi_awburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWLOCK" *)
output wire m00_axi_awlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWCACHE" *)
output wire [3 : 0] m00_axi_awcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWPROT" *)
output wire [2 : 0] m00_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWQOS" *)
output wire [3 : 0] m00_axi_awqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWUSER" *)
output wire [0 : 0] m00_axi_awuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWVALID" *)
output wire m00_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi AWREADY" *)
input wire m00_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi WDATA" *)
output wire [127 : 0] m00_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi WSTRB" *)
output wire [15 : 0] m00_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi WLAST" *)
output wire m00_axi_wlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi WUSER" *)
output wire [0 : 0] m00_axi_wuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi WVALID" *)
output wire m00_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi WREADY" *)
input wire m00_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi BID" *)
input wire [15 : 0] m00_axi_bid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi BRESP" *)
input wire [1 : 0] m00_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi BUSER" *)
input wire [0 : 0] m00_axi_buser;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi BVALID" *)
input wire m00_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi BREADY" *)
output wire m00_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARID" *)
output wire [15 : 0] m00_axi_arid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARADDR" *)
output wire [39 : 0] m00_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARLEN" *)
output wire [7 : 0] m00_axi_arlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARSIZE" *)
output wire [2 : 0] m00_axi_arsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARBURST" *)
output wire [1 : 0] m00_axi_arburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARLOCK" *)
output wire m00_axi_arlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARCACHE" *)
output wire [3 : 0] m00_axi_arcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARPROT" *)
output wire [2 : 0] m00_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARQOS" *)
output wire [3 : 0] m00_axi_arqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARUSER" *)
output wire [0 : 0] m00_axi_aruser;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARVALID" *)
output wire m00_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi ARREADY" *)
input wire m00_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi RID" *)
input wire [15 : 0] m00_axi_rid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi RDATA" *)
input wire [127 : 0] m00_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi RRESP" *)
input wire [1 : 0] m00_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi RLAST" *)
input wire m00_axi_rlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi RUSER" *)
input wire [0 : 0] m00_axi_ruser;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi RVALID" *)
input wire m00_axi_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m00_axi, DATA_WIDTH 128, PROTOCOL AXI4, FREQ_HZ 149985016, ID_WIDTH 16, ADDR_WIDTH 40, AWUSER_WIDTH 1, ARUSER_WIDTH 1, WUSER_WIDTH 1, RUSER_WIDTH 1, BUSER_WIDTH 1, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, \
NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m00_axi RREADY" *)
output wire m00_axi_rready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s00_axi_aclk, ASSOCIATED_RESET s00_axi_aresetn, ASSOCIATED_BUSIF s00_axi, FREQ_HZ 149985016, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s00_axi_aclk CLK" *)
input wire s00_axi_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s00_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s00_axi_aresetn RST" *)
input wire s00_axi_aresetn;
output wire [3 : 0] debug_state;

  backstabber_v1_0 #(
    .C_ACE_ADDR_WIDTH(44),
    .C_ACE_DATA_WIDTH(128),
    .C_Config_AXI_ID_WIDTH(0),
    .C_Config_AXI_DATA_WIDTH(128),
    .C_Config_AXI_ADDR_WIDTH(40),
    .C_Config_AXI_AWUSER_WIDTH(16),
    .C_Config_AXI_ARUSER_WIDTH(16),
    .C_Config_AXI_WUSER_WIDTH(0),
    .C_Config_AXI_RUSER_WIDTH(0),
    .C_Config_AXI_BUSER_WIDTH(0),
    .BUS_WIDTH(128),
    .CACHE_LINE_WIDTH_BITS(512),
    .C_ACE_ACSNOOP_WIDTH(4),
    .QUEUE_DEPTH(2),
    .C_M00_AXI_ID_WIDTH(16),
    .C_M00_AXI_BURST_LEN(4),
    .C_M00_AXI_ADDR_WIDTH(40),
    .C_M00_AXI_DATA_WIDTH(128),
    .C_M00_AXI_AWUSER_WIDTH(0),
    .C_M00_AXI_ARUSER_WIDTH(0),
    .C_M00_AXI_WUSER_WIDTH(0),
    .C_M00_AXI_RUSER_WIDTH(0),
    .C_M00_AXI_BUSER_WIDTH(0),
    .WRITER(0),
    .C_S00_AXI_ID_WIDTH(16),
    .C_S00_AXI_BURST_LEN(4),
    .C_S00_AXI_ADDR_WIDTH(40),
    .C_S00_AXI_DATA_WIDTH(128),
    .C_S00_AXI_AWUSER_WIDTH(0),
    .C_S00_AXI_ARUSER_WIDTH(0),
    .C_S00_AXI_WUSER_WIDTH(0),
    .C_S00_AXI_RUSER_WIDTH(0),
    .C_S00_AXI_BUSER_WIDTH(0)
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
    .ace_aclk(ace_aclk),
    .ace_aresetn(ace_aresetn),
    .acaddr(acaddr),
    .acprot(acprot),
    .acready(acready),
    .acsnoop(acsnoop),
    .acvalid(acvalid),
    .araddr(araddr),
    .arbar(arbar),
    .arburst(arburst),
    .arcache(arcache),
    .ardomain(ardomain),
    .arid(arid),
    .arlen(arlen),
    .arlock(arlock),
    .arprot(arprot),
    .arqos(arqos),
    .arready(arready),
    .arregion(arregion),
    .arsize(arsize),
    .arsnoop(arsnoop),
    .aruser(aruser),
    .arvalid(arvalid),
    .awaddr(awaddr),
    .awbar(awbar),
    .awburst(awburst),
    .awcache(awcache),
    .awdomain(awdomain),
    .awid(awid),
    .awlen(awlen),
    .awlock(awlock),
    .awprot(awprot),
    .awqos(awqos),
    .awready(awready),
    .awregion(awregion),
    .awsize(awsize),
    .awsnoop(awsnoop),
    .awuser(awuser),
    .awvalid(awvalid),
    .bid(bid),
    .bready(bready),
    .bresp(bresp),
    .buser(buser),
    .bvalid(bvalid),
    .cddata(cddata),
    .cdlast(cdlast),
    .cdready(cdready),
    .cdvalid(cdvalid),
    .crready(crready),
    .crresp(crresp),
    .crvalid(crvalid),
    .rack(rack),
    .rdata(rdata),
    .rid(rid),
    .rlast(rlast),
    .rready(rready),
    .rresp(rresp),
    .ruser(ruser),
    .rvalid(rvalid),
    .wack(wack),
    .wdata(wdata),
    .wid(wid),
    .wlast(wlast),
    .wready(wready),
    .wstrb(wstrb),
    .wuser(wuser),
    .wvalid(wvalid),
    .m00_axi_aclk(m00_axi_aclk),
    .m00_axi_aresetn(m00_axi_aresetn),
    .m00_axi_awid(m00_axi_awid),
    .m00_axi_awaddr(m00_axi_awaddr),
    .m00_axi_awlen(m00_axi_awlen),
    .m00_axi_awsize(m00_axi_awsize),
    .m00_axi_awburst(m00_axi_awburst),
    .m00_axi_awlock(m00_axi_awlock),
    .m00_axi_awcache(m00_axi_awcache),
    .m00_axi_awprot(m00_axi_awprot),
    .m00_axi_awqos(m00_axi_awqos),
    .m00_axi_awuser(m00_axi_awuser),
    .m00_axi_awvalid(m00_axi_awvalid),
    .m00_axi_awready(m00_axi_awready),
    .m00_axi_wdata(m00_axi_wdata),
    .m00_axi_wstrb(m00_axi_wstrb),
    .m00_axi_wlast(m00_axi_wlast),
    .m00_axi_wuser(m00_axi_wuser),
    .m00_axi_wvalid(m00_axi_wvalid),
    .m00_axi_wready(m00_axi_wready),
    .m00_axi_bid(m00_axi_bid),
    .m00_axi_bresp(m00_axi_bresp),
    .m00_axi_buser(m00_axi_buser),
    .m00_axi_bvalid(m00_axi_bvalid),
    .m00_axi_bready(m00_axi_bready),
    .m00_axi_arid(m00_axi_arid),
    .m00_axi_araddr(m00_axi_araddr),
    .m00_axi_arlen(m00_axi_arlen),
    .m00_axi_arsize(m00_axi_arsize),
    .m00_axi_arburst(m00_axi_arburst),
    .m00_axi_arlock(m00_axi_arlock),
    .m00_axi_arcache(m00_axi_arcache),
    .m00_axi_arprot(m00_axi_arprot),
    .m00_axi_arqos(m00_axi_arqos),
    .m00_axi_aruser(m00_axi_aruser),
    .m00_axi_arvalid(m00_axi_arvalid),
    .m00_axi_arready(m00_axi_arready),
    .m00_axi_rid(m00_axi_rid),
    .m00_axi_rdata(m00_axi_rdata),
    .m00_axi_rresp(m00_axi_rresp),
    .m00_axi_rlast(m00_axi_rlast),
    .m00_axi_ruser(m00_axi_ruser),
    .m00_axi_rvalid(m00_axi_rvalid),
    .m00_axi_rready(m00_axi_rready),
    .s00_axi_aclk(s00_axi_aclk),
    .s00_axi_aresetn(s00_axi_aresetn),
    .s00_axi_awid(16'B0),
    .s00_axi_awaddr(40'B0),
    .s00_axi_awlen(8'B0),
    .s00_axi_awsize(3'B0),
    .s00_axi_awburst(2'B1),
    .s00_axi_awlock(1'B0),
    .s00_axi_awcache(3),
    .s00_axi_awprot(3'B0),
    .s00_axi_awqos(4'B0),
    .s00_axi_awuser(1'B0),
    .s00_axi_awvalid(1'B0),
    .s00_axi_awready(),
    .s00_axi_wdata(128'B0),
    .s00_axi_wstrb(16'B1),
    .s00_axi_wlast(1'B0),
    .s00_axi_wuser(1'B0),
    .s00_axi_wvalid(1'B0),
    .s00_axi_wready(),
    .s00_axi_bid(),
    .s00_axi_bresp(),
    .s00_axi_buser(),
    .s00_axi_bvalid(),
    .s00_axi_bready(1'B0),
    .s00_axi_arid(16'B0),
    .s00_axi_araddr(40'B0),
    .s00_axi_arlen(8'B0),
    .s00_axi_arsize(3'B0),
    .s00_axi_arburst(2'B1),
    .s00_axi_arlock(1'B0),
    .s00_axi_arcache(3),
    .s00_axi_arprot(3'B0),
    .s00_axi_arqos(4'B0),
    .s00_axi_aruser(1'B0),
    .s00_axi_arvalid(1'B0),
    .s00_axi_arready(),
    .s00_axi_rid(),
    .s00_axi_rdata(),
    .s00_axi_rresp(),
    .s00_axi_rlast(),
    .s00_axi_ruser(),
    .s00_axi_rvalid(),
    .s00_axi_rready(1'B0),
    .debug_state(debug_state)
  );
endmodule
