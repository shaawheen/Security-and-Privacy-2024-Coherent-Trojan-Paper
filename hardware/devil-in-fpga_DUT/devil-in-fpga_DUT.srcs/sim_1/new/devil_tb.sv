`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2023 12:43:24 PM
// Design Name: 
// Module Name: devil_tb
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

import axi_vip_pkg::*;
import design_1_axi_vip_0_0_pkg::*;

//--------------   ADDRESS MAP  ----------------
`define DEVIL_BASE_ADDR 32'h80010000
`define CTRL            32'h00
`define STATUS          32'h04
`define DELAY           32'h08
`define ACSNOOP         32'h0C
`define BASE_ADDR       32'h10
`define MEM_SIZE        32'h14
       
module devil_tb();
    xil_axi_uint                mst_agent_verbosity = XIL_AXI_VERBOSITY_NONE;
    design_1_axi_vip_0_0_mst_t  mst_agent;
    xil_axi_prot_t  prot = 0;
    xil_axi_resp_t  resp;
    bit tb_reset;
    bit tb_clk;

    design_1_wrapper DUT
        (.clk_100MHz(tb_clk),
            .reset(tb_reset));

    initial begin
        tb_reset <= 1'b1;
        repeat (16) @(negedge tb_clk);
        tb_reset <= 1'b0;
    end

    always #1 tb_clk <= ~tb_clk;

    // Main process
    initial begin
    $display("Start Simulation");
    // new agents
    mst_agent = new("MasterVIP", DUT.design_1_i.axi_vip_0.inst.IF);
    // Set tags for easier debug
    mst_agent.set_agent_tag("Master VIP");
    // Set verbosity
    mst_agent.set_verbosity(mst_agent_verbosity);
    // start the agents
    mst_agent.start_master();

    test_regs();

    $display("END Simulation");
    $finish;
    end 

    task test_regs();
        //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,32'h1,resp); 
        #10ns;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DELAY,prot,32'h10,resp); 
        #100ns;
    endtask :test_regs

endmodule
