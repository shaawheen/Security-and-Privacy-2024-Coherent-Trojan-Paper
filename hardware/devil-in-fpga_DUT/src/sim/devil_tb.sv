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
import design_1_axi_vip_1_0_pkg::*;

//--------------   ADDRESS MAP  ----------------
`define DEVIL_BASE_ADDR 32'h80010000
`define CTRL            32'h00
`define STATUS          32'h04
`define DELAY           32'h08
`define ACSNOOP         32'h0C
`define BASE_ADDR       32'h10
`define MEM_SIZE        32'h14
`define ARSNOOP         32'h18
`define L_ARADDR        32'h1C
`define H_ARADDR        32'h20
`define AWSNOOP         32'h24
`define L_AWADDR        32'h28
`define H_AWADDR        32'h2C
`define DATA0           32'h40
`define DATA1           32'h44
`define DATA2           32'h48
`define DATA3           32'h4C
`define DATA4           32'h50
`define DATA5           32'h54
`define DATA6           32'h58
`define DATA7           32'h5C
`define DATA8           32'h60
`define DATA9           32'h64
`define DATA10          32'h68
`define DATA11          32'h6C
`define DATA12          32'h70
`define DATA13          32'h74
`define DATA14          32'h78
`define DATA15          32'h7C
`define PATTERN0        32'h80
`define PATTERN1        32'h84
`define PATTERN2        32'h88
`define PATTERN3        32'h8C
`define PATTERN4        32'h90
`define PATTERN5        32'h94
`define PATTERN6        32'h98
`define PATTERN7        32'h9C
`define PATTERN8        32'hA0
`define PATTERN9        32'hA4
`define PATTERN10       32'hA8
`define PATTERN11       32'hAC
`define PATTERN12       32'hB0
`define PATTERN13       32'hB4
`define PATTERN14       32'hB8
`define PATTERN15       32'hBC


`define READ_ONCE           4'b0000
`define WRITE_LINE_UNIQUE   3'b001

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
    `define FUNC_ADL        2
    `define FUNC_ADT        3
    `define FUNC_PDT        4
