
`timescale 1 ns / 1 ps

	module byte_writer_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Master Bus Interface AXI
		parameter  C_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h80000000,
		parameter integer C_AXI_BURST_LEN	= 1,
		parameter integer C_AXI_ID_WIDTH	= 1,
		parameter integer C_AXI_ADDR_WIDTH	= 32,
		parameter integer C_AXI_DATA_WIDTH	= 128,
		parameter integer C_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_AXI_WUSER_WIDTH	= 0,
		parameter integer C_AXI_RUSER_WIDTH	= 0,
		parameter integer C_AXI_BUSER_WIDTH	= 0,
		
        // Parameters of Axi Slave Bus Interface Config_AXI
        parameter integer C_Config_AXI_ID_WIDTH     = 16,
        parameter integer C_Config_AXI_DATA_WIDTH   = 128,
        parameter integer C_Config_AXI_ADDR_WIDTH   = 40,
        parameter integer C_Config_AXI_AWUSER_WIDTH = 0,
        parameter integer C_Config_AXI_ARUSER_WIDTH = 0,
        parameter integer C_Config_AXI_WUSER_WIDTH  = 0,
        parameter integer C_Config_AXI_RUSER_WIDTH  = 0,
        parameter integer C_Config_AXI_BUSER_WIDTH  = 0
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line
        // Ports of Axi Slave Bus Interface Config_AXI
        input  wire                                          config_axi_aclk,
        input  wire                                          config_axi_aresetn,
        input  wire            [C_Config_AXI_ID_WIDTH-1 : 0] config_axi_awid,
        input  wire          [C_Config_AXI_ADDR_WIDTH-1 : 0] config_axi_awaddr,
        input  wire                                  [7 : 0] config_axi_awlen,
        input  wire                                  [2 : 0] config_axi_awsize,
        input  wire                                  [1 : 0] config_axi_awburst,
        input  wire                                          config_axi_awlock,
        input  wire                                  [3 : 0] config_axi_awcache,
        input  wire                                  [2 : 0] config_axi_awprot,
        input  wire                                  [3 : 0] config_axi_awqos,
        input  wire                                  [3 : 0] config_axi_awregion,
        input  wire        [C_Config_AXI_AWUSER_WIDTH-1 : 0] config_axi_awuser,
        input  wire                                          config_axi_awvalid,
        output wire                                          config_axi_awready,
        input  wire          [C_Config_AXI_DATA_WIDTH-1 : 0] config_axi_wdata,
        input  wire      [(C_Config_AXI_DATA_WIDTH/8)-1 : 0] config_axi_wstrb,
        input  wire                                          config_axi_wlast,
        input  wire                                          config_axi_wvalid,
        output wire                                          config_axi_wready,
        output wire            [C_Config_AXI_ID_WIDTH-1 : 0] config_axi_bid,
        output wire                                  [1 : 0] config_axi_bresp,
        output wire                                          config_axi_bvalid,
        input  wire                                          config_axi_bready,
        input  wire            [C_Config_AXI_ID_WIDTH-1 : 0] config_axi_arid,
        input  wire          [C_Config_AXI_ADDR_WIDTH-1 : 0] config_axi_araddr,
        input  wire                                  [7 : 0] config_axi_arlen,
        input  wire                                  [2 : 0] config_axi_arsize,
        input  wire                                  [1 : 0] config_axi_arburst,
        input  wire                                          config_axi_arlock,
        input  wire                                  [3 : 0] config_axi_arcache,
        input  wire                                  [2 : 0] config_axi_arprot,
        input  wire                                  [3 : 0] config_axi_arqos,
        input  wire                                  [3 : 0] config_axi_arregion,
        input  wire        [C_Config_AXI_ARUSER_WIDTH-1 : 0] config_axi_aruser,
        input  wire                                          config_axi_arvalid,
        output wire                                          config_axi_arready,
        output wire            [C_Config_AXI_ID_WIDTH-1 : 0] config_axi_rid,
        output wire          [C_Config_AXI_DATA_WIDTH-1 : 0] config_axi_rdata,
        output wire                                  [1 : 0] config_axi_rresp,
        output wire                                          config_axi_rlast,
        output wire                                          config_axi_rvalid,
        input  wire                                          config_axi_rready,

		// Ports of Axi Master Bus Interface AXI
		input wire  axi_init_axi_txn,
		input wire  axi_aclk,
		input wire  axi_aresetn,
		output wire [C_AXI_ID_WIDTH-1 : 0] axi_awid,
		output wire [C_AXI_ADDR_WIDTH-1 : 0] axi_awaddr,
		output wire [7 : 0] axi_awlen,
		output wire [2 : 0] axi_awsize,
		output wire [1 : 0] axi_awburst,
		output wire  axi_awlock,
		output wire [3 : 0] axi_awcache,
		output wire [2 : 0] axi_awprot,
		output wire [3 : 0] axi_awqos,
		output wire  axi_awvalid,
		input wire  axi_awready,
		output wire [C_AXI_DATA_WIDTH-1 : 0] axi_wdata,
		output wire [C_AXI_DATA_WIDTH/8-1 : 0] axi_wstrb,
		output wire  axi_wlast,
		output wire  axi_wvalid,
		input wire  axi_wready,
		input wire [C_AXI_ID_WIDTH-1 : 0] axi_bid,
		input wire [1 : 0] axi_bresp,
		input wire  axi_bvalid,
		output wire  axi_bready,
		output wire [C_AXI_ID_WIDTH-1 : 0] axi_arid,
		output wire [C_AXI_ADDR_WIDTH-1 : 0] axi_araddr,
		output wire [7 : 0] axi_arlen,
		output wire [2 : 0] axi_arsize,
		output wire [1 : 0] axi_arburst,
		output wire  axi_arlock,
		output wire [3 : 0] axi_arcache,
		output wire [2 : 0] axi_arprot,
		output wire [3 : 0] axi_arqos,
		output wire  axi_arvalid,
		input wire  axi_arready,
		input wire [C_AXI_ID_WIDTH-1 : 0] axi_rid,
		input wire [C_AXI_DATA_WIDTH-1 : 0] axi_rdata,
		input wire [1 : 0] axi_rresp,
		input wire  axi_rlast,
		input wire  axi_rvalid,
		output wire  axi_rready
	);

	parameter IDLE = 1'b0, // This state initiates AXI4Lite transaction 
			// after the state machine changes state to INIT_WRITE 
			// when there is 0 to 1 transition on INIT_AXI_TXN
		    INIT_WRITE   = 1'b1; // This state initializes write transaction,
			// once writes are done, the state machine 
			// changes state to INIT_READ 
			
    wire [((C_Config_AXI_DATA_WIDTH/8)*32)-1 : 0] buffer;    
    reg     [1:0] mst_exec_state;
    reg  	      init_txn_ff;
    reg           init_txn_ff2;
    wire  	      init_txn_pulse;
    //reg           aw_handshake;
    reg           axi_awvalid_reg;
    reg           axi_wlast_reg;
    reg           axi_wvalid_reg;
    reg           axi_bready_reg;
    reg           start_single_burst_write;
    reg           writes_done;
// function called clogb2 that returns an integer which has the 
    // value of the ceiling of the log base 2.                      
    function integer clogb2 (input integer bit_depth);              
    begin                                                           
    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
      bit_depth = bit_depth >> 1;                                 
    end                                                           
    endfunction                                                     


	//i/o connections. write address (aw)
    assign axi_awid    = 'b0;
    //the axi address is a concatenation of the target base address + active offset range
    assign axi_awaddr    = C_AXI_TARGET_SLAVE_BASE_ADDR ;
    //burst length is number of transaction beats, minus 1
    assign axi_awlen    = C_AXI_BURST_LEN - 1;
    //size should be c_axi_data_width, in 2^size bytes, otherwise narrow bursts are used
    assign axi_awsize    = clogb2((C_AXI_DATA_WIDTH/8)-1);
    //incr burst type is usually used, except for keyhole bursts
    assign axi_awburst    = 2'b01;
    assign axi_awlock    = 1'b0;
    //update value to 4'b0011 if coherent accesses to be used via the zynq acp port. not allocated, modifiable, not bufferable. not bufferable since this example is meant to test memory, not intermediate cache. 
    assign axi_awcache    = 4'b0010;
    assign axi_awprot    = 3'h0;
    assign axi_awqos    = 4'h0;
    assign axi_awvalid    = axi_awvalid_reg;
    //write data(w)
    assign axi_wdata    = 1'b1; //assume we always write one
    //all bursts are complete and aligned in this example
    assign axi_wstrb    = {(C_AXI_DATA_WIDTH/8){1'b1}};
    assign axi_wlast    = axi_wlast_reg;
    assign axi_wvalid    = axi_wvalid_reg;
    //write response (b)
    assign axi_bready    = axi_bready_reg;
    
    assign axi_arid       = 'b0;
    assign axi_araddr    =  'b0;
    //burst length is number of transaction beats, minus 1
    assign axi_arlen     = C_AXI_BURST_LEN - 1;
    //size should be c_axi_data_width, in 2^n bytes, otherwise narrow bursts are used
    assign axi_arsize    = clogb2((C_AXI_DATA_WIDTH/8)-1);
    //incr burst type is usually used, except for keyhole bursts
    assign axi_arburst   = 2'b01;
    assign axi_arlock    = 1'b0;
    //update value to 4'b0011 if coherent accesses to be used via the zynq acp port. not allocated, modifiable, not bufferable. not bufferable since this example is meant to test memory, not intermediate cache. 
    assign axi_arcache   = 4'b0010;
    assign axi_arprot    = 3'h0;
    assign axi_arqos     = 4'h0;
    assign axi_arvalid   = 'b0; //we never read
    //read and read response (r)
    assign axi_rready    = 'b0; //we never read
    //Example design I/O
 
    assign init_txn_pulse    = (!init_txn_ff2) && init_txn_ff;

	//Generate a pulse to initiate AXI transaction.
	always @(posedge axi_aclk)										      
	  begin                                                                        
	    // Initiates AXI transaction delay    
	    if (axi_aresetn == 0 )                                                   
	      begin                                                                    
	        init_txn_ff <= 1'b0;                                                   
	        init_txn_ff2 <= 1'b0;                                                   
	      end                                                                               
	    else                                                                       
	      begin  
	        init_txn_ff <= axi_init_axi_txn;
	        init_txn_ff2 <= init_txn_ff;                                                                 
	      end                                                                      
	  end     
	  
    ///////////////////////////// AW Channel//////////////////////////////
    always @(posedge axi_aclk)                                   
    begin                                                             
        if (axi_aresetn == 0)                                           
        begin                                                            
            axi_awvalid_reg <= 1'b0;                                        
        end                                                              
      // If previously not valid , start next transaction                
      else if (~axi_awvalid && init_txn_pulse == 1'b1 )                 
      begin                                                            
            axi_awvalid_reg <= 1'b1;                                      
      end                                                              
      /* Once asserted, VALIDs cannot be deasserted, so axi_awvalid      
      must wait until transaction is accepted */                         
      else if (axi_awready && axi_awvalid_reg)                             
      begin                                                            
        axi_awvalid_reg <= 1'b0;     
        //aw_handshake <= 1'b1;                                      
      end                                                              
      else                                                               
        axi_awvalid_reg <= axi_awvalid_reg;                                    
    end                                                                
    ///////////////////////////// W Channel//////////////////////////////                                                                             
     always @(posedge axi_aclk)                                                      
     begin                                                                             
       if (axi_aresetn == 0 || init_txn_pulse == 1'b1 )                                                        
         begin                                                                         
           axi_wvalid_reg <= 1'b0; 
           axi_wlast_reg <= 1'b0;                                                        
         end                                                                           
       // If previously not valid, start next transaction                              
       else if (~axi_wvalid_reg  && axi_awready && axi_awvalid_reg)                               
       begin     
         //aw_handshake <= 1'b0;                                                                    
         axi_wvalid_reg <= 1'b1; 
         axi_wlast_reg <= 1'b1;                                                        
       end                                                                           
       /* If WREADY and too many writes, throttle WVALID                               
       Once asserted, VALIDs cannot be deasserted, so WVALID                           
       must wait until burst is complete with WLAST */                                 
       else if (axi_wlast && axi_wready)    
       begin                                                
         axi_wvalid_reg <= 1'b0;         
         axi_wlast_reg <= 1'b0;
       end
       else                                                                            
         axi_wvalid_reg <= axi_wvalid_reg;                                                     
     end                                                                               
      ///////////////////////////// B Channel//////////////////////////////                                                                                                
 	  always @(posedge axi_aclk)                                     
      begin                                                                 
        if (axi_aresetn == 0 || init_txn_pulse == 1'b1 )                                            
          begin                                                             
            axi_bready_reg <= 1'b0;                                             
          end                                                               
        // accept/acknowledge bresp with axi_bready by the master           
        // when M_AXI_BVALID is asserted by slave                           
        else if (axi_bvalid && ~axi_bready_reg)                               
          begin                                                             
            axi_bready_reg <= 1'b1;                                             
          end                                                               
        // deassert after one clock cycle                                   
        else if (axi_bready_reg)                                                
          begin                                                             
            axi_bready_reg <= 1'b0;                                             
          end                                                               
        // retain the previous value                                        
        else                                                                
          axi_bready_reg <= axi_bready_reg;                                         
      end                                                                   
	  //implement master command interface state machine                                                        
                                                                                                                
//      always @ ( posedge axi_aclk)                                                                            
//      begin                                                                                                     
//        if (axi_aresetn == 1'b0 )                                                                             
//          begin                                                                                                 
//            // reset condition                                                                                  
//            // All the signals are assigned default values under reset condition                                
//            mst_exec_state      <= IDLE;                                                                
//            start_single_burst_write <= 1'b0;                                                                   

//          end                                                                                                   
//        else                                                                                                    
//          begin                                                                                                 
                                                                                                                
//            // state transition                                                                                 
//            case (mst_exec_state)                                                                               
                                                                                                                
//              IDLE:                                                                                     
//                // This state is responsible to wait for user defined C_M_START_COUNT                           
//                // number of clock cycles.                                                                      
//                if ( init_txn_pulse == 1'b1)                                                      
//                  begin                                                                                         
//                    mst_exec_state  <= INIT_WRITE;                                                              
//                  end                                                                                           
//                else                                                                                            
//                  begin                                                                                         
//                    mst_exec_state  <= IDLE;                                                            
//                  end                                                                                           
                                                                                                                
//              INIT_WRITE:                                                                                       
//                // This state is responsible to issue start_single_write pulse to                               
//                // initiate a write transaction. Write transactions will be                                     
//                // issued until burst_write_active signal is asserted.                                          
//                // write controller                                                                             
////                if (writes_done)                                                                                
////                  begin                                                                                         
////                    mst_exec_state <= IDLE;//                                                              
////                  end                                                                                           
////                else                                                                                            
//                  begin                                                                                                                                                                                                                                                      
//                    if (~axi_awvalid_reg && ~start_single_burst_write )                       
//                      begin                                                                                     
//                        start_single_burst_write <= 1'b1;                                                       
//                      end                                                                                       
//                    else                                                                                        
//                      begin                                                                                     
//                        start_single_burst_write <= 1'b0; //Negate to generate a pulse
//                        mst_exec_state <= IDLE;                          
//                      end                                                                                       
//                  end                                                                                           
                                                                                           
//              default :                                                                                         
//                begin                                                                                           
//                  mst_exec_state  <= IDLE;                                                              
//                end                                                                                             
//            endcase                                                                                             
//          end                                                                                                   
//      end //MASTER_EXECUTION_PROC                                                                               
    
    
      always @(posedge axi_aclk)                                                                              
      begin                                                                                                     
      if (axi_aresetn == 0 || init_txn_pulse == 1'b1)                                                                                 
        writes_done <= 1'b0;                                                                                  
      else if (axi_bvalid && axi_bready_reg)                          
        writes_done <= 1'b1;                                                                                  
      else                                                                                                    
        writes_done <= writes_done;                                                                           
      end                          

        // Instantiation of Axi Bus Interface Config_AXI
    ConfigurationPort # ( 
        .C_S_AXI_ID_WIDTH(C_Config_AXI_ID_WIDTH),
        .C_S_AXI_DATA_WIDTH(C_Config_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_Config_AXI_ADDR_WIDTH),
        .C_S_AXI_AWUSER_WIDTH(C_Config_AXI_AWUSER_WIDTH),
        .C_S_AXI_ARUSER_WIDTH(C_Config_AXI_ARUSER_WIDTH)
    ) configuration_port (
        .S_AXI_ACLK(config_axi_aclk),
        .S_AXI_ARESETN(config_axi_aresetn),
        .S_AXI_AWID(config_axi_awid),
        .S_AXI_AWADDR(config_axi_awaddr),
        .S_AXI_AWLEN(config_axi_awlen),
        .S_AXI_AWSIZE(config_axi_awsize),
        .S_AXI_AWBURST(config_axi_awburst),
        .S_AXI_AWLOCK(config_axi_awlock),
        .S_AXI_AWCACHE(config_axi_awcache),
        .S_AXI_AWPROT(config_axi_awprot),
        .S_AXI_AWQOS(config_axi_awqos),
        .S_AXI_AWREGION(config_axi_awregion),
        .S_AXI_AWUSER(config_axi_awuser),
        .S_AXI_AWVALID(config_axi_awvalid),
        .S_AXI_AWREADY(config_axi_awready),
        .S_AXI_WDATA(config_axi_wdata),
        .S_AXI_WSTRB(config_axi_wstrb),
        .S_AXI_WLAST(config_axi_wlast),
        .S_AXI_WVALID(config_axi_wvalid),
        .S_AXI_WREADY(config_axi_wready),
        .S_AXI_BID(config_axi_bid),
        .S_AXI_BRESP(config_axi_bresp),
        .S_AXI_BVALID(config_axi_bvalid),
        .S_AXI_BREADY(config_axi_bready),
        .S_AXI_ARID(config_axi_arid),
        .S_AXI_ARADDR(config_axi_araddr),
        .S_AXI_ARLEN(config_axi_arlen),
        .S_AXI_ARSIZE(config_axi_arsize),
        .S_AXI_ARBURST(config_axi_arburst),
        .S_AXI_ARLOCK(config_axi_arlock),
        .S_AXI_ARCACHE(config_axi_arcache),
        .S_AXI_ARPROT(config_axi_arprot),
        .S_AXI_ARQOS(config_axi_arqos),
        .S_AXI_ARREGION(config_axi_arregion),
        .S_AXI_ARUSER(config_axi_aruser),
        .S_AXI_ARVALID(config_axi_arvalid),
        .S_AXI_ARREADY(config_axi_arready),
        .S_AXI_RID(config_axi_rid),
        .S_AXI_RDATA(config_axi_rdata),
        .S_AXI_RRESP(config_axi_rresp),
        .S_AXI_RLAST(config_axi_rlast),
        .S_AXI_RVALID(config_axi_rvalid),
        .S_AXI_RREADY(config_axi_rready),
        .memory_out(buffer)
    );


	endmodule
