`include "devil_ctrl_defines.vh"

wire  [C_ACE_ADDR_WIDTH-1:0] w_from_ctrl_araddr;
wire                   [3:0] w_from_ctrl_arsnoop;
wire  [C_ACE_ADDR_WIDTH-1:0] w_from_ctrl_awaddr;
wire                   [2:0] w_from_ctrl_awsnoop;
wire                   [1:0] w_from_ctrl_ardomain;
wire                   [3:0] w_from_ctrl_active_func;
wire                         w_reply;

assign w_from_ctrl_araddr       = i_controller_signals[CTRL_SIGNAL1_WIDTH-1:0];
assign w_from_ctrl_arsnoop      = i_controller_signals[CTRL_SIGNAL2_WIDTH-1:CTRL_SIGNAL1_WIDTH];
assign w_from_ctrl_awaddr       = i_controller_signals[CTRL_SIGNAL3_WIDTH-1:CTRL_SIGNAL2_WIDTH];
assign w_from_ctrl_awsnoop      = i_controller_signals[CTRL_SIGNAL4_WIDTH-1:CTRL_SIGNAL3_WIDTH];
assign w_from_ctrl_ardomain     = i_controller_signals[CTRL_SIGNAL5_WIDTH-1:CTRL_SIGNAL4_WIDTH];
assign w_from_ctrl_active_func  = i_controller_signals[CTRL_SIGNAL6_WIDTH-1:CTRL_SIGNAL5_WIDTH];
assign w_reply                  = i_controller_signals[CTRL_SIGNAL7_WIDTH-1:CTRL_SIGNAL6_WIDTH];