`define CRRESP_pos  9
`define ACFLT_pos   14
`define ADDRFLT_pos 15
`define OSHEN_pos   16
`define CONEN_pos   17
`define ADLEN_pos   18
`define ADTEN_pos   19
`define PDTEN_pos   20
`define MONEN_pos   21


module devil_tb();
    xil_axi_uint                mst_agent_verbosity = XIL_AXI_VERBOSITY_NONE;
    xil_axi_uint                slv_agent_verbosity = XIL_AXI_VERBOSITY_NONE;
    design_1_axi_vip_0_0_mst_t  mst_agent;
    design_1_axi_vip_1_0_slv_mem_t  slv_agent;
    xil_axi_prot_t  prot = 0;
    xil_axi_resp_t  resp;
    bit tb_reset;
    bit tb_clk;
    bit [31:0] reg_ctrl;
    bit [31:0] reg_status;
    bit [31:0] reg_rdata;
    bit [31:0] reg_acsnoop;
    bit [31:0] reg_addr;
    bit [31:0] reg_size;
    bit [31:0] reg_l_araddr;
    bit [31:0] reg_h_araddr;
    bit [31:0] reg_l_awaddr; 
    bit [31:0] reg_h_awaddr;
    bit [31:0] reg_wdata1;
    bit [31:0] reg_wdata2;
    bit [31:0] reg_wdata3;
    bit [31:0] reg_wdata4;
    bit [31:0] reg_arsnoop;
    bit [31:0] reg_awsnoop;
    bit [31:0] reg_wdata;
    bit [43:0]acaddr;
    bit [3:0]acsnoop;
    bit [31:0] reg_DATA0;
    bit [31:0] reg_DATA1;
    bit [31:0] reg_DATA2;
    bit [31:0] reg_DATA3;
    bit [31:0] reg_DATA4;
    bit [31:0] reg_DATA5;
    bit [31:0] reg_DATA6;
    bit [31:0] reg_DATA7;
    bit [31:0] reg_DATA8;
    bit [31:0] reg_DATA9;
    bit [31:0] reg_DATA10;
    bit [31:0] reg_DATA11;
    bit [31:0] reg_DATA12;
    bit [31:0] reg_DATA13;
    bit [31:0] reg_DATA14;
    bit [31:0] reg_DATA15;
    bit [31:0] reg_PATTERN0;
    bit [31:0] reg_PATTERN1;
    bit [31:0] reg_PATTERN2;
    bit [31:0] reg_PATTERN3;
    bit [31:0] reg_PATTERN4;
    bit [31:0] reg_PATTERN5;
    bit [31:0] reg_PATTERN6;
    bit [31:0] reg_PATTERN7;
    bit [31:0] reg_PATTERN8;
    bit [31:0] reg_PATTERN9;
    bit [31:0] reg_PATTERN10;
    bit [31:0] reg_PATTERN11;
    bit [31:0] reg_PATTERN12;
    bit [31:0] reg_PATTERN13;
    bit [31:0] reg_PATTERN14;
    bit [31:0] reg_PATTERN15;
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
        //  .acvalid_0(0),
         .acvalid_0(acvalid),
         .cdready_0(1),
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
    slv_agent = new("SlaveVIP",DUT.design_1_i.axi_vip_1.inst.IF);
    // Set tags for easier debug
    mst_agent.set_agent_tag("Master VIP");
    slv_agent.set_agent_tag("Slave VIP");
    // Set verbosity
    mst_agent.set_verbosity(mst_agent_verbosity);
    slv_agent.set_verbosity(slv_agent_verbosity);
    // start the agents
    mst_agent.start_master();
    slv_agent.start_slave();
    slv_agent.mem_model.set_memory_fill_policy(XIL_AXI_MEMORY_FILL_RANDOM);      
    // slv_agent.mem_model.set_default_memory_value(32'hF0F0F0F0);   

    monitor_transation_devil();
    // data_leak_FMS_new_devil();
    // data_tampering_FSM_devil();
    // test_data_regs();
    // data_leak_FMS_devil();
    // PDT_devil();
    // data_tampering_devil();
    // data_leak_devil();
    // osh_cr_devil();  
    // osh_cr_devil();  
    // con_cr_devil();
    // dummy_cr_devil();
    // ac_filter_cr_devil();
    // addr_filter_cr_devil();
    // ac_addr_filter_cr_devil();

    $display("END Simulation");
    $finish;
    end 

    task monitor_transation_devil();
        acaddr = 44'h00040000000;  // Emulae Snoop Address
        reg_ctrl = (`FUNC_PDT << `FUNC_pos) // active data leak
                    | (1 << `PDTEN_pos) 
                    | (1 << `MONEN_pos)               
                    | (1 << `EN_pos);

        // Data to do a write snoop
        reg_DATA0   = 32'h00000000;
        reg_DATA1   = 32'h00000001;
        reg_DATA2   = 32'h00000002;
        reg_DATA3   = 32'h00000003;
        reg_DATA4   = 32'h00000004;
        reg_DATA5   = 32'h00000005;
        reg_DATA6   = 32'h00000006; 
        reg_DATA7   = 32'h00000007;
        reg_DATA8   = 32'h00000008;
        reg_DATA9   = 32'h00000009;
        reg_DATA10  = 32'h0000000A;
        reg_DATA11  = 32'h0000000B;
        reg_DATA12  = 32'h0000000C;
        reg_DATA13  = 32'h0000000D;
        reg_DATA14  = 32'h0000000E;
        reg_DATA15  = 32'h0000000F;

        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA0,prot, reg_DATA0,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA1,prot, reg_DATA1,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA2,prot, reg_DATA2,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA3,prot, reg_DATA3,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA4,prot, reg_DATA4,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA5,prot, reg_DATA5,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA6,prot, reg_DATA6,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA7,prot, reg_DATA7,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA8,prot, reg_DATA8,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA9,prot, reg_DATA9,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA10,prot,reg_DATA10,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA11,prot,reg_DATA11,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA12,prot,reg_DATA12,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA13,prot,reg_DATA13,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA14,prot,reg_DATA14,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA15,prot,reg_DATA15,resp); 

        // Match pattern simulation (this is the same data VIP has)
        reg_PATTERN0  = 32'hd54783c2; // a9bd7bfd 
        reg_PATTERN1  = 32'hdcd5db54; // 910003fd
        reg_PATTERN2  = 32'hbbaf7e47; // b90013ff
        reg_PATTERN3  = 32'hfe16863c; // 52800140
        reg_PATTERN4  = 32'hd206ceac; // b9001be0
        reg_PATTERN5  = 32'hd260d0b8; // b9001fff
        reg_PATTERN6  = 32'hf65b9c92; // 52a80000
        reg_PATTERN7  = 32'hcd197260; // b90023e0
        reg_PATTERN8  = 32'hfcb01399; // 52820041
        reg_PATTERN9  = 32'h1443e896; // 72a00201
        reg_PATTERN10 = 32'h893d8de5; // 90000000
        reg_PATTERN11 = 32'h1cd9b232; // 91368000
        reg_PATTERN12 = 32'hc8772659; // 97ffff80
        reg_PATTERN13 = 32'h1ec5cf46; // b90027e0
        reg_PATTERN14 = 32'hff78efa1; // b94027e0
        reg_PATTERN15 = 32'heb624e0d; // 3100041f     

        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN0,prot, reg_PATTERN0,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN1,prot, reg_PATTERN1,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN2,prot, reg_PATTERN2,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN3,prot, reg_PATTERN3,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN4,prot, reg_PATTERN4,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN5,prot, reg_PATTERN5,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN6,prot, reg_PATTERN6,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN7,prot, reg_PATTERN7,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN8,prot, reg_PATTERN8,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN9,prot, reg_PATTERN9,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN10,prot,reg_PATTERN10,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN11,prot,reg_PATTERN11,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN12,prot,reg_PATTERN12,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN13,prot,reg_PATTERN13,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN14,prot,reg_PATTERN14,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`PATTERN15,prot,reg_PATTERN15,resp);    

        reg_l_awaddr = 32'h40000100;
        reg_awsnoop = `WRITE_LINE_UNIQUE;

        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`L_AWADDR,prot,reg_l_awaddr,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`AWSNOOP,prot,reg_awsnoop,resp); 
        

        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        #100ns;
        reg_ctrl =  (0 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        #100ns;
    endtask :monitor_transation_devil

    task data_leak_FMS_new_devil();
        reg_l_araddr = 32'h40000000;
        reg_h_araddr = 8'h00;
        reg_arsnoop = `READ_ONCE;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`L_ARADDR,prot,reg_l_araddr,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`H_ARADDR,prot,reg_h_araddr,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`ARSNOOP,prot,reg_arsnoop,resp); 

        reg_ctrl = (`FUNC_ADL << `FUNC_pos) // active data leak
                    | (1 << `ADLEN_pos)               
                    | (1 << `EN_pos);

        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        #100ns;
        reg_ctrl =  (0 << `EN_pos);
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        #100ns;
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA1,prot,reg_rdata,resp);
        $display("RDATA1 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA2,prot,reg_rdata,resp);
        $display("RDATA2 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA3,prot,reg_rdata,resp);
        $display("RDATA3 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA4,prot,reg_rdata,resp);
        $display("RDATA4 = %h",reg_rdata);
    endtask :data_leak_FMS_new_devil

    task test_data_regs();
        reg_wdata = 32'hFFFFFFFF;
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA0,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA1,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA2,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA3,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA4,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA5,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA6,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA7,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA8,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA9,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA10,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA11,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA12,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA13,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA14,prot,reg_wdata,resp); 
        mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DATA15,prot,reg_wdata,resp); 
        #10ns;
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA0,prot,reg_rdata,resp);
        $display("RDATA0 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA1,prot,reg_rdata,resp);
        $display("RDATA1 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA2,prot,reg_rdata,resp);
        $display("RDATA2 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA3,prot,reg_rdata,resp);
        $display("RDATA3 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA4,prot,reg_rdata,resp);
        $display("RDATA4 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA5,prot,reg_rdata,resp);
        $display("RDATA5 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA6,prot,reg_rdata,resp);
        $display("RDATA6 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA7,prot,reg_rdata,resp);
        $display("RDATA7 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA8,prot,reg_rdata,resp);
        $display("RDATA8 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA9,prot,reg_rdata,resp);
        $display("RDATA9 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA10,prot,reg_rdata,resp);
        $display("RDATA10 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA11,prot,reg_rdata,resp);
        $display("RDATA11 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA12,prot,reg_rdata,resp);
        $display("RDATA12 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA13,prot,reg_rdata,resp);
        $display("RDATA13 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA14,prot,reg_rdata,resp);
        $display("RDATA14 = %h",reg_rdata);
        mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`DATA15,prot,reg_rdata,resp);
        $display("RDATA15 = %h",reg_rdata);
    endtask :test_data_regs

    // task data_tampering_FSM_devil();
    //     reg_l_awaddr = 32'h00000000;
    //     reg_h_awaddr = 8'h00;
    //     reg_wdata1 = 32'hF0F0F0F0;
    //     reg_wdata2 = 32'h00000001;
    //     reg_wdata3 = 32'hFFFFFFFF;
    //     reg_wdata4 = 32'h00000002;
    //     reg_awsnoop = `WRITE_LINE_UNIQUE;

    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`L_AWADDR,prot,reg_l_awaddr,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`H_AWADDR,prot,reg_h_awaddr,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA1,prot,reg_wdata1,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA2,prot,reg_wdata2,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA3,prot,reg_wdata3,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA4,prot,reg_wdata4,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`AWSNOOP,prot,reg_awsnoop,resp); 
        
    //     reg_ctrl = (`FUNC_ADT << `FUNC_pos) // active data tampering
    //                 | (1 << `ADTEN_pos)               
    //                 | (1 << `EN_pos);
                    
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #100ns;
    //     reg_ctrl =  (0 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #10ns;
    // endtask :data_tampering_FSM_devil

    // task data_leak_FMS_devil();
    //     reg_l_araddr = 32'h40000000;
    //     reg_h_araddr = 8'h00;
    //     reg_arsnoop = `READ_ONCE;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`L_ARADDR,prot,reg_l_araddr,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`H_ARADDR,prot,reg_h_araddr,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`ARSNOOP,prot,reg_arsnoop,resp); 

    //     reg_ctrl = (`FUNC_ADL << `FUNC_pos) // active data leak
    //                 | (1 << `ADLEN_pos)               
    //                 | (1 << `EN_pos);

    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #100ns;
    //     reg_ctrl =  (0 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #100ns;
    //     mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`RDATA1,prot,reg_rdata,resp);
    //     $display("RDATA1 = %h",reg_rdata);
    //     mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`RDATA2,prot,reg_rdata,resp);
    //     $display("RDATA2 = %h",reg_rdata);
    //     mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`RDATA3,prot,reg_rdata,resp);
    //     $display("RDATA3 = %h",reg_rdata);
    //     mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`RDATA4,prot,reg_rdata,resp);
    //     $display("RDATA4 = %h",reg_rdata);
    // endtask :data_leak_FMS_devil

    // task PDT_devil();
    //     reg_wdata1 = 32'hF0F0F0F0;
    //     reg_wdata2 = 32'h00000001;
    //     reg_wdata3 = 32'hFFFFFFFF;
    //     reg_wdata4 = 32'h00000002;
        
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA1,prot,reg_wdata1,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA2,prot,reg_wdata2,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA3,prot,reg_wdata3,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA4,prot,reg_wdata4,resp); 

    //     // Address Filter
    //     acaddr = 44'h00040000000;  // Simulate address
    //     reg_addr = 32'h40000000;
    //     reg_size = 32'h00000004;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`MEM_SIZE,prot,reg_size,resp);

    //     // Snoop Filter
    //     acsnoop = 1; // Simulate snoop
    //     reg_acsnoop = 1;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`ACSNOOP,prot,reg_acsnoop,resp); 
        
    //     reg_ctrl =    (5'b00001 << `CRRESP_pos) 
    //                 | (1 << `ACFLT_pos) 
    //                 | (1 << `ADDRFLT_pos) 
    //                 | (1 << `PDTEN_pos)               
    //                 | (`FUNC_PDT << `FUNC_pos) 
    //                 | (1 << `EN_pos);

    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        
    //     #100ns;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,0,resp); 
    //     #100ns;
    // endtask :PDT_devil

    // task data_tampering_devil();
    //     reg_l_awaddr = 32'h00000002;
    //     reg_h_awaddr = 8'h00;
    //     reg_wdata1 = 32'hF0F0F0F0;
    //     reg_wdata2 = 32'h00000001;
    //     reg_wdata3 = 32'hFFFFFFFF;
    //     reg_wdata4 = 32'h00000002;
    //     reg_awsnoop = `WRITE_LINE_UNIQUE;

    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`L_AWADDR,prot,reg_l_awaddr,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`H_AWADDR,prot,reg_h_awaddr,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA1,prot,reg_wdata1,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA2,prot,reg_wdata2,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA3,prot,reg_wdata3,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`WDATA4,prot,reg_wdata4,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`AWSNOOP,prot,reg_awsnoop,resp); 
        
    //     reg_ctrl =  (1 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #100ns;
    //     reg_ctrl =  (0 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #10ns;
    // endtask :data_tampering_devil

    // task data_leak_devil();
    //     reg_l_araddr = 32'h00000002;
    //     reg_h_araddr = 8'h00;
    //     reg_arsnoop = `READ_ONCE;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`L_ARADDR,prot,reg_l_araddr,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`H_ARADDR,prot,reg_h_araddr,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`ARSNOOP,prot,reg_arsnoop,resp); 
    //     reg_ctrl =  (1 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #100ns;
    //     reg_ctrl =  (0 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #100ns;
    //     mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`RDATA1,prot,reg_rdata,resp);
    //     $display("RDATA1 = %h",reg_rdata);
    //     mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`RDATA2,prot,reg_rdata,resp);
    //     $display("RDATA2 = %h",reg_rdata);
    //     mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`RDATA3,prot,reg_rdata,resp);
    //     $display("RDATA3 = %h",reg_rdata);
    //     mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`RDATA4,prot,reg_rdata,resp);
    //     $display("RDATA4 = %h",reg_rdata);
    // endtask :data_leak_devil

    // task osh_cr_devil();
    //     //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
    //     //AXI4LITE_READ_BURST(addr,prot,data,resp);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`DELAY,prot,2,resp);
        
    //     reg_ctrl =  (`TEST_DELAY_CR << `TEST_pos) | (`FUNC_OSH << `FUNC_pos) |
    //                 (1 << `OSHEN_pos) | (1 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp);

    //     while(!reg_status)
    //         mst_agent.AXI4LITE_READ_BURST(`DEVIL_BASE_ADDR +`STATUS,prot,reg_status,resp);
    
    //     //clean bit
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`STATUS,prot,1,resp); 

    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,0,resp);
    //     #10ns;
    // endtask :osh_cr_devil

    // task con_cr_devil();
    //     //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
    //     reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | 
    //             (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (1 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 

    //     #98ns;
    //     acsnoop = 4'b1111;

    //     #100ns;
    //     acsnoop = 0;
        
    //     #10000ns;
    //     reg_ctrl =  (1 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | 
    //             (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (0 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #100ns;
    // endtask :con_cr_devil

    // task dummy_cr_devil();
    //     //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
    //     reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | 
    //             (5 << `FUNC_pos) | (1 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        
    //     #100ns;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,0,resp); 
    //     #100ns;
    // endtask :dummy_cr_devil

    // task ac_filter_cr_devil();
    //      //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
    //     reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | (1<<`ACFLT_pos) |
    //             (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (1 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        
    //     #100ns;
    //     reg_acsnoop = 1;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`ACSNOOP,prot,reg_acsnoop,resp); 
        
    //     #10000ns;
    //     reg_ctrl =  (1 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | (1<<`ACFLT_pos) |
    //             (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (0 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #100ns;
    // endtask :ac_filter_cr_devil

    // task addr_filter_cr_devil();
    //      //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
    //     reg_addr = 32'h00000010;
    //     reg_size = 32'h100;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`MEM_SIZE,prot,reg_size,resp); 
       
    //     reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | (1<<`ADDRFLT_pos) |
    //             (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (1 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
       
    //     #10ns;
    //     reg_addr = 32'h00000000;
    //     reg_size = 32'h100;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp); 
        
    //     #10ns; // match
    //     reg_addr = 32'h00000010;
    //     reg_size = 32'h100;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp);
       
    //     #10000ns;
    //     reg_ctrl =  (1 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | (1<<`ADDRFLT_pos) |
    //             (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (0 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #100ns;
    // endtask :addr_filter_cr_devil

    // task ac_addr_filter_cr_devil();
    //      //AXI4LITE_WRITE_BURST(addr1,prot,data_wr1,resp);
    //     reg_addr = 32'h00000010;
    //     reg_size = 32'h100;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp); 
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`MEM_SIZE,prot,reg_size,resp); 

    //     reg_acsnoop = 1;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`ACSNOOP,prot,reg_acsnoop,resp); 

    //     reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | 
    //                 (1 <<`ADDRFLT_pos) | (1 <<`ACFLT_pos) |
    //                 (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (1 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
        
    //     #10ns;
    //     reg_addr = 32'h00000000;
    //     reg_size = 32'h100;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp); 
        
    //     #10ns; // match
    //     reg_acsnoop = 0;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`ACSNOOP,prot,reg_acsnoop,resp); 
      
    //    #10ns;
    //     reg_addr = 32'h00000010;
    //     reg_size = 32'h100;
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`BASE_ADDR,prot,reg_addr,resp);
       
    //     #10000ns;
    //     reg_ctrl =  (0 << `DELAY_pos) | (`TEST_DELAY_CR << `TEST_pos) | 
    //                 (1 <<`ADDRFLT_pos) | (1 <<`ACFLT_pos) |
    //                 (`FUNC_CON << `FUNC_pos) | (1 << `CONEN_pos) | (0 << `EN_pos);
    //     mst_agent.AXI4LITE_WRITE_BURST(`DEVIL_BASE_ADDR +`CTRL,prot,reg_ctrl,resp); 
    //     #100ns;
    // endtask :ac_addr_filter_cr_devil


endmodule