//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
//Date        : Sat Jul  1 10:40:42 2023
//Host        : cris running 64-bit Linux Mint 20.3
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (acaddr_0,
    acsnoop_0,
    acvalid_0,
    clk_100MHz,
    config_axi_0_araddr,
    config_axi_0_arburst,
    config_axi_0_arcache,
    config_axi_0_arid,
    config_axi_0_arlen,
    config_axi_0_arlock,
    config_axi_0_arprot,
    config_axi_0_arqos,
    config_axi_0_arready,
    config_axi_0_arregion,
    config_axi_0_arsize,
    config_axi_0_aruser,
    config_axi_0_arvalid,
    config_axi_0_awaddr,
    config_axi_0_awburst,
    config_axi_0_awcache,
    config_axi_0_awid,
    config_axi_0_awlen,
    config_axi_0_awlock,
    config_axi_0_awprot,
    config_axi_0_awqos,
    config_axi_0_awready,
    config_axi_0_awregion,
    config_axi_0_awsize,
    config_axi_0_awuser,
    config_axi_0_awvalid,
    config_axi_0_bid,
    config_axi_0_bready,
    config_axi_0_bresp,
    config_axi_0_bvalid,
    config_axi_0_rdata,
    config_axi_0_rid,
    config_axi_0_rlast,
    config_axi_0_rready,
    config_axi_0_rresp,
    config_axi_0_rvalid,
    config_axi_0_wdata,
    config_axi_0_wlast,
    config_axi_0_wready,
    config_axi_0_wstrb,
    config_axi_0_wvalid,
    crready_0,
    crvalid_0,
    m00_axi_0_araddr,
    m00_axi_0_arburst,
    m00_axi_0_arcache,
    m00_axi_0_arid,
    m00_axi_0_arlen,
    m00_axi_0_arlock,
    m00_axi_0_arprot,
    m00_axi_0_arqos,
    m00_axi_0_arready,
    m00_axi_0_arsize,
    m00_axi_0_aruser,
    m00_axi_0_arvalid,
    m00_axi_0_awaddr,
    m00_axi_0_awburst,
    m00_axi_0_awcache,
    m00_axi_0_awid,
    m00_axi_0_awlen,
    m00_axi_0_awlock,
    m00_axi_0_awprot,
    m00_axi_0_awqos,
    m00_axi_0_awready,
    m00_axi_0_awsize,
    m00_axi_0_awuser,
    m00_axi_0_awvalid,
    m00_axi_0_bid,
    m00_axi_0_bready,
    m00_axi_0_bresp,
    m00_axi_0_buser,
    m00_axi_0_bvalid,
    m00_axi_0_rdata,
    m00_axi_0_rid,
    m00_axi_0_rlast,
    m00_axi_0_rready,
    m00_axi_0_rresp,
    m00_axi_0_ruser,
    m00_axi_0_rvalid,
    m00_axi_0_wdata,
    m00_axi_0_wlast,
    m00_axi_0_wready,
    m00_axi_0_wstrb,
    m00_axi_0_wuser,
    m00_axi_0_wvalid,
    reset,
    s00_axi_0_araddr,
    s00_axi_0_arburst,
    s00_axi_0_arcache,
    s00_axi_0_arid,
    s00_axi_0_arlen,
    s00_axi_0_arlock,
    s00_axi_0_arprot,
    s00_axi_0_arqos,
    s00_axi_0_arready,
    s00_axi_0_arsize,
    s00_axi_0_aruser,
    s00_axi_0_arvalid,
    s00_axi_0_awaddr,
    s00_axi_0_awburst,
    s00_axi_0_awcache,
    s00_axi_0_awid,
    s00_axi_0_awlen,
    s00_axi_0_awlock,
    s00_axi_0_awprot,
    s00_axi_0_awqos,
    s00_axi_0_awready,
    s00_axi_0_awsize,
    s00_axi_0_awuser,
    s00_axi_0_awvalid,
    s00_axi_0_bid,
    s00_axi_0_bready,
    s00_axi_0_bresp,
    s00_axi_0_buser,
    s00_axi_0_bvalid,
    s00_axi_0_rdata,
    s00_axi_0_rid,
    s00_axi_0_rlast,
    s00_axi_0_rready,
    s00_axi_0_rresp,
    s00_axi_0_ruser,
    s00_axi_0_rvalid,
    s00_axi_0_wdata,
    s00_axi_0_wlast,
    s00_axi_0_wready,
    s00_axi_0_wstrb,
    s00_axi_0_wuser,
    s00_axi_0_wvalid);
  input [43:0]acaddr_0;
  input [3:0]acsnoop_0;
  input acvalid_0;
  input clk_100MHz;
  input [39:0]config_axi_0_araddr;
  input [1:0]config_axi_0_arburst;
  input [3:0]config_axi_0_arcache;
  input [15:0]config_axi_0_arid;
  input [7:0]config_axi_0_arlen;
  input config_axi_0_arlock;
  input [2:0]config_axi_0_arprot;
  input [3:0]config_axi_0_arqos;
  output config_axi_0_arready;
  input [3:0]config_axi_0_arregion;
  input [2:0]config_axi_0_arsize;
  input [0:0]config_axi_0_aruser;
  input config_axi_0_arvalid;
  input [39:0]config_axi_0_awaddr;
  input [1:0]config_axi_0_awburst;
  input [3:0]config_axi_0_awcache;
  input [15:0]config_axi_0_awid;
  input [7:0]config_axi_0_awlen;
  input config_axi_0_awlock;
  input [2:0]config_axi_0_awprot;
  input [3:0]config_axi_0_awqos;
  output config_axi_0_awready;
  input [3:0]config_axi_0_awregion;
  input [2:0]config_axi_0_awsize;
  input [0:0]config_axi_0_awuser;
  input config_axi_0_awvalid;
  output [15:0]config_axi_0_bid;
  input config_axi_0_bready;
  output [1:0]config_axi_0_bresp;
  output config_axi_0_bvalid;
  output [127:0]config_axi_0_rdata;
  output [15:0]config_axi_0_rid;
  output config_axi_0_rlast;
  input config_axi_0_rready;
  output [1:0]config_axi_0_rresp;
  output config_axi_0_rvalid;
  input [127:0]config_axi_0_wdata;
  input config_axi_0_wlast;
  output config_axi_0_wready;
  input [15:0]config_axi_0_wstrb;
  input config_axi_0_wvalid;
  input crready_0;
  output crvalid_0;
  output [39:0]m00_axi_0_araddr;
  output [1:0]m00_axi_0_arburst;
  output [3:0]m00_axi_0_arcache;
  output [15:0]m00_axi_0_arid;
  output [7:0]m00_axi_0_arlen;
  output m00_axi_0_arlock;
  output [2:0]m00_axi_0_arprot;
  output [3:0]m00_axi_0_arqos;
  input m00_axi_0_arready;
  output [2:0]m00_axi_0_arsize;
  output [0:0]m00_axi_0_aruser;
  output m00_axi_0_arvalid;
  output [39:0]m00_axi_0_awaddr;
  output [1:0]m00_axi_0_awburst;
  output [3:0]m00_axi_0_awcache;
  output [15:0]m00_axi_0_awid;
  output [7:0]m00_axi_0_awlen;
  output m00_axi_0_awlock;
  output [2:0]m00_axi_0_awprot;
  output [3:0]m00_axi_0_awqos;
  input m00_axi_0_awready;
  output [2:0]m00_axi_0_awsize;
  output [0:0]m00_axi_0_awuser;
  output m00_axi_0_awvalid;
  input [15:0]m00_axi_0_bid;
  output m00_axi_0_bready;
  input [1:0]m00_axi_0_bresp;
  input [0:0]m00_axi_0_buser;
  input m00_axi_0_bvalid;
  input [127:0]m00_axi_0_rdata;
  input [15:0]m00_axi_0_rid;
  input m00_axi_0_rlast;
  output m00_axi_0_rready;
  input [1:0]m00_axi_0_rresp;
  input [0:0]m00_axi_0_ruser;
  input m00_axi_0_rvalid;
  output [127:0]m00_axi_0_wdata;
  output m00_axi_0_wlast;
  input m00_axi_0_wready;
  output [15:0]m00_axi_0_wstrb;
  output [0:0]m00_axi_0_wuser;
  output m00_axi_0_wvalid;
  input reset;
  input [39:0]s00_axi_0_araddr;
  input [1:0]s00_axi_0_arburst;
  input [3:0]s00_axi_0_arcache;
  input [15:0]s00_axi_0_arid;
  input [7:0]s00_axi_0_arlen;
  input s00_axi_0_arlock;
  input [2:0]s00_axi_0_arprot;
  input [3:0]s00_axi_0_arqos;
  output s00_axi_0_arready;
  input [2:0]s00_axi_0_arsize;
  input [0:0]s00_axi_0_aruser;
  input s00_axi_0_arvalid;
  input [39:0]s00_axi_0_awaddr;
  input [1:0]s00_axi_0_awburst;
  input [3:0]s00_axi_0_awcache;
  input [15:0]s00_axi_0_awid;
  input [7:0]s00_axi_0_awlen;
  input s00_axi_0_awlock;
  input [2:0]s00_axi_0_awprot;
  input [3:0]s00_axi_0_awqos;
  output s00_axi_0_awready;
  input [2:0]s00_axi_0_awsize;
  input [0:0]s00_axi_0_awuser;
  input s00_axi_0_awvalid;
  output [15:0]s00_axi_0_bid;
  input s00_axi_0_bready;
  output [1:0]s00_axi_0_bresp;
  output [0:0]s00_axi_0_buser;
  output s00_axi_0_bvalid;
  output [127:0]s00_axi_0_rdata;
  output [15:0]s00_axi_0_rid;
  output s00_axi_0_rlast;
  input s00_axi_0_rready;
  output [1:0]s00_axi_0_rresp;
  output [0:0]s00_axi_0_ruser;
  output s00_axi_0_rvalid;
  input [127:0]s00_axi_0_wdata;
  input s00_axi_0_wlast;
  output s00_axi_0_wready;
  input [15:0]s00_axi_0_wstrb;
  input [0:0]s00_axi_0_wuser;
  input s00_axi_0_wvalid;

  wire [43:0]acaddr_0;
  wire [3:0]acsnoop_0;
  wire acvalid_0;
  wire clk_100MHz;
  wire [39:0]config_axi_0_araddr;
  wire [1:0]config_axi_0_arburst;
  wire [3:0]config_axi_0_arcache;
  wire [15:0]config_axi_0_arid;
  wire [7:0]config_axi_0_arlen;
  wire config_axi_0_arlock;
  wire [2:0]config_axi_0_arprot;
  wire [3:0]config_axi_0_arqos;
  wire config_axi_0_arready;
  wire [3:0]config_axi_0_arregion;
  wire [2:0]config_axi_0_arsize;
  wire [0:0]config_axi_0_aruser;
  wire config_axi_0_arvalid;
  wire [39:0]config_axi_0_awaddr;
  wire [1:0]config_axi_0_awburst;
  wire [3:0]config_axi_0_awcache;
  wire [15:0]config_axi_0_awid;
  wire [7:0]config_axi_0_awlen;
  wire config_axi_0_awlock;
  wire [2:0]config_axi_0_awprot;
  wire [3:0]config_axi_0_awqos;
  wire config_axi_0_awready;
  wire [3:0]config_axi_0_awregion;
  wire [2:0]config_axi_0_awsize;
  wire [0:0]config_axi_0_awuser;
  wire config_axi_0_awvalid;
  wire [15:0]config_axi_0_bid;
  wire config_axi_0_bready;
  wire [1:0]config_axi_0_bresp;
  wire config_axi_0_bvalid;
  wire [127:0]config_axi_0_rdata;
  wire [15:0]config_axi_0_rid;
  wire config_axi_0_rlast;
  wire config_axi_0_rready;
  wire [1:0]config_axi_0_rresp;
  wire config_axi_0_rvalid;
  wire [127:0]config_axi_0_wdata;
  wire config_axi_0_wlast;
  wire config_axi_0_wready;
  wire [15:0]config_axi_0_wstrb;
  wire config_axi_0_wvalid;
  wire crready_0;
  wire crvalid_0;
  wire [39:0]m00_axi_0_araddr;
  wire [1:0]m00_axi_0_arburst;
  wire [3:0]m00_axi_0_arcache;
  wire [15:0]m00_axi_0_arid;
  wire [7:0]m00_axi_0_arlen;
  wire m00_axi_0_arlock;
  wire [2:0]m00_axi_0_arprot;
  wire [3:0]m00_axi_0_arqos;
  wire m00_axi_0_arready;
  wire [2:0]m00_axi_0_arsize;
  wire [0:0]m00_axi_0_aruser;
  wire m00_axi_0_arvalid;
  wire [39:0]m00_axi_0_awaddr;
  wire [1:0]m00_axi_0_awburst;
  wire [3:0]m00_axi_0_awcache;
  wire [15:0]m00_axi_0_awid;
  wire [7:0]m00_axi_0_awlen;
  wire m00_axi_0_awlock;
  wire [2:0]m00_axi_0_awprot;
  wire [3:0]m00_axi_0_awqos;
  wire m00_axi_0_awready;
  wire [2:0]m00_axi_0_awsize;
  wire [0:0]m00_axi_0_awuser;
  wire m00_axi_0_awvalid;
  wire [15:0]m00_axi_0_bid;
  wire m00_axi_0_bready;
  wire [1:0]m00_axi_0_bresp;
  wire [0:0]m00_axi_0_buser;
  wire m00_axi_0_bvalid;
  wire [127:0]m00_axi_0_rdata;
  wire [15:0]m00_axi_0_rid;
  wire m00_axi_0_rlast;
  wire m00_axi_0_rready;
  wire [1:0]m00_axi_0_rresp;
  wire [0:0]m00_axi_0_ruser;
  wire m00_axi_0_rvalid;
  wire [127:0]m00_axi_0_wdata;
  wire m00_axi_0_wlast;
  wire m00_axi_0_wready;
  wire [15:0]m00_axi_0_wstrb;
  wire [0:0]m00_axi_0_wuser;
  wire m00_axi_0_wvalid;
  wire reset;
  wire [39:0]s00_axi_0_araddr;
  wire [1:0]s00_axi_0_arburst;
  wire [3:0]s00_axi_0_arcache;
  wire [15:0]s00_axi_0_arid;
  wire [7:0]s00_axi_0_arlen;
  wire s00_axi_0_arlock;
  wire [2:0]s00_axi_0_arprot;
  wire [3:0]s00_axi_0_arqos;
  wire s00_axi_0_arready;
  wire [2:0]s00_axi_0_arsize;
  wire [0:0]s00_axi_0_aruser;
  wire s00_axi_0_arvalid;
  wire [39:0]s00_axi_0_awaddr;
  wire [1:0]s00_axi_0_awburst;
  wire [3:0]s00_axi_0_awcache;
  wire [15:0]s00_axi_0_awid;
  wire [7:0]s00_axi_0_awlen;
  wire s00_axi_0_awlock;
  wire [2:0]s00_axi_0_awprot;
  wire [3:0]s00_axi_0_awqos;
  wire s00_axi_0_awready;
  wire [2:0]s00_axi_0_awsize;
  wire [0:0]s00_axi_0_awuser;
  wire s00_axi_0_awvalid;
  wire [15:0]s00_axi_0_bid;
  wire s00_axi_0_bready;
  wire [1:0]s00_axi_0_bresp;
  wire [0:0]s00_axi_0_buser;
  wire s00_axi_0_bvalid;
  wire [127:0]s00_axi_0_rdata;
  wire [15:0]s00_axi_0_rid;
  wire s00_axi_0_rlast;
  wire s00_axi_0_rready;
  wire [1:0]s00_axi_0_rresp;
  wire [0:0]s00_axi_0_ruser;
  wire s00_axi_0_rvalid;
  wire [127:0]s00_axi_0_wdata;
  wire s00_axi_0_wlast;
  wire s00_axi_0_wready;
  wire [15:0]s00_axi_0_wstrb;
  wire [0:0]s00_axi_0_wuser;
  wire s00_axi_0_wvalid;

  design_1 design_1_i
       (.acaddr_0(acaddr_0),
        .acsnoop_0(acsnoop_0),
        .acvalid_0(acvalid_0),
        .clk_100MHz(clk_100MHz),
        .config_axi_0_araddr(config_axi_0_araddr),
        .config_axi_0_arburst(config_axi_0_arburst),
        .config_axi_0_arcache(config_axi_0_arcache),
        .config_axi_0_arid(config_axi_0_arid),
        .config_axi_0_arlen(config_axi_0_arlen),
        .config_axi_0_arlock(config_axi_0_arlock),
        .config_axi_0_arprot(config_axi_0_arprot),
        .config_axi_0_arqos(config_axi_0_arqos),
        .config_axi_0_arready(config_axi_0_arready),
        .config_axi_0_arregion(config_axi_0_arregion),
        .config_axi_0_arsize(config_axi_0_arsize),
        .config_axi_0_aruser(config_axi_0_aruser),
        .config_axi_0_arvalid(config_axi_0_arvalid),
        .config_axi_0_awaddr(config_axi_0_awaddr),
        .config_axi_0_awburst(config_axi_0_awburst),
        .config_axi_0_awcache(config_axi_0_awcache),
        .config_axi_0_awid(config_axi_0_awid),
        .config_axi_0_awlen(config_axi_0_awlen),
        .config_axi_0_awlock(config_axi_0_awlock),
        .config_axi_0_awprot(config_axi_0_awprot),
        .config_axi_0_awqos(config_axi_0_awqos),
        .config_axi_0_awready(config_axi_0_awready),
        .config_axi_0_awregion(config_axi_0_awregion),
        .config_axi_0_awsize(config_axi_0_awsize),
        .config_axi_0_awuser(config_axi_0_awuser),
        .config_axi_0_awvalid(config_axi_0_awvalid),
        .config_axi_0_bid(config_axi_0_bid),
        .config_axi_0_bready(config_axi_0_bready),
        .config_axi_0_bresp(config_axi_0_bresp),
        .config_axi_0_bvalid(config_axi_0_bvalid),
        .config_axi_0_rdata(config_axi_0_rdata),
        .config_axi_0_rid(config_axi_0_rid),
        .config_axi_0_rlast(config_axi_0_rlast),
        .config_axi_0_rready(config_axi_0_rready),
        .config_axi_0_rresp(config_axi_0_rresp),
        .config_axi_0_rvalid(config_axi_0_rvalid),
        .config_axi_0_wdata(config_axi_0_wdata),
        .config_axi_0_wlast(config_axi_0_wlast),
        .config_axi_0_wready(config_axi_0_wready),
        .config_axi_0_wstrb(config_axi_0_wstrb),
        .config_axi_0_wvalid(config_axi_0_wvalid),
        .crready_0(crready_0),
        .crvalid_0(crvalid_0),
        .m00_axi_0_araddr(m00_axi_0_araddr),
        .m00_axi_0_arburst(m00_axi_0_arburst),
        .m00_axi_0_arcache(m00_axi_0_arcache),
        .m00_axi_0_arid(m00_axi_0_arid),
        .m00_axi_0_arlen(m00_axi_0_arlen),
        .m00_axi_0_arlock(m00_axi_0_arlock),
        .m00_axi_0_arprot(m00_axi_0_arprot),
        .m00_axi_0_arqos(m00_axi_0_arqos),
        .m00_axi_0_arready(m00_axi_0_arready),
        .m00_axi_0_arsize(m00_axi_0_arsize),
        .m00_axi_0_aruser(m00_axi_0_aruser),
        .m00_axi_0_arvalid(m00_axi_0_arvalid),
        .m00_axi_0_awaddr(m00_axi_0_awaddr),
        .m00_axi_0_awburst(m00_axi_0_awburst),
        .m00_axi_0_awcache(m00_axi_0_awcache),
        .m00_axi_0_awid(m00_axi_0_awid),
        .m00_axi_0_awlen(m00_axi_0_awlen),
        .m00_axi_0_awlock(m00_axi_0_awlock),
        .m00_axi_0_awprot(m00_axi_0_awprot),
        .m00_axi_0_awqos(m00_axi_0_awqos),
        .m00_axi_0_awready(m00_axi_0_awready),
        .m00_axi_0_awsize(m00_axi_0_awsize),
        .m00_axi_0_awuser(m00_axi_0_awuser),
        .m00_axi_0_awvalid(m00_axi_0_awvalid),
        .m00_axi_0_bid(m00_axi_0_bid),
        .m00_axi_0_bready(m00_axi_0_bready),
        .m00_axi_0_bresp(m00_axi_0_bresp),
        .m00_axi_0_buser(m00_axi_0_buser),
        .m00_axi_0_bvalid(m00_axi_0_bvalid),
        .m00_axi_0_rdata(m00_axi_0_rdata),
        .m00_axi_0_rid(m00_axi_0_rid),
        .m00_axi_0_rlast(m00_axi_0_rlast),
        .m00_axi_0_rready(m00_axi_0_rready),
        .m00_axi_0_rresp(m00_axi_0_rresp),
        .m00_axi_0_ruser(m00_axi_0_ruser),
        .m00_axi_0_rvalid(m00_axi_0_rvalid),
        .m00_axi_0_wdata(m00_axi_0_wdata),
        .m00_axi_0_wlast(m00_axi_0_wlast),
        .m00_axi_0_wready(m00_axi_0_wready),
        .m00_axi_0_wstrb(m00_axi_0_wstrb),
        .m00_axi_0_wuser(m00_axi_0_wuser),
        .m00_axi_0_wvalid(m00_axi_0_wvalid),
        .reset(reset),
        .s00_axi_0_araddr(s00_axi_0_araddr),
        .s00_axi_0_arburst(s00_axi_0_arburst),
        .s00_axi_0_arcache(s00_axi_0_arcache),
        .s00_axi_0_arid(s00_axi_0_arid),
        .s00_axi_0_arlen(s00_axi_0_arlen),
        .s00_axi_0_arlock(s00_axi_0_arlock),
        .s00_axi_0_arprot(s00_axi_0_arprot),
        .s00_axi_0_arqos(s00_axi_0_arqos),
        .s00_axi_0_arready(s00_axi_0_arready),
        .s00_axi_0_arsize(s00_axi_0_arsize),
        .s00_axi_0_aruser(s00_axi_0_aruser),
        .s00_axi_0_arvalid(s00_axi_0_arvalid),
        .s00_axi_0_awaddr(s00_axi_0_awaddr),
        .s00_axi_0_awburst(s00_axi_0_awburst),
        .s00_axi_0_awcache(s00_axi_0_awcache),
        .s00_axi_0_awid(s00_axi_0_awid),
        .s00_axi_0_awlen(s00_axi_0_awlen),
        .s00_axi_0_awlock(s00_axi_0_awlock),
        .s00_axi_0_awprot(s00_axi_0_awprot),
        .s00_axi_0_awqos(s00_axi_0_awqos),
        .s00_axi_0_awready(s00_axi_0_awready),
        .s00_axi_0_awsize(s00_axi_0_awsize),
        .s00_axi_0_awuser(s00_axi_0_awuser),
        .s00_axi_0_awvalid(s00_axi_0_awvalid),
        .s00_axi_0_bid(s00_axi_0_bid),
        .s00_axi_0_bready(s00_axi_0_bready),
        .s00_axi_0_bresp(s00_axi_0_bresp),
        .s00_axi_0_buser(s00_axi_0_buser),
        .s00_axi_0_bvalid(s00_axi_0_bvalid),
        .s00_axi_0_rdata(s00_axi_0_rdata),
        .s00_axi_0_rid(s00_axi_0_rid),
        .s00_axi_0_rlast(s00_axi_0_rlast),
        .s00_axi_0_rready(s00_axi_0_rready),
        .s00_axi_0_rresp(s00_axi_0_rresp),
        .s00_axi_0_ruser(s00_axi_0_ruser),
        .s00_axi_0_rvalid(s00_axi_0_rvalid),
        .s00_axi_0_wdata(s00_axi_0_wdata),
        .s00_axi_0_wlast(s00_axi_0_wlast),
        .s00_axi_0_wready(s00_axi_0_wready),
        .s00_axi_0_wstrb(s00_axi_0_wstrb),
        .s00_axi_0_wuser(s00_axi_0_wuser),
        .s00_axi_0_wvalid(s00_axi_0_wvalid));
endmodule
