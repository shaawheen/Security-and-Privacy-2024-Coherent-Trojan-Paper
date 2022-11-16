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


#include "design_1_zynq_ultra_ps_e_0_0_sc.h"

#include "design_1_zynq_ultra_ps_e_0_0.h"

#include "zynq_ultra_ps_e_tlm.h"

#include <map>
#include <string>





#ifdef XILINX_SIMULATOR
design_1_zynq_ultra_ps_e_0_0::design_1_zynq_ultra_ps_e_0_0(const sc_core::sc_module_name& nm) : design_1_zynq_ultra_ps_e_0_0_sc(nm), maxihpm0_fpd_aclk("maxihpm0_fpd_aclk"), maxigp0_awid("maxigp0_awid"), maxigp0_awaddr("maxigp0_awaddr"), maxigp0_awlen("maxigp0_awlen"), maxigp0_awsize("maxigp0_awsize"), maxigp0_awburst("maxigp0_awburst"), maxigp0_awlock("maxigp0_awlock"), maxigp0_awcache("maxigp0_awcache"), maxigp0_awprot("maxigp0_awprot"), maxigp0_awvalid("maxigp0_awvalid"), maxigp0_awuser("maxigp0_awuser"), maxigp0_awready("maxigp0_awready"), maxigp0_wdata("maxigp0_wdata"), maxigp0_wstrb("maxigp0_wstrb"), maxigp0_wlast("maxigp0_wlast"), maxigp0_wvalid("maxigp0_wvalid"), maxigp0_wready("maxigp0_wready"), maxigp0_bid("maxigp0_bid"), maxigp0_bresp("maxigp0_bresp"), maxigp0_bvalid("maxigp0_bvalid"), maxigp0_bready("maxigp0_bready"), maxigp0_arid("maxigp0_arid"), maxigp0_araddr("maxigp0_araddr"), maxigp0_arlen("maxigp0_arlen"), maxigp0_arsize("maxigp0_arsize"), maxigp0_arburst("maxigp0_arburst"), maxigp0_arlock("maxigp0_arlock"), maxigp0_arcache("maxigp0_arcache"), maxigp0_arprot("maxigp0_arprot"), maxigp0_arvalid("maxigp0_arvalid"), maxigp0_aruser("maxigp0_aruser"), maxigp0_arready("maxigp0_arready"), maxigp0_rid("maxigp0_rid"), maxigp0_rdata("maxigp0_rdata"), maxigp0_rresp("maxigp0_rresp"), maxigp0_rlast("maxigp0_rlast"), maxigp0_rvalid("maxigp0_rvalid"), maxigp0_rready("maxigp0_rready"), maxigp0_awqos("maxigp0_awqos"), maxigp0_arqos("maxigp0_arqos"), maxihpm0_lpd_aclk("maxihpm0_lpd_aclk"), maxigp2_awid("maxigp2_awid"), maxigp2_awaddr("maxigp2_awaddr"), maxigp2_awlen("maxigp2_awlen"), maxigp2_awsize("maxigp2_awsize"), maxigp2_awburst("maxigp2_awburst"), maxigp2_awlock("maxigp2_awlock"), maxigp2_awcache("maxigp2_awcache"), maxigp2_awprot("maxigp2_awprot"), maxigp2_awvalid("maxigp2_awvalid"), maxigp2_awuser("maxigp2_awuser"), maxigp2_awready("maxigp2_awready"), maxigp2_wdata("maxigp2_wdata"), maxigp2_wstrb("maxigp2_wstrb"), maxigp2_wlast("maxigp2_wlast"), maxigp2_wvalid("maxigp2_wvalid"), maxigp2_wready("maxigp2_wready"), maxigp2_bid("maxigp2_bid"), maxigp2_bresp("maxigp2_bresp"), maxigp2_bvalid("maxigp2_bvalid"), maxigp2_bready("maxigp2_bready"), maxigp2_arid("maxigp2_arid"), maxigp2_araddr("maxigp2_araddr"), maxigp2_arlen("maxigp2_arlen"), maxigp2_arsize("maxigp2_arsize"), maxigp2_arburst("maxigp2_arburst"), maxigp2_arlock("maxigp2_arlock"), maxigp2_arcache("maxigp2_arcache"), maxigp2_arprot("maxigp2_arprot"), maxigp2_arvalid("maxigp2_arvalid"), maxigp2_aruser("maxigp2_aruser"), maxigp2_arready("maxigp2_arready"), maxigp2_rid("maxigp2_rid"), maxigp2_rdata("maxigp2_rdata"), maxigp2_rresp("maxigp2_rresp"), maxigp2_rlast("maxigp2_rlast"), maxigp2_rvalid("maxigp2_rvalid"), maxigp2_rready("maxigp2_rready"), maxigp2_awqos("maxigp2_awqos"), maxigp2_arqos("maxigp2_arqos"), saxihpc0_fpd_aclk("saxihpc0_fpd_aclk"), saxigp0_aruser("saxigp0_aruser"), saxigp0_awuser("saxigp0_awuser"), saxigp0_awid("saxigp0_awid"), saxigp0_awaddr("saxigp0_awaddr"), saxigp0_awlen("saxigp0_awlen"), saxigp0_awsize("saxigp0_awsize"), saxigp0_awburst("saxigp0_awburst"), saxigp0_awlock("saxigp0_awlock"), saxigp0_awcache("saxigp0_awcache"), saxigp0_awprot("saxigp0_awprot"), saxigp0_awvalid("saxigp0_awvalid"), saxigp0_awready("saxigp0_awready"), saxigp0_wdata("saxigp0_wdata"), saxigp0_wstrb("saxigp0_wstrb"), saxigp0_wlast("saxigp0_wlast"), saxigp0_wvalid("saxigp0_wvalid"), saxigp0_wready("saxigp0_wready"), saxigp0_bid("saxigp0_bid"), saxigp0_bresp("saxigp0_bresp"), saxigp0_bvalid("saxigp0_bvalid"), saxigp0_bready("saxigp0_bready"), saxigp0_arid("saxigp0_arid"), saxigp0_araddr("saxigp0_araddr"), saxigp0_arlen("saxigp0_arlen"), saxigp0_arsize("saxigp0_arsize"), saxigp0_arburst("saxigp0_arburst"), saxigp0_arlock("saxigp0_arlock"), saxigp0_arcache("saxigp0_arcache"), saxigp0_arprot("saxigp0_arprot"), saxigp0_arvalid("saxigp0_arvalid"), saxigp0_arready("saxigp0_arready"), saxigp0_rid("saxigp0_rid"), saxigp0_rdata("saxigp0_rdata"), saxigp0_rresp("saxigp0_rresp"), saxigp0_rlast("saxigp0_rlast"), saxigp0_rvalid("saxigp0_rvalid"), saxigp0_rready("saxigp0_rready"), saxigp0_awqos("saxigp0_awqos"), saxigp0_arqos("saxigp0_arqos"), sacefpd_aclk("sacefpd_aclk"), sacefpd_wuser("sacefpd_wuser"), sacefpd_buser("sacefpd_buser"), sacefpd_ruser("sacefpd_ruser"), sacefpd_awuser("sacefpd_awuser"), sacefpd_awsnoop("sacefpd_awsnoop"), sacefpd_awsize("sacefpd_awsize"), sacefpd_awregion("sacefpd_awregion"), sacefpd_awqos("sacefpd_awqos"), sacefpd_awprot("sacefpd_awprot"), sacefpd_awlen("sacefpd_awlen"), sacefpd_awid("sacefpd_awid"), sacefpd_awdomain("sacefpd_awdomain"), sacefpd_awcache("sacefpd_awcache"), sacefpd_awburst("sacefpd_awburst"), sacefpd_awbar("sacefpd_awbar"), sacefpd_awaddr("sacefpd_awaddr"), sacefpd_awlock("sacefpd_awlock"), sacefpd_awvalid("sacefpd_awvalid"), sacefpd_awready("sacefpd_awready"), sacefpd_wstrb("sacefpd_wstrb"), sacefpd_wdata("sacefpd_wdata"), sacefpd_wlast("sacefpd_wlast"), sacefpd_wvalid("sacefpd_wvalid"), sacefpd_wready("sacefpd_wready"), sacefpd_bresp("sacefpd_bresp"), sacefpd_bid("sacefpd_bid"), sacefpd_bvalid("sacefpd_bvalid"), sacefpd_bready("sacefpd_bready"), sacefpd_aruser("sacefpd_aruser"), sacefpd_arsnoop("sacefpd_arsnoop"), sacefpd_arsize("sacefpd_arsize"), sacefpd_arregion("sacefpd_arregion"), sacefpd_arqos("sacefpd_arqos"), sacefpd_arprot("sacefpd_arprot"), sacefpd_arlen("sacefpd_arlen"), sacefpd_arid("sacefpd_arid"), sacefpd_ardomain("sacefpd_ardomain"), sacefpd_arcache("sacefpd_arcache"), sacefpd_arburst("sacefpd_arburst"), sacefpd_arbar("sacefpd_arbar"), sacefpd_araddr("sacefpd_araddr"), sacefpd_arlock("sacefpd_arlock"), sacefpd_arvalid("sacefpd_arvalid"), sacefpd_arready("sacefpd_arready"), sacefpd_rresp("sacefpd_rresp"), sacefpd_rid("sacefpd_rid"), sacefpd_rdata("sacefpd_rdata"), sacefpd_rlast("sacefpd_rlast"), sacefpd_rvalid("sacefpd_rvalid"), sacefpd_rready("sacefpd_rready"), sacefpd_acsnoop("sacefpd_acsnoop"), sacefpd_acprot("sacefpd_acprot"), sacefpd_acaddr("sacefpd_acaddr"), sacefpd_acvalid("sacefpd_acvalid"), sacefpd_acready("sacefpd_acready"), sacefpd_cddata("sacefpd_cddata"), sacefpd_cdlast("sacefpd_cdlast"), sacefpd_cdvalid("sacefpd_cdvalid"), sacefpd_cdready("sacefpd_cdready"), sacefpd_crresp("sacefpd_crresp"), sacefpd_crvalid("sacefpd_crvalid"), sacefpd_crready("sacefpd_crready"), sacefpd_wack("sacefpd_wack"), sacefpd_rack("sacefpd_rack"), pl_ps_irq0("pl_ps_irq0"), pl_resetn0("pl_resetn0"), pl_clk0("pl_clk0")
{

  // initialize pins
  mp_impl->maxihpm0_fpd_aclk(maxihpm0_fpd_aclk);
  mp_impl->maxihpm0_lpd_aclk(maxihpm0_lpd_aclk);
  mp_impl->saxihpc0_fpd_aclk(saxihpc0_fpd_aclk);
  mp_impl->sacefpd_aclk(sacefpd_aclk);
  mp_impl->sacefpd_wuser(sacefpd_wuser);
  mp_impl->sacefpd_buser(sacefpd_buser);
  mp_impl->sacefpd_ruser(sacefpd_ruser);
  mp_impl->sacefpd_awuser(sacefpd_awuser);
  mp_impl->sacefpd_awsnoop(sacefpd_awsnoop);
  mp_impl->sacefpd_awsize(sacefpd_awsize);
  mp_impl->sacefpd_awregion(sacefpd_awregion);
  mp_impl->sacefpd_awqos(sacefpd_awqos);
  mp_impl->sacefpd_awprot(sacefpd_awprot);
  mp_impl->sacefpd_awlen(sacefpd_awlen);
  mp_impl->sacefpd_awid(sacefpd_awid);
  mp_impl->sacefpd_awdomain(sacefpd_awdomain);
  mp_impl->sacefpd_awcache(sacefpd_awcache);
  mp_impl->sacefpd_awburst(sacefpd_awburst);
  mp_impl->sacefpd_awbar(sacefpd_awbar);
  mp_impl->sacefpd_awaddr(sacefpd_awaddr);
  mp_impl->sacefpd_awlock(sacefpd_awlock);
  mp_impl->sacefpd_awvalid(sacefpd_awvalid);
  mp_impl->sacefpd_awready(sacefpd_awready);
  mp_impl->sacefpd_wstrb(sacefpd_wstrb);
  mp_impl->sacefpd_wdata(sacefpd_wdata);
  mp_impl->sacefpd_wlast(sacefpd_wlast);
  mp_impl->sacefpd_wvalid(sacefpd_wvalid);
  mp_impl->sacefpd_wready(sacefpd_wready);
  mp_impl->sacefpd_bresp(sacefpd_bresp);
  mp_impl->sacefpd_bid(sacefpd_bid);
  mp_impl->sacefpd_bvalid(sacefpd_bvalid);
  mp_impl->sacefpd_bready(sacefpd_bready);
  mp_impl->sacefpd_aruser(sacefpd_aruser);
  mp_impl->sacefpd_arsnoop(sacefpd_arsnoop);
  mp_impl->sacefpd_arsize(sacefpd_arsize);
  mp_impl->sacefpd_arregion(sacefpd_arregion);
  mp_impl->sacefpd_arqos(sacefpd_arqos);
  mp_impl->sacefpd_arprot(sacefpd_arprot);
  mp_impl->sacefpd_arlen(sacefpd_arlen);
  mp_impl->sacefpd_arid(sacefpd_arid);
  mp_impl->sacefpd_ardomain(sacefpd_ardomain);
  mp_impl->sacefpd_arcache(sacefpd_arcache);
  mp_impl->sacefpd_arburst(sacefpd_arburst);
  mp_impl->sacefpd_arbar(sacefpd_arbar);
  mp_impl->sacefpd_araddr(sacefpd_araddr);
  mp_impl->sacefpd_arlock(sacefpd_arlock);
  mp_impl->sacefpd_arvalid(sacefpd_arvalid);
  mp_impl->sacefpd_arready(sacefpd_arready);
  mp_impl->sacefpd_rresp(sacefpd_rresp);
  mp_impl->sacefpd_rid(sacefpd_rid);
  mp_impl->sacefpd_rdata(sacefpd_rdata);
  mp_impl->sacefpd_rlast(sacefpd_rlast);
  mp_impl->sacefpd_rvalid(sacefpd_rvalid);
  mp_impl->sacefpd_rready(sacefpd_rready);
  mp_impl->sacefpd_acsnoop(sacefpd_acsnoop);
  mp_impl->sacefpd_acprot(sacefpd_acprot);
  mp_impl->sacefpd_acaddr(sacefpd_acaddr);
  mp_impl->sacefpd_acvalid(sacefpd_acvalid);
  mp_impl->sacefpd_acready(sacefpd_acready);
  mp_impl->sacefpd_cddata(sacefpd_cddata);
  mp_impl->sacefpd_cdlast(sacefpd_cdlast);
  mp_impl->sacefpd_cdvalid(sacefpd_cdvalid);
  mp_impl->sacefpd_cdready(sacefpd_cdready);
  mp_impl->sacefpd_crresp(sacefpd_crresp);
  mp_impl->sacefpd_crvalid(sacefpd_crvalid);
  mp_impl->sacefpd_crready(sacefpd_crready);
  mp_impl->sacefpd_wack(sacefpd_wack);
  mp_impl->sacefpd_rack(sacefpd_rack);
  mp_impl->pl_ps_irq0(pl_ps_irq0);
  mp_impl->pl_resetn0(pl_resetn0);
  mp_impl->pl_clk0(pl_clk0);

  // initialize transactors
  mp_M_AXI_HPM0_FPD_transactor = NULL;
  mp_M_AXI_HPM0_LPD_transactor = NULL;
  mp_S_AXI_HPC0_FPD_transactor = NULL;
  mp_saxigp0_aruser_converter = NULL;
  mp_saxigp0_awuser_converter = NULL;

  // initialize socket stubs

}

