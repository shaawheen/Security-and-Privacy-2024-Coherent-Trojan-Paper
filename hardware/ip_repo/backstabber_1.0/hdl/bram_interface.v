`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Cristiano
// 
// Create Date: 03/14/2024 05:03:44 PM
// Design Name: 
// Module Name: bram_interface
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

module bram_interface(
	// Global Clock Signal
	input wire  		 S_AXI_ACLK,
	// Global Reset Signal. This Signal is Active LOW
	input wire  		 S_AXI_ARESETN,
	// control signals
	input wire  		       i_trigger,
	output wire  		       o_busy,
	output wire  		       o_end,
	//output wire copy_trigger,
	input  wire         [14:0] i_read_size,
	input  wire         [14:0] i_base_addr,
	input  wire  [(128*4)-1:0] i_wrdata,
	// bram ports,
	output wire 	  		   o_bram_en,
	output wire 	     [3:0] o_bram_we,
	output wire 	    [14:0] o_bram_addr,
	output wire 	    [31:0] o_bram_wrdata
    );
//------------------------------------------------------------------------------
// FSM STATES AND DEFINES
//------------------------------------------------------------------------------
	parameter [2:0] IDLE			= 0,
					START_READ		= 1,
					READ_VECTOR		= 2,
					START_WRITE_32  = 3,
					START_WRITE_512 = 4,
					END_BRAM 		= 5;		

//------------------------------------------------------------------------------
// WIRES
//------------------------------------------------------------------------------
	wire  	pulse;	

//------------------------------------------------------------------------------
// REGISTERS
//------------------------------------------------------------------------------
	reg [14:0] r_bram_addr; 
	reg [14:0] r_data_read_size;
	reg [31:0] r_bram_wrdata;
	reg  [3:0] r_word_index;
	reg  [2:0] fsm_read_data;
	reg  	   init_txn_ff;
	reg  	   init_txn_ff2;

//------------------------------------------------------------------------------
// GENERIC OUTPUT SIGNALS
//------------------------------------------------------------------------------
	assign o_bram_en 	 = (fsm_read_data == START_WRITE_512);
	assign o_bram_we 	 = (fsm_read_data == START_WRITE_512);
	assign o_end 		 = (fsm_read_data == END_BRAM);
	assign o_busy 		 = (fsm_read_data != IDLE);
	assign o_bram_addr   = r_bram_addr;
	assign o_bram_wrdata = r_word_index == 1 	? i_wrdata[31+32*1:0+32*1]: 
						   r_word_index == 2 	? i_wrdata[31+32*2:0+32*2]: 
						   r_word_index == 3 	? i_wrdata[31+32*3:0+32*3]: 
						   r_word_index == 4 	? i_wrdata[31+32*4:0+32*4]: 
						   r_word_index == 5 	? i_wrdata[31+32*5:0+32*5]: 
						   r_word_index == 6 	? i_wrdata[31+32*6:0+32*6]: 
						   r_word_index == 7 	? i_wrdata[31+32*7:0+32*7]: 
						   r_word_index == 8 	? i_wrdata[31+32*8:0+32*8]: 
						   r_word_index == 9 	? i_wrdata[31+32*9:0+32*9]: 
						   r_word_index == 10 	? i_wrdata[31+32*10:0+32*10]: 
						   r_word_index == 11 	? i_wrdata[31+32*11:0+32*11]: 
						   r_word_index == 12 	? i_wrdata[31+32*12:0+32*12]: 
						   r_word_index == 13 	? i_wrdata[31+32*13:0+32*13]: 
						   r_word_index == 14 	? i_wrdata[31+32*14:0+32*14]: 
						   r_word_index == 15 	? i_wrdata[31+32*15:0+32*15]: 
						   i_wrdata[31+32*0:0+32*0];

	assign data_bram_pulse = (!init_txn_ff2) && init_txn_ff;

//------------------------------------------------------------------------------
// FSM - Pulse
//------------------------------------------------------------------------------
	//Generate a pulse to initiate the BRAM read operation.
	always @(posedge S_AXI_ACLK)										      
	  begin                                                                        
	    // Initiates AXI transaction delay    
	    if (S_AXI_ARESETN == 0 )                                                   
	      begin                                                                    
	        init_txn_ff <= 1'b0;                                                   
	        init_txn_ff2 <= 1'b0;                                                   
	      end                                                                               
	    else                                                                       
	      begin  
	        init_txn_ff <= i_trigger;
	        init_txn_ff2 <= init_txn_ff;                                                                 
	      end                                                                      
	  end 

//------------------------------------------------------------------------------
// FSM - Access BRAM
//------------------------------------------------------------------------------

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
			r_bram_addr <= 0;
			r_word_index <= 0;
			r_bram_wrdata <= 0;
			r_data_read_size <= 0;
	   		fsm_read_data <= IDLE;
	    end 
	  else
	    begin    
	       case (fsm_read_data)                                                                                                                                 
			IDLE:  // 0
				begin
					if ( data_bram_pulse ) begin 
						// fsm_read_data <= START_READ;
						fsm_read_data <= START_WRITE_512;
						// Put in position 16 and start in postion -4. Don't 
						// know why why, but the wirting is being shift 4 bytes
						r_bram_addr <= i_base_addr + 32'h10-4;  
					end
					else begin
						r_data_read_size <= 0;
					end
				end
			START_READ: // 1
				begin
					r_bram_addr <= i_base_addr;
					r_data_read_size <= r_data_read_size + 1;
					fsm_read_data <= READ_VECTOR;  
				end
			READ_VECTOR: // 2
				begin
					if (r_data_read_size < i_read_size) begin
						r_bram_addr <= r_bram_addr + 4;
						r_data_read_size <= r_data_read_size + 1;
					end
					else 
						fsm_read_data <= END_BRAM;   
				end
			START_WRITE_32: // 3
				begin
					r_bram_addr <= i_base_addr;
					fsm_read_data <= END_BRAM;  
				end
			START_WRITE_512: // 4
				begin
					if (r_word_index < 15) begin
						r_bram_addr <= r_bram_addr + 4;
						r_word_index <= r_word_index + 1;
					end
					else
						fsm_read_data <= END_BRAM;  
				end
			END_BRAM: // 5
				begin
					r_bram_addr <= 0;
					r_word_index <= 0;
					fsm_read_data <= IDLE;  
				end
			default :                                                                
				begin                                                              
					fsm_read_data <= IDLE;                                     
				end                                                                    
	        endcase                            
	    end 
	end 

endmodule
