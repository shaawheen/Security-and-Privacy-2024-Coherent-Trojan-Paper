// NOTE: I need to update the top module CTRL_OUT_SIGNAL_WIDTH every time I had a 
// new signal, for the width of the signal to accomodate the new signal 
// -> width = C_ACE_ADDR_WIDTH + 4 + C_ACE_ADDR_WIDTH + 3 + 2 + 4 + 1 

`define CTRL_OUT_SIGNAL_WIDTH   (C_ACE_ADDR_WIDTH + 4 + C_ACE_ADDR_WIDTH + 3 + 2 + 4 + 1)

parameter CTRL_SIGNAL1_WIDTH = C_ACE_ADDR_WIDTH;
parameter CTRL_SIGNAL2_WIDTH = (CTRL_SIGNAL1_WIDTH + 4);
parameter CTRL_SIGNAL3_WIDTH = (CTRL_SIGNAL2_WIDTH + C_ACE_ADDR_WIDTH);
parameter CTRL_SIGNAL4_WIDTH = (CTRL_SIGNAL3_WIDTH + 3);
parameter CTRL_SIGNAL5_WIDTH = (CTRL_SIGNAL4_WIDTH + 2);
parameter CTRL_SIGNAL6_WIDTH = (CTRL_SIGNAL5_WIDTH + 4);
parameter CTRL_SIGNAL7_WIDTH = (CTRL_SIGNAL6_WIDTH + 1);