void design_1_zynq_ultra_ps_e_0_0::before_end_of_elaboration()
{
  // configure 'M_AXI_HPM0_FPD' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "M_AXI_HPM0_FPD_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'M_AXI_HPM0_FPD' transactor parameters
    xsc::common_cpp::properties M_AXI_HPM0_FPD_transactor_param_props;
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "8");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "8");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ID_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ADDR_WIDTH", "40");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("AWUSER_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ARUSER_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_BURST", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_LOCK", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_PROT", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_CACHE", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_QOS", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_REGION", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_BRESP", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_RRESP", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_READ_THREADS", "4");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "4");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_SIZE", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_RESET", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXI_HPM0_FPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    M_AXI_HPM0_FPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    M_AXI_HPM0_FPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_M_AXI_HPM0_FPD_transactor = new xtlm::xaximm_xtlm2pin_t<128,40,16,16,1,1,16,1>("M_AXI_HPM0_FPD_transactor", M_AXI_HPM0_FPD_transactor_param_props);

    // M_AXI_HPM0_FPD' transactor ports

    mp_M_AXI_HPM0_FPD_transactor->AWID(maxigp0_awid);
    mp_M_AXI_HPM0_FPD_transactor->AWADDR(maxigp0_awaddr);
    mp_M_AXI_HPM0_FPD_transactor->AWLEN(maxigp0_awlen);
    mp_M_AXI_HPM0_FPD_transactor->AWSIZE(maxigp0_awsize);
    mp_M_AXI_HPM0_FPD_transactor->AWBURST(maxigp0_awburst);
    mp_M_AXI_HPM0_FPD_transactor->AWLOCK(maxigp0_awlock);
    mp_M_AXI_HPM0_FPD_transactor->AWCACHE(maxigp0_awcache);
    mp_M_AXI_HPM0_FPD_transactor->AWPROT(maxigp0_awprot);
    mp_M_AXI_HPM0_FPD_transactor->AWVALID(maxigp0_awvalid);
    mp_M_AXI_HPM0_FPD_transactor->AWUSER(maxigp0_awuser);
    mp_M_AXI_HPM0_FPD_transactor->AWREADY(maxigp0_awready);
    mp_M_AXI_HPM0_FPD_transactor->WDATA(maxigp0_wdata);
    mp_M_AXI_HPM0_FPD_transactor->WSTRB(maxigp0_wstrb);
    mp_M_AXI_HPM0_FPD_transactor->WLAST(maxigp0_wlast);
    mp_M_AXI_HPM0_FPD_transactor->WVALID(maxigp0_wvalid);
    mp_M_AXI_HPM0_FPD_transactor->WREADY(maxigp0_wready);
    mp_M_AXI_HPM0_FPD_transactor->BID(maxigp0_bid);
    mp_M_AXI_HPM0_FPD_transactor->BRESP(maxigp0_bresp);
    mp_M_AXI_HPM0_FPD_transactor->BVALID(maxigp0_bvalid);
    mp_M_AXI_HPM0_FPD_transactor->BREADY(maxigp0_bready);
    mp_M_AXI_HPM0_FPD_transactor->ARID(maxigp0_arid);
    mp_M_AXI_HPM0_FPD_transactor->ARADDR(maxigp0_araddr);
    mp_M_AXI_HPM0_FPD_transactor->ARLEN(maxigp0_arlen);
    mp_M_AXI_HPM0_FPD_transactor->ARSIZE(maxigp0_arsize);
    mp_M_AXI_HPM0_FPD_transactor->ARBURST(maxigp0_arburst);
    mp_M_AXI_HPM0_FPD_transactor->ARLOCK(maxigp0_arlock);
    mp_M_AXI_HPM0_FPD_transactor->ARCACHE(maxigp0_arcache);
    mp_M_AXI_HPM0_FPD_transactor->ARPROT(maxigp0_arprot);
    mp_M_AXI_HPM0_FPD_transactor->ARVALID(maxigp0_arvalid);
    mp_M_AXI_HPM0_FPD_transactor->ARUSER(maxigp0_aruser);
    mp_M_AXI_HPM0_FPD_transactor->ARREADY(maxigp0_arready);
    mp_M_AXI_HPM0_FPD_transactor->RID(maxigp0_rid);
    mp_M_AXI_HPM0_FPD_transactor->RDATA(maxigp0_rdata);
    mp_M_AXI_HPM0_FPD_transactor->RRESP(maxigp0_rresp);
    mp_M_AXI_HPM0_FPD_transactor->RLAST(maxigp0_rlast);
    mp_M_AXI_HPM0_FPD_transactor->RVALID(maxigp0_rvalid);
    mp_M_AXI_HPM0_FPD_transactor->RREADY(maxigp0_rready);
    mp_M_AXI_HPM0_FPD_transactor->AWQOS(maxigp0_awqos);
    mp_M_AXI_HPM0_FPD_transactor->ARQOS(maxigp0_arqos);
    mp_M_AXI_HPM0_FPD_transactor->CLK(maxihpm0_fpd_aclk);
    m_M_AXI_HPM0_FPD_transactor_rst_signal.write(1);
    mp_M_AXI_HPM0_FPD_transactor->RST(m_M_AXI_HPM0_FPD_transactor_rst_signal);

    // M_AXI_HPM0_FPD' transactor sockets

    mp_impl->M_AXI_HPM0_FPD_rd_socket->bind(*(mp_M_AXI_HPM0_FPD_transactor->rd_socket));
    mp_impl->M_AXI_HPM0_FPD_wr_socket->bind(*(mp_M_AXI_HPM0_FPD_transactor->wr_socket));
  }
  else
  {
  }

  // configure 'M_AXI_HPM0_LPD' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "M_AXI_HPM0_LPD_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'M_AXI_HPM0_LPD' transactor parameters
    xsc::common_cpp::properties M_AXI_HPM0_LPD_transactor_param_props;
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "8");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "8");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ID_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ADDR_WIDTH", "40");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("AWUSER_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ARUSER_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_BURST", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_LOCK", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_PROT", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_CACHE", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_QOS", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_REGION", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_BRESP", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_RRESP", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_READ_THREADS", "4");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "4");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_SIZE", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_RESET", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXI_HPM0_LPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    M_AXI_HPM0_LPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    M_AXI_HPM0_LPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_M_AXI_HPM0_LPD_transactor = new xtlm::xaximm_xtlm2pin_t<128,40,16,16,1,1,16,1>("M_AXI_HPM0_LPD_transactor", M_AXI_HPM0_LPD_transactor_param_props);

    // M_AXI_HPM0_LPD' transactor ports

    mp_M_AXI_HPM0_LPD_transactor->AWID(maxigp2_awid);
    mp_M_AXI_HPM0_LPD_transactor->AWADDR(maxigp2_awaddr);
    mp_M_AXI_HPM0_LPD_transactor->AWLEN(maxigp2_awlen);
    mp_M_AXI_HPM0_LPD_transactor->AWSIZE(maxigp2_awsize);
    mp_M_AXI_HPM0_LPD_transactor->AWBURST(maxigp2_awburst);
    mp_M_AXI_HPM0_LPD_transactor->AWLOCK(maxigp2_awlock);
    mp_M_AXI_HPM0_LPD_transactor->AWCACHE(maxigp2_awcache);
    mp_M_AXI_HPM0_LPD_transactor->AWPROT(maxigp2_awprot);
    mp_M_AXI_HPM0_LPD_transactor->AWVALID(maxigp2_awvalid);
    mp_M_AXI_HPM0_LPD_transactor->AWUSER(maxigp2_awuser);
    mp_M_AXI_HPM0_LPD_transactor->AWREADY(maxigp2_awready);
    mp_M_AXI_HPM0_LPD_transactor->WDATA(maxigp2_wdata);
    mp_M_AXI_HPM0_LPD_transactor->WSTRB(maxigp2_wstrb);
    mp_M_AXI_HPM0_LPD_transactor->WLAST(maxigp2_wlast);
    mp_M_AXI_HPM0_LPD_transactor->WVALID(maxigp2_wvalid);
    mp_M_AXI_HPM0_LPD_transactor->WREADY(maxigp2_wready);
    mp_M_AXI_HPM0_LPD_transactor->BID(maxigp2_bid);
    mp_M_AXI_HPM0_LPD_transactor->BRESP(maxigp2_bresp);
    mp_M_AXI_HPM0_LPD_transactor->BVALID(maxigp2_bvalid);
    mp_M_AXI_HPM0_LPD_transactor->BREADY(maxigp2_bready);
    mp_M_AXI_HPM0_LPD_transactor->ARID(maxigp2_arid);
    mp_M_AXI_HPM0_LPD_transactor->ARADDR(maxigp2_araddr);
    mp_M_AXI_HPM0_LPD_transactor->ARLEN(maxigp2_arlen);
    mp_M_AXI_HPM0_LPD_transactor->ARSIZE(maxigp2_arsize);
    mp_M_AXI_HPM0_LPD_transactor->ARBURST(maxigp2_arburst);
    mp_M_AXI_HPM0_LPD_transactor->ARLOCK(maxigp2_arlock);
    mp_M_AXI_HPM0_LPD_transactor->ARCACHE(maxigp2_arcache);
    mp_M_AXI_HPM0_LPD_transactor->ARPROT(maxigp2_arprot);
    mp_M_AXI_HPM0_LPD_transactor->ARVALID(maxigp2_arvalid);
    mp_M_AXI_HPM0_LPD_transactor->ARUSER(maxigp2_aruser);
    mp_M_AXI_HPM0_LPD_transactor->ARREADY(maxigp2_arready);
    mp_M_AXI_HPM0_LPD_transactor->RID(maxigp2_rid);
    mp_M_AXI_HPM0_LPD_transactor->RDATA(maxigp2_rdata);
    mp_M_AXI_HPM0_LPD_transactor->RRESP(maxigp2_rresp);
    mp_M_AXI_HPM0_LPD_transactor->RLAST(maxigp2_rlast);
    mp_M_AXI_HPM0_LPD_transactor->RVALID(maxigp2_rvalid);
    mp_M_AXI_HPM0_LPD_transactor->RREADY(maxigp2_rready);
    mp_M_AXI_HPM0_LPD_transactor->AWQOS(maxigp2_awqos);
    mp_M_AXI_HPM0_LPD_transactor->ARQOS(maxigp2_arqos);
    mp_M_AXI_HPM0_LPD_transactor->CLK(maxihpm0_lpd_aclk);
    m_M_AXI_HPM0_LPD_transactor_rst_signal.write(1);
    mp_M_AXI_HPM0_LPD_transactor->RST(m_M_AXI_HPM0_LPD_transactor_rst_signal);

    // M_AXI_HPM0_LPD' transactor sockets

    mp_impl->M_AXI_HPM0_LPD_rd_socket->bind(*(mp_M_AXI_HPM0_LPD_transactor->rd_socket));
    mp_impl->M_AXI_HPM0_LPD_wr_socket->bind(*(mp_M_AXI_HPM0_LPD_transactor->wr_socket));
  }
  else
  {
  }

  // configure 'S_AXI_HPC0_FPD' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "S_AXI_HPC0_FPD_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'S_AXI_HPC0_FPD' transactor parameters
    xsc::common_cpp::properties S_AXI_HPC0_FPD_transactor_param_props;
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "16");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "16");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ID_WIDTH", "6");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ADDR_WIDTH", "49");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("AWUSER_WIDTH", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ARUSER_WIDTH", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_BURST", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_LOCK", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_PROT", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_CACHE", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_QOS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_REGION", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_BRESP", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_RRESP", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_READ_THREADS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_SIZE", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_RESET", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addFloat("PHASE", "0.0");
    S_AXI_HPC0_FPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    S_AXI_HPC0_FPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    S_AXI_HPC0_FPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_S_AXI_HPC0_FPD_transactor = new xtlm::xaximm_pin2xtlm_t<128,49,6,1,1,1,1,1>("S_AXI_HPC0_FPD_transactor", S_AXI_HPC0_FPD_transactor_param_props);

    // S_AXI_HPC0_FPD' transactor ports

    mp_saxigp0_aruser_converter = new xsc::common::scalar2vectorN_converter<1>("saxigp0_aruser_converter");
    mp_saxigp0_aruser_converter->scalar_in(saxigp0_aruser);
    mp_saxigp0_aruser_converter->vector_out(m_saxigp0_aruser_converter_signal);
    mp_S_AXI_HPC0_FPD_transactor->ARUSER(m_saxigp0_aruser_converter_signal);
    mp_saxigp0_awuser_converter = new xsc::common::scalar2vectorN_converter<1>("saxigp0_awuser_converter");
    mp_saxigp0_awuser_converter->scalar_in(saxigp0_awuser);
    mp_saxigp0_awuser_converter->vector_out(m_saxigp0_awuser_converter_signal);
    mp_S_AXI_HPC0_FPD_transactor->AWUSER(m_saxigp0_awuser_converter_signal);
    mp_S_AXI_HPC0_FPD_transactor->AWID(saxigp0_awid);
    mp_S_AXI_HPC0_FPD_transactor->AWADDR(saxigp0_awaddr);
    mp_S_AXI_HPC0_FPD_transactor->AWLEN(saxigp0_awlen);
    mp_S_AXI_HPC0_FPD_transactor->AWSIZE(saxigp0_awsize);
    mp_S_AXI_HPC0_FPD_transactor->AWBURST(saxigp0_awburst);
    mp_S_AXI_HPC0_FPD_transactor->AWLOCK(saxigp0_awlock);
    mp_S_AXI_HPC0_FPD_transactor->AWCACHE(saxigp0_awcache);
    mp_S_AXI_HPC0_FPD_transactor->AWPROT(saxigp0_awprot);
    mp_S_AXI_HPC0_FPD_transactor->AWVALID(saxigp0_awvalid);
    mp_S_AXI_HPC0_FPD_transactor->AWREADY(saxigp0_awready);
    mp_S_AXI_HPC0_FPD_transactor->WDATA(saxigp0_wdata);
    mp_S_AXI_HPC0_FPD_transactor->WSTRB(saxigp0_wstrb);
    mp_S_AXI_HPC0_FPD_transactor->WLAST(saxigp0_wlast);
    mp_S_AXI_HPC0_FPD_transactor->WVALID(saxigp0_wvalid);
    mp_S_AXI_HPC0_FPD_transactor->WREADY(saxigp0_wready);
    mp_S_AXI_HPC0_FPD_transactor->BID(saxigp0_bid);
    mp_S_AXI_HPC0_FPD_transactor->BRESP(saxigp0_bresp);
    mp_S_AXI_HPC0_FPD_transactor->BVALID(saxigp0_bvalid);
    mp_S_AXI_HPC0_FPD_transactor->BREADY(saxigp0_bready);
    mp_S_AXI_HPC0_FPD_transactor->ARID(saxigp0_arid);
    mp_S_AXI_HPC0_FPD_transactor->ARADDR(saxigp0_araddr);
    mp_S_AXI_HPC0_FPD_transactor->ARLEN(saxigp0_arlen);
    mp_S_AXI_HPC0_FPD_transactor->ARSIZE(saxigp0_arsize);
    mp_S_AXI_HPC0_FPD_transactor->ARBURST(saxigp0_arburst);
    mp_S_AXI_HPC0_FPD_transactor->ARLOCK(saxigp0_arlock);
    mp_S_AXI_HPC0_FPD_transactor->ARCACHE(saxigp0_arcache);
    mp_S_AXI_HPC0_FPD_transactor->ARPROT(saxigp0_arprot);
    mp_S_AXI_HPC0_FPD_transactor->ARVALID(saxigp0_arvalid);
    mp_S_AXI_HPC0_FPD_transactor->ARREADY(saxigp0_arready);
    mp_S_AXI_HPC0_FPD_transactor->RID(saxigp0_rid);
    mp_S_AXI_HPC0_FPD_transactor->RDATA(saxigp0_rdata);
    mp_S_AXI_HPC0_FPD_transactor->RRESP(saxigp0_rresp);
    mp_S_AXI_HPC0_FPD_transactor->RLAST(saxigp0_rlast);
    mp_S_AXI_HPC0_FPD_transactor->RVALID(saxigp0_rvalid);
    mp_S_AXI_HPC0_FPD_transactor->RREADY(saxigp0_rready);
    mp_S_AXI_HPC0_FPD_transactor->AWQOS(saxigp0_awqos);
    mp_S_AXI_HPC0_FPD_transactor->ARQOS(saxigp0_arqos);
    mp_S_AXI_HPC0_FPD_transactor->CLK(saxihpc0_fpd_aclk);
    m_S_AXI_HPC0_FPD_transactor_rst_signal.write(1);
    mp_S_AXI_HPC0_FPD_transactor->RST(m_S_AXI_HPC0_FPD_transactor_rst_signal);

    // S_AXI_HPC0_FPD' transactor sockets

    mp_impl->S_AXI_HPC0_FPD_rd_socket->bind(*(mp_S_AXI_HPC0_FPD_transactor->rd_socket));
    mp_impl->S_AXI_HPC0_FPD_wr_socket->bind(*(mp_S_AXI_HPC0_FPD_transactor->wr_socket));
  }
  else
  {
  }

}

#endif // XILINX_SIMULATOR




#ifdef XM_SYSTEMC
design_1_zynq_ultra_ps_e_0_0::design_1_zynq_ultra_ps_e_0_0(const sc_core::sc_module_name& nm) : design_1_zynq_ultra_ps_e_0_0_sc(nm), maxihpm0_fpd_aclk("maxihpm0_fpd_aclk"), maxigp0_awid("maxigp0_awid"), maxigp0_awaddr("maxigp0_awaddr"), maxigp0_awlen("maxigp0_awlen"), maxigp0_awsize("maxigp0_awsize"), maxigp0_awburst("maxigp0_awburst"), maxigp0_awlock("maxigp0_awlock"), maxigp0_awcache("maxigp0_awcache"), maxigp0_awprot("maxigp0_awprot"), maxigp0_awvalid("maxigp0_awvalid"), maxigp0_awuser("maxigp0_awuser"), maxigp0_awready("maxigp0_awready"), maxigp0_wdata("maxigp0_wdata"), maxigp0_wstrb("maxigp0_wstrb"), maxigp0_wlast("maxigp0_wlast"), maxigp0_wvalid("maxigp0_wvalid"), maxigp0_wready("maxigp0_wready"), maxigp0_bid("maxigp0_bid"), maxigp0_bresp("maxigp0_bresp"), maxigp0_bvalid("maxigp0_bvalid"), maxigp0_bready("maxigp0_bready"), maxigp0_arid("maxigp0_arid"), maxigp0_araddr("maxigp0_araddr"), maxigp0_arlen("maxigp0_arlen"), maxigp0_arsize("maxigp0_arsize"), maxigp0_arburst("maxigp0_arburst"), maxigp0_arlock("maxigp0_arlock"), maxigp0_arcache("maxigp0_arcache"), maxigp0_arprot("maxigp0_arprot"), maxigp0_arvalid("maxigp0_arvalid"), maxigp0_aruser("maxigp0_aruser"), maxigp0_arready("maxigp0_arready"), maxigp0_rid("maxigp0_rid"), maxigp0_rdata("maxigp0_rdata"), maxigp0_rresp("maxigp0_rresp"), maxigp0_rlast("maxigp0_rlast"), maxigp0_rvalid("maxigp0_rvalid"), maxigp0_rready("maxigp0_rready"), maxigp0_awqos("maxigp0_awqos"), maxigp0_arqos("maxigp0_arqos"), maxihpm0_lpd_aclk("maxihpm0_lpd_aclk"), maxigp2_awid("maxigp2_awid"), maxigp2_awaddr("maxigp2_awaddr"), maxigp2_awlen("maxigp2_awlen"), maxigp2_awsize("maxigp2_awsize"), maxigp2_awburst("maxigp2_awburst"), maxigp2_awlock("maxigp2_awlock"), maxigp2_awcache("maxigp2_awcache"), maxigp2_awprot("maxigp2_awprot"), maxigp2_awvalid("maxigp2_awvalid"), maxigp2_awuser("maxigp2_awuser"), maxigp2_awready("maxigp2_awready"), maxigp2_wdata("maxigp2_wdata"), maxigp2_wstrb("maxigp2_wstrb"), maxigp2_wlast("maxigp2_wlast"), maxigp2_wvalid("maxigp2_wvalid"), maxigp2_wready("maxigp2_wready"), maxigp2_bid("maxigp2_bid"), maxigp2_bresp("maxigp2_bresp"), maxigp2_bvalid("maxigp2_bvalid"), maxigp2_bready("maxigp2_bready"), maxigp2_arid("maxigp2_arid"), maxigp2_araddr("maxigp2_araddr"), maxigp2_arlen("maxigp2_arlen"), maxigp2_arsize("maxigp2_arsize"), maxigp2_arburst("maxigp2_arburst"), maxigp2_arlock("maxigp2_arlock"), maxigp2_arcache("maxigp2_arcache"), maxigp2_arprot("maxigp2_arprot"), maxigp2_arvalid("maxigp2_arvalid"), maxigp2_aruser("maxigp2_aruser"), maxigp2_arready("maxigp2_arready"), maxigp2_rid("maxigp2_rid"), maxigp2_rdata("maxigp2_rdata"), maxigp2_rresp("maxigp2_rresp"), maxigp2_rlast("maxigp2_rlast"), maxigp2_rvalid("maxigp2_rvalid"), maxigp2_rready("maxigp2_rready"), maxigp2_awqos("maxigp2_awqos"), maxigp2_arqos("maxigp2_arqos"), saxihpc0_fpd_aclk("saxihpc0_fpd_aclk"), saxigp0_aruser("saxigp0_aruser"), saxigp0_awuser("saxigp0_awuser"), saxigp0_awid("saxigp0_awid"), saxigp0_awaddr("saxigp0_awaddr"), saxigp0_awlen("saxigp0_awlen"), saxigp0_awsize("saxigp0_awsize"), saxigp0_awburst("saxigp0_awburst"), saxigp0_awlock("saxigp0_awlock"), saxigp0_awcache("saxigp0_awcache"), saxigp0_awprot("saxigp0_awprot"), saxigp0_awvalid("saxigp0_awvalid"), saxigp0_awready("saxigp0_awready"), saxigp0_wdata("saxigp0_wdata"), saxigp0_wstrb("saxigp0_wstrb"), saxigp0_wlast("saxigp0_wlast"), saxigp0_wvalid("saxigp0_wvalid"), saxigp0_wready("saxigp0_wready"), saxigp0_bid("saxigp0_bid"), saxigp0_bresp("saxigp0_bresp"), saxigp0_bvalid("saxigp0_bvalid"), saxigp0_bready("saxigp0_bready"), saxigp0_arid("saxigp0_arid"), saxigp0_araddr("saxigp0_araddr"), saxigp0_arlen("saxigp0_arlen"), saxigp0_arsize("saxigp0_arsize"), saxigp0_arburst("saxigp0_arburst"), saxigp0_arlock("saxigp0_arlock"), saxigp0_arcache("saxigp0_arcache"), saxigp0_arprot("saxigp0_arprot"), saxigp0_arvalid("saxigp0_arvalid"), saxigp0_arready("saxigp0_arready"), saxigp0_rid("saxigp0_rid"), saxigp0_rdata("saxigp0_rdata"), saxigp0_rresp("saxigp0_rresp"), saxigp0_rlast("saxigp0_rlast"), saxigp0_rvalid("saxigp0_rvalid"), saxigp0_rready("saxigp0_rready"), saxigp0_awqos("saxigp0_awqos"), saxigp0_arqos("saxigp0_arqos"), sacefpd_aclk("sacefpd_aclk"), sacefpd_wuser("sacefpd_wuser"), sacefpd_buser("sacefpd_buser"), sacefpd_ruser("sacefpd_ruser"), sacefpd_awuser("sacefpd_awuser"), sacefpd_awsnoop("sacefpd_awsnoop"), sacefpd_awsize("sacefpd_awsize"), sacefpd_awregion("sacefpd_awregion"), sacefpd_awqos("sacefpd_awqos"), sacefpd_awprot("sacefpd_awprot"), sacefpd_awlen("sacefpd_awlen"), sacefpd_awid("sacefpd_awid"), sacefpd_awdomain("sacefpd_awdomain"), sacefpd_awcache("sacefpd_awcache"), sacefpd_awburst("sacefpd_awburst"), sacefpd_awbar("sacefpd_awbar"), sacefpd_awaddr("sacefpd_awaddr"), sacefpd_awlock("sacefpd_awlock"), sacefpd_awvalid("sacefpd_awvalid"), sacefpd_awready("sacefpd_awready"), sacefpd_wstrb("sacefpd_wstrb"), sacefpd_wdata("sacefpd_wdata"), sacefpd_wlast("sacefpd_wlast"), sacefpd_wvalid("sacefpd_wvalid"), sacefpd_wready("sacefpd_wready"), sacefpd_bresp("sacefpd_bresp"), sacefpd_bid("sacefpd_bid"), sacefpd_bvalid("sacefpd_bvalid"), sacefpd_bready("sacefpd_bready"), sacefpd_aruser("sacefpd_aruser"), sacefpd_arsnoop("sacefpd_arsnoop"), sacefpd_arsize("sacefpd_arsize"), sacefpd_arregion("sacefpd_arregion"), sacefpd_arqos("sacefpd_arqos"), sacefpd_arprot("sacefpd_arprot"), sacefpd_arlen("sacefpd_arlen"), sacefpd_arid("sacefpd_arid"), sacefpd_ardomain("sacefpd_ardomain"), sacefpd_arcache("sacefpd_arcache"), sacefpd_arburst("sacefpd_arburst"), sacefpd_arbar("sacefpd_arbar"), sacefpd_araddr("sacefpd_araddr"), sacefpd_arlock("sacefpd_arlock"), sacefpd_arvalid("sacefpd_arvalid"), sacefpd_arready("sacefpd_arready"), sacefpd_rresp("sacefpd_rresp"), sacefpd_rid("sacefpd_rid"), sacefpd_rdata("sacefpd_rdata"), sacefpd_rlast("sacefpd_rlast"), sacefpd_rvalid("sacefpd_rvalid"), sacefpd_rready("sacefpd_rready"), sacefpd_acsnoop("sacefpd_acsnoop"), sacefpd_acprot("sacefpd_acprot"), sacefpd_acaddr("sacefpd_acaddr"), sacefpd_acvalid("sacefpd_acvalid"), sacefpd_acready("sacefpd_acready"), sacefpd_cddata("sacefpd_cddata"), sacefpd_cdlast("sacefpd_cdlast"), sacefpd_cdvalid("sacefpd_cdvalid"), sacefpd_cdready("sacefpd_cdready"), sacefpd_crresp("sacefpd_crresp"), sacefpd_crvalid("sacefpd_crvalid"), sacefpd_crready("sacefpd_crready"), sacefpd_wack("sacefpd_wack"), sacefpd_rack("sacefpd_rack"), pl_ps_irq0("pl_ps_irq0"), pl_resetn0("pl_resetn0"), pl_clk0("pl_clk0")
{

  // initialize pins
  mp_impl->maxihpm0_fpd_aclk(maxihpm0_fpd_aclk);
  mp_impl->maxihpm0_lpd_aclk(maxihpm0_lpd_aclk);
  mp_impl->saxihpc0_fpd_aclk(saxihpc0_fpd_aclk);
  mp_impl->sacefpd_aclk(sacefpd_aclk);
  mp_impl->sacefpd_wuser(sacefpd_wuser);
  mp_impl->sacefpd_buser(sacefpd_buser);
  mp_impl->sacefpd_ruser(sacefpd_ruser);
  mp_impl->sacefpd_awuser(sacefpd_awuser);
  mp_impl->sacefpd_awsnoop(sacefpd_awsnoop);
  mp_impl->sacefpd_awsize(sacefpd_awsize);
  mp_impl->sacefpd_awregion(sacefpd_awregion);
  mp_impl->sacefpd_awqos(sacefpd_awqos);
  mp_impl->sacefpd_awprot(sacefpd_awprot);
  mp_impl->sacefpd_awlen(sacefpd_awlen);
  mp_impl->sacefpd_awid(sacefpd_awid);
  mp_impl->sacefpd_awdomain(sacefpd_awdomain);
  mp_impl->sacefpd_awcache(sacefpd_awcache);
  mp_impl->sacefpd_awburst(sacefpd_awburst);
  mp_impl->sacefpd_awbar(sacefpd_awbar);
  mp_impl->sacefpd_awaddr(sacefpd_awaddr);
  mp_impl->sacefpd_awlock(sacefpd_awlock);
  mp_impl->sacefpd_awvalid(sacefpd_awvalid);
  mp_impl->sacefpd_awready(sacefpd_awready);
  mp_impl->sacefpd_wstrb(sacefpd_wstrb);
  mp_impl->sacefpd_wdata(sacefpd_wdata);
  mp_impl->sacefpd_wlast(sacefpd_wlast);
  mp_impl->sacefpd_wvalid(sacefpd_wvalid);
  mp_impl->sacefpd_wready(sacefpd_wready);
  mp_impl->sacefpd_bresp(sacefpd_bresp);
  mp_impl->sacefpd_bid(sacefpd_bid);
  mp_impl->sacefpd_bvalid(sacefpd_bvalid);
  mp_impl->sacefpd_bready(sacefpd_bready);
  mp_impl->sacefpd_aruser(sacefpd_aruser);
  mp_impl->sacefpd_arsnoop(sacefpd_arsnoop);
  mp_impl->sacefpd_arsize(sacefpd_arsize);
  mp_impl->sacefpd_arregion(sacefpd_arregion);
  mp_impl->sacefpd_arqos(sacefpd_arqos);
  mp_impl->sacefpd_arprot(sacefpd_arprot);
  mp_impl->sacefpd_arlen(sacefpd_arlen);
  mp_impl->sacefpd_arid(sacefpd_arid);
  mp_impl->sacefpd_ardomain(sacefpd_ardomain);
  mp_impl->sacefpd_arcache(sacefpd_arcache);
  mp_impl->sacefpd_arburst(sacefpd_arburst);
  mp_impl->sacefpd_arbar(sacefpd_arbar);
  mp_impl->sacefpd_araddr(sacefpd_araddr);
  mp_impl->sacefpd_arlock(sacefpd_arlock);
  mp_impl->sacefpd_arvalid(sacefpd_arvalid);
  mp_impl->sacefpd_arready(sacefpd_arready);
  mp_impl->sacefpd_rresp(sacefpd_rresp);
  mp_impl->sacefpd_rid(sacefpd_rid);
  mp_impl->sacefpd_rdata(sacefpd_rdata);
  mp_impl->sacefpd_rlast(sacefpd_rlast);
  mp_impl->sacefpd_rvalid(sacefpd_rvalid);
  mp_impl->sacefpd_rready(sacefpd_rready);
  mp_impl->sacefpd_acsnoop(sacefpd_acsnoop);
  mp_impl->sacefpd_acprot(sacefpd_acprot);
  mp_impl->sacefpd_acaddr(sacefpd_acaddr);
  mp_impl->sacefpd_acvalid(sacefpd_acvalid);
  mp_impl->sacefpd_acready(sacefpd_acready);
  mp_impl->sacefpd_cddata(sacefpd_cddata);
  mp_impl->sacefpd_cdlast(sacefpd_cdlast);
  mp_impl->sacefpd_cdvalid(sacefpd_cdvalid);
  mp_impl->sacefpd_cdready(sacefpd_cdready);
  mp_impl->sacefpd_crresp(sacefpd_crresp);
  mp_impl->sacefpd_crvalid(sacefpd_crvalid);
  mp_impl->sacefpd_crready(sacefpd_crready);
  mp_impl->sacefpd_wack(sacefpd_wack);
  mp_impl->sacefpd_rack(sacefpd_rack);
  mp_impl->pl_ps_irq0(pl_ps_irq0);
  mp_impl->pl_resetn0(pl_resetn0);
  mp_impl->pl_clk0(pl_clk0);

  // initialize transactors
  mp_M_AXI_HPM0_FPD_transactor = NULL;
  mp_M_AXI_HPM0_LPD_transactor = NULL;
  mp_S_AXI_HPC0_FPD_transactor = NULL;
  mp_saxigp0_aruser_converter = NULL;
  mp_saxigp0_awuser_converter = NULL;

  // initialize socket stubs

}

