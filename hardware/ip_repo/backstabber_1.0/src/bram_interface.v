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
	input wire  		 i_trigger,
	output wire  		 o_busy,
	output wire  		 o_end,
	//output wire copy_trigger,
	input  wire   [14:0] i_read_size,
	input  wire   [14:0] i_base_addr,
	input  wire  [127:0] i_wrdata,
	// bram ports,
	output wire 		 o_bram_en,
	output wire    [3:0] o_bram_we,
	output wire   [14:0] o_bram_addr,
	output wire   [31:0] o_bram_wrdata
    );
//------------------------------------------------------------------------------
// FSM STATES AND DEFINES
//------------------------------------------------------------------------------
	parameter [2:0] IDLE			= 0,
					START_READ		= 1,
					READ_VECTOR		= 2,
					START_WRITE_32  = 3,
					START_WRITE_128 = 4,
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
	reg  [3:0] r_bram_en;
	reg 	   r_bram_we;
	reg 	   r_busy;
	reg 	   r_end;
	reg  [2:0] r_word_index;
	reg [2:0] fsm_read_data;
	reg  	init_txn_ff;
	reg  	init_txn_ff2;

//------------------------------------------------------------------------------
// GENERIC OUTPUT SIGNALS
//------------------------------------------------------------------------------
	assign  o_bram_en 	= r_bram_en;
	assign  o_bram_en 	= r_bram_en;
	assign  o_bram_addr = r_bram_addr;
	assign  o_busy 		= r_busy;
	assign  o_end 		= r_end;

	assign data_bram_pulse = (!init_txn_ff2) && init_txn_ff;

//------------------------------------------------------------------------------
// FSM - Pulse
//------------------------------------------------------------------------------
	// //Generate a pulse to initiate the BRAM read operation.
	// always @(posedge S_AXI_ACLK)										      
	//   begin                                                                        
	//     // Initiates AXI transaction delay    
	//     if (S_AXI_ARESETN == 0 )                                                   
	//       begin                                                                    
	//         init_txn_ff <= 1'b0;                                                   
	//         init_txn_ff2 <= 1'b0;                                                   
	//       end                                                                               
	//     else                                                                       
	//       begin  
	//         init_txn_ff <= i_trigger;
	//         init_txn_ff2 <= init_txn_ff;                                                                 
	//       end                                                                      
	//   end 

//------------------------------------------------------------------------------
// FSM - Access BRAM
//------------------------------------------------------------------------------

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
			r_end <= 0;
			r_busy <= 0;
			r_bram_en <= 0;
			r_bram_we <= 0;
			r_bram_addr <= 0;
			r_word_index <= 0;
			r_data_read_size <= 0;
	   		fsm_read_data <= IDLE;
	    end 
	  else
	    begin    
	       case (fsm_read_data)                                                                                                                                 
			IDLE:  // 0
				begin
					r_end <= 0;
					// if ( data_bram_pulse ) begin 
					if ( i_trigger ) begin 
						// fsm_read_data <= START_READ;
						fsm_read_data <= START_WRITE_128;
					end
					else begin
						r_data_read_size <= 0;
					end
				end
			START_READ: // 1
				begin
					r_busy <= 1;
					r_bram_addr <= i_base_addr;
					r_bram_en <= 1;
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
					r_busy <= 1;
					r_bram_en <= 1;
					r_bram_we <= 1;
					r_bram_addr <= i_base_addr;
					r_bram_wrdata <= i_wrdata[127+128*0:0+128*0];
					fsm_read_data <= END_BRAM;  
				end
			START_WRITE_128: // 4
				begin
					r_busy <= 1;
					r_bram_en <= 1;
					r_bram_we <= 1;
					if (r_word_index < 4) begin
						r_bram_addr <= r_bram_addr + 4;
						r_word_index <= r_word_index + 1;
						r_bram_wrdata <=  r_word_index == 1 ? i_wrdata[127+128*1:0+128*1]: 
										  r_word_index == 2 ? i_wrdata[127+128*2:0+128*2]: 
										  r_word_index == 3 ? i_wrdata[127+128*3:0+128*3]: 
										  i_wrdata[127+128*0:0+128*0]; 
					end
					else
						fsm_read_data <= END_BRAM;  
				end
			END_BRAM: // 5
				begin
					r_end <= 1;
					r_busy <= 0;
					r_bram_en <= 0;
					r_bram_we <= 0;
					r_bram_addr <= 0;
					fsm_read_data <= IDLE;  
				end
			default :                                                                
				begin    
					r_busy <= 0;                                                              
					fsm_read_data <= IDLE;                                     
				end                                                                    
	        endcase                            
	    end 
	end 

endmodule
