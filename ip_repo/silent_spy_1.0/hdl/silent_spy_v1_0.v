//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Shahin Roozkhosh
// 
// Create Date: 03/04/2022 04:57:49 PM
// Design Name:
// Module Name: Back Stabber
// Project Name: Backstabbing
// Target Devices: zcu102 with ACE port
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
`timescale 1 ns / 1 ps

	module silent_spy_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line
		parameter integer ACE_ADDR_LOG_BIT_BEGIN   = 6,
		parameter integer ACE_ADDR_LOG_BIT_END     = 31,
		
		parameter integer QUEUE_DEPTH              = 1024, 
		
		
        // Paremeters of ACE Interface
        parameter integer C_ACE_ADDR_WIDTH	        = 44,
        parameter integer C_ACE_DATA_WIDTH          = 128,
        parameter integer C_ACE_ACSNOOP_WIDTH       = 4,
        // Parameters of Axi Slave Bus Interface Config_AXI
        parameter integer C_Config_AXI_ID_WIDTH     = 16,
        parameter integer C_Config_AXI_DATA_WIDTH   = 128,
        parameter integer C_Config_AXI_ADDR_WIDTH   = 40,
        parameter integer C_Config_AXI_AWUSER_WIDTH = 0,
        parameter integer C_Config_AXI_ARUSER_WIDTH = 0,
        parameter integer C_Config_AXI_WUSER_WIDTH  = 0,
        parameter integer C_Config_AXI_RUSER_WIDTH  = 0,
        parameter integer C_Config_AXI_BUSER_WIDTH  = 0,
        parameter integer BUS_WIDTH	                = 128,
        parameter integer CACHE_LINE_WIDTH_BITS     = 512,
        // Parameters of Axi Slave Bus Interface M00_AXI
        parameter integer C_M00_AXI_ID_WIDTH        = 16,
        parameter integer C_M00_AXI_BURST_LEN       = 4,
        parameter integer C_M00_AXI_ADDR_WIDTH      = 40,
        parameter integer C_M00_AXI_DATA_WIDTH      = 128,
        parameter integer C_M00_AXI_AWUSER_WIDTH    = 0,
        parameter integer C_M00_AXI_ARUSER_WIDTH    = 0,
        parameter integer C_M00_AXI_WUSER_WIDTH     = 0,
        parameter integer C_M00_AXI_RUSER_WIDTH     = 0,
        parameter integer C_M00_AXI_BUSER_WIDTH     = 0,
        parameter integer PL_DRAM_WRITE_WIDTH      = 128
	)
	(
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
        // Ports of ACE Interface with PL
        input  wire                                          ace_aclk,
        input  wire                                          ace_aresetn,
        input  wire                   [C_ACE_ADDR_WIDTH-1:0] acaddr,
        input  wire                                    [2:0] acprot,
        output wire                                          acready,
        input  wire                [C_ACE_ACSNOOP_WIDTH-1:0] acsnoop,
        input  wire                                          acvalid,
        input  wire                                          crready,
        output wire                                    [4:0] crresp,
        output wire                                          crvalid,
        output wire                   [C_ACE_DATA_WIDTH-1:0] cddata,
        output wire                                          cdlast,
        input  wire                                          cdready,
        output wire                                          cdvalid,
        output wire                   [C_ACE_ADDR_WIDTH-1:0] araddr,
        output wire                                    [1:0] arbar,
        output wire                                    [1:0] arburst,
        output wire                                    [3:0] arcache,
        output wire                                    [1:0] ardomain,
        output wire                                    [5:0] arid,
        output wire                                    [7:0] arlen,
        output wire                                          arlock,
        output wire                                    [2:0] arprot,
        output wire                                    [3:0] arqos,
        input  wire                                          arready,
        output wire                                    [3:0] arregion,
        output wire                                    [2:0] arsize,
        output wire                                    [3:0] arsnoop,
        output wire                                   [15:0] aruser,
        output wire                                          arvalid,
        output wire                   [C_ACE_ADDR_WIDTH-1:0] awaddr,
        output wire                                    [1:0] awbar,
        output wire                                    [1:0] awburst,
        output wire                                    [3:0] awcache,
        output wire                                    [1:0] awdomain,
        output wire                                    [5:0] awid,
        output wire                                    [7:0] awlen,
        output wire                                          awlock,
        output wire                                    [2:0] awprot,
        output wire                                    [3:0] awqos,
        input  wire                                          awready,
        output wire                                    [3:0] awregion,
        output wire                                    [2:0] awsize,
        output wire                                    [2:0] awsnoop,
        output wire                                   [15:0] awuser,
        output wire                                          awvalid,
        input  wire                                    [5:0] bid,
        output wire                                          bready,
        input  wire                                    [1:0] bresp,
        input  wire                                          buser,
        input  wire                                          bvalid,
        output wire                                          rack,
        input  wire                   [C_ACE_DATA_WIDTH-1:0] rdata,
        input  wire                                    [5:0] rid,
        input  wire                                          rlast,
        output wire                                          rready,
        input  wire                                    [3:0] rresp,
        input  wire                                          ruser,
        input  wire                                          rvalid,
        output wire                                          wack,
        output wire                   [C_ACE_DATA_WIDTH-1:0] wdata,
        output wire                                    [5:0] wid,
        output wire                                          wlast,
        input  wire                                          wready,
        output wire                                   [15:0] wstrb,
        output wire                                          wuser,
        output wire                                          wvalid,
        // Ports of Axi Master Bus Interface M00_AXI
        input  wire                                          m00_axi_aclk,
        input  wire                                          m00_axi_aresetn,
        output wire               [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_awid,
        output wire             [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr,
        output wire                                  [7 : 0] m00_axi_awlen,
        output wire                                  [2 : 0] m00_axi_awsize,
        output wire                                  [1 : 0] m00_axi_awburst,
        output wire                                          m00_axi_awlock,
        output wire                                  [3 : 0] m00_axi_awcache,
        output wire                                  [2 : 0] m00_axi_awprot,
        output wire                                  [3 : 0] m00_axi_awqos,
        output wire           [C_M00_AXI_AWUSER_WIDTH-1 : 0] m00_axi_awuser,
        output wire                                          m00_axi_awvalid,
        input  wire                                          m00_axi_awready,
        output wire             [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata,
        output wire           [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb,
        output wire                                          m00_axi_wlast,
        output wire            [C_M00_AXI_WUSER_WIDTH-1 : 0] m00_axi_wuser,
        output wire                                          m00_axi_wvalid,
        input  wire                                          m00_axi_wready,
        input  wire               [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_bid,
        input  wire                                  [1 : 0] m00_axi_bresp,
        input  wire            [C_M00_AXI_BUSER_WIDTH-1 : 0] m00_axi_buser,
        input  wire                                          m00_axi_bvalid,
        output wire                                          m00_axi_bready,
        output wire               [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid,
        output wire             [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr,
        output wire                                  [7 : 0] m00_axi_arlen,
        output wire                                  [2 : 0] m00_axi_arsize,
        output wire                                  [1 : 0] m00_axi_arburst,
        output wire                                          m00_axi_arlock,
        output wire                                  [3 : 0] m00_axi_arcache,
        output wire                                  [2 : 0] m00_axi_arprot,
        output wire                                  [3 : 0] m00_axi_arqos,
        output wire           [C_M00_AXI_ARUSER_WIDTH-1 : 0] m00_axi_aruser,
        output wire                                          m00_axi_arvalid,
        input  wire                                          m00_axi_arready,
        input  wire               [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid,
        input  wire             [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata,
        input  wire                                  [1 : 0] m00_axi_rresp,
        input  wire                                          m00_axi_rlast,
        input  wire            [C_M00_AXI_RUSER_WIDTH-1 : 0] m00_axi_ruser,
        input  wire                                          m00_axi_rvalid,
        output wire                                          m00_axi_rready,
        // Debug (temporary) IO
        output wire                                    [3:0] debug_state
	);
    localparam SPY_TIMESTAMP_WIDTH      = 32 + ACE_ADDR_LOG_BIT_BEGIN;
	wire                          ac_handshake;
    wire                          r_handshake;
    wire                          dvm_operation_last_condition;
    wire                          dvm_operation_multi_condition;
    wire                          dvm_sync_last_condition;
    wire                          dvm_sync_multi_condition;
    wire                          log_condition;
    wire                          data_snoop_condition;
    wire                          queue_buffer_condition;
    wire                          queue_push_condition;
    wire                          queue_pop_condition;
    wire                          queue_empty;
    wire                          queue_full;
    reg [(PL_DRAM_WRITE_WIDTH/2)-1 : 0] queue_push_data;
    
    wire    [PL_DRAM_WRITE_WIDTH : 0] write_data;
    reg   [SPY_TIMESTAMP_WIDTH-1 : 0] delta_timestamp;
    wire                              spy_aw_handshake;
    wire                              spy_w_handshake;
    reg [C_M00_AXI_ADDR_WIDTH-1:0]    spy_write_address;
    wire  [$clog2(QUEUE_DEPTH)-1 : 0] spy_queue_counter;
    reg                       [7 : 0] spy_burst_counter;
    wire                              spy_done;
    

	localparam BURST_LEN = CACHE_LINE_WIDTH_BITS/BUS_WIDTH;

	// Raw data from the configuration port
    wire [((C_Config_AXI_DATA_WIDTH/8)*32)-1 : 0] buffer;
    wire                               [64-1 : 0] config_port_to_backstabber_begin_log;
    wire                               [64-1 : 0] config_port_to_backstabber_write_address;
    wire                               [64-1 : 0] config_port_to_backstabber_spy_ready;
   



    localparam IDLE                     = 0;
    localparam NON_REPLY_OR_DVM_OP_LAST = 1;
    localparam DVM_SYNC_MP              = 2;
    localparam DVM_SYNC_WAIT            = 3;
    localparam DVM_SYNC_LAST            = 4;
    localparam DVM_SYNC_READ            = 5;
    localparam DVM_SYNC_RACK            = 6;
    localparam DVM_OP_MP                = 7;
    localparam DVM_OP_WAIT              = 8;
    reg   [3 : 0] snoop_state;
    
    localparam TIMER_IDLE               = 0;
    localparam TIMER_ACTIVE             = 1;
    reg timer_state;
    
    localparam SPY_IDLE                 = 0;
    localparam SPY_AW_HANDSHAKE         = 1; 
    localparam SPY_W_HANDSHAKE          = 2;
    reg   [1 : 0] spy_state;
    
    localparam QUEUE_PUSH_IDLE          = 0;    
    localparam QUEUE_PUSH_ONE_VALID     = 1;
    localparam QUEUE_PUSH_TWO_VALID     = 2;
    reg [1 : 0] queue_push_state;
 
     // AXI outputs
    assign m00_axi_awid    = 0;
    assign m00_axi_awaddr  = spy_write_address + config_port_to_backstabber_write_address[C_M00_AXI_ADDR_WIDTH-1 : 0];
    assign m00_axi_awlen   = (spy_queue_counter <= 255) ? spy_queue_counter-1 : 255; // 255 is the max burst-size that zcu supports
    assign m00_axi_awsize  = 3'b100;  // 16 Bytes in burst
    assign m00_axi_awburst = 2'b01;   // INCR
    assign m00_axi_awlock  = 0;
    assign m00_axi_awcache = 4'b1110; // ALLOCATE ?
    assign m00_axi_awprot  = 3'b011;
    assign m00_axi_awqos   = 0;
    assign m00_axi_awuser  = 0;
    assign m00_axi_awvalid = (spy_state == SPY_AW_HANDSHAKE);
    assign m00_axi_wvalid  = (spy_state == SPY_W_HANDSHAKE);
    assign m00_axi_wlast   = (spy_state == SPY_W_HANDSHAKE) && (spy_burst_counter == 0);
    //assign m00_axi_wdata [C_M00_AXI_DATA_WIDTH-1 : PL_DRAM_WRITE_WIDTH] = 0;
    assign m00_axi_wdata [PL_DRAM_WRITE_WIDTH-1 : 0] = write_data;
    assign m00_axi_wstrb  = (16'hFFFF >> ((BUS_WIDTH - PL_DRAM_WRITE_WIDTH)/8));
    
    assign m00_axi_bready  = 1;//always accept write-back responses

    assign m00_axi_arid    = 0;
    assign m00_axi_araddr  = 0;
    assign m00_axi_arlen   = 0;
    assign m00_axi_arsize  = 0;
    assign m00_axi_arburst = 0;
    assign m00_axi_arlock  = 0;
    assign m00_axi_arcache = 0;
    assign m00_axi_arprot  = 0;
    assign m00_axi_arqos   = 0;
    assign m00_axi_aruser  = 0;
    assign m00_axi_arvalid = 0;
    assign m00_axi_rready  = 0;

    assign queue_buffer_condition         = (snoop_state == IDLE) && data_snoop_condition && ~queue_full && log_condition; //(snoop_state == REPLY) && ~queue_full && crready;
    assign queue_push_condition           = (queue_push_state == QUEUE_PUSH_TWO_VALID) && queue_buffer_condition;
    assign queue_pop_condition          = (spy_state == SPY_W_HANDSHAKE) && spy_w_handshake && ~queue_empty;
	assign log_condition                = (|config_port_to_backstabber_begin_log);
    assign spy_aw_handshake             = m00_axi_awvalid && m00_axi_awready;
    assign spy_w_handshake              = m00_axi_wvalid && m00_axi_wready;
    assign spy_done                     = ~log_condition && queue_empty;
        
	assign config_port_to_backstabber_begin_log         = buffer[0 +: 64];
    assign config_port_to_backstabber_write_address     = buffer[64 +: 64];



	//assign crresp   = (is_in_range & ace_enable) ? 5'b01001 : 5'b00000; //Alyaws accept if is in range - DataTransfer & IsShared;
    assign crresp   =  0; //we don't have the data;
    assign acready  =  ~queue_full && ((snoop_state == IDLE)          ||
                       (snoop_state == DVM_SYNC_WAIT) ||
                       (snoop_state == DVM_OP_WAIT));
    assign crvalid  = ((snoop_state == NON_REPLY_OR_DVM_OP_LAST) && crready) ||
                      ((snoop_state == DVM_SYNC_MP) && crready) ||
                      ((snoop_state == DVM_OP_MP) && crready) ||
                      ((snoop_state == DVM_SYNC_LAST) && crready && arready);
    assign araddr   = 0;
    assign arbar    = 1'b0;
    assign arburst  = 2'b01; //Should be calculated based on the acaddr inc or wrap?
    assign arcache  = 4'h3;//Refer to page 64 of manual. What is the effect of ARCACHE[1]?
    assign ardomain = 2'b00;
    assign arid     = 0;
    assign arlen    = 0; // Set to 3 for Four bursts to fill 64B (CL size)
    assign arlock   = 0;
    assign arprot   = 3'b011; //Data, Privileged, Non-secure access
    assign arqos    = 0;
    assign arregion = 0;
    assign arsize   = 4'b100; //Size of each burst is 16B
    assign arsnoop  = ((snoop_state == DVM_SYNC_LAST) && crready && arready) ? 4'he : 0; //Means arbar and ardomain have to be 0
    assign aruser   = 0;
    assign arvalid  = ((snoop_state == DVM_SYNC_LAST) && crready && arready); //acvalid & is_in_range & ace_enable;
    assign awaddr   = 0;
    assign awbar    = 0;
    assign awburst  = 0;
    assign awcache  = 0;
    assign awdomain = 0;
    assign awid     = 0;
    assign awlen    = 0;
    assign awlock   = 0;
    assign awprot   = 0;
    assign awqos    = 0;
    assign awregion = 0;
    assign awsize   = 0;
    assign awsnoop  = 0;
    assign awuser   = 0;
    assign awvalid  = 0;
    assign bready   = 0;
    assign wack     = 0;
    assign wdata    = 0;
    assign wlast    = 0;
    assign wstrb    = 0;
    assign wuser    = 0;
    assign wvalid   = 0;
    assign cddata   = 0;
    assign cdlast   = 0;
    assign cdvalid  = 0;
    assign rready   = (snoop_state == DVM_SYNC_READ);
    assign rack     = (snoop_state == DVM_SYNC_READ);
    assign ac_handshake                   = acready && acvalid;
    assign r_handshake                    = rready && rvalid && rlast;
    assign data_snoop_condition            = ac_handshake && (acsnoop != 4'hf);
    assign dvm_operation_last_condition   = ac_handshake && (acsnoop == 4'hf) && (acaddr[15:12] != 4'b1100) && (acaddr[0] == 0);
    assign dvm_operation_multi_condition  = ac_handshake && (acsnoop == 4'hf) && (acaddr[15:12] != 4'b1100) && (acaddr[0] == 1);
    assign dvm_sync_last_condition        = ac_handshake && (acsnoop == 4'hf) && (acaddr[15:12] == 4'b1100) && (acaddr[0] == 0);
    assign dvm_sync_multi_condition       = ac_handshake && (acsnoop == 4'hf) && (acaddr[15:12] == 4'b1100) && (acaddr[0] == 1);
    
    assign debug_state                    = snoop_state;
    
    
     always @(posedge ace_aclk)
     begin
       if(~ace_aresetn)
       begin
            queue_push_state <= QUEUE_PUSH_IDLE;
            queue_push_data  <= 0;
       end
       else if(queue_push_state == QUEUE_PUSH_IDLE)
       begin
            if(queue_buffer_condition)
            begin
                queue_push_state <= QUEUE_PUSH_TWO_VALID;
                queue_push_data <= {delta_timestamp, acaddr[ACE_ADDR_LOG_BIT_END : ACE_ADDR_LOG_BIT_BEGIN]}; 
            end
            else
                queue_push_state <= queue_push_state;
       end
//       else if(queue_push_state == QUEUE_PUSH_ONE_VALID)
//       begin
//            if(queue_buffer_condition)
//            begin
//                queue_push_state <= QUEUE_PUSH_TWO_VALID;
//                queue_push_data <= queue_push_data;
//            end
//            else
//                queue_push_state <= queue_push_state;
//       end
       else if(queue_push_state == QUEUE_PUSH_TWO_VALID)
       begin
            if(queue_buffer_condition)
            begin
                 queue_push_state <= QUEUE_PUSH_IDLE;
                 queue_push_data <= 0;
            end
            else
                queue_push_state <= queue_push_state;            
       end   
    end
    
    always @(posedge ace_aclk)
    begin
        if(~ace_aresetn)
        begin
            spy_state <= SPY_IDLE;
            spy_burst_counter <= 0;
            spy_write_address <= 0;
        end
        else if( spy_state == SPY_IDLE)
        begin
            if(~queue_empty)
                spy_state <= SPY_AW_HANDSHAKE;
            else 
                spy_state <= spy_state;
        end
        else if( spy_state == SPY_AW_HANDSHAKE)
        begin
            if(spy_aw_handshake)
            begin
                spy_state <= SPY_W_HANDSHAKE;
                spy_burst_counter <= m00_axi_awlen;                
            end
            else 
                spy_state <= spy_state;
        end
        else if( spy_state == SPY_W_HANDSHAKE)
        begin
            if(spy_w_handshake && (spy_burst_counter == 0))
            begin
                spy_state <= SPY_IDLE;
                spy_write_address <= spy_write_address + (PL_DRAM_WRITE_WIDTH/8);
            end
            else if (spy_w_handshake)
            begin
                spy_state <= spy_state;
                spy_write_address <= spy_write_address + (PL_DRAM_WRITE_WIDTH/8);
                spy_burst_counter <= spy_burst_counter -1;
            end
            else
                spy_state <= spy_state;
        end
    end
    
   
    always @(posedge ace_aclk)
    begin
        if(~ace_aresetn)
        begin
            timer_state <= TIMER_IDLE;
            delta_timestamp <= 0;
        end
        else if (timer_state == TIMER_IDLE)
        begin
            if(log_condition)
                timer_state <= TIMER_ACTIVE;
        end
        else if (timer_state == TIMER_ACTIVE)
        begin
            if(~log_condition)
                timer_state <= TIMER_IDLE;
            else if(log_condition)
            begin
                if(queue_buffer_condition)
                    delta_timestamp <= 1;
                else
                    delta_timestamp <= delta_timestamp + 1;
            end
        end
    end
   
   

	//main state-machine
	always @(posedge ace_aclk)
    begin
        if(~ace_aresetn)
            snoop_state <= IDLE;
        else if (snoop_state == IDLE)
        begin
            if(data_snoop_condition || dvm_operation_last_condition)
                snoop_state <= NON_REPLY_OR_DVM_OP_LAST;
            else if (dvm_sync_multi_condition)
                snoop_state <= DVM_SYNC_MP;
            else if (dvm_sync_last_condition)
                snoop_state <= DVM_SYNC_LAST;
            else if (dvm_operation_multi_condition)
                snoop_state <= DVM_OP_MP;
            else
                snoop_state <= snoop_state;
        end
        else if (snoop_state == NON_REPLY_OR_DVM_OP_LAST)
        begin
            if (crready)
                snoop_state <= IDLE;
            else
                snoop_state <= snoop_state;
        end
        else if (snoop_state == DVM_SYNC_MP)
        begin
             if (crready)
                 snoop_state <= DVM_SYNC_WAIT;
             else
                 snoop_state <= snoop_state;
        end
        else if (snoop_state == DVM_SYNC_WAIT)
        begin
             if (ac_handshake)// && (acsnoop == 4'hF))
                 snoop_state <= DVM_SYNC_LAST;
             else
                 snoop_state <= snoop_state;
        end
        else if (snoop_state == DVM_SYNC_LAST)
        begin
             if (arready && crready)
                 snoop_state <= DVM_SYNC_READ;
             else
                 snoop_state <= snoop_state;
        end
//        else if (snoop_state == DVM_SYNC_READ)
//        begin
//             if (r_handshake)
//                 snoop_state <= DVM_SYNC_RACK;
//             else
//                 snoop_state <= snoop_state;
//        end
        //else if (snoop_state == DVM_SYNC_RACK)
        else if (snoop_state == DVM_SYNC_READ)
        begin
             snoop_state <= IDLE;
        end
        else if (snoop_state == DVM_OP_MP)
        begin
             if (crready)
                 snoop_state <= DVM_OP_WAIT;
             else
                 snoop_state <= snoop_state;
        end
        else if (snoop_state == DVM_OP_WAIT)
        begin
             if (ac_handshake)// && (acsnoop == 4'hF))
                 snoop_state <= NON_REPLY_OR_DVM_OP_LAST;
             else
                 snoop_state <= snoop_state;
        end
    end

    Queue #(
        .DATA_SIZE(PL_DRAM_WRITE_WIDTH),
        .QUEUE_LENGTH(QUEUE_DEPTH)
    ) contexts (
        .clock(ace_aclk),
        .reset(~ace_aresetn),
        .valueIn({queue_push_data,delta_timestamp, acaddr[ACE_ADDR_LOG_BIT_END : ACE_ADDR_LOG_BIT_BEGIN]}),
        .valueInValid(queue_push_condition),
        .consumed(queue_pop_condition),
        .valueOut(write_data),
        .empty(queue_empty),
        .full(queue_full),
        .counter(spy_queue_counter)
    );

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
        .memory_out(buffer),
        .memory_in({{(512-64-64){1'b0}} , {(64-C_M00_AXI_ADDR_WIDTH){1'b0}}, spy_write_address, {(64-1){1'b0}}, spy_done})
    );


	endmodule