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

// FSM snoop states
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
    
// Devil FSM states
    parameter [3:0] DEVIL_IDLE               = 0,
                    DEVIL_ONE_SHOT_DELAY     = 1,
                    DEVIL_CONTINUOS_DELAY    = 2,
                    DEVIL_RESPONSE           = 3,
                    DEVIL_DELAY              = 4,
                    DEVIL_END                = 5;
    
// Devil-in-the-fpga Functions
    parameter [3:0] OSH = 0,
                    CON = 1;

// Devil-in-the-fpga Tests
    parameter [3:0] FUZZING                  = 0,
                    REPLY_WITH_DELAY_CRVALID = 1,
                    REPLY_WITH_DELAY_CDVALID = 2,
                    REPLY_WITH_DELAY_CDLAST  = 3;

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

    always #1 tb_clk <= ~tb_clk;

    // Instantiation of devil-in-fpgs module
    devil_in_fpga #(
		.C_S_AXI_DATA_WIDTH(32),
        .C_ACE_DATA_WIDTH(128),
        .DEVIL_EN(10)
    ) devil_in_fpga_inst(
        .ace_aclk(tb_clk),
        .ace_aresetn(tb_reset),
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
        .o_cdlast(w_cdlast)
    );

    // Main process
  initial begin

    $timeformat (-12, 1, "ps", 1);

   	/* code */
	   	tb_reset = 1'b0;
	    #135
	    tb_reset = 1'b1;
      #1
      control_reg[0] = 1; //EN IP

      #1
      snoop_state = DEVIL_EN;
      control_reg[4:1] = REPLY_WITH_DELAY_CRVALID; 
      control_reg[8:5] = OSH;
      control_reg[13:9] = 0; //crresp
      control_reg[16] = 1; //OSH_EN
      delay_reg = 1; 

	    #1

	    wait(w_fsm_devil_state == DEVIL_IDLE); // wait for idle state
      snoop_state = IDLE;
      control_reg[16] = 0; //OSH_EN

      #1

      control_reg[17] = 1; //CON_EN

      #1

	    for (int i = 0; i < 5; i++) begin 
        // reply with delay 5 times
	    	wait(w_fsm_devil_state == DEVIL_RESPONSE);
	    	wait(w_fsm_devil_state == DEVIL_CONTINUOS_DELAY);
	    end

      #100

    $display("End of Simulation");
 
    $finish;
  end 
  


endmodule
