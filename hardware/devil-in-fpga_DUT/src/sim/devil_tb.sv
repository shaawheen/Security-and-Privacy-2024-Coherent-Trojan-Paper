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

// Control Reg bits
`define EN_pos      0
`define TEST_pos    1
    `define TEST_FUZZ       0
    `define TEST_DELAY_CR   1
    `define TEST_DELAY_CD   2
    `define TEST_DELAY_CL   3
`define FUNC_pos    5
    `define FUNC_OSH        0
    `define FUNC_CON        1
`define CRRESP_pos  9
`define ACFLT_pos   14
`define ADDRFLT_pos 15
`define OSHEN_pos   16
`define CONEN_pos   17
`define DELAY_pos   18


module devil_tb();
    xil_axi_uint                mst_agent_verbosity = XIL_AXI_VERBOSITY_NONE;
    design_1_axi_vip_0_0_mst_t  mst_agent;
    xil_axi_prot_t  prot = 0;
    xil_axi_resp_t  resp;
    bit tb_reset;
    bit tb_clk;
    bit [31:0] reg_ctrl;
    bit [31:0] reg_status;
    bit [31:0] reg_acsnoop;
    bit [31:0] reg_addr;
    bit [31:0] reg_size;
    bit [43:0]acaddr;
    bit [3:0]acsnoop;
    bit acvalid;
    bit crvalid;
    bit crready;
    bit [4:0] dummy_counter;

    design_1_wrapper DUT
        (.clk_100MHz(tb_clk),
         .reset(tb_reset),
         .crvalid_0(crvalid),
         .acaddr_0(acaddr),
         .acsnoop_0(acsnoop),
         .acvalid_0(acvalid),
         .crready_0(1)
        );

    initial begin
        tb_reset <= 1'b1;
        dummy_counter <= 0;
        acsnoop <= 0;
        repeat (16) @(negedge tb_clk);
        tb_reset <= 1'b0;
    end

    always #1 tb_clk <= ~tb_clk;

    // test handshake 
    always @(posedge tb_clk) begin
        if(tb_reset)
            acvalid <= 1'b0;
        else begin
            if (dummy_counter == 0) begin
                acvalid <= ~acvalid;
                dummy_counter <= 0;
            end
            else 
                dummy_counter <= dummy_counter + 1;
        end
    end

    // always @(crvalid) begin
    // if (crvalid)
    //     crready <= 1'b1;
    // else if (! crvalid)
    //     crready <= 1'b0;
    // end

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

    // osh_cr_devil();  
    osh_cr_devil();  
    // con_cr_devil();
    // dummy_cr_devil();
    // ac_filter_cr_devil();
    // addr_filter_cr_devil();
    // ac_addr_filter_cr_devil();

    $display("END Simulation");
    $finish;
    end 

    task osh_cr_devil();
        //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
        //AXI4LITE_READ_BURST(addr,prot,data,resp);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DELAY,prot,2,resp);
        
        reg_ctrl =  (`TEST_DELAY_CR << `TEST_pos) | (`FUNC_OSH << `FUNC_pos) |
                    (1 << `OSHEN_pos) | (1 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp);

        while(!reg_status)
            mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`STATUS,prot,reg_status,resp);
    
        //clean bit
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`STATUS,prot,1,resp); 

        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,0,resp);
        #10ns;
    endtask :osh_cr_devil

    task con_cr_devil();
        //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
        reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | 
                (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (1 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 

        #98ns;
        acsnoop = 4'b1111;

        #100ns;
        acsnoop = 0;
        
        #10000ns;
        reg_ctrl =  (1 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | 
                (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (0 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        #100ns;
    endtask :con_cr_devil

    task dummy_cr_devil();
        //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
        reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | 
                (5 << `FUNC_pos) | (1 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        
        #100ns;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,0,resp); 
        #100ns;
    endtask :dummy_cr_devil

    task ac_filter_cr_devil();
         //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
        reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | (1<<`ACFLT_pos) |
                (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (1 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        
        #100ns;
        reg_acsnoop = 1;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`ACSNOOP,prot,reg_acsnoop,resp); 
        
        #10000ns;
        reg_ctrl =  (1 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | (1<<`ACFLT_pos) |
                (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (0 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        #100ns;
    endtask :ac_filter_cr_devil

    task addr_filter_cr_devil();
         //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
        reg_addr = 32'h00000010;
        reg_size = 32'h100;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`MEM_SIZE,prot,reg_size,resp); 
       
        reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | (1<<`ADDRFLT_pos) |
                (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (1 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
       
        #10ns;
        reg_addr = 32'h00000000;
        reg_size = 32'h100;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp); 
        
        #10ns; // match
        reg_addr = 32'h00000010;
        reg_size = 32'h100;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp);
       
        #10000ns;
        reg_ctrl =  (1 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | (1<<`ADDRFLT_pos) |
                (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (0 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        #100ns;
    endtask :addr_filter_cr_devil

    task ac_addr_filter_cr_devil();
         //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
        reg_addr = 32'h00000010;
        reg_size = 32'h100;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`MEM_SIZE,prot,reg_size,resp); 

        reg_acsnoop = 1;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`ACSNOOP,prot,reg_acsnoop,resp); 

        reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | 
                    (1 <<`ADDRFLT_pos) | (1 <<`ACFLT_pos) |
                    (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (1 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        
        #10ns;
        reg_addr = 32'h00000000;
        reg_size = 32'h100;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp); 
        
        #10ns; // match
        reg_acsnoop = 0;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`ACSNOOP,prot,reg_acsnoop,resp); 
      
       #10ns;
        reg_addr = 32'h00000010;
        reg_size = 32'h100;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp);
       
        #10000ns;
        reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | 
                    (1 <<`ADDRFLT_pos) | (1 <<`ACFLT_pos) |
                    (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (0 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        #100ns;
    endtask :ac_addr_filter_cr_devil


endmodule