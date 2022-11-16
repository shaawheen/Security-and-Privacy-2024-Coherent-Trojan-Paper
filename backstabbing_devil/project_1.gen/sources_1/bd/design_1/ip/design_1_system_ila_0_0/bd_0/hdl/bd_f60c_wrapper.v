//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Command: generate_target bd_f60c_wrapper.bd
//Design : bd_f60c_wrapper
//Purpose: IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module bd_f60c_wrapper
   (clk,
    probe0,
    probe1,
    probe10,
    probe11,
    probe12,
    probe13,
    probe14,
    probe15,
    probe16,
    probe17,
    probe18,
    probe19,
    probe2,
    probe20,
    probe21,
    probe22,
    probe23,
    probe24,
    probe3,
    probe4,
    probe5,
    probe6,
    probe7,
    probe8,
    probe9);
  input clk;
  input [43:0]probe0;
  input [2:0]probe1;
  input [0:0]probe10;
  input [0:0]probe11;
  input [0:0]probe12;
  input [0:0]probe13;
  input [0:0]probe14;
  input [0:0]probe15;
  input [4:0]probe16;
  input [0:0]probe17;
  input [127:0]probe18;
  input [0:0]probe19;
  input [0:0]probe2;
  input [0:0]probe20;
  input [0:0]probe21;
  input [0:0]probe22;
  input [3:0]probe23;
  input [0:0]probe24;
  input [3:0]probe3;
  input [0:0]probe4;
  input [43:0]probe5;
  input [1:0]probe6;
  input [1:0]probe7;
  input [0:0]probe8;
  input [3:0]probe9;

  wire clk;
  wire [43:0]probe0;
  wire [2:0]probe1;
  wire [0:0]probe10;
  wire [0:0]probe11;
  wire [0:0]probe12;
  wire [0:0]probe13;
  wire [0:0]probe14;
  wire [0:0]probe15;
  wire [4:0]probe16;
  wire [0:0]probe17;
  wire [127:0]probe18;
  wire [0:0]probe19;
  wire [0:0]probe2;
  wire [0:0]probe20;
  wire [0:0]probe21;
  wire [0:0]probe22;
  wire [3:0]probe23;
  wire [0:0]probe24;
  wire [3:0]probe3;
  wire [0:0]probe4;
  wire [43:0]probe5;
  wire [1:0]probe6;
  wire [1:0]probe7;
  wire [0:0]probe8;
  wire [3:0]probe9;

  bd_f60c bd_f60c_i
       (.clk(clk),
        .probe0(probe0),
        .probe1(probe1),
        .probe10(probe10),
        .probe11(probe11),
        .probe12(probe12),
        .probe13(probe13),
        .probe14(probe14),
        .probe15(probe15),
        .probe16(probe16),
        .probe17(probe17),
        .probe18(probe18),
        .probe19(probe19),
        .probe2(probe2),
        .probe20(probe20),
        .probe21(probe21),
        .probe22(probe22),
        .probe23(probe23),
        .probe24(probe24),
        .probe3(probe3),
        .probe4(probe4),
        .probe5(probe5),
        .probe6(probe6),
        .probe7(probe7),
        .probe8(probe8),
        .probe9(probe9));
endmodule