void design_1_zynq_ultra_ps_e_0_0::before_end_of_elaboration()
{
  // configure 'M_AXI_HPM0_FPD' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "M_AXI_HPM0_FPD_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'M_AXI_HPM0_FPD' transactor parameters
    xsc::common_cpp::properties M_AXI_HPM0_FPD_transactor_param_props;
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "8");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "8");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ID_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ADDR_WIDTH", "40");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("AWUSER_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ARUSER_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_BURST", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_LOCK", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_PROT", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_CACHE", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_QOS", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_REGION", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_BRESP", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_RRESP", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_READ_THREADS", "4");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "4");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_SIZE", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_RESET", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXI_HPM0_FPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    M_AXI_HPM0_FPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    M_AXI_HPM0_FPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_M_AXI_HPM0_FPD_transactor = new xtlm::xaximm_xtlm2pin_t<128,40,16,16,1,1,16,1>("M_AXI_HPM0_FPD_transactor", M_AXI_HPM0_FPD_transactor_param_props);

    // M_AXI_HPM0_FPD' transactor ports

    mp_M_AXI_HPM0_FPD_transactor->AWID(maxigp0_awid);
    mp_M_AXI_HPM0_FPD_transactor->AWADDR(maxigp0_awaddr);
    mp_M_AXI_HPM0_FPD_transactor->AWLEN(maxigp0_awlen);
    mp_M_AXI_HPM0_FPD_transactor->AWSIZE(maxigp0_awsize);
    mp_M_AXI_HPM0_FPD_transactor->AWBURST(maxigp0_awburst);
    mp_M_AXI_HPM0_FPD_transactor->AWLOCK(maxigp0_awlock);
    mp_M_AXI_HPM0_FPD_transactor->AWCACHE(maxigp0_awcache);
    mp_M_AXI_HPM0_FPD_transactor->AWPROT(maxigp0_awprot);
    mp_M_AXI_HPM0_FPD_transactor->AWVALID(maxigp0_awvalid);
    mp_M_AXI_HPM0_FPD_transactor->AWUSER(maxigp0_awuser);
    mp_M_AXI_HPM0_FPD_transactor->AWREADY(maxigp0_awready);
    mp_M_AXI_HPM0_FPD_transactor->WDATA(maxigp0_wdata);
    mp_M_AXI_HPM0_FPD_transactor->WSTRB(maxigp0_wstrb);
    mp_M_AXI_HPM0_FPD_transactor->WLAST(maxigp0_wlast);
    mp_M_AXI_HPM0_FPD_transactor->WVALID(maxigp0_wvalid);
    mp_M_AXI_HPM0_FPD_transactor->WREADY(maxigp0_wready);
    mp_M_AXI_HPM0_FPD_transactor->BID(maxigp0_bid);
    mp_M_AXI_HPM0_FPD_transactor->BRESP(maxigp0_bresp);
    mp_M_AXI_HPM0_FPD_transactor->BVALID(maxigp0_bvalid);
    mp_M_AXI_HPM0_FPD_transactor->BREADY(maxigp0_bready);
    mp_M_AXI_HPM0_FPD_transactor->ARID(maxigp0_arid);
    mp_M_AXI_HPM0_FPD_transactor->ARADDR(maxigp0_araddr);
    mp_M_AXI_HPM0_FPD_transactor->ARLEN(maxigp0_arlen);
    mp_M_AXI_HPM0_FPD_transactor->ARSIZE(maxigp0_arsize);
    mp_M_AXI_HPM0_FPD_transactor->ARBURST(maxigp0_arburst);
    mp_M_AXI_HPM0_FPD_transactor->ARLOCK(maxigp0_arlock);
    mp_M_AXI_HPM0_FPD_transactor->ARCACHE(maxigp0_arcache);
    mp_M_AXI_HPM0_FPD_transactor->ARPROT(maxigp0_arprot);
    mp_M_AXI_HPM0_FPD_transactor->ARVALID(maxigp0_arvalid);
    mp_M_AXI_HPM0_FPD_transactor->ARUSER(maxigp0_aruser);
    mp_M_AXI_HPM0_FPD_transactor->ARREADY(maxigp0_arready);
    mp_M_AXI_HPM0_FPD_transactor->RID(maxigp0_rid);
    mp_M_AXI_HPM0_FPD_transactor->RDATA(maxigp0_rdata);
    mp_M_AXI_HPM0_FPD_transactor->RRESP(maxigp0_rresp);
    mp_M_AXI_HPM0_FPD_transactor->RLAST(maxigp0_rlast);
    mp_M_AXI_HPM0_FPD_transactor->RVALID(maxigp0_rvalid);
    mp_M_AXI_HPM0_FPD_transactor->RREADY(maxigp0_rready);
    mp_M_AXI_HPM0_FPD_transactor->AWQOS(maxigp0_awqos);
    mp_M_AXI_HPM0_FPD_transactor->ARQOS(maxigp0_arqos);
    mp_M_AXI_HPM0_FPD_transactor->CLK(maxihpm0_fpd_aclk);
    m_M_AXI_HPM0_FPD_transactor_rst_signal.write(1);
    mp_M_AXI_HPM0_FPD_transactor->RST(m_M_AXI_HPM0_FPD_transactor_rst_signal);

    // M_AXI_HPM0_FPD' transactor sockets

    mp_impl->M_AXI_HPM0_FPD_rd_socket->bind(*(mp_M_AXI_HPM0_FPD_transactor->rd_socket));
    mp_impl->M_AXI_HPM0_FPD_wr_socket->bind(*(mp_M_AXI_HPM0_FPD_transactor->wr_socket));
  }
  else
  {
  }

  // configure 'M_AXI_HPM0_LPD' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "M_AXI_HPM0_LPD_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'M_AXI_HPM0_LPD' transactor parameters
    xsc::common_cpp::properties M_AXI_HPM0_LPD_transactor_param_props;
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "8");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "8");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ID_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ADDR_WIDTH", "40");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("AWUSER_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ARUSER_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_BURST", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_LOCK", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_PROT", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_CACHE", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_QOS", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_REGION", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_BRESP", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_RRESP", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_READ_THREADS", "4");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "4");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_SIZE", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_RESET", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXI_HPM0_LPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    M_AXI_HPM0_LPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    M_AXI_HPM0_LPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_M_AXI_HPM0_LPD_transactor = new xtlm::xaximm_xtlm2pin_t<128,40,16,16,1,1,16,1>("M_AXI_HPM0_LPD_transactor", M_AXI_HPM0_LPD_transactor_param_props);

    // M_AXI_HPM0_LPD' transactor ports

    mp_M_AXI_HPM0_LPD_transactor->AWID(maxigp2_awid);
    mp_M_AXI_HPM0_LPD_transactor->AWADDR(maxigp2_awaddr);
    mp_M_AXI_HPM0_LPD_transactor->AWLEN(maxigp2_awlen);
    mp_M_AXI_HPM0_LPD_transactor->AWSIZE(maxigp2_awsize);
    mp_M_AXI_HPM0_LPD_transactor->AWBURST(maxigp2_awburst);
    mp_M_AXI_HPM0_LPD_transactor->AWLOCK(maxigp2_awlock);
    mp_M_AXI_HPM0_LPD_transactor->AWCACHE(maxigp2_awcache);
    mp_M_AXI_HPM0_LPD_transactor->AWPROT(maxigp2_awprot);
    mp_M_AXI_HPM0_LPD_transactor->AWVALID(maxigp2_awvalid);
    mp_M_AXI_HPM0_LPD_transactor->AWUSER(maxigp2_awuser);
    mp_M_AXI_HPM0_LPD_transactor->AWREADY(maxigp2_awready);
    mp_M_AXI_HPM0_LPD_transactor->WDATA(maxigp2_wdata);
    mp_M_AXI_HPM0_LPD_transactor->WSTRB(maxigp2_wstrb);
    mp_M_AXI_HPM0_LPD_transactor->WLAST(maxigp2_wlast);
    mp_M_AXI_HPM0_LPD_transactor->WVALID(maxigp2_wvalid);
    mp_M_AXI_HPM0_LPD_transactor->WREADY(maxigp2_wready);
    mp_M_AXI_HPM0_LPD_transactor->BID(maxigp2_bid);
    mp_M_AXI_HPM0_LPD_transactor->BRESP(maxigp2_bresp);
    mp_M_AXI_HPM0_LPD_transactor->BVALID(maxigp2_bvalid);
    mp_M_AXI_HPM0_LPD_transactor->BREADY(maxigp2_bready);
    mp_M_AXI_HPM0_LPD_transactor->ARID(maxigp2_arid);
    mp_M_AXI_HPM0_LPD_transactor->ARADDR(maxigp2_araddr);
    mp_M_AXI_HPM0_LPD_transactor->ARLEN(maxigp2_arlen);
    mp_M_AXI_HPM0_LPD_transactor->ARSIZE(maxigp2_arsize);
    mp_M_AXI_HPM0_LPD_transactor->ARBURST(maxigp2_arburst);
    mp_M_AXI_HPM0_LPD_transactor->ARLOCK(maxigp2_arlock);
    mp_M_AXI_HPM0_LPD_transactor->ARCACHE(maxigp2_arcache);
    mp_M_AXI_HPM0_LPD_transactor->ARPROT(maxigp2_arprot);
    mp_M_AXI_HPM0_LPD_transactor->ARVALID(maxigp2_arvalid);
    mp_M_AXI_HPM0_LPD_transactor->ARUSER(maxigp2_aruser);
    mp_M_AXI_HPM0_LPD_transactor->ARREADY(maxigp2_arready);
    mp_M_AXI_HPM0_LPD_transactor->RID(maxigp2_rid);
    mp_M_AXI_HPM0_LPD_transactor->RDATA(maxigp2_rdata);
    mp_M_AXI_HPM0_LPD_transactor->RRESP(maxigp2_rresp);
    mp_M_AXI_HPM0_LPD_transactor->RLAST(maxigp2_rlast);
    mp_M_AXI_HPM0_LPD_transactor->RVALID(maxigp2_rvalid);
    mp_M_AXI_HPM0_LPD_transactor->RREADY(maxigp2_rready);
    mp_M_AXI_HPM0_LPD_transactor->AWQOS(maxigp2_awqos);
    mp_M_AXI_HPM0_LPD_transactor->ARQOS(maxigp2_arqos);
    mp_M_AXI_HPM0_LPD_transactor->CLK(maxihpm0_lpd_aclk);
    m_M_AXI_HPM0_LPD_transactor_rst_signal.write(1);
    mp_M_AXI_HPM0_LPD_transactor->RST(m_M_AXI_HPM0_LPD_transactor_rst_signal);

    // M_AXI_HPM0_LPD' transactor sockets

    mp_impl->M_AXI_HPM0_LPD_rd_socket->bind(*(mp_M_AXI_HPM0_LPD_transactor->rd_socket));
    mp_impl->M_AXI_HPM0_LPD_wr_socket->bind(*(mp_M_AXI_HPM0_LPD_transactor->wr_socket));
  }
  else
  {
  }

  // configure 'S_AXI_HPC0_FPD' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "S_AXI_HPC0_FPD_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'S_AXI_HPC0_FPD' transactor parameters
    xsc::common_cpp::properties S_AXI_HPC0_FPD_transactor_param_props;
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "16");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "16");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ID_WIDTH", "6");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ADDR_WIDTH", "49");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("AWUSER_WIDTH", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ARUSER_WIDTH", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_BURST", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_LOCK", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_PROT", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_CACHE", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_QOS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_REGION", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_BRESP", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_RRESP", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_READ_THREADS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_SIZE", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_RESET", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addFloat("PHASE", "0.0");
    S_AXI_HPC0_FPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    S_AXI_HPC0_FPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    S_AXI_HPC0_FPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_S_AXI_HPC0_FPD_transactor = new xtlm::xaximm_pin2xtlm_t<128,49,6,1,1,1,1,1>("S_AXI_HPC0_FPD_transactor", S_AXI_HPC0_FPD_transactor_param_props);

    // S_AXI_HPC0_FPD' transactor ports

    mp_saxigp0_aruser_converter = new xsc::common::scalar2vectorN_converter<1>("saxigp0_aruser_converter");
    mp_saxigp0_aruser_converter->scalar_in(saxigp0_aruser);
    mp_saxigp0_aruser_converter->vector_out(m_saxigp0_aruser_converter_signal);
    mp_S_AXI_HPC0_FPD_transactor->ARUSER(m_saxigp0_aruser_converter_signal);
    mp_saxigp0_awuser_converter = new xsc::common::scalar2vectorN_converter<1>("saxigp0_awuser_converter");
    mp_saxigp0_awuser_converter->scalar_in(saxigp0_awuser);
    mp_saxigp0_awuser_converter->vector_out(m_saxigp0_awuser_converter_signal);
    mp_S_AXI_HPC0_FPD_transactor->AWUSER(m_saxigp0_awuser_converter_signal);
    mp_S_AXI_HPC0_FPD_transactor->AWID(saxigp0_awid);
    mp_S_AXI_HPC0_FPD_transactor->AWADDR(saxigp0_awaddr);
    mp_S_AXI_HPC0_FPD_transactor->AWLEN(saxigp0_awlen);
    mp_S_AXI_HPC0_FPD_transactor->AWSIZE(saxigp0_awsize);
    mp_S_AXI_HPC0_FPD_transactor->AWBURST(saxigp0_awburst);
    mp_S_AXI_HPC0_FPD_transactor->AWLOCK(saxigp0_awlock);
    mp_S_AXI_HPC0_FPD_transactor->AWCACHE(saxigp0_awcache);
    mp_S_AXI_HPC0_FPD_transactor->AWPROT(saxigp0_awprot);
    mp_S_AXI_HPC0_FPD_transactor->AWVALID(saxigp0_awvalid);
    mp_S_AXI_HPC0_FPD_transactor->AWREADY(saxigp0_awready);
    mp_S_AXI_HPC0_FPD_transactor->WDATA(saxigp0_wdata);
    mp_S_AXI_HPC0_FPD_transactor->WSTRB(saxigp0_wstrb);
    mp_S_AXI_HPC0_FPD_transactor->WLAST(saxigp0_wlast);
    mp_S_AXI_HPC0_FPD_transactor->WVALID(saxigp0_wvalid);
    mp_S_AXI_HPC0_FPD_transactor->WREADY(saxigp0_wready);
    mp_S_AXI_HPC0_FPD_transactor->BID(saxigp0_bid);
    mp_S_AXI_HPC0_FPD_transactor->BRESP(saxigp0_bresp);
    mp_S_AXI_HPC0_FPD_transactor->BVALID(saxigp0_bvalid);
    mp_S_AXI_HPC0_FPD_transactor->BREADY(saxigp0_bready);
    mp_S_AXI_HPC0_FPD_transactor->ARID(saxigp0_arid);
    mp_S_AXI_HPC0_FPD_transactor->ARADDR(saxigp0_araddr);
    mp_S_AXI_HPC0_FPD_transactor->ARLEN(saxigp0_arlen);
    mp_S_AXI_HPC0_FPD_transactor->ARSIZE(saxigp0_arsize);
    mp_S_AXI_HPC0_FPD_transactor->ARBURST(saxigp0_arburst);
    mp_S_AXI_HPC0_FPD_transactor->ARLOCK(saxigp0_arlock);
    mp_S_AXI_HPC0_FPD_transactor->ARCACHE(saxigp0_arcache);
    mp_S_AXI_HPC0_FPD_transactor->ARPROT(saxigp0_arprot);
    mp_S_AXI_HPC0_FPD_transactor->ARVALID(saxigp0_arvalid);
    mp_S_AXI_HPC0_FPD_transactor->ARREADY(saxigp0_arready);
    mp_S_AXI_HPC0_FPD_transactor->RID(saxigp0_rid);
    mp_S_AXI_HPC0_FPD_transactor->RDATA(saxigp0_rdata);
    mp_S_AXI_HPC0_FPD_transactor->RRESP(saxigp0_rresp);
    mp_S_AXI_HPC0_FPD_transactor->RLAST(saxigp0_rlast);
    mp_S_AXI_HPC0_FPD_transactor->RVALID(saxigp0_rvalid);
    mp_S_AXI_HPC0_FPD_transactor->RREADY(saxigp0_rready);
    mp_S_AXI_HPC0_FPD_transactor->AWQOS(saxigp0_awqos);
    mp_S_AXI_HPC0_FPD_transactor->ARQOS(saxigp0_arqos);
    mp_S_AXI_HPC0_FPD_transactor->CLK(saxihpc0_fpd_aclk);
    m_S_AXI_HPC0_FPD_transactor_rst_signal.write(1);
    mp_S_AXI_HPC0_FPD_transactor->RST(m_S_AXI_HPC0_FPD_transactor_rst_signal);

    // S_AXI_HPC0_FPD' transactor sockets

    mp_impl->S_AXI_HPC0_FPD_rd_socket->bind(*(mp_S_AXI_HPC0_FPD_transactor->rd_socket));
    mp_impl->S_AXI_HPC0_FPD_wr_socket->bind(*(mp_S_AXI_HPC0_FPD_transactor->wr_socket));
  }
  else
  {
  }

}

