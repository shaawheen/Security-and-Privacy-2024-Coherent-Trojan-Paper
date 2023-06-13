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


    parameter [3:0] DEVIL_IDLE               = 0,
                    DEVIL_ONE_SHOT_DELAY     = 1,
                    DEVIL_CONTINUOS_DELAY    = 2,
                    DEVIL_RESPONSE           = 3,
                    DEVIL_DELAY              = 4,
                    DEVIL_END                = 5;

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
        .i_delay_reg(),
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
        #10
        
        snoop_state = 10;
        control_reg[4:1] = 4'b0001; 
        delay_reg = 1; 

	    #10000

	    wait(w_fsm_devil_state == DEVIL_END); // wait for idle state

	    /*wait((tvalid_R && tvalid_I))
	    wait(!(tvalid_R && tvalid_I))*/


	    /*for (int i = 0; i < 80; i++) begin
	    	//send vector of input gnss data and grid
	    	send_in_grid <= 1;
	    	#10
	    	end_in_grid <= 0;
	    	//Wait for the fft to finish
	    	wait(fft_TValid)
	    	//Send PRNx 
	    	send_prn_fft <= 1;
	    	#10
	    	send_prn_fft <= 0;
	    	//wait for the TLast of the FFT to send another vector of data | This is done sequential here, but will be non-sequential in reality
	    	wait(FFT_TLast)
	    	//wait for the the TValid of the first stage of the squareABS (This modulo has two stage, i.e., 2 clocks)
	    	// to assert the TLast of the accumulator and clean the accumulator
	    	wait(first_stage_squareABS_tvalid) // isto depois vai ter de ser independente do último, i.e., FFT_TLast e first_stage_squareABS_tvalid sendo geridos em blocos diferentes
	    	// asserting TLast makes the accumulator start counting from scratch
	    	s_accumulator_Tlast_aka_reset_0 <= 1; 
	    	#10
	    	s_accumulator_Tlast_aka_reset_0 <= 0;

	    end*/
	    // start = 1;
	    // #10
	    // start = 0;

	    // for (int i = 0; i < 2; i++) begin 
		//     //count 80 TValids in the result -> all 80 bins processed
	    // 	wait((m_axis_result_tvalid ));
	    // 	wait(!(m_axis_result_tvalid));
	    // end

  // ------------------- Code for carrier_gen simulation ------------------------ 
  /* 	start = 1;
    #10
		s_axis_config_tdata_0 = coefficient[bin];
    start = 0;
    #10
    //for (int i = 0; i < 80; i++) begin 
		s_axis_config_tvalid_0 = 1;
		#10
		s_axis_config_tvalid_0 = 0;
		#30 // 3 clocks
		Tvalid_dds = 1; 
		//count 8000
		wait((tb_end ));
	//end
	//wait(!(m_axis_result_tvalid)); 
    */

    $display("Successful Test");
 
    $finish;
  end 
  


endmodule
