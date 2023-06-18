`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2023 03:16:23 PM
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



module devil_tb();

    // Snoop States 
    localparam IDLE                     = 0;
    localparam NON_REPLY_OR_DVM_OP_LAST = 1;
    localparam DVM_SYNC_MP              = 2;
    localparam DVM_SYNC_WAIT            = 3;
    localparam DVM_SYNC_LAST            = 4;
    localparam DVM_SYNC_READ            = 5;
    localparam DVM_SYNC_RACK            = 6;
    localparam DVM_OP_MP                = 7;
    localparam DVM_OP_WAIT              = 8;
    localparam REPLY                    = 9;; 
    localparam DEVIL_EN                 = 10; 

    // Devil stages
    parameter [3:0] DEVIL_IDLE               = 0,
                    DEVIL_ONE_SHOT_DELAY     = 1,
                    DEVIL_CONTINUOS_DELAY    = 2,
                    DEVIL_RESPONSE           = 3,
                    DEVIL_DELAY              = 4,
                    DEVIL_FILTER             = 5,
                    DEVIL_FUNCTION           = 6,
                    DEVIL_END                = 7,
                    DEVIL_DUMMY_REPLY        = 8;
    
    // Devil-in-the-fpga Tests
    parameter [3:0] OSH  = 0,
                    CON  = 1;
    
    // Devil-in-the-fpga Tests
    parameter [3:0] FUZZING                   = 0,
                    REPLY_WITH_DELAY_CRVALID  = 1,
                    REPLY_WITH_DELAY_CDVALID  = 2,
                    REPLY_WITH_DELAY_CDLAST   = 3;


    bit tb_clk;
    bit tb_reset;
    bit [3:0] snoop_state;
    bit [3:0] w_fsm_devil_state;
    bit [31:0] control_reg;
    bit [31:0] read_status_reg;
    bit [31:0] w_write_status_reg;
    bit [31:0] delay_reg;
    bit [31:0] acsnoop_reg;
    bit [31:0] base_addr_reg;
    bit [31:0] addr_size_reg;
    bit [127:0] w_rdata;
    bit [4:0] w_crresp;
    bit w_crvalid;
    bit w_cdvalid;
    bit w_cdlast;
    bit w_devil_end;
    bit acvalid;
    bit crready;
    bit w_acready;

    always #1 tb_clk <= ~tb_clk;


    // Instantiation of devil-in-fpgs module
    devil_in_fpga #(
		.C_S_AXI_DATA_WIDTH(32),
        .C_ACE_DATA_WIDTH(128),
        .C_ACE_ADDR_WIDTH(44),
        .DEVIL_EN(10)
    ) devil_in_fpga_inst(
        .ace_aclk(tb_clk),
        .ace_aresetn(tb_reset),
        .acsnoop(4'b0000),
        .acaddr(1),
        .i_snoop_state(snoop_state),
        .o_fsm_devil_state(w_fsm_devil_state),
        .i_control_reg(control_reg),
        .i_read_status_reg(read_status_reg), // The Value that User Writes to Status Reg
        .o_write_status_reg(w_write_status_reg), // The Value that the this IP Writes to Status Reg 
        .i_delay_reg(delay_reg),
        .i_acsnoop_reg(acsnoop_reg),
        .i_base_addr_reg(base_addr_reg),
        .i_addr_size_reg(addr_size_reg),
        .o_rdata(w_rdata),
        .o_crresp(w_crresp),
        .o_crvalid(w_crvalid),
        .o_cdvalid(w_cdvalid),
        .o_cdlast(w_cdlast),
        .o_end(w_devil_end),
        .i_acvalid(acvalid),
        .i_crready(1),
        .o_acready(w_acready)
    );


    // Main process
  initial begin

    $timeformat (-12, 1, "ps", 1);

   	/* code */
	   	tb_reset = 1'b0;
	    #135
	    tb_reset = 1'b1;

      // (No filter) Test one shot delay
      control_reg[8:5] = OSH;
      snoop_state = DEVIL_EN;
      control_reg[4:1] = REPLY_WITH_DELAY_CDLAST; 
      control_reg[16] = 1'b1; // enable One Shot Delay
      delay_reg = 1; 
      #10
      acvalid = 1;
      #1 // one clock for the registers to be asserteded
	    wait(w_fsm_devil_state == DEVIL_IDLE); // wait for idle state
      acvalid = 0;
      control_reg[16] = 1'b0; // disable One Shot Delay
      snoop_state = IDLE; 

      #100

      // test continuous delay
      control_reg[8:5] = CON;
      snoop_state = DEVIL_EN;
      control_reg[4:1] = REPLY_WITH_DELAY_CRVALID; 
      control_reg[17] = 1'b1; // enable Continuous Delay
      delay_reg = 2;
      #1 // one clock for the registers to be asserted
      for (int i = 0; i < 5; i++) begin 
        #10 // one clock for the registers to be asserted  
        acvalid = 1;
        #1 // one clock for the registers to be asserted
        // 5 replys with delay
        wait(w_fsm_devil_state == DEVIL_IDLE); 
        control_reg[4:1] = REPLY_WITH_DELAY_CDVALID; 
        acvalid = 0;
      end
      
      control_reg[17] = 1'b0; // disable Continuous Delay
      snoop_state = IDLE; 

      #10
      // (AC Filter) Test one shot delay
      control_reg[8:5] = OSH;
      snoop_state = DEVIL_EN;
      control_reg[4:1] = REPLY_WITH_DELAY_CRVALID; 
      control_reg[14] = 1'b1; // AC filter on
      control_reg[16] = 1'b1; // enable One Shot Delay
      // acsnoop_reg = 4'b0001; // mismatch value
      acsnoop_reg = 4'b0000; // match 
      delay_reg = 1; 
      #10
      acvalid = 1;
      #1 // one clock for the registers to be asserteded
	    wait(w_fsm_devil_state == DEVIL_END);  // wait for the END
      acvalid = 0;
      control_reg[16] = 1'b0; // disable One Shot Delay
      snoop_state = IDLE; 

      #10
      // (Addr Filter) Test one shot delay
      control_reg[8:5] = OSH;
      snoop_state = DEVIL_EN;
      control_reg[4:1] = REPLY_WITH_DELAY_CRVALID; 
      control_reg[14] = 1'b0; // AC filter off
      control_reg[15] = 1'b1; // AC filter on
      control_reg[16] = 1'b1; // enable One Shot Delay
      base_addr_reg = 0; // match 
      // base_addr_reg = 2; // mismatch 
      addr_size_reg = 10; // match 
      delay_reg = 1; 
      acvalid = 1;
      #1 // one clock for the registers to be asserteded
	    wait(w_fsm_devil_state == DEVIL_END);  // wait for the END
      acvalid = 0;
      control_reg[16] = 1'b0; // disable One Shot Delay
      snoop_state = IDLE; 

      #10
      // (AC + ADDR Filter) Test one shot delay
      control_reg[8:5] = OSH;
      snoop_state = DEVIL_EN;
      control_reg[4:1] = REPLY_WITH_DELAY_CRVALID; 
      control_reg[14] = 1'b1; // AC filter off
      control_reg[15] = 1'b1; // AC filter on
      control_reg[16] = 1'b1; // enable One Shot Delay
      // acsnoop_reg = 4'b0001; // mismatch value
      acsnoop_reg = 4'b0000; // match 
      base_addr_reg = 0; // match 
      addr_size_reg = 10; // match 
      delay_reg = 1; 
      acvalid = 1;
      #1 // one clock for the registers to be asserteded
	    wait(w_fsm_devil_state == DEVIL_END);  // wait for the END
      acvalid = 0;
      control_reg[16] = 1'b0; // disable One Shot Delay
      snoop_state = IDLE; 

      #10
      // Test dummy reply, i.e., no filter or function applied
      control_reg[8:5] = 7; // fucntion 7 does not exist, should go to dummy reply 
      snoop_state = DEVIL_EN;
      control_reg[4:1] = REPLY_WITH_DELAY_CDLAST; 
      control_reg[16] = 1'b1; // enable One Shot Delay
      delay_reg = 1; 
      acvalid = 1;
      #1 // one clock for the registers to be asserteded
	    wait(w_fsm_devil_state == DEVIL_IDLE); // wait for idle state
      acvalid = 0;
      control_reg[16] = 1'b0; // disable One Shot Delay
      snoop_state = IDLE; 

      #10
      // Test dummy reply, i.e., no filter or function applied
      control_reg[8:5] = OSH;  
      snoop_state = DEVIL_EN;
      control_reg[4:1] = REPLY_WITH_DELAY_CDLAST; 
      control_reg[14] = 1'b1; // AC filter on
      control_reg[16] = 1'b1; // enable One Shot Delay
      acsnoop_reg = 4'b0001; // mismatch value, should go to dummy reply 
      delay_reg = 1; 
      acvalid = 1;
      #1 // one clock for the registers to be asserteded
	    wait(w_fsm_devil_state == DEVIL_IDLE); // wait for idle state
      acvalid = 0;
      control_reg[16] = 1'b0; // disable One Shot Delay
      snoop_state = IDLE; 

      #10

    $display("End");
 
    $finish;
  end 
  


endmodule