#endif // XM_SYSTEMC




#ifdef RIVIERA
design_1_zynq_ultra_ps_e_0_0::design_1_zynq_ultra_ps_e_0_0(const sc_core::sc_module_name& nm) : design_1_zynq_ultra_ps_e_0_0_sc(nm), maxihpm0_fpd_aclk("maxihpm0_fpd_aclk"), maxigp0_awid("maxigp0_awid"), maxigp0_awaddr("maxigp0_awaddr"), maxigp0_awlen("maxigp0_awlen"), maxigp0_awsize("maxigp0_awsize"), maxigp0_awburst("maxigp0_awburst"), maxigp0_awlock("maxigp0_awlock"), maxigp0_awcache("maxigp0_awcache"), maxigp0_awprot("maxigp0_awprot"), maxigp0_awvalid("maxigp0_awvalid"), maxigp0_awuser("maxigp0_awuser"), maxigp0_awready("maxigp0_awready"), maxigp0_wdata("maxigp0_wdata"), maxigp0_wstrb("maxigp0_wstrb"), maxigp0_wlast("maxigp0_wlast"), maxigp0_wvalid("maxigp0_wvalid"), maxigp0_wready("maxigp0_wready"), maxigp0_bid("maxigp0_bid"), maxigp0_bresp("maxigp0_bresp"), maxigp0_bvalid("maxigp0_bvalid"), maxigp0_bready("maxigp0_bready"), maxigp0_arid("maxigp0_arid"), maxigp0_araddr("maxigp0_araddr"), maxigp0_arlen("maxigp0_arlen"), maxigp0_arsize("maxigp0_arsize"), maxigp0_arburst("maxigp0_arburst"), maxigp0_arlock("maxigp0_arlock"), maxigp0_arcache("maxigp0_arcache"), maxigp0_arprot("maxigp0_arprot"), maxigp0_arvalid("maxigp0_arvalid"), maxigp0_aruser("maxigp0_aruser"), maxigp0_arready("maxigp0_arready"), maxigp0_rid("maxigp0_rid"), maxigp0_rdata("maxigp0_rdata"), maxigp0_rresp("maxigp0_rresp"), maxigp0_rlast("maxigp0_rlast"), maxigp0_rvalid("maxigp0_rvalid"), maxigp0_rready("maxigp0_rready"), maxigp0_awqos("maxigp0_awqos"), maxigp0_arqos("maxigp0_arqos"), maxihpm0_lpd_aclk("maxihpm0_lpd_aclk"), maxigp2_awid("maxigp2_awid"), maxigp2_awaddr("maxigp2_awaddr"), maxigp2_awlen("maxigp2_awlen"), maxigp2_awsize("maxigp2_awsize"), maxigp2_awburst("maxigp2_awburst"), maxigp2_awlock("maxigp2_awlock"), maxigp2_awcache("maxigp2_awcache"), maxigp2_awprot("maxigp2_awprot"), maxigp2_awvalid("maxigp2_awvalid"), maxigp2_awuser("maxigp2_awuser"), maxigp2_awready("maxigp2_awready"), maxigp2_wdata("maxigp2_wdata"), maxigp2_wstrb("maxigp2_wstrb"), maxigp2_wlast("maxigp2_wlast"), maxigp2_wvalid("maxigp2_wvalid"), maxigp2_wready("maxigp2_wready"), maxigp2_bid("maxigp2_bid"), maxigp2_bresp("maxigp2_bresp"), maxigp2_bvalid("maxigp2_bvalid"), maxigp2_bready("maxigp2_bready"), maxigp2_arid("maxigp2_arid"), maxigp2_araddr("maxigp2_araddr"), maxigp2_arlen("maxigp2_arlen"), maxigp2_arsize("maxigp2_arsize"), maxigp2_arburst("maxigp2_arburst"), maxigp2_arlock("maxigp2_arlock"), maxigp2_arcache("maxigp2_arcache"), maxigp2_arprot("maxigp2_arprot"), maxigp2_arvalid("maxigp2_arvalid"), maxigp2_aruser("maxigp2_aruser"), maxigp2_arready("maxigp2_arready"), maxigp2_rid("maxigp2_rid"), maxigp2_rdata("maxigp2_rdata"), maxigp2_rresp("maxigp2_rresp"), maxigp2_rlast("maxigp2_rlast"), maxigp2_rvalid("maxigp2_rvalid"), maxigp2_rready("maxigp2_rready"), maxigp2_awqos("maxigp2_awqos"), maxigp2_arqos("maxigp2_arqos"), saxihpc0_fpd_aclk("saxihpc0_fpd_aclk"), saxigp0_aruser("saxigp0_aruser"), saxigp0_awuser("saxigp0_awuser"), saxigp0_awid("saxigp0_awid"), saxigp0_awaddr("saxigp0_awaddr"), saxigp0_awlen("saxigp0_awlen"), saxigp0_awsize("saxigp0_awsize"), saxigp0_awburst("saxigp0_awburst"), saxigp0_awlock("saxigp0_awlock"), saxigp0_awcache("saxigp0_awcache"), saxigp0_awprot("saxigp0_awprot"), saxigp0_awvalid("saxigp0_awvalid"), saxigp0_awready("saxigp0_awready"), saxigp0_wdata("saxigp0_wdata"), saxigp0_wstrb("saxigp0_wstrb"), saxigp0_wlast("saxigp0_wlast"), saxigp0_wvalid("saxigp0_wvalid"), saxigp0_wready("saxigp0_wready"), saxigp0_bid("saxigp0_bid"), saxigp0_bresp("saxigp0_bresp"), saxigp0_bvalid("saxigp0_bvalid"), saxigp0_bready("saxigp0_bready"), saxigp0_arid("saxigp0_arid"), saxigp0_araddr("saxigp0_araddr"), saxigp0_arlen("saxigp0_arlen"), saxigp0_arsize("saxigp0_arsize"), saxigp0_arburst("saxigp0_arburst"), saxigp0_arlock("saxigp0_arlock"), saxigp0_arcache("saxigp0_arcache"), saxigp0_arprot("saxigp0_arprot"), saxigp0_arvalid("saxigp0_arvalid"), saxigp0_arready("saxigp0_arready"), saxigp0_rid("saxigp0_rid"), saxigp0_rdata("saxigp0_rdata"), saxigp0_rresp("saxigp0_rresp"), saxigp0_rlast("saxigp0_rlast"), saxigp0_rvalid("saxigp0_rvalid"), saxigp0_rready("saxigp0_rready"), saxigp0_awqos("saxigp0_awqos"), saxigp0_arqos("saxigp0_arqos"), sacefpd_aclk("sacefpd_aclk"), sacefpd_wuser("sacefpd_wuser"), sacefpd_buser("sacefpd_buser"), sacefpd_ruser("sacefpd_ruser"), sacefpd_awuser("sacefpd_awuser"), sacefpd_awsnoop("sacefpd_awsnoop"), sacefpd_awsize("sacefpd_awsize"), sacefpd_awregion("sacefpd_awregion"), sacefpd_awqos("sacefpd_awqos"), sacefpd_awprot("sacefpd_awprot"), sacefpd_awlen("sacefpd_awlen"), sacefpd_awid("sacefpd_awid"), sacefpd_awdomain("sacefpd_awdomain"), sacefpd_awcache("sacefpd_awcache"), sacefpd_awburst("sacefpd_awburst"), sacefpd_awbar("sacefpd_awbar"), sacefpd_awaddr("sacefpd_awaddr"), sacefpd_awlock("sacefpd_awlock"), sacefpd_awvalid("sacefpd_awvalid"), sacefpd_awready("sacefpd_awready"), sacefpd_wstrb("sacefpd_wstrb"), sacefpd_wdata("sacefpd_wdata"), sacefpd_wlast("sacefpd_wlast"), sacefpd_wvalid("sacefpd_wvalid"), sacefpd_wready("sacefpd_wready"), sacefpd_bresp("sacefpd_bresp"), sacefpd_bid("sacefpd_bid"), sacefpd_bvalid("sacefpd_bvalid"), sacefpd_bready("sacefpd_bready"), sacefpd_aruser("sacefpd_aruser"), sacefpd_arsnoop("sacefpd_arsnoop"), sacefpd_arsize("sacefpd_arsize"), sacefpd_arregion("sacefpd_arregion"), sacefpd_arqos("sacefpd_arqos"), sacefpd_arprot("sacefpd_arprot"), sacefpd_arlen("sacefpd_arlen"), sacefpd_arid("sacefpd_arid"), sacefpd_ardomain("sacefpd_ardomain"), sacefpd_arcache("sacefpd_arcache"), sacefpd_arburst("sacefpd_arburst"), sacefpd_arbar("sacefpd_arbar"), sacefpd_araddr("sacefpd_araddr"), sacefpd_arlock("sacefpd_arlock"), sacefpd_arvalid("sacefpd_arvalid"), sacefpd_arready("sacefpd_arready"), sacefpd_rresp("sacefpd_rresp"), sacefpd_rid("sacefpd_rid"), sacefpd_rdata("sacefpd_rdata"), sacefpd_rlast("sacefpd_rlast"), sacefpd_rvalid("sacefpd_rvalid"), sacefpd_rready("sacefpd_rready"), sacefpd_acsnoop("sacefpd_acsnoop"), sacefpd_acprot("sacefpd_acprot"), sacefpd_acaddr("sacefpd_acaddr"), sacefpd_acvalid("sacefpd_acvalid"), sacefpd_acready("sacefpd_acready"), sacefpd_cddata("sacefpd_cddata"), sacefpd_cdlast("sacefpd_cdlast"), sacefpd_cdvalid("sacefpd_cdvalid"), sacefpd_cdready("sacefpd_cdready"), sacefpd_crresp("sacefpd_crresp"), sacefpd_crvalid("sacefpd_crvalid"), sacefpd_crready("sacefpd_crready"), sacefpd_wack("sacefpd_wack"), sacefpd_rack("sacefpd_rack"), pl_ps_irq0("pl_ps_irq0"), pl_resetn0("pl_resetn0"), pl_clk0("pl_clk0")
{

  // initialize pins
  mp_impl->maxihpm0_fpd_aclk(maxihpm0_fpd_aclk);
  mp_impl->maxihpm0_lpd_aclk(maxihpm0_lpd_aclk);
  mp_impl->saxihpc0_fpd_aclk(saxihpc0_fpd_aclk);
  mp_impl->sacefpd_aclk(sacefpd_aclk);
  mp_impl->sacefpd_wuser(sacefpd_wuser);
  mp_impl->sacefpd_buser(sacefpd_buser);
  mp_impl->sacefpd_ruser(sacefpd_ruser);
  mp_impl->sacefpd_awuser(sacefpd_awuser);
  mp_impl->sacefpd_awsnoop(sacefpd_awsnoop);
  mp_impl->sacefpd_awsize(sacefpd_awsize);
  mp_impl->sacefpd_awregion(sacefpd_awregion);
  mp_impl->sacefpd_awqos(sacefpd_awqos);
  mp_impl->sacefpd_awprot(sacefpd_awprot);
  mp_impl->sacefpd_awlen(sacefpd_awlen);
  mp_impl->sacefpd_awid(sacefpd_awid);
  mp_impl->sacefpd_awdomain(sacefpd_awdomain);
  mp_impl->sacefpd_awcache(sacefpd_awcache);
  mp_impl->sacefpd_awburst(sacefpd_awburst);
  mp_impl->sacefpd_awbar(sacefpd_awbar);
  mp_impl->sacefpd_awaddr(sacefpd_awaddr);
  mp_impl->sacefpd_awlock(sacefpd_awlock);
  mp_impl->sacefpd_awvalid(sacefpd_awvalid);
  mp_impl->sacefpd_awready(sacefpd_awready);
  mp_impl->sacefpd_wstrb(sacefpd_wstrb);
  mp_impl->sacefpd_wdata(sacefpd_wdata);
  mp_impl->sacefpd_wlast(sacefpd_wlast);
  mp_impl->sacefpd_wvalid(sacefpd_wvalid);
  mp_impl->sacefpd_wready(sacefpd_wready);
  mp_impl->sacefpd_bresp(sacefpd_bresp);
  mp_impl->sacefpd_bid(sacefpd_bid);
  mp_impl->sacefpd_bvalid(sacefpd_bvalid);
  mp_impl->sacefpd_bready(sacefpd_bready);
  mp_impl->sacefpd_aruser(sacefpd_aruser);
  mp_impl->sacefpd_arsnoop(sacefpd_arsnoop);
  mp_impl->sacefpd_arsize(sacefpd_arsize);
  mp_impl->sacefpd_arregion(sacefpd_arregion);
  mp_impl->sacefpd_arqos(sacefpd_arqos);
  mp_impl->sacefpd_arprot(sacefpd_arprot);
  mp_impl->sacefpd_arlen(sacefpd_arlen);
  mp_impl->sacefpd_arid(sacefpd_arid);
  mp_impl->sacefpd_ardomain(sacefpd_ardomain);
  mp_impl->sacefpd_arcache(sacefpd_arcache);
  mp_impl->sacefpd_arburst(sacefpd_arburst);
  mp_impl->sacefpd_arbar(sacefpd_arbar);
  mp_impl->sacefpd_araddr(sacefpd_araddr);
  mp_impl->sacefpd_arlock(sacefpd_arlock);
  mp_impl->sacefpd_arvalid(sacefpd_arvalid);
  mp_impl->sacefpd_arready(sacefpd_arready);
  mp_impl->sacefpd_rresp(sacefpd_rresp);
  mp_impl->sacefpd_rid(sacefpd_rid);
  mp_impl->sacefpd_rdata(sacefpd_rdata);
  mp_impl->sacefpd_rlast(sacefpd_rlast);
  mp_impl->sacefpd_rvalid(sacefpd_rvalid);
  mp_impl->sacefpd_rready(sacefpd_rready);
  mp_impl->sacefpd_acsnoop(sacefpd_acsnoop);
  mp_impl->sacefpd_acprot(sacefpd_acprot);
  mp_impl->sacefpd_acaddr(sacefpd_acaddr);
  mp_impl->sacefpd_acvalid(sacefpd_acvalid);
  mp_impl->sacefpd_acready(sacefpd_acready);
  mp_impl->sacefpd_cddata(sacefpd_cddata);
  mp_impl->sacefpd_cdlast(sacefpd_cdlast);
  mp_impl->sacefpd_cdvalid(sacefpd_cdvalid);
  mp_impl->sacefpd_cdready(sacefpd_cdready);
  mp_impl->sacefpd_crresp(sacefpd_crresp);
  mp_impl->sacefpd_crvalid(sacefpd_crvalid);
  mp_impl->sacefpd_crready(sacefpd_crready);
  mp_impl->sacefpd_wack(sacefpd_wack);
  mp_impl->sacefpd_rack(sacefpd_rack);
  mp_impl->pl_ps_irq0(pl_ps_irq0);
  mp_impl->pl_resetn0(pl_resetn0);
  mp_impl->pl_clk0(pl_clk0);

  // initialize transactors
  mp_M_AXI_HPM0_FPD_transactor = NULL;
  mp_M_AXI_HPM0_LPD_transactor = NULL;
  mp_S_AXI_HPC0_FPD_transactor = NULL;
  mp_saxigp0_aruser_converter = NULL;
  mp_saxigp0_awuser_converter = NULL;

  // initialize socket stubs

}

