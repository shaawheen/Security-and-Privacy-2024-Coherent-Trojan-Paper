//////////////////////////////////////////////////////////////////////////////////
// Company: Technische Universitat Munchen. Chair of Cyber-Physical Systems.
// Engineer: Denis Hoornaert.
//
// Create Date: 02/04/2020 10:53:49 AM
// Design Name: Staller
// Module Name: Staller
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

`timescale 1 ns / 1 ps

module AXI_sink #
(
    // AXI interface parameters
    parameter integer C_S_AXI_ID_WIDTH	    = 16,
    parameter integer C_S_AXI_DATA_WIDTH	= 128,
    parameter integer C_S_AXI_ADDR_WIDTH	= 40,
    parameter integer C_S_AXI_AWUSER_WIDTH	= 0,
    parameter integer C_S_AXI_ARUSER_WIDTH	= 0,
    parameter integer C_S_AXI_WUSER_WIDTH	= 0,
    parameter integer C_S_AXI_RUSER_WIDTH	= 0,
    parameter integer C_S_AXI_BUSER_WIDTH	= 0,
    // Queue parameters
    parameter integer QUEUE_LENGTH          = 32,
    parameter integer REGISTER_SIZE         = 32,
    // Transactions parameters
    parameter integer BEATS                 = 4
)
(
    input wire                                S_AXI_ACLK,
    input wire                                S_AXI_ARESETN,
    input wire       [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_AWID,
    input wire     [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
    input wire                        [7 : 0] S_AXI_AWLEN,
    input wire                        [2 : 0] S_AXI_AWSIZE,
    input wire                        [1 : 0] S_AXI_AWBURST,
    input wire                                S_AXI_AWLOCK,
    input wire                        [3 : 0] S_AXI_AWCACHE,
    input wire                        [2 : 0] S_AXI_AWPROT,
    input wire                        [3 : 0] S_AXI_AWQOS,
    input wire                        [3 : 0] S_AXI_AWREGION,
    input wire   [C_S_AXI_AWUSER_WIDTH-1 : 0] S_AXI_AWUSER,
    input wire                                S_AXI_AWVALID,
    output wire                               S_AXI_AWREADY,
    input wire     [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
    input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
    input wire                                S_AXI_WLAST,
    input wire    [C_S_AXI_WUSER_WIDTH-1 : 0] S_AXI_WUSER,
    input wire                                S_AXI_WVALID,
    output wire                               S_AXI_WREADY,
    output wire      [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_BID,
    output wire                       [1 : 0] S_AXI_BRESP,
    output wire   [C_S_AXI_BUSER_WIDTH-1 : 0] S_AXI_BUSER,
    output wire                               S_AXI_BVALID,
    input wire                                S_AXI_BREADY,
    input wire       [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_ARID,
    input wire     [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
    input wire                        [7 : 0] S_AXI_ARLEN,
    input wire                        [2 : 0] S_AXI_ARSIZE,
    input wire                        [1 : 0] S_AXI_ARBURST,
    input wire                                S_AXI_ARLOCK,
    input wire                        [3 : 0] S_AXI_ARCACHE,
    input wire                        [2 : 0] S_AXI_ARPROT,
    input wire                        [3 : 0] S_AXI_ARQOS,
    input wire                        [3 : 0] S_AXI_ARREGION,
    input wire   [C_S_AXI_ARUSER_WIDTH-1 : 0] S_AXI_ARUSER,
    input wire                                S_AXI_ARVALID,
    output wire                               S_AXI_ARREADY,
    output wire      [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_RID,
    output wire    [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
    output wire                       [1 : 0] S_AXI_RRESP,
    output wire                               S_AXI_RLAST,
    output wire   [C_S_AXI_RUSER_WIDTH-1 : 0] S_AXI_RUSER,
    output wire                               S_AXI_RVALID,
    input wire                                S_AXI_RREADY
);

localparam BUS_WIDTH = (C_S_AXI_DATA_WIDTH/8);

// Control signals
wire                             read_empty;
wire                             read_full;
wire                             write_empty;
wire                             write_full;
// AXI4FULL signals
wire                             ar_handshake;
wire                             r_handshake;
wire                             r_done;
wire                             aw_handshake;
wire                             w_handshake;
wire                             w_done;
wire                             b_handshake;
wire                             axi_arready;
wire  	                         axi_rlast;
wire                             axi_rvalid;
reg                              axi_bvalid;
//The axi_arv_arr_flag flag marks the presence of read address valid
//reg axi_arv_arr_flag;
//The axi_arlen_cntr internal read address counter to keep track of beats in a burst transaction
reg [7:0] axi_arlen_cntr;
reg [7:0] axi_arlen;

// I/O Connections assignments
assign  ar_handshake = axi_arready && S_AXI_ARVALID;
assign  aw_handshake = S_AXI_AWREADY & S_AXI_AWVALID;
assign   b_handshake = S_AXI_BVALID && S_AXI_BVALID;
assign   r_handshake = axi_rvalid && S_AXI_RREADY;
assign   w_handshake = S_AXI_WREADY & S_AXI_WVALID;
assign        r_done = r_handshake && axi_rlast;
assign        w_done = w_handshake && S_AXI_WLAST;
assign     axi_rlast = (axi_arlen_cntr == BEATS-1);
// AXI
assign    axi_rvalid = ~read_empty;
assign   axi_arready = ~read_full;
assign S_AXI_ARREADY = axi_arready;
assign S_AXI_RDATA	 = 0;
assign S_AXI_RRESP	 = 0;
assign S_AXI_RLAST	 = axi_rlast;
assign S_AXI_RUSER	 = 0;
assign S_AXI_RVALID	 = axi_rvalid;
//assign S_AXI_RID     = head_of_the_queue_ID;
assign S_AXI_AWREADY = ~write_full;
assign S_AXI_WREADY  = 1;
assign S_AXI_BVALID  = axi_bvalid;
assign S_AXI_BRESP   = 0; //status: OK

QueueRAM #(
    .DATA_SIZE(C_S_AXI_ID_WIDTH),
    .QUEUE_LENGTH(QUEUE_LENGTH),
    .REGISTER_SIZE(REGISTER_SIZE)
) queue_read (
    .clock(S_AXI_ACLK),
    .reset(~S_AXI_ARESETN),
    .valueIn(S_AXI_ARID),
    .valueInValid(ar_handshake),
    .consumed(r_done),
    .valueOut(S_AXI_RID),
    .empty(read_empty),
    .full(read_full)
);

QueueRAM #(
    .DATA_SIZE(C_S_AXI_ID_WIDTH),
    .QUEUE_LENGTH(QUEUE_LENGTH),
    .REGISTER_SIZE(REGISTER_SIZE)
) queue_write (
    .clock(S_AXI_ACLK),
    .reset(~S_AXI_ARESETN),
    .valueIn(S_AXI_AWID),
    .valueInValid(aw_handshake),
    .consumed(b_handshake),
    .valueOut(S_AXI_BID),
    .empty(write_empty),
    .full(write_full)
);

always @( posedge S_AXI_ACLK )
begin
  if ( S_AXI_ARESETN == 1'b0 )
    begin
      axi_arlen_cntr <= 0;
      axi_arlen <= BEATS-1;
    end
  else
    begin
        if (r_handshake)
        begin
            axi_arlen_cntr <= (axi_arlen_cntr == axi_arlen)? 0 : axi_arlen_cntr + 1;
        end
    end
end

always @( posedge S_AXI_ACLK )
begin
if ( S_AXI_ARESETN == 1'b0 )
    begin
        axi_bvalid <= 0;
    end 
else  
    begin
        axi_bvalid <= w_done;        
    end
end 

endmodule