void design_1_zynq_ultra_ps_e_0_0::before_end_of_elaboration()
{
  // configure 'M_AXI_HPM0_FPD' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "M_AXI_HPM0_FPD_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'M_AXI_HPM0_FPD' transactor parameters
    xsc::common_cpp::properties M_AXI_HPM0_FPD_transactor_param_props;
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "8");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "8");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ID_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ADDR_WIDTH", "40");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("AWUSER_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ARUSER_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_BURST", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_LOCK", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_PROT", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_CACHE", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_QOS", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_REGION", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_BRESP", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_RRESP", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_READ_THREADS", "4");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "4");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_SIZE", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_RESET", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXI_HPM0_FPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    M_AXI_HPM0_FPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    M_AXI_HPM0_FPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_M_AXI_HPM0_FPD_transactor = new xtlm::xaximm_xtlm2pin_t<128,40,16,16,1,1,16,1>("M_AXI_HPM0_FPD_transactor", M_AXI_HPM0_FPD_transactor_param_props);

    // M_AXI_HPM0_FPD' transactor ports

    mp_M_AXI_HPM0_FPD_transactor->AWID(maxigp0_awid);
    mp_M_AXI_HPM0_FPD_transactor->AWADDR(maxigp0_awaddr);
    mp_M_AXI_HPM0_FPD_transactor->AWLEN(maxigp0_awlen);
    mp_M_AXI_HPM0_FPD_transactor->AWSIZE(maxigp0_awsize);
    mp_M_AXI_HPM0_FPD_transactor->AWBURST(maxigp0_awburst);
    mp_M_AXI_HPM0_FPD_transactor->AWLOCK(maxigp0_awlock);
    mp_M_AXI_HPM0_FPD_transactor->AWCACHE(maxigp0_awcache);
    mp_M_AXI_HPM0_FPD_transactor->AWPROT(maxigp0_awprot);
    mp_M_AXI_HPM0_FPD_transactor->AWVALID(maxigp0_awvalid);
    mp_M_AXI_HPM0_FPD_transactor->AWUSER(maxigp0_awuser);
    mp_M_AXI_HPM0_FPD_transactor->AWREADY(maxigp0_awready);
    mp_M_AXI_HPM0_FPD_transactor->WDATA(maxigp0_wdata);
    mp_M_AXI_HPM0_FPD_transactor->WSTRB(maxigp0_wstrb);
    mp_M_AXI_HPM0_FPD_transactor->WLAST(maxigp0_wlast);
    mp_M_AXI_HPM0_FPD_transactor->WVALID(maxigp0_wvalid);
    mp_M_AXI_HPM0_FPD_transactor->WREADY(maxigp0_wready);
    mp_M_AXI_HPM0_FPD_transactor->BID(maxigp0_bid);
    mp_M_AXI_HPM0_FPD_transactor->BRESP(maxigp0_bresp);
    mp_M_AXI_HPM0_FPD_transactor->BVALID(maxigp0_bvalid);
    mp_M_AXI_HPM0_FPD_transactor->BREADY(maxigp0_bready);
    mp_M_AXI_HPM0_FPD_transactor->ARID(maxigp0_arid);
    mp_M_AXI_HPM0_FPD_transactor->ARADDR(maxigp0_araddr);
    mp_M_AXI_HPM0_FPD_transactor->ARLEN(maxigp0_arlen);
    mp_M_AXI_HPM0_FPD_transactor->ARSIZE(maxigp0_arsize);
    mp_M_AXI_HPM0_FPD_transactor->ARBURST(maxigp0_arburst);
    mp_M_AXI_HPM0_FPD_transactor->ARLOCK(maxigp0_arlock);
    mp_M_AXI_HPM0_FPD_transactor->ARCACHE(maxigp0_arcache);
    mp_M_AXI_HPM0_FPD_transactor->ARPROT(maxigp0_arprot);
    mp_M_AXI_HPM0_FPD_transactor->ARVALID(maxigp0_arvalid);
    mp_M_AXI_HPM0_FPD_transactor->ARUSER(maxigp0_aruser);
    mp_M_AXI_HPM0_FPD_transactor->ARREADY(maxigp0_arready);
    mp_M_AXI_HPM0_FPD_transactor->RID(maxigp0_rid);
    mp_M_AXI_HPM0_FPD_transactor->RDATA(maxigp0_rdata);
    mp_M_AXI_HPM0_FPD_transactor->RRESP(maxigp0_rresp);
    mp_M_AXI_HPM0_FPD_transactor->RLAST(maxigp0_rlast);
    mp_M_AXI_HPM0_FPD_transactor->RVALID(maxigp0_rvalid);
    mp_M_AXI_HPM0_FPD_transactor->RREADY(maxigp0_rready);
    mp_M_AXI_HPM0_FPD_transactor->AWQOS(maxigp0_awqos);
    mp_M_AXI_HPM0_FPD_transactor->ARQOS(maxigp0_arqos);
    mp_M_AXI_HPM0_FPD_transactor->CLK(maxihpm0_fpd_aclk);
    m_M_AXI_HPM0_FPD_transactor_rst_signal.write(1);
    mp_M_AXI_HPM0_FPD_transactor->RST(m_M_AXI_HPM0_FPD_transactor_rst_signal);

    // M_AXI_HPM0_FPD' transactor sockets

    mp_impl->M_AXI_HPM0_FPD_rd_socket->bind(*(mp_M_AXI_HPM0_FPD_transactor->rd_socket));
    mp_impl->M_AXI_HPM0_FPD_wr_socket->bind(*(mp_M_AXI_HPM0_FPD_transactor->wr_socket));
  }
  else
  {
  }

  // configure 'M_AXI_HPM0_LPD' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "M_AXI_HPM0_LPD_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'M_AXI_HPM0_LPD' transactor parameters
    xsc::common_cpp::properties M_AXI_HPM0_LPD_transactor_param_props;
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "8");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "8");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ID_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ADDR_WIDTH", "40");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("AWUSER_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ARUSER_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_BURST", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_LOCK", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_PROT", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_CACHE", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_QOS", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_REGION", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_BRESP", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_RRESP", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_READ_THREADS", "4");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "4");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_SIZE", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_RESET", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXI_HPM0_LPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    M_AXI_HPM0_LPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    M_AXI_HPM0_LPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_M_AXI_HPM0_LPD_transactor = new xtlm::xaximm_xtlm2pin_t<128,40,16,16,1,1,16,1>("M_AXI_HPM0_LPD_transactor", M_AXI_HPM0_LPD_transactor_param_props);

    // M_AXI_HPM0_LPD' transactor ports

    mp_M_AXI_HPM0_LPD_transactor->AWID(maxigp2_awid);
    mp_M_AXI_HPM0_LPD_transactor->AWADDR(maxigp2_awaddr);
    mp_M_AXI_HPM0_LPD_transactor->AWLEN(maxigp2_awlen);
    mp_M_AXI_HPM0_LPD_transactor->AWSIZE(maxigp2_awsize);
    mp_M_AXI_HPM0_LPD_transactor->AWBURST(maxigp2_awburst);
    mp_M_AXI_HPM0_LPD_transactor->AWLOCK(maxigp2_awlock);
    mp_M_AXI_HPM0_LPD_transactor->AWCACHE(maxigp2_awcache);
    mp_M_AXI_HPM0_LPD_transactor->AWPROT(maxigp2_awprot);
    mp_M_AXI_HPM0_LPD_transactor->AWVALID(maxigp2_awvalid);
    mp_M_AXI_HPM0_LPD_transactor->AWUSER(maxigp2_awuser);
    mp_M_AXI_HPM0_LPD_transactor->AWREADY(maxigp2_awready);
    mp_M_AXI_HPM0_LPD_transactor->WDATA(maxigp2_wdata);
    mp_M_AXI_HPM0_LPD_transactor->WSTRB(maxigp2_wstrb);
    mp_M_AXI_HPM0_LPD_transactor->WLAST(maxigp2_wlast);
    mp_M_AXI_HPM0_LPD_transactor->WVALID(maxigp2_wvalid);
    mp_M_AXI_HPM0_LPD_transactor->WREADY(maxigp2_wready);
    mp_M_AXI_HPM0_LPD_transactor->BID(maxigp2_bid);
    mp_M_AXI_HPM0_LPD_transactor->BRESP(maxigp2_bresp);
    mp_M_AXI_HPM0_LPD_transactor->BVALID(maxigp2_bvalid);
    mp_M_AXI_HPM0_LPD_transactor->BREADY(maxigp2_bready);
    mp_M_AXI_HPM0_LPD_transactor->ARID(maxigp2_arid);
    mp_M_AXI_HPM0_LPD_transactor->ARADDR(maxigp2_araddr);
    mp_M_AXI_HPM0_LPD_transactor->ARLEN(maxigp2_arlen);
    mp_M_AXI_HPM0_LPD_transactor->ARSIZE(maxigp2_arsize);
    mp_M_AXI_HPM0_LPD_transactor->ARBURST(maxigp2_arburst);
    mp_M_AXI_HPM0_LPD_transactor->ARLOCK(maxigp2_arlock);
    mp_M_AXI_HPM0_LPD_transactor->ARCACHE(maxigp2_arcache);
    mp_M_AXI_HPM0_LPD_transactor->ARPROT(maxigp2_arprot);
    mp_M_AXI_HPM0_LPD_transactor->ARVALID(maxigp2_arvalid);
    mp_M_AXI_HPM0_LPD_transactor->ARUSER(maxigp2_aruser);
    mp_M_AXI_HPM0_LPD_transactor->ARREADY(maxigp2_arready);
    mp_M_AXI_HPM0_LPD_transactor->RID(maxigp2_rid);
    mp_M_AXI_HPM0_LPD_transactor->RDATA(maxigp2_rdata);
    mp_M_AXI_HPM0_LPD_transactor->RRESP(maxigp2_rresp);
    mp_M_AXI_HPM0_LPD_transactor->RLAST(maxigp2_rlast);
    mp_M_AXI_HPM0_LPD_transactor->RVALID(maxigp2_rvalid);
    mp_M_AXI_HPM0_LPD_transactor->RREADY(maxigp2_rready);
    mp_M_AXI_HPM0_LPD_transactor->AWQOS(maxigp2_awqos);
    mp_M_AXI_HPM0_LPD_transactor->ARQOS(maxigp2_arqos);
    mp_M_AXI_HPM0_LPD_transactor->CLK(maxihpm0_lpd_aclk);
    m_M_AXI_HPM0_LPD_transactor_rst_signal.write(1);
    mp_M_AXI_HPM0_LPD_transactor->RST(m_M_AXI_HPM0_LPD_transactor_rst_signal);

    // M_AXI_HPM0_LPD' transactor sockets

    mp_impl->M_AXI_HPM0_LPD_rd_socket->bind(*(mp_M_AXI_HPM0_LPD_transactor->rd_socket));
    mp_impl->M_AXI_HPM0_LPD_wr_socket->bind(*(mp_M_AXI_HPM0_LPD_transactor->wr_socket));
  }
  else
  {
  }

  // configure 'S_AXI_HPC0_FPD' transactor

  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "S_AXI_HPC0_FPD_TLM_MODE") != 1)
  {
    // Instantiate Socket Stubs

  // 'S_AXI_HPC0_FPD' transactor parameters
    xsc::common_cpp::properties S_AXI_HPC0_FPD_transactor_param_props;
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "16");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "16");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ID_WIDTH", "6");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ADDR_WIDTH", "49");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("AWUSER_WIDTH", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ARUSER_WIDTH", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_BURST", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_LOCK", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_PROT", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_CACHE", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_QOS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_REGION", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_BRESP", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_RRESP", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_READ_THREADS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_SIZE", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_RESET", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addFloat("PHASE", "0.0");
    S_AXI_HPC0_FPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    S_AXI_HPC0_FPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    S_AXI_HPC0_FPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_S_AXI_HPC0_FPD_transactor = new xtlm::xaximm_pin2xtlm_t<128,49,6,1,1,1,1,1>("S_AXI_HPC0_FPD_transactor", S_AXI_HPC0_FPD_transactor_param_props);

    // S_AXI_HPC0_FPD' transactor ports

    mp_saxigp0_aruser_converter = new xsc::common::scalar2vectorN_converter<1>("saxigp0_aruser_converter");
    mp_saxigp0_aruser_converter->scalar_in(saxigp0_aruser);
    mp_saxigp0_aruser_converter->vector_out(m_saxigp0_aruser_converter_signal);
    mp_S_AXI_HPC0_FPD_transactor->ARUSER(m_saxigp0_aruser_converter_signal);
    mp_saxigp0_awuser_converter = new xsc::common::scalar2vectorN_converter<1>("saxigp0_awuser_converter");
    mp_saxigp0_awuser_converter->scalar_in(saxigp0_awuser);
    mp_saxigp0_awuser_converter->vector_out(m_saxigp0_awuser_converter_signal);
    mp_S_AXI_HPC0_FPD_transactor->AWUSER(m_saxigp0_awuser_converter_signal);
    mp_S_AXI_HPC0_FPD_transactor->AWID(saxigp0_awid);
    mp_S_AXI_HPC0_FPD_transactor->AWADDR(saxigp0_awaddr);
    mp_S_AXI_HPC0_FPD_transactor->AWLEN(saxigp0_awlen);
    mp_S_AXI_HPC0_FPD_transactor->AWSIZE(saxigp0_awsize);
    mp_S_AXI_HPC0_FPD_transactor->AWBURST(saxigp0_awburst);
    mp_S_AXI_HPC0_FPD_transactor->AWLOCK(saxigp0_awlock);
    mp_S_AXI_HPC0_FPD_transactor->AWCACHE(saxigp0_awcache);
    mp_S_AXI_HPC0_FPD_transactor->AWPROT(saxigp0_awprot);
    mp_S_AXI_HPC0_FPD_transactor->AWVALID(saxigp0_awvalid);
    mp_S_AXI_HPC0_FPD_transactor->AWREADY(saxigp0_awready);
    mp_S_AXI_HPC0_FPD_transactor->WDATA(saxigp0_wdata);
    mp_S_AXI_HPC0_FPD_transactor->WSTRB(saxigp0_wstrb);
    mp_S_AXI_HPC0_FPD_transactor->WLAST(saxigp0_wlast);
    mp_S_AXI_HPC0_FPD_transactor->WVALID(saxigp0_wvalid);
    mp_S_AXI_HPC0_FPD_transactor->WREADY(saxigp0_wready);
    mp_S_AXI_HPC0_FPD_transactor->BID(saxigp0_bid);
    mp_S_AXI_HPC0_FPD_transactor->BRESP(saxigp0_bresp);
    mp_S_AXI_HPC0_FPD_transactor->BVALID(saxigp0_bvalid);
    mp_S_AXI_HPC0_FPD_transactor->BREADY(saxigp0_bready);
    mp_S_AXI_HPC0_FPD_transactor->ARID(saxigp0_arid);
    mp_S_AXI_HPC0_FPD_transactor->ARADDR(saxigp0_araddr);
    mp_S_AXI_HPC0_FPD_transactor->ARLEN(saxigp0_arlen);
    mp_S_AXI_HPC0_FPD_transactor->ARSIZE(saxigp0_arsize);
    mp_S_AXI_HPC0_FPD_transactor->ARBURST(saxigp0_arburst);
    mp_S_AXI_HPC0_FPD_transactor->ARLOCK(saxigp0_arlock);
    mp_S_AXI_HPC0_FPD_transactor->ARCACHE(saxigp0_arcache);
    mp_S_AXI_HPC0_FPD_transactor->ARPROT(saxigp0_arprot);
    mp_S_AXI_HPC0_FPD_transactor->ARVALID(saxigp0_arvalid);
    mp_S_AXI_HPC0_FPD_transactor->ARREADY(saxigp0_arready);
    mp_S_AXI_HPC0_FPD_transactor->RID(saxigp0_rid);
    mp_S_AXI_HPC0_FPD_transactor->RDATA(saxigp0_rdata);
    mp_S_AXI_HPC0_FPD_transactor->RRESP(saxigp0_rresp);
    mp_S_AXI_HPC0_FPD_transactor->RLAST(saxigp0_rlast);
    mp_S_AXI_HPC0_FPD_transactor->RVALID(saxigp0_rvalid);
    mp_S_AXI_HPC0_FPD_transactor->RREADY(saxigp0_rready);
    mp_S_AXI_HPC0_FPD_transactor->AWQOS(saxigp0_awqos);
    mp_S_AXI_HPC0_FPD_transactor->ARQOS(saxigp0_arqos);
    mp_S_AXI_HPC0_FPD_transactor->CLK(saxihpc0_fpd_aclk);
    m_S_AXI_HPC0_FPD_transactor_rst_signal.write(1);
    mp_S_AXI_HPC0_FPD_transactor->RST(m_S_AXI_HPC0_FPD_transactor_rst_signal);

    // S_AXI_HPC0_FPD' transactor sockets

    mp_impl->S_AXI_HPC0_FPD_rd_socket->bind(*(mp_S_AXI_HPC0_FPD_transactor->rd_socket));
    mp_impl->S_AXI_HPC0_FPD_wr_socket->bind(*(mp_S_AXI_HPC0_FPD_transactor->wr_socket));
  }
  else
  {
  }

}

#endif // RIVIERA




#ifdef VCSSYSTEMC
design_1_zynq_ultra_ps_e_0_0::design_1_zynq_ultra_ps_e_0_0(const sc_core::sc_module_name& nm) : design_1_zynq_ultra_ps_e_0_0_sc(nm),  maxihpm0_fpd_aclk("maxihpm0_fpd_aclk"), maxigp0_awid("maxigp0_awid"), maxigp0_awaddr("maxigp0_awaddr"), maxigp0_awlen("maxigp0_awlen"), maxigp0_awsize("maxigp0_awsize"), maxigp0_awburst("maxigp0_awburst"), maxigp0_awlock("maxigp0_awlock"), maxigp0_awcache("maxigp0_awcache"), maxigp0_awprot("maxigp0_awprot"), maxigp0_awvalid("maxigp0_awvalid"), maxigp0_awuser("maxigp0_awuser"), maxigp0_awready("maxigp0_awready"), maxigp0_wdata("maxigp0_wdata"), maxigp0_wstrb("maxigp0_wstrb"), maxigp0_wlast("maxigp0_wlast"), maxigp0_wvalid("maxigp0_wvalid"), maxigp0_wready("maxigp0_wready"), maxigp0_bid("maxigp0_bid"), maxigp0_bresp("maxigp0_bresp"), maxigp0_bvalid("maxigp0_bvalid"), maxigp0_bready("maxigp0_bready"), maxigp0_arid("maxigp0_arid"), maxigp0_araddr("maxigp0_araddr"), maxigp0_arlen("maxigp0_arlen"), maxigp0_arsize("maxigp0_arsize"), maxigp0_arburst("maxigp0_arburst"), maxigp0_arlock("maxigp0_arlock"), maxigp0_arcache("maxigp0_arcache"), maxigp0_arprot("maxigp0_arprot"), maxigp0_arvalid("maxigp0_arvalid"), maxigp0_aruser("maxigp0_aruser"), maxigp0_arready("maxigp0_arready"), maxigp0_rid("maxigp0_rid"), maxigp0_rdata("maxigp0_rdata"), maxigp0_rresp("maxigp0_rresp"), maxigp0_rlast("maxigp0_rlast"), maxigp0_rvalid("maxigp0_rvalid"), maxigp0_rready("maxigp0_rready"), maxigp0_awqos("maxigp0_awqos"), maxigp0_arqos("maxigp0_arqos"), maxihpm0_lpd_aclk("maxihpm0_lpd_aclk"), maxigp2_awid("maxigp2_awid"), maxigp2_awaddr("maxigp2_awaddr"), maxigp2_awlen("maxigp2_awlen"), maxigp2_awsize("maxigp2_awsize"), maxigp2_awburst("maxigp2_awburst"), maxigp2_awlock("maxigp2_awlock"), maxigp2_awcache("maxigp2_awcache"), maxigp2_awprot("maxigp2_awprot"), maxigp2_awvalid("maxigp2_awvalid"), maxigp2_awuser("maxigp2_awuser"), maxigp2_awready("maxigp2_awready"), maxigp2_wdata("maxigp2_wdata"), maxigp2_wstrb("maxigp2_wstrb"), maxigp2_wlast("maxigp2_wlast"), maxigp2_wvalid("maxigp2_wvalid"), maxigp2_wready("maxigp2_wready"), maxigp2_bid("maxigp2_bid"), maxigp2_bresp("maxigp2_bresp"), maxigp2_bvalid("maxigp2_bvalid"), maxigp2_bready("maxigp2_bready"), maxigp2_arid("maxigp2_arid"), maxigp2_araddr("maxigp2_araddr"), maxigp2_arlen("maxigp2_arlen"), maxigp2_arsize("maxigp2_arsize"), maxigp2_arburst("maxigp2_arburst"), maxigp2_arlock("maxigp2_arlock"), maxigp2_arcache("maxigp2_arcache"), maxigp2_arprot("maxigp2_arprot"), maxigp2_arvalid("maxigp2_arvalid"), maxigp2_aruser("maxigp2_aruser"), maxigp2_arready("maxigp2_arready"), maxigp2_rid("maxigp2_rid"), maxigp2_rdata("maxigp2_rdata"), maxigp2_rresp("maxigp2_rresp"), maxigp2_rlast("maxigp2_rlast"), maxigp2_rvalid("maxigp2_rvalid"), maxigp2_rready("maxigp2_rready"), maxigp2_awqos("maxigp2_awqos"), maxigp2_arqos("maxigp2_arqos"), saxihpc0_fpd_aclk("saxihpc0_fpd_aclk"), saxigp0_aruser("saxigp0_aruser"), saxigp0_awuser("saxigp0_awuser"), saxigp0_awid("saxigp0_awid"), saxigp0_awaddr("saxigp0_awaddr"), saxigp0_awlen("saxigp0_awlen"), saxigp0_awsize("saxigp0_awsize"), saxigp0_awburst("saxigp0_awburst"), saxigp0_awlock("saxigp0_awlock"), saxigp0_awcache("saxigp0_awcache"), saxigp0_awprot("saxigp0_awprot"), saxigp0_awvalid("saxigp0_awvalid"), saxigp0_awready("saxigp0_awready"), saxigp0_wdata("saxigp0_wdata"), saxigp0_wstrb("saxigp0_wstrb"), saxigp0_wlast("saxigp0_wlast"), saxigp0_wvalid("saxigp0_wvalid"), saxigp0_wready("saxigp0_wready"), saxigp0_bid("saxigp0_bid"), saxigp0_bresp("saxigp0_bresp"), saxigp0_bvalid("saxigp0_bvalid"), saxigp0_bready("saxigp0_bready"), saxigp0_arid("saxigp0_arid"), saxigp0_araddr("saxigp0_araddr"), saxigp0_arlen("saxigp0_arlen"), saxigp0_arsize("saxigp0_arsize"), saxigp0_arburst("saxigp0_arburst"), saxigp0_arlock("saxigp0_arlock"), saxigp0_arcache("saxigp0_arcache"), saxigp0_arprot("saxigp0_arprot"), saxigp0_arvalid("saxigp0_arvalid"), saxigp0_arready("saxigp0_arready"), saxigp0_rid("saxigp0_rid"), saxigp0_rdata("saxigp0_rdata"), saxigp0_rresp("saxigp0_rresp"), saxigp0_rlast("saxigp0_rlast"), saxigp0_rvalid("saxigp0_rvalid"), saxigp0_rready("saxigp0_rready"), saxigp0_awqos("saxigp0_awqos"), saxigp0_arqos("saxigp0_arqos"), sacefpd_aclk("sacefpd_aclk"), sacefpd_wuser("sacefpd_wuser"), sacefpd_buser("sacefpd_buser"), sacefpd_ruser("sacefpd_ruser"), sacefpd_awuser("sacefpd_awuser"), sacefpd_awsnoop("sacefpd_awsnoop"), sacefpd_awsize("sacefpd_awsize"), sacefpd_awregion("sacefpd_awregion"), sacefpd_awqos("sacefpd_awqos"), sacefpd_awprot("sacefpd_awprot"), sacefpd_awlen("sacefpd_awlen"), sacefpd_awid("sacefpd_awid"), sacefpd_awdomain("sacefpd_awdomain"), sacefpd_awcache("sacefpd_awcache"), sacefpd_awburst("sacefpd_awburst"), sacefpd_awbar("sacefpd_awbar"), sacefpd_awaddr("sacefpd_awaddr"), sacefpd_awlock("sacefpd_awlock"), sacefpd_awvalid("sacefpd_awvalid"), sacefpd_awready("sacefpd_awready"), sacefpd_wstrb("sacefpd_wstrb"), sacefpd_wdata("sacefpd_wdata"), sacefpd_wlast("sacefpd_wlast"), sacefpd_wvalid("sacefpd_wvalid"), sacefpd_wready("sacefpd_wready"), sacefpd_bresp("sacefpd_bresp"), sacefpd_bid("sacefpd_bid"), sacefpd_bvalid("sacefpd_bvalid"), sacefpd_bready("sacefpd_bready"), sacefpd_aruser("sacefpd_aruser"), sacefpd_arsnoop("sacefpd_arsnoop"), sacefpd_arsize("sacefpd_arsize"), sacefpd_arregion("sacefpd_arregion"), sacefpd_arqos("sacefpd_arqos"), sacefpd_arprot("sacefpd_arprot"), sacefpd_arlen("sacefpd_arlen"), sacefpd_arid("sacefpd_arid"), sacefpd_ardomain("sacefpd_ardomain"), sacefpd_arcache("sacefpd_arcache"), sacefpd_arburst("sacefpd_arburst"), sacefpd_arbar("sacefpd_arbar"), sacefpd_araddr("sacefpd_araddr"), sacefpd_arlock("sacefpd_arlock"), sacefpd_arvalid("sacefpd_arvalid"), sacefpd_arready("sacefpd_arready"), sacefpd_rresp("sacefpd_rresp"), sacefpd_rid("sacefpd_rid"), sacefpd_rdata("sacefpd_rdata"), sacefpd_rlast("sacefpd_rlast"), sacefpd_rvalid("sacefpd_rvalid"), sacefpd_rready("sacefpd_rready"), sacefpd_acsnoop("sacefpd_acsnoop"), sacefpd_acprot("sacefpd_acprot"), sacefpd_acaddr("sacefpd_acaddr"), sacefpd_acvalid("sacefpd_acvalid"), sacefpd_acready("sacefpd_acready"), sacefpd_cddata("sacefpd_cddata"), sacefpd_cdlast("sacefpd_cdlast"), sacefpd_cdvalid("sacefpd_cdvalid"), sacefpd_cdready("sacefpd_cdready"), sacefpd_crresp("sacefpd_crresp"), sacefpd_crvalid("sacefpd_crvalid"), sacefpd_crready("sacefpd_crready"), sacefpd_wack("sacefpd_wack"), sacefpd_rack("sacefpd_rack"), pl_ps_irq0("pl_ps_irq0"), pl_resetn0("pl_resetn0"), pl_clk0("pl_clk0")
{
  // initialize pins
  mp_impl->maxihpm0_fpd_aclk(maxihpm0_fpd_aclk);
  mp_impl->maxihpm0_lpd_aclk(maxihpm0_lpd_aclk);
  mp_impl->saxihpc0_fpd_aclk(saxihpc0_fpd_aclk);
  mp_impl->sacefpd_aclk(sacefpd_aclk);
  mp_impl->sacefpd_wuser(sacefpd_wuser);
  mp_impl->sacefpd_buser(sacefpd_buser);
  mp_impl->sacefpd_ruser(sacefpd_ruser);
  mp_impl->sacefpd_awuser(sacefpd_awuser);
  mp_impl->sacefpd_awsnoop(sacefpd_awsnoop);
  mp_impl->sacefpd_awsize(sacefpd_awsize);
  mp_impl->sacefpd_awregion(sacefpd_awregion);
  mp_impl->sacefpd_awqos(sacefpd_awqos);
  mp_impl->sacefpd_awprot(sacefpd_awprot);
  mp_impl->sacefpd_awlen(sacefpd_awlen);
  mp_impl->sacefpd_awid(sacefpd_awid);
  mp_impl->sacefpd_awdomain(sacefpd_awdomain);
  mp_impl->sacefpd_awcache(sacefpd_awcache);
  mp_impl->sacefpd_awburst(sacefpd_awburst);
  mp_impl->sacefpd_awbar(sacefpd_awbar);
  mp_impl->sacefpd_awaddr(sacefpd_awaddr);
  mp_impl->sacefpd_awlock(sacefpd_awlock);
  mp_impl->sacefpd_awvalid(sacefpd_awvalid);
  mp_impl->sacefpd_awready(sacefpd_awready);
  mp_impl->sacefpd_wstrb(sacefpd_wstrb);
  mp_impl->sacefpd_wdata(sacefpd_wdata);
  mp_impl->sacefpd_wlast(sacefpd_wlast);
  mp_impl->sacefpd_wvalid(sacefpd_wvalid);
  mp_impl->sacefpd_wready(sacefpd_wready);
  mp_impl->sacefpd_bresp(sacefpd_bresp);
  mp_impl->sacefpd_bid(sacefpd_bid);
  mp_impl->sacefpd_bvalid(sacefpd_bvalid);
  mp_impl->sacefpd_bready(sacefpd_bready);
  mp_impl->sacefpd_aruser(sacefpd_aruser);
  mp_impl->sacefpd_arsnoop(sacefpd_arsnoop);
  mp_impl->sacefpd_arsize(sacefpd_arsize);
  mp_impl->sacefpd_arregion(sacefpd_arregion);
  mp_impl->sacefpd_arqos(sacefpd_arqos);
  mp_impl->sacefpd_arprot(sacefpd_arprot);
  mp_impl->sacefpd_arlen(sacefpd_arlen);
  mp_impl->sacefpd_arid(sacefpd_arid);
  mp_impl->sacefpd_ardomain(sacefpd_ardomain);
  mp_impl->sacefpd_arcache(sacefpd_arcache);
  mp_impl->sacefpd_arburst(sacefpd_arburst);
  mp_impl->sacefpd_arbar(sacefpd_arbar);
  mp_impl->sacefpd_araddr(sacefpd_araddr);
  mp_impl->sacefpd_arlock(sacefpd_arlock);
  mp_impl->sacefpd_arvalid(sacefpd_arvalid);
  mp_impl->sacefpd_arready(sacefpd_arready);
  mp_impl->sacefpd_rresp(sacefpd_rresp);
  mp_impl->sacefpd_rid(sacefpd_rid);
  mp_impl->sacefpd_rdata(sacefpd_rdata);
  mp_impl->sacefpd_rlast(sacefpd_rlast);
  mp_impl->sacefpd_rvalid(sacefpd_rvalid);
  mp_impl->sacefpd_rready(sacefpd_rready);
  mp_impl->sacefpd_acsnoop(sacefpd_acsnoop);
  mp_impl->sacefpd_acprot(sacefpd_acprot);
  mp_impl->sacefpd_acaddr(sacefpd_acaddr);
  mp_impl->sacefpd_acvalid(sacefpd_acvalid);
  mp_impl->sacefpd_acready(sacefpd_acready);
  mp_impl->sacefpd_cddata(sacefpd_cddata);
  mp_impl->sacefpd_cdlast(sacefpd_cdlast);
  mp_impl->sacefpd_cdvalid(sacefpd_cdvalid);
  mp_impl->sacefpd_cdready(sacefpd_cdready);
  mp_impl->sacefpd_crresp(sacefpd_crresp);
  mp_impl->sacefpd_crvalid(sacefpd_crvalid);
  mp_impl->sacefpd_crready(sacefpd_crready);
  mp_impl->sacefpd_wack(sacefpd_wack);
  mp_impl->sacefpd_rack(sacefpd_rack);
  mp_impl->pl_ps_irq0(pl_ps_irq0);
  mp_impl->pl_resetn0(pl_resetn0);
  mp_impl->pl_clk0(pl_clk0);

  // initialize transactors
  mp_M_AXI_HPM0_FPD_transactor = NULL;
  mp_M_AXI_HPM0_LPD_transactor = NULL;
  mp_S_AXI_HPC0_FPD_transactor = NULL;
  mp_saxigp0_aruser_converter = NULL;
  mp_saxigp0_awuser_converter = NULL;

  // Instantiate Socket Stubs

  // configure M_AXI_HPM0_FPD_transactor
    xsc::common_cpp::properties M_AXI_HPM0_FPD_transactor_param_props;
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "8");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "8");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ID_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ADDR_WIDTH", "40");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("AWUSER_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ARUSER_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_BURST", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_LOCK", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_PROT", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_CACHE", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_QOS", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_REGION", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_BRESP", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_RRESP", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_READ_THREADS", "4");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "4");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_SIZE", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_RESET", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXI_HPM0_FPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    M_AXI_HPM0_FPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    M_AXI_HPM0_FPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_M_AXI_HPM0_FPD_transactor = new xtlm::xaximm_xtlm2pin_t<128,40,16,16,1,1,16,1>("M_AXI_HPM0_FPD_transactor", M_AXI_HPM0_FPD_transactor_param_props);
  mp_M_AXI_HPM0_FPD_transactor->AWID(maxigp0_awid);
  mp_M_AXI_HPM0_FPD_transactor->AWADDR(maxigp0_awaddr);
  mp_M_AXI_HPM0_FPD_transactor->AWLEN(maxigp0_awlen);
  mp_M_AXI_HPM0_FPD_transactor->AWSIZE(maxigp0_awsize);
  mp_M_AXI_HPM0_FPD_transactor->AWBURST(maxigp0_awburst);
  mp_M_AXI_HPM0_FPD_transactor->AWLOCK(maxigp0_awlock);
  mp_M_AXI_HPM0_FPD_transactor->AWCACHE(maxigp0_awcache);
  mp_M_AXI_HPM0_FPD_transactor->AWPROT(maxigp0_awprot);
  mp_M_AXI_HPM0_FPD_transactor->AWVALID(maxigp0_awvalid);
  mp_M_AXI_HPM0_FPD_transactor->AWUSER(maxigp0_awuser);
  mp_M_AXI_HPM0_FPD_transactor->AWREADY(maxigp0_awready);
  mp_M_AXI_HPM0_FPD_transactor->WDATA(maxigp0_wdata);
  mp_M_AXI_HPM0_FPD_transactor->WSTRB(maxigp0_wstrb);
  mp_M_AXI_HPM0_FPD_transactor->WLAST(maxigp0_wlast);
  mp_M_AXI_HPM0_FPD_transactor->WVALID(maxigp0_wvalid);
  mp_M_AXI_HPM0_FPD_transactor->WREADY(maxigp0_wready);
  mp_M_AXI_HPM0_FPD_transactor->BID(maxigp0_bid);
  mp_M_AXI_HPM0_FPD_transactor->BRESP(maxigp0_bresp);
  mp_M_AXI_HPM0_FPD_transactor->BVALID(maxigp0_bvalid);
  mp_M_AXI_HPM0_FPD_transactor->BREADY(maxigp0_bready);
  mp_M_AXI_HPM0_FPD_transactor->ARID(maxigp0_arid);
  mp_M_AXI_HPM0_FPD_transactor->ARADDR(maxigp0_araddr);
  mp_M_AXI_HPM0_FPD_transactor->ARLEN(maxigp0_arlen);
  mp_M_AXI_HPM0_FPD_transactor->ARSIZE(maxigp0_arsize);
  mp_M_AXI_HPM0_FPD_transactor->ARBURST(maxigp0_arburst);
  mp_M_AXI_HPM0_FPD_transactor->ARLOCK(maxigp0_arlock);
  mp_M_AXI_HPM0_FPD_transactor->ARCACHE(maxigp0_arcache);
  mp_M_AXI_HPM0_FPD_transactor->ARPROT(maxigp0_arprot);
  mp_M_AXI_HPM0_FPD_transactor->ARVALID(maxigp0_arvalid);
  mp_M_AXI_HPM0_FPD_transactor->ARUSER(maxigp0_aruser);
  mp_M_AXI_HPM0_FPD_transactor->ARREADY(maxigp0_arready);
  mp_M_AXI_HPM0_FPD_transactor->RID(maxigp0_rid);
  mp_M_AXI_HPM0_FPD_transactor->RDATA(maxigp0_rdata);
  mp_M_AXI_HPM0_FPD_transactor->RRESP(maxigp0_rresp);
  mp_M_AXI_HPM0_FPD_transactor->RLAST(maxigp0_rlast);
  mp_M_AXI_HPM0_FPD_transactor->RVALID(maxigp0_rvalid);
  mp_M_AXI_HPM0_FPD_transactor->RREADY(maxigp0_rready);
  mp_M_AXI_HPM0_FPD_transactor->AWQOS(maxigp0_awqos);
  mp_M_AXI_HPM0_FPD_transactor->ARQOS(maxigp0_arqos);
  mp_M_AXI_HPM0_FPD_transactor->CLK(maxihpm0_fpd_aclk);
  m_M_AXI_HPM0_FPD_transactor_rst_signal.write(1);
  mp_M_AXI_HPM0_FPD_transactor->RST(m_M_AXI_HPM0_FPD_transactor_rst_signal);
  // configure M_AXI_HPM0_LPD_transactor
    xsc::common_cpp::properties M_AXI_HPM0_LPD_transactor_param_props;
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "8");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "8");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ID_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ADDR_WIDTH", "40");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("AWUSER_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ARUSER_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_BURST", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_LOCK", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_PROT", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_CACHE", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_QOS", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_REGION", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_BRESP", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_RRESP", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_READ_THREADS", "4");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "4");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_SIZE", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_RESET", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXI_HPM0_LPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    M_AXI_HPM0_LPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    M_AXI_HPM0_LPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_M_AXI_HPM0_LPD_transactor = new xtlm::xaximm_xtlm2pin_t<128,40,16,16,1,1,16,1>("M_AXI_HPM0_LPD_transactor", M_AXI_HPM0_LPD_transactor_param_props);
  mp_M_AXI_HPM0_LPD_transactor->AWID(maxigp2_awid);
  mp_M_AXI_HPM0_LPD_transactor->AWADDR(maxigp2_awaddr);
  mp_M_AXI_HPM0_LPD_transactor->AWLEN(maxigp2_awlen);
  mp_M_AXI_HPM0_LPD_transactor->AWSIZE(maxigp2_awsize);
  mp_M_AXI_HPM0_LPD_transactor->AWBURST(maxigp2_awburst);
  mp_M_AXI_HPM0_LPD_transactor->AWLOCK(maxigp2_awlock);
  mp_M_AXI_HPM0_LPD_transactor->AWCACHE(maxigp2_awcache);
  mp_M_AXI_HPM0_LPD_transactor->AWPROT(maxigp2_awprot);
  mp_M_AXI_HPM0_LPD_transactor->AWVALID(maxigp2_awvalid);
  mp_M_AXI_HPM0_LPD_transactor->AWUSER(maxigp2_awuser);
  mp_M_AXI_HPM0_LPD_transactor->AWREADY(maxigp2_awready);
  mp_M_AXI_HPM0_LPD_transactor->WDATA(maxigp2_wdata);
  mp_M_AXI_HPM0_LPD_transactor->WSTRB(maxigp2_wstrb);
  mp_M_AXI_HPM0_LPD_transactor->WLAST(maxigp2_wlast);
  mp_M_AXI_HPM0_LPD_transactor->WVALID(maxigp2_wvalid);
  mp_M_AXI_HPM0_LPD_transactor->WREADY(maxigp2_wready);
  mp_M_AXI_HPM0_LPD_transactor->BID(maxigp2_bid);
  mp_M_AXI_HPM0_LPD_transactor->BRESP(maxigp2_bresp);
  mp_M_AXI_HPM0_LPD_transactor->BVALID(maxigp2_bvalid);
  mp_M_AXI_HPM0_LPD_transactor->BREADY(maxigp2_bready);
  mp_M_AXI_HPM0_LPD_transactor->ARID(maxigp2_arid);
  mp_M_AXI_HPM0_LPD_transactor->ARADDR(maxigp2_araddr);
  mp_M_AXI_HPM0_LPD_transactor->ARLEN(maxigp2_arlen);
  mp_M_AXI_HPM0_LPD_transactor->ARSIZE(maxigp2_arsize);
  mp_M_AXI_HPM0_LPD_transactor->ARBURST(maxigp2_arburst);
  mp_M_AXI_HPM0_LPD_transactor->ARLOCK(maxigp2_arlock);
  mp_M_AXI_HPM0_LPD_transactor->ARCACHE(maxigp2_arcache);
  mp_M_AXI_HPM0_LPD_transactor->ARPROT(maxigp2_arprot);
  mp_M_AXI_HPM0_LPD_transactor->ARVALID(maxigp2_arvalid);
  mp_M_AXI_HPM0_LPD_transactor->ARUSER(maxigp2_aruser);
  mp_M_AXI_HPM0_LPD_transactor->ARREADY(maxigp2_arready);
  mp_M_AXI_HPM0_LPD_transactor->RID(maxigp2_rid);
  mp_M_AXI_HPM0_LPD_transactor->RDATA(maxigp2_rdata);
  mp_M_AXI_HPM0_LPD_transactor->RRESP(maxigp2_rresp);
  mp_M_AXI_HPM0_LPD_transactor->RLAST(maxigp2_rlast);
  mp_M_AXI_HPM0_LPD_transactor->RVALID(maxigp2_rvalid);
  mp_M_AXI_HPM0_LPD_transactor->RREADY(maxigp2_rready);
  mp_M_AXI_HPM0_LPD_transactor->AWQOS(maxigp2_awqos);
  mp_M_AXI_HPM0_LPD_transactor->ARQOS(maxigp2_arqos);
  mp_M_AXI_HPM0_LPD_transactor->CLK(maxihpm0_lpd_aclk);
  m_M_AXI_HPM0_LPD_transactor_rst_signal.write(1);
  mp_M_AXI_HPM0_LPD_transactor->RST(m_M_AXI_HPM0_LPD_transactor_rst_signal);
  // configure S_AXI_HPC0_FPD_transactor
    xsc::common_cpp::properties S_AXI_HPC0_FPD_transactor_param_props;
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "16");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "16");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ID_WIDTH", "6");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ADDR_WIDTH", "49");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("AWUSER_WIDTH", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ARUSER_WIDTH", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_BURST", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_LOCK", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_PROT", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_CACHE", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_QOS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_REGION", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_BRESP", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_RRESP", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_READ_THREADS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_SIZE", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_RESET", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addFloat("PHASE", "0.0");
    S_AXI_HPC0_FPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    S_AXI_HPC0_FPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    S_AXI_HPC0_FPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_S_AXI_HPC0_FPD_transactor = new xtlm::xaximm_pin2xtlm_t<128,49,6,1,1,1,1,1>("S_AXI_HPC0_FPD_transactor", S_AXI_HPC0_FPD_transactor_param_props);
  mp_saxigp0_aruser_converter = new xsc::common::scalar2vectorN_converter<1>("saxigp0_aruser_converter");
  mp_saxigp0_aruser_converter->scalar_in(saxigp0_aruser);
  mp_saxigp0_aruser_converter->vector_out(m_saxigp0_aruser_converter_signal);
  mp_S_AXI_HPC0_FPD_transactor->ARUSER(m_saxigp0_aruser_converter_signal);
  mp_saxigp0_awuser_converter = new xsc::common::scalar2vectorN_converter<1>("saxigp0_awuser_converter");
  mp_saxigp0_awuser_converter->scalar_in(saxigp0_awuser);
  mp_saxigp0_awuser_converter->vector_out(m_saxigp0_awuser_converter_signal);
  mp_S_AXI_HPC0_FPD_transactor->AWUSER(m_saxigp0_awuser_converter_signal);
  mp_S_AXI_HPC0_FPD_transactor->AWID(saxigp0_awid);
  mp_S_AXI_HPC0_FPD_transactor->AWADDR(saxigp0_awaddr);
  mp_S_AXI_HPC0_FPD_transactor->AWLEN(saxigp0_awlen);
  mp_S_AXI_HPC0_FPD_transactor->AWSIZE(saxigp0_awsize);
  mp_S_AXI_HPC0_FPD_transactor->AWBURST(saxigp0_awburst);
  mp_S_AXI_HPC0_FPD_transactor->AWLOCK(saxigp0_awlock);
  mp_S_AXI_HPC0_FPD_transactor->AWCACHE(saxigp0_awcache);
  mp_S_AXI_HPC0_FPD_transactor->AWPROT(saxigp0_awprot);
  mp_S_AXI_HPC0_FPD_transactor->AWVALID(saxigp0_awvalid);
  mp_S_AXI_HPC0_FPD_transactor->AWREADY(saxigp0_awready);
  mp_S_AXI_HPC0_FPD_transactor->WDATA(saxigp0_wdata);
  mp_S_AXI_HPC0_FPD_transactor->WSTRB(saxigp0_wstrb);
  mp_S_AXI_HPC0_FPD_transactor->WLAST(saxigp0_wlast);
  mp_S_AXI_HPC0_FPD_transactor->WVALID(saxigp0_wvalid);
  mp_S_AXI_HPC0_FPD_transactor->WREADY(saxigp0_wready);
  mp_S_AXI_HPC0_FPD_transactor->BID(saxigp0_bid);
  mp_S_AXI_HPC0_FPD_transactor->BRESP(saxigp0_bresp);
  mp_S_AXI_HPC0_FPD_transactor->BVALID(saxigp0_bvalid);
  mp_S_AXI_HPC0_FPD_transactor->BREADY(saxigp0_bready);
  mp_S_AXI_HPC0_FPD_transactor->ARID(saxigp0_arid);
  mp_S_AXI_HPC0_FPD_transactor->ARADDR(saxigp0_araddr);
  mp_S_AXI_HPC0_FPD_transactor->ARLEN(saxigp0_arlen);
  mp_S_AXI_HPC0_FPD_transactor->ARSIZE(saxigp0_arsize);
  mp_S_AXI_HPC0_FPD_transactor->ARBURST(saxigp0_arburst);
  mp_S_AXI_HPC0_FPD_transactor->ARLOCK(saxigp0_arlock);
  mp_S_AXI_HPC0_FPD_transactor->ARCACHE(saxigp0_arcache);
  mp_S_AXI_HPC0_FPD_transactor->ARPROT(saxigp0_arprot);
  mp_S_AXI_HPC0_FPD_transactor->ARVALID(saxigp0_arvalid);
  mp_S_AXI_HPC0_FPD_transactor->ARREADY(saxigp0_arready);
  mp_S_AXI_HPC0_FPD_transactor->RID(saxigp0_rid);
  mp_S_AXI_HPC0_FPD_transactor->RDATA(saxigp0_rdata);
  mp_S_AXI_HPC0_FPD_transactor->RRESP(saxigp0_rresp);
  mp_S_AXI_HPC0_FPD_transactor->RLAST(saxigp0_rlast);
  mp_S_AXI_HPC0_FPD_transactor->RVALID(saxigp0_rvalid);
  mp_S_AXI_HPC0_FPD_transactor->RREADY(saxigp0_rready);
  mp_S_AXI_HPC0_FPD_transactor->AWQOS(saxigp0_awqos);
  mp_S_AXI_HPC0_FPD_transactor->ARQOS(saxigp0_arqos);
  mp_S_AXI_HPC0_FPD_transactor->CLK(saxihpc0_fpd_aclk);
  m_S_AXI_HPC0_FPD_transactor_rst_signal.write(1);
  mp_S_AXI_HPC0_FPD_transactor->RST(m_S_AXI_HPC0_FPD_transactor_rst_signal);

  // initialize transactors stubs
  M_AXI_HPM0_FPD_transactor_initiator_wr_socket_stub = nullptr;
  M_AXI_HPM0_FPD_transactor_initiator_rd_socket_stub = nullptr;
  M_AXI_HPM0_LPD_transactor_initiator_wr_socket_stub = nullptr;
  M_AXI_HPM0_LPD_transactor_initiator_rd_socket_stub = nullptr;
  S_AXI_HPC0_FPD_transactor_target_wr_socket_stub = nullptr;
  S_AXI_HPC0_FPD_transactor_target_rd_socket_stub = nullptr;

}

void design_1_zynq_ultra_ps_e_0_0::before_end_of_elaboration()
{
  // configure 'M_AXI_HPM0_FPD' transactor
  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "M_AXI_HPM0_FPD_TLM_MODE") != 1)
  {
    mp_impl->M_AXI_HPM0_FPD_rd_socket->bind(*(mp_M_AXI_HPM0_FPD_transactor->rd_socket));
    mp_impl->M_AXI_HPM0_FPD_wr_socket->bind(*(mp_M_AXI_HPM0_FPD_transactor->wr_socket));
  
  }
  else
  {
    M_AXI_HPM0_FPD_transactor_initiator_wr_socket_stub = new xtlm::xtlm_aximm_initiator_stub("wr_socket",0);
    M_AXI_HPM0_FPD_transactor_initiator_wr_socket_stub->bind(*(mp_M_AXI_HPM0_FPD_transactor->wr_socket));
    M_AXI_HPM0_FPD_transactor_initiator_rd_socket_stub = new xtlm::xtlm_aximm_initiator_stub("rd_socket",0);
    M_AXI_HPM0_FPD_transactor_initiator_rd_socket_stub->bind(*(mp_M_AXI_HPM0_FPD_transactor->rd_socket));
    mp_M_AXI_HPM0_FPD_transactor->disable_transactor();
  }

  // configure 'M_AXI_HPM0_LPD' transactor
  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "M_AXI_HPM0_LPD_TLM_MODE") != 1)
  {
    mp_impl->M_AXI_HPM0_LPD_rd_socket->bind(*(mp_M_AXI_HPM0_LPD_transactor->rd_socket));
    mp_impl->M_AXI_HPM0_LPD_wr_socket->bind(*(mp_M_AXI_HPM0_LPD_transactor->wr_socket));
  
  }
  else
  {
    M_AXI_HPM0_LPD_transactor_initiator_wr_socket_stub = new xtlm::xtlm_aximm_initiator_stub("wr_socket",0);
    M_AXI_HPM0_LPD_transactor_initiator_wr_socket_stub->bind(*(mp_M_AXI_HPM0_LPD_transactor->wr_socket));
    M_AXI_HPM0_LPD_transactor_initiator_rd_socket_stub = new xtlm::xtlm_aximm_initiator_stub("rd_socket",0);
    M_AXI_HPM0_LPD_transactor_initiator_rd_socket_stub->bind(*(mp_M_AXI_HPM0_LPD_transactor->rd_socket));
    mp_M_AXI_HPM0_LPD_transactor->disable_transactor();
  }

  // configure 'S_AXI_HPC0_FPD' transactor
  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "S_AXI_HPC0_FPD_TLM_MODE") != 1)
  {
    mp_impl->S_AXI_HPC0_FPD_rd_socket->bind(*(mp_S_AXI_HPC0_FPD_transactor->rd_socket));
    mp_impl->S_AXI_HPC0_FPD_wr_socket->bind(*(mp_S_AXI_HPC0_FPD_transactor->wr_socket));
  
  }
  else
  {
    S_AXI_HPC0_FPD_transactor_target_wr_socket_stub = new xtlm::xtlm_aximm_target_stub("wr_socket",0);
    S_AXI_HPC0_FPD_transactor_target_wr_socket_stub->bind(*(mp_S_AXI_HPC0_FPD_transactor->wr_socket));
    S_AXI_HPC0_FPD_transactor_target_rd_socket_stub = new xtlm::xtlm_aximm_target_stub("rd_socket",0);
    S_AXI_HPC0_FPD_transactor_target_rd_socket_stub->bind(*(mp_S_AXI_HPC0_FPD_transactor->rd_socket));
    mp_S_AXI_HPC0_FPD_transactor->disable_transactor();
  }

}

#endif // VCSSYSTEMC




#ifdef MTI_SYSTEMC
design_1_zynq_ultra_ps_e_0_0::design_1_zynq_ultra_ps_e_0_0(const sc_core::sc_module_name& nm) : design_1_zynq_ultra_ps_e_0_0_sc(nm),  maxihpm0_fpd_aclk("maxihpm0_fpd_aclk"), maxigp0_awid("maxigp0_awid"), maxigp0_awaddr("maxigp0_awaddr"), maxigp0_awlen("maxigp0_awlen"), maxigp0_awsize("maxigp0_awsize"), maxigp0_awburst("maxigp0_awburst"), maxigp0_awlock("maxigp0_awlock"), maxigp0_awcache("maxigp0_awcache"), maxigp0_awprot("maxigp0_awprot"), maxigp0_awvalid("maxigp0_awvalid"), maxigp0_awuser("maxigp0_awuser"), maxigp0_awready("maxigp0_awready"), maxigp0_wdata("maxigp0_wdata"), maxigp0_wstrb("maxigp0_wstrb"), maxigp0_wlast("maxigp0_wlast"), maxigp0_wvalid("maxigp0_wvalid"), maxigp0_wready("maxigp0_wready"), maxigp0_bid("maxigp0_bid"), maxigp0_bresp("maxigp0_bresp"), maxigp0_bvalid("maxigp0_bvalid"), maxigp0_bready("maxigp0_bready"), maxigp0_arid("maxigp0_arid"), maxigp0_araddr("maxigp0_araddr"), maxigp0_arlen("maxigp0_arlen"), maxigp0_arsize("maxigp0_arsize"), maxigp0_arburst("maxigp0_arburst"), maxigp0_arlock("maxigp0_arlock"), maxigp0_arcache("maxigp0_arcache"), maxigp0_arprot("maxigp0_arprot"), maxigp0_arvalid("maxigp0_arvalid"), maxigp0_aruser("maxigp0_aruser"), maxigp0_arready("maxigp0_arready"), maxigp0_rid("maxigp0_rid"), maxigp0_rdata("maxigp0_rdata"), maxigp0_rresp("maxigp0_rresp"), maxigp0_rlast("maxigp0_rlast"), maxigp0_rvalid("maxigp0_rvalid"), maxigp0_rready("maxigp0_rready"), maxigp0_awqos("maxigp0_awqos"), maxigp0_arqos("maxigp0_arqos"), maxihpm0_lpd_aclk("maxihpm0_lpd_aclk"), maxigp2_awid("maxigp2_awid"), maxigp2_awaddr("maxigp2_awaddr"), maxigp2_awlen("maxigp2_awlen"), maxigp2_awsize("maxigp2_awsize"), maxigp2_awburst("maxigp2_awburst"), maxigp2_awlock("maxigp2_awlock"), maxigp2_awcache("maxigp2_awcache"), maxigp2_awprot("maxigp2_awprot"), maxigp2_awvalid("maxigp2_awvalid"), maxigp2_awuser("maxigp2_awuser"), maxigp2_awready("maxigp2_awready"), maxigp2_wdata("maxigp2_wdata"), maxigp2_wstrb("maxigp2_wstrb"), maxigp2_wlast("maxigp2_wlast"), maxigp2_wvalid("maxigp2_wvalid"), maxigp2_wready("maxigp2_wready"), maxigp2_bid("maxigp2_bid"), maxigp2_bresp("maxigp2_bresp"), maxigp2_bvalid("maxigp2_bvalid"), maxigp2_bready("maxigp2_bready"), maxigp2_arid("maxigp2_arid"), maxigp2_araddr("maxigp2_araddr"), maxigp2_arlen("maxigp2_arlen"), maxigp2_arsize("maxigp2_arsize"), maxigp2_arburst("maxigp2_arburst"), maxigp2_arlock("maxigp2_arlock"), maxigp2_arcache("maxigp2_arcache"), maxigp2_arprot("maxigp2_arprot"), maxigp2_arvalid("maxigp2_arvalid"), maxigp2_aruser("maxigp2_aruser"), maxigp2_arready("maxigp2_arready"), maxigp2_rid("maxigp2_rid"), maxigp2_rdata("maxigp2_rdata"), maxigp2_rresp("maxigp2_rresp"), maxigp2_rlast("maxigp2_rlast"), maxigp2_rvalid("maxigp2_rvalid"), maxigp2_rready("maxigp2_rready"), maxigp2_awqos("maxigp2_awqos"), maxigp2_arqos("maxigp2_arqos"), saxihpc0_fpd_aclk("saxihpc0_fpd_aclk"), saxigp0_aruser("saxigp0_aruser"), saxigp0_awuser("saxigp0_awuser"), saxigp0_awid("saxigp0_awid"), saxigp0_awaddr("saxigp0_awaddr"), saxigp0_awlen("saxigp0_awlen"), saxigp0_awsize("saxigp0_awsize"), saxigp0_awburst("saxigp0_awburst"), saxigp0_awlock("saxigp0_awlock"), saxigp0_awcache("saxigp0_awcache"), saxigp0_awprot("saxigp0_awprot"), saxigp0_awvalid("saxigp0_awvalid"), saxigp0_awready("saxigp0_awready"), saxigp0_wdata("saxigp0_wdata"), saxigp0_wstrb("saxigp0_wstrb"), saxigp0_wlast("saxigp0_wlast"), saxigp0_wvalid("saxigp0_wvalid"), saxigp0_wready("saxigp0_wready"), saxigp0_bid("saxigp0_bid"), saxigp0_bresp("saxigp0_bresp"), saxigp0_bvalid("saxigp0_bvalid"), saxigp0_bready("saxigp0_bready"), saxigp0_arid("saxigp0_arid"), saxigp0_araddr("saxigp0_araddr"), saxigp0_arlen("saxigp0_arlen"), saxigp0_arsize("saxigp0_arsize"), saxigp0_arburst("saxigp0_arburst"), saxigp0_arlock("saxigp0_arlock"), saxigp0_arcache("saxigp0_arcache"), saxigp0_arprot("saxigp0_arprot"), saxigp0_arvalid("saxigp0_arvalid"), saxigp0_arready("saxigp0_arready"), saxigp0_rid("saxigp0_rid"), saxigp0_rdata("saxigp0_rdata"), saxigp0_rresp("saxigp0_rresp"), saxigp0_rlast("saxigp0_rlast"), saxigp0_rvalid("saxigp0_rvalid"), saxigp0_rready("saxigp0_rready"), saxigp0_awqos("saxigp0_awqos"), saxigp0_arqos("saxigp0_arqos"), sacefpd_aclk("sacefpd_aclk"), sacefpd_wuser("sacefpd_wuser"), sacefpd_buser("sacefpd_buser"), sacefpd_ruser("sacefpd_ruser"), sacefpd_awuser("sacefpd_awuser"), sacefpd_awsnoop("sacefpd_awsnoop"), sacefpd_awsize("sacefpd_awsize"), sacefpd_awregion("sacefpd_awregion"), sacefpd_awqos("sacefpd_awqos"), sacefpd_awprot("sacefpd_awprot"), sacefpd_awlen("sacefpd_awlen"), sacefpd_awid("sacefpd_awid"), sacefpd_awdomain("sacefpd_awdomain"), sacefpd_awcache("sacefpd_awcache"), sacefpd_awburst("sacefpd_awburst"), sacefpd_awbar("sacefpd_awbar"), sacefpd_awaddr("sacefpd_awaddr"), sacefpd_awlock("sacefpd_awlock"), sacefpd_awvalid("sacefpd_awvalid"), sacefpd_awready("sacefpd_awready"), sacefpd_wstrb("sacefpd_wstrb"), sacefpd_wdata("sacefpd_wdata"), sacefpd_wlast("sacefpd_wlast"), sacefpd_wvalid("sacefpd_wvalid"), sacefpd_wready("sacefpd_wready"), sacefpd_bresp("sacefpd_bresp"), sacefpd_bid("sacefpd_bid"), sacefpd_bvalid("sacefpd_bvalid"), sacefpd_bready("sacefpd_bready"), sacefpd_aruser("sacefpd_aruser"), sacefpd_arsnoop("sacefpd_arsnoop"), sacefpd_arsize("sacefpd_arsize"), sacefpd_arregion("sacefpd_arregion"), sacefpd_arqos("sacefpd_arqos"), sacefpd_arprot("sacefpd_arprot"), sacefpd_arlen("sacefpd_arlen"), sacefpd_arid("sacefpd_arid"), sacefpd_ardomain("sacefpd_ardomain"), sacefpd_arcache("sacefpd_arcache"), sacefpd_arburst("sacefpd_arburst"), sacefpd_arbar("sacefpd_arbar"), sacefpd_araddr("sacefpd_araddr"), sacefpd_arlock("sacefpd_arlock"), sacefpd_arvalid("sacefpd_arvalid"), sacefpd_arready("sacefpd_arready"), sacefpd_rresp("sacefpd_rresp"), sacefpd_rid("sacefpd_rid"), sacefpd_rdata("sacefpd_rdata"), sacefpd_rlast("sacefpd_rlast"), sacefpd_rvalid("sacefpd_rvalid"), sacefpd_rready("sacefpd_rready"), sacefpd_acsnoop("sacefpd_acsnoop"), sacefpd_acprot("sacefpd_acprot"), sacefpd_acaddr("sacefpd_acaddr"), sacefpd_acvalid("sacefpd_acvalid"), sacefpd_acready("sacefpd_acready"), sacefpd_cddata("sacefpd_cddata"), sacefpd_cdlast("sacefpd_cdlast"), sacefpd_cdvalid("sacefpd_cdvalid"), sacefpd_cdready("sacefpd_cdready"), sacefpd_crresp("sacefpd_crresp"), sacefpd_crvalid("sacefpd_crvalid"), sacefpd_crready("sacefpd_crready"), sacefpd_wack("sacefpd_wack"), sacefpd_rack("sacefpd_rack"), pl_ps_irq0("pl_ps_irq0"), pl_resetn0("pl_resetn0"), pl_clk0("pl_clk0")
{
  // initialize pins
  mp_impl->maxihpm0_fpd_aclk(maxihpm0_fpd_aclk);
  mp_impl->maxihpm0_lpd_aclk(maxihpm0_lpd_aclk);
  mp_impl->saxihpc0_fpd_aclk(saxihpc0_fpd_aclk);
  mp_impl->sacefpd_aclk(sacefpd_aclk);
  mp_impl->sacefpd_wuser(sacefpd_wuser);
  mp_impl->sacefpd_buser(sacefpd_buser);
  mp_impl->sacefpd_ruser(sacefpd_ruser);
  mp_impl->sacefpd_awuser(sacefpd_awuser);
  mp_impl->sacefpd_awsnoop(sacefpd_awsnoop);
  mp_impl->sacefpd_awsize(sacefpd_awsize);
  mp_impl->sacefpd_awregion(sacefpd_awregion);
  mp_impl->sacefpd_awqos(sacefpd_awqos);
  mp_impl->sacefpd_awprot(sacefpd_awprot);
  mp_impl->sacefpd_awlen(sacefpd_awlen);
  mp_impl->sacefpd_awid(sacefpd_awid);
  mp_impl->sacefpd_awdomain(sacefpd_awdomain);
  mp_impl->sacefpd_awcache(sacefpd_awcache);
  mp_impl->sacefpd_awburst(sacefpd_awburst);
  mp_impl->sacefpd_awbar(sacefpd_awbar);
  mp_impl->sacefpd_awaddr(sacefpd_awaddr);
  mp_impl->sacefpd_awlock(sacefpd_awlock);
  mp_impl->sacefpd_awvalid(sacefpd_awvalid);
  mp_impl->sacefpd_awready(sacefpd_awready);
  mp_impl->sacefpd_wstrb(sacefpd_wstrb);
  mp_impl->sacefpd_wdata(sacefpd_wdata);
  mp_impl->sacefpd_wlast(sacefpd_wlast);
  mp_impl->sacefpd_wvalid(sacefpd_wvalid);
  mp_impl->sacefpd_wready(sacefpd_wready);
  mp_impl->sacefpd_bresp(sacefpd_bresp);
  mp_impl->sacefpd_bid(sacefpd_bid);
  mp_impl->sacefpd_bvalid(sacefpd_bvalid);
  mp_impl->sacefpd_bready(sacefpd_bready);
  mp_impl->sacefpd_aruser(sacefpd_aruser);
  mp_impl->sacefpd_arsnoop(sacefpd_arsnoop);
  mp_impl->sacefpd_arsize(sacefpd_arsize);
  mp_impl->sacefpd_arregion(sacefpd_arregion);
  mp_impl->sacefpd_arqos(sacefpd_arqos);
  mp_impl->sacefpd_arprot(sacefpd_arprot);
  mp_impl->sacefpd_arlen(sacefpd_arlen);
  mp_impl->sacefpd_arid(sacefpd_arid);
  mp_impl->sacefpd_ardomain(sacefpd_ardomain);
  mp_impl->sacefpd_arcache(sacefpd_arcache);
  mp_impl->sacefpd_arburst(sacefpd_arburst);
  mp_impl->sacefpd_arbar(sacefpd_arbar);
  mp_impl->sacefpd_araddr(sacefpd_araddr);
  mp_impl->sacefpd_arlock(sacefpd_arlock);
  mp_impl->sacefpd_arvalid(sacefpd_arvalid);
  mp_impl->sacefpd_arready(sacefpd_arready);
  mp_impl->sacefpd_rresp(sacefpd_rresp);
  mp_impl->sacefpd_rid(sacefpd_rid);
  mp_impl->sacefpd_rdata(sacefpd_rdata);
  mp_impl->sacefpd_rlast(sacefpd_rlast);
  mp_impl->sacefpd_rvalid(sacefpd_rvalid);
  mp_impl->sacefpd_rready(sacefpd_rready);
  mp_impl->sacefpd_acsnoop(sacefpd_acsnoop);
  mp_impl->sacefpd_acprot(sacefpd_acprot);
  mp_impl->sacefpd_acaddr(sacefpd_acaddr);
  mp_impl->sacefpd_acvalid(sacefpd_acvalid);
  mp_impl->sacefpd_acready(sacefpd_acready);
  mp_impl->sacefpd_cddata(sacefpd_cddata);
  mp_impl->sacefpd_cdlast(sacefpd_cdlast);
  mp_impl->sacefpd_cdvalid(sacefpd_cdvalid);
  mp_impl->sacefpd_cdready(sacefpd_cdready);
  mp_impl->sacefpd_crresp(sacefpd_crresp);
  mp_impl->sacefpd_crvalid(sacefpd_crvalid);
  mp_impl->sacefpd_crready(sacefpd_crready);
  mp_impl->sacefpd_wack(sacefpd_wack);
  mp_impl->sacefpd_rack(sacefpd_rack);
  mp_impl->pl_ps_irq0(pl_ps_irq0);
  mp_impl->pl_resetn0(pl_resetn0);
  mp_impl->pl_clk0(pl_clk0);

  // initialize transactors
  mp_M_AXI_HPM0_FPD_transactor = NULL;
  mp_M_AXI_HPM0_LPD_transactor = NULL;
  mp_S_AXI_HPC0_FPD_transactor = NULL;
  mp_saxigp0_aruser_converter = NULL;
  mp_saxigp0_awuser_converter = NULL;

  // Instantiate Socket Stubs

  // configure M_AXI_HPM0_FPD_transactor
    xsc::common_cpp::properties M_AXI_HPM0_FPD_transactor_param_props;
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "8");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "8");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ID_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ADDR_WIDTH", "40");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("AWUSER_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("ARUSER_WIDTH", "16");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_BURST", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_LOCK", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_PROT", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_CACHE", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_QOS", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_REGION", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_BRESP", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_RRESP", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_READ_THREADS", "4");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "4");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_SIZE", "1");
    M_AXI_HPM0_FPD_transactor_param_props.addLong("HAS_RESET", "0");
    M_AXI_HPM0_FPD_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXI_HPM0_FPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    M_AXI_HPM0_FPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    M_AXI_HPM0_FPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_M_AXI_HPM0_FPD_transactor = new xtlm::xaximm_xtlm2pin_t<128,40,16,16,1,1,16,1>("M_AXI_HPM0_FPD_transactor", M_AXI_HPM0_FPD_transactor_param_props);
  mp_M_AXI_HPM0_FPD_transactor->AWID(maxigp0_awid);
  mp_M_AXI_HPM0_FPD_transactor->AWADDR(maxigp0_awaddr);
  mp_M_AXI_HPM0_FPD_transactor->AWLEN(maxigp0_awlen);
  mp_M_AXI_HPM0_FPD_transactor->AWSIZE(maxigp0_awsize);
  mp_M_AXI_HPM0_FPD_transactor->AWBURST(maxigp0_awburst);
  mp_M_AXI_HPM0_FPD_transactor->AWLOCK(maxigp0_awlock);
  mp_M_AXI_HPM0_FPD_transactor->AWCACHE(maxigp0_awcache);
  mp_M_AXI_HPM0_FPD_transactor->AWPROT(maxigp0_awprot);
  mp_M_AXI_HPM0_FPD_transactor->AWVALID(maxigp0_awvalid);
  mp_M_AXI_HPM0_FPD_transactor->AWUSER(maxigp0_awuser);
  mp_M_AXI_HPM0_FPD_transactor->AWREADY(maxigp0_awready);
  mp_M_AXI_HPM0_FPD_transactor->WDATA(maxigp0_wdata);
  mp_M_AXI_HPM0_FPD_transactor->WSTRB(maxigp0_wstrb);
  mp_M_AXI_HPM0_FPD_transactor->WLAST(maxigp0_wlast);
  mp_M_AXI_HPM0_FPD_transactor->WVALID(maxigp0_wvalid);
  mp_M_AXI_HPM0_FPD_transactor->WREADY(maxigp0_wready);
  mp_M_AXI_HPM0_FPD_transactor->BID(maxigp0_bid);
  mp_M_AXI_HPM0_FPD_transactor->BRESP(maxigp0_bresp);
  mp_M_AXI_HPM0_FPD_transactor->BVALID(maxigp0_bvalid);
  mp_M_AXI_HPM0_FPD_transactor->BREADY(maxigp0_bready);
  mp_M_AXI_HPM0_FPD_transactor->ARID(maxigp0_arid);
  mp_M_AXI_HPM0_FPD_transactor->ARADDR(maxigp0_araddr);
  mp_M_AXI_HPM0_FPD_transactor->ARLEN(maxigp0_arlen);
  mp_M_AXI_HPM0_FPD_transactor->ARSIZE(maxigp0_arsize);
  mp_M_AXI_HPM0_FPD_transactor->ARBURST(maxigp0_arburst);
  mp_M_AXI_HPM0_FPD_transactor->ARLOCK(maxigp0_arlock);
  mp_M_AXI_HPM0_FPD_transactor->ARCACHE(maxigp0_arcache);
  mp_M_AXI_HPM0_FPD_transactor->ARPROT(maxigp0_arprot);
  mp_M_AXI_HPM0_FPD_transactor->ARVALID(maxigp0_arvalid);
  mp_M_AXI_HPM0_FPD_transactor->ARUSER(maxigp0_aruser);
  mp_M_AXI_HPM0_FPD_transactor->ARREADY(maxigp0_arready);
  mp_M_AXI_HPM0_FPD_transactor->RID(maxigp0_rid);
  mp_M_AXI_HPM0_FPD_transactor->RDATA(maxigp0_rdata);
  mp_M_AXI_HPM0_FPD_transactor->RRESP(maxigp0_rresp);
  mp_M_AXI_HPM0_FPD_transactor->RLAST(maxigp0_rlast);
  mp_M_AXI_HPM0_FPD_transactor->RVALID(maxigp0_rvalid);
  mp_M_AXI_HPM0_FPD_transactor->RREADY(maxigp0_rready);
  mp_M_AXI_HPM0_FPD_transactor->AWQOS(maxigp0_awqos);
  mp_M_AXI_HPM0_FPD_transactor->ARQOS(maxigp0_arqos);
  mp_M_AXI_HPM0_FPD_transactor->CLK(maxihpm0_fpd_aclk);
  m_M_AXI_HPM0_FPD_transactor_rst_signal.write(1);
  mp_M_AXI_HPM0_FPD_transactor->RST(m_M_AXI_HPM0_FPD_transactor_rst_signal);
  // configure M_AXI_HPM0_LPD_transactor
    xsc::common_cpp::properties M_AXI_HPM0_LPD_transactor_param_props;
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "8");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "8");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ID_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ADDR_WIDTH", "40");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("AWUSER_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("ARUSER_WIDTH", "16");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_BURST", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_LOCK", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_PROT", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_CACHE", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_QOS", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_REGION", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_BRESP", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_RRESP", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_READ_THREADS", "4");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "4");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_SIZE", "1");
    M_AXI_HPM0_LPD_transactor_param_props.addLong("HAS_RESET", "0");
    M_AXI_HPM0_LPD_transactor_param_props.addFloat("PHASE", "0.0");
    M_AXI_HPM0_LPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    M_AXI_HPM0_LPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    M_AXI_HPM0_LPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_M_AXI_HPM0_LPD_transactor = new xtlm::xaximm_xtlm2pin_t<128,40,16,16,1,1,16,1>("M_AXI_HPM0_LPD_transactor", M_AXI_HPM0_LPD_transactor_param_props);
  mp_M_AXI_HPM0_LPD_transactor->AWID(maxigp2_awid);
  mp_M_AXI_HPM0_LPD_transactor->AWADDR(maxigp2_awaddr);
  mp_M_AXI_HPM0_LPD_transactor->AWLEN(maxigp2_awlen);
  mp_M_AXI_HPM0_LPD_transactor->AWSIZE(maxigp2_awsize);
  mp_M_AXI_HPM0_LPD_transactor->AWBURST(maxigp2_awburst);
  mp_M_AXI_HPM0_LPD_transactor->AWLOCK(maxigp2_awlock);
  mp_M_AXI_HPM0_LPD_transactor->AWCACHE(maxigp2_awcache);
  mp_M_AXI_HPM0_LPD_transactor->AWPROT(maxigp2_awprot);
  mp_M_AXI_HPM0_LPD_transactor->AWVALID(maxigp2_awvalid);
  mp_M_AXI_HPM0_LPD_transactor->AWUSER(maxigp2_awuser);
  mp_M_AXI_HPM0_LPD_transactor->AWREADY(maxigp2_awready);
  mp_M_AXI_HPM0_LPD_transactor->WDATA(maxigp2_wdata);
  mp_M_AXI_HPM0_LPD_transactor->WSTRB(maxigp2_wstrb);
  mp_M_AXI_HPM0_LPD_transactor->WLAST(maxigp2_wlast);
  mp_M_AXI_HPM0_LPD_transactor->WVALID(maxigp2_wvalid);
  mp_M_AXI_HPM0_LPD_transactor->WREADY(maxigp2_wready);
  mp_M_AXI_HPM0_LPD_transactor->BID(maxigp2_bid);
  mp_M_AXI_HPM0_LPD_transactor->BRESP(maxigp2_bresp);
  mp_M_AXI_HPM0_LPD_transactor->BVALID(maxigp2_bvalid);
  mp_M_AXI_HPM0_LPD_transactor->BREADY(maxigp2_bready);
  mp_M_AXI_HPM0_LPD_transactor->ARID(maxigp2_arid);
  mp_M_AXI_HPM0_LPD_transactor->ARADDR(maxigp2_araddr);
  mp_M_AXI_HPM0_LPD_transactor->ARLEN(maxigp2_arlen);
  mp_M_AXI_HPM0_LPD_transactor->ARSIZE(maxigp2_arsize);
  mp_M_AXI_HPM0_LPD_transactor->ARBURST(maxigp2_arburst);
  mp_M_AXI_HPM0_LPD_transactor->ARLOCK(maxigp2_arlock);
  mp_M_AXI_HPM0_LPD_transactor->ARCACHE(maxigp2_arcache);
  mp_M_AXI_HPM0_LPD_transactor->ARPROT(maxigp2_arprot);
  mp_M_AXI_HPM0_LPD_transactor->ARVALID(maxigp2_arvalid);
  mp_M_AXI_HPM0_LPD_transactor->ARUSER(maxigp2_aruser);
  mp_M_AXI_HPM0_LPD_transactor->ARREADY(maxigp2_arready);
  mp_M_AXI_HPM0_LPD_transactor->RID(maxigp2_rid);
  mp_M_AXI_HPM0_LPD_transactor->RDATA(maxigp2_rdata);
  mp_M_AXI_HPM0_LPD_transactor->RRESP(maxigp2_rresp);
  mp_M_AXI_HPM0_LPD_transactor->RLAST(maxigp2_rlast);
  mp_M_AXI_HPM0_LPD_transactor->RVALID(maxigp2_rvalid);
  mp_M_AXI_HPM0_LPD_transactor->RREADY(maxigp2_rready);
  mp_M_AXI_HPM0_LPD_transactor->AWQOS(maxigp2_awqos);
  mp_M_AXI_HPM0_LPD_transactor->ARQOS(maxigp2_arqos);
  mp_M_AXI_HPM0_LPD_transactor->CLK(maxihpm0_lpd_aclk);
  m_M_AXI_HPM0_LPD_transactor_rst_signal.write(1);
  mp_M_AXI_HPM0_LPD_transactor->RST(m_M_AXI_HPM0_LPD_transactor_rst_signal);
  // configure S_AXI_HPC0_FPD_transactor
    xsc::common_cpp::properties S_AXI_HPC0_FPD_transactor_param_props;
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_WRITE_OUTSTANDING", "16");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_READ_OUTSTANDING", "16");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("DATA_WIDTH", "128");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("FREQ_HZ", "149985016");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ID_WIDTH", "6");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ADDR_WIDTH", "49");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("AWUSER_WIDTH", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("ARUSER_WIDTH", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("WUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("RUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("BUSER_WIDTH", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_BURST", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_LOCK", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_PROT", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_CACHE", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_QOS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_REGION", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_WSTRB", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_BRESP", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_RRESP", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("SUPPORTS_NARROW_BURST", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("MAX_BURST_LENGTH", "256");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_READ_THREADS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("NUM_WRITE_THREADS", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("RUSER_BITS_PER_BYTE", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("WUSER_BITS_PER_BYTE", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_SIZE", "1");
    S_AXI_HPC0_FPD_transactor_param_props.addLong("HAS_RESET", "0");
    S_AXI_HPC0_FPD_transactor_param_props.addFloat("PHASE", "0.0");
    S_AXI_HPC0_FPD_transactor_param_props.addString("PROTOCOL", "AXI4");
    S_AXI_HPC0_FPD_transactor_param_props.addString("READ_WRITE_MODE", "READ_WRITE");
    S_AXI_HPC0_FPD_transactor_param_props.addString("CLK_DOMAIN", "design_1_zynq_ultra_ps_e_0_0_pl_clk0");

    mp_S_AXI_HPC0_FPD_transactor = new xtlm::xaximm_pin2xtlm_t<128,49,6,1,1,1,1,1>("S_AXI_HPC0_FPD_transactor", S_AXI_HPC0_FPD_transactor_param_props);
  mp_saxigp0_aruser_converter = new xsc::common::scalar2vectorN_converter<1>("saxigp0_aruser_converter");
  mp_saxigp0_aruser_converter->scalar_in(saxigp0_aruser);
  mp_saxigp0_aruser_converter->vector_out(m_saxigp0_aruser_converter_signal);
  mp_S_AXI_HPC0_FPD_transactor->ARUSER(m_saxigp0_aruser_converter_signal);
  mp_saxigp0_awuser_converter = new xsc::common::scalar2vectorN_converter<1>("saxigp0_awuser_converter");
  mp_saxigp0_awuser_converter->scalar_in(saxigp0_awuser);
  mp_saxigp0_awuser_converter->vector_out(m_saxigp0_awuser_converter_signal);
  mp_S_AXI_HPC0_FPD_transactor->AWUSER(m_saxigp0_awuser_converter_signal);
  mp_S_AXI_HPC0_FPD_transactor->AWID(saxigp0_awid);
  mp_S_AXI_HPC0_FPD_transactor->AWADDR(saxigp0_awaddr);
  mp_S_AXI_HPC0_FPD_transactor->AWLEN(saxigp0_awlen);
  mp_S_AXI_HPC0_FPD_transactor->AWSIZE(saxigp0_awsize);
  mp_S_AXI_HPC0_FPD_transactor->AWBURST(saxigp0_awburst);
  mp_S_AXI_HPC0_FPD_transactor->AWLOCK(saxigp0_awlock);
  mp_S_AXI_HPC0_FPD_transactor->AWCACHE(saxigp0_awcache);
  mp_S_AXI_HPC0_FPD_transactor->AWPROT(saxigp0_awprot);
  mp_S_AXI_HPC0_FPD_transactor->AWVALID(saxigp0_awvalid);
  mp_S_AXI_HPC0_FPD_transactor->AWREADY(saxigp0_awready);
  mp_S_AXI_HPC0_FPD_transactor->WDATA(saxigp0_wdata);
  mp_S_AXI_HPC0_FPD_transactor->WSTRB(saxigp0_wstrb);
  mp_S_AXI_HPC0_FPD_transactor->WLAST(saxigp0_wlast);
  mp_S_AXI_HPC0_FPD_transactor->WVALID(saxigp0_wvalid);
  mp_S_AXI_HPC0_FPD_transactor->WREADY(saxigp0_wready);
  mp_S_AXI_HPC0_FPD_transactor->BID(saxigp0_bid);
  mp_S_AXI_HPC0_FPD_transactor->BRESP(saxigp0_bresp);
  mp_S_AXI_HPC0_FPD_transactor->BVALID(saxigp0_bvalid);
  mp_S_AXI_HPC0_FPD_transactor->BREADY(saxigp0_bready);
  mp_S_AXI_HPC0_FPD_transactor->ARID(saxigp0_arid);
  mp_S_AXI_HPC0_FPD_transactor->ARADDR(saxigp0_araddr);
  mp_S_AXI_HPC0_FPD_transactor->ARLEN(saxigp0_arlen);
  mp_S_AXI_HPC0_FPD_transactor->ARSIZE(saxigp0_arsize);
  mp_S_AXI_HPC0_FPD_transactor->ARBURST(saxigp0_arburst);
  mp_S_AXI_HPC0_FPD_transactor->ARLOCK(saxigp0_arlock);
  mp_S_AXI_HPC0_FPD_transactor->ARCACHE(saxigp0_arcache);
  mp_S_AXI_HPC0_FPD_transactor->ARPROT(saxigp0_arprot);
  mp_S_AXI_HPC0_FPD_transactor->ARVALID(saxigp0_arvalid);
  mp_S_AXI_HPC0_FPD_transactor->ARREADY(saxigp0_arready);
  mp_S_AXI_HPC0_FPD_transactor->RID(saxigp0_rid);
  mp_S_AXI_HPC0_FPD_transactor->RDATA(saxigp0_rdata);
  mp_S_AXI_HPC0_FPD_transactor->RRESP(saxigp0_rresp);
  mp_S_AXI_HPC0_FPD_transactor->RLAST(saxigp0_rlast);
  mp_S_AXI_HPC0_FPD_transactor->RVALID(saxigp0_rvalid);
  mp_S_AXI_HPC0_FPD_transactor->RREADY(saxigp0_rready);
  mp_S_AXI_HPC0_FPD_transactor->AWQOS(saxigp0_awqos);
  mp_S_AXI_HPC0_FPD_transactor->ARQOS(saxigp0_arqos);
  mp_S_AXI_HPC0_FPD_transactor->CLK(saxihpc0_fpd_aclk);
  m_S_AXI_HPC0_FPD_transactor_rst_signal.write(1);
  mp_S_AXI_HPC0_FPD_transactor->RST(m_S_AXI_HPC0_FPD_transactor_rst_signal);

  // initialize transactors stubs
  M_AXI_HPM0_FPD_transactor_initiator_wr_socket_stub = nullptr;
  M_AXI_HPM0_FPD_transactor_initiator_rd_socket_stub = nullptr;
  M_AXI_HPM0_LPD_transactor_initiator_wr_socket_stub = nullptr;
  M_AXI_HPM0_LPD_transactor_initiator_rd_socket_stub = nullptr;
  S_AXI_HPC0_FPD_transactor_target_wr_socket_stub = nullptr;
  S_AXI_HPC0_FPD_transactor_target_rd_socket_stub = nullptr;

}

void design_1_zynq_ultra_ps_e_0_0::before_end_of_elaboration()
{
  // configure 'M_AXI_HPM0_FPD' transactor
  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "M_AXI_HPM0_FPD_TLM_MODE") != 1)
  {
    mp_impl->M_AXI_HPM0_FPD_rd_socket->bind(*(mp_M_AXI_HPM0_FPD_transactor->rd_socket));
    mp_impl->M_AXI_HPM0_FPD_wr_socket->bind(*(mp_M_AXI_HPM0_FPD_transactor->wr_socket));
  
  }
  else
  {
    M_AXI_HPM0_FPD_transactor_initiator_wr_socket_stub = new xtlm::xtlm_aximm_initiator_stub("wr_socket",0);
    M_AXI_HPM0_FPD_transactor_initiator_wr_socket_stub->bind(*(mp_M_AXI_HPM0_FPD_transactor->wr_socket));
    M_AXI_HPM0_FPD_transactor_initiator_rd_socket_stub = new xtlm::xtlm_aximm_initiator_stub("rd_socket",0);
    M_AXI_HPM0_FPD_transactor_initiator_rd_socket_stub->bind(*(mp_M_AXI_HPM0_FPD_transactor->rd_socket));
    mp_M_AXI_HPM0_FPD_transactor->disable_transactor();
  }

  // configure 'M_AXI_HPM0_LPD' transactor
  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "M_AXI_HPM0_LPD_TLM_MODE") != 1)
  {
    mp_impl->M_AXI_HPM0_LPD_rd_socket->bind(*(mp_M_AXI_HPM0_LPD_transactor->rd_socket));
    mp_impl->M_AXI_HPM0_LPD_wr_socket->bind(*(mp_M_AXI_HPM0_LPD_transactor->wr_socket));
  
  }
  else
  {
    M_AXI_HPM0_LPD_transactor_initiator_wr_socket_stub = new xtlm::xtlm_aximm_initiator_stub("wr_socket",0);
    M_AXI_HPM0_LPD_transactor_initiator_wr_socket_stub->bind(*(mp_M_AXI_HPM0_LPD_transactor->wr_socket));
    M_AXI_HPM0_LPD_transactor_initiator_rd_socket_stub = new xtlm::xtlm_aximm_initiator_stub("rd_socket",0);
    M_AXI_HPM0_LPD_transactor_initiator_rd_socket_stub->bind(*(mp_M_AXI_HPM0_LPD_transactor->rd_socket));
    mp_M_AXI_HPM0_LPD_transactor->disable_transactor();
  }

  // configure 'S_AXI_HPC0_FPD' transactor
  if (xsc::utils::xsc_sim_manager::getInstanceParameterInt("design_1_zynq_ultra_ps_e_0_0", "S_AXI_HPC0_FPD_TLM_MODE") != 1)
  {
    mp_impl->S_AXI_HPC0_FPD_rd_socket->bind(*(mp_S_AXI_HPC0_FPD_transactor->rd_socket));
    mp_impl->S_AXI_HPC0_FPD_wr_socket->bind(*(mp_S_AXI_HPC0_FPD_transactor->wr_socket));
  
  }
  else
  {
    S_AXI_HPC0_FPD_transactor_target_wr_socket_stub = new xtlm::xtlm_aximm_target_stub("wr_socket",0);
    S_AXI_HPC0_FPD_transactor_target_wr_socket_stub->bind(*(mp_S_AXI_HPC0_FPD_transactor->wr_socket));
    S_AXI_HPC0_FPD_transactor_target_rd_socket_stub = new xtlm::xtlm_aximm_target_stub("rd_socket",0);
    S_AXI_HPC0_FPD_transactor_target_rd_socket_stub->bind(*(mp_S_AXI_HPC0_FPD_transactor->rd_socket));
    mp_S_AXI_HPC0_FPD_transactor->disable_transactor();
  }

}

#endif // MTI_SYSTEMC




design_1_zynq_ultra_ps_e_0_0::~design_1_zynq_ultra_ps_e_0_0()
{
  delete mp_M_AXI_HPM0_FPD_transactor;

  delete mp_M_AXI_HPM0_LPD_transactor;

  delete mp_S_AXI_HPC0_FPD_transactor;
  delete mp_saxigp0_aruser_converter;
  delete mp_saxigp0_awuser_converter;

}

#ifdef MTI_SYSTEMC
SC_MODULE_EXPORT(design_1_zynq_ultra_ps_e_0_0);
#endif

#ifdef XM_SYSTEMC
XMSC_MODULE_EXPORT(design_1_zynq_ultra_ps_e_0_0);
#endif

#ifdef RIVIERA
SC_MODULE_EXPORT(design_1_zynq_ultra_ps_e_0_0);
SC_REGISTER_BV(128);
#endif

