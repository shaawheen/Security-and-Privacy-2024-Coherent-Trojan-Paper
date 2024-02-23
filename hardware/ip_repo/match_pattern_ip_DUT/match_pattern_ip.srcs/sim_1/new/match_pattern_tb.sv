`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2024 05:59:22 PM
// Design Name: 
// Module Name: match_pattern_tb
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



module match_pattern_tb();

    localparam CL_SIZE = 64;

    bit tb_reset;
    bit tb_clk;
    bit [(CL_SIZE*8)-1:0] reg_i_pattern;
    bit             [4:0] reg_i_pattern_size;
    bit [(CL_SIZE*8)-1:0] reg_i_cache_line;
    bit                   reg_o_full_match;
    bit                   reg_o_partial_match;
    bit             [3:0] reg_o_match_offset;
    bit                   reg_o_op_end;
    bit                   reg_i_trigger;

    always #1 tb_clk <= ~tb_clk;

    match_pattern #(
        .CL_SIZE(CL_SIZE)
    ) match_pattern_inst(
        .i_pattern(reg_i_pattern),
        .i_pattern_size(reg_i_pattern_size),
        .i_cache_line(reg_i_cache_line),
        .i_trigger(reg_i_trigger),
        .o_full_match(reg_o_full_match),
        .o_partial_match(reg_o_partial_match),
        .o_match_offset(reg_o_match_offset),
        .o_op_end(reg_o_op_end)
    );

    // Main process
    initial begin

        $timeformat (-12, 1, "ps", 1);

        /* code */
        // test_n1();
        test_n2();
        // test_n3();

        $display("End");
        $finish;
    end 

    task test_n3();
        tb_reset = 1'b0;
        reg_i_trigger = 0;
        #10
        tb_reset = 1'b1;
        
        // Set Pattern
        reg_i_pattern[31+32*0:0+32*0]   = 32'hd54783c2;
        reg_i_pattern[31+32*1:0+32*1]   = 32'hdcd5db54;
        reg_i_pattern[31+32*2:0+32*2]   = 32'hbbaf7e47;
        reg_i_pattern[31+32*3:0+32*3]   = 32'hfe16863c;
        reg_i_pattern[31+32*4:0+32*4]   = 32'hd206ceac;
        reg_i_pattern[31+32*5:0+32*5]   = 32'hd260d0b8;
        reg_i_pattern[31+32*6:0+32*6]   = 32'hf65b9c92; 
        reg_i_pattern[31+32*7:0+32*7]   = 32'hcd197260;
        reg_i_pattern[31+32*8:0+32*8]   = 32'hfcb01399;
        reg_i_pattern[31+32*9:0+32*9]   = 32'h1443e896;
        reg_i_pattern[31+32*10:0+32*10] = 32'h893d8de5;
        reg_i_pattern[31+32*11:0+32*11] = 32'h1cd9b232;
        reg_i_pattern[31+32*12:0+32*12] = 32'hc8772659;
        reg_i_pattern[31+32*13:0+32*13] = 32'h1ec5cf46;
        reg_i_pattern[31+32*14:0+32*14] = 32'hff78efa1;
        reg_i_pattern[31+32*15:0+32*15] = 32'heb624e0d;

        reg_i_pattern_size = 5'd16;

        // wait(w_fsm_devil_state == DEVIL_IDLE); // wait for idle state

        //----------------------------------------------------------------------
        // Match First Element Not Aligned
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'ha0a0a0a0;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'ha0a0a0a0;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hd54783c2;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hdcd5db54;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hbbaf7e47;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hfe16863c;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hd206ceac; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'hd260d0b8;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hf65b9c92;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'hcd197260;
        reg_i_cache_line[31+32*10:0+32*10] = 32'hfcb01399;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h1443e896;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h893d8de5;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h1cd9b232;
        reg_i_cache_line[31+32*14:0+32*14] = 32'hc8772659;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h1ec5cf46;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match First Element Not Aligned
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hff78efa1;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'heb624e0d;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'h0;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'h0;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'h0;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'h0;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'h0; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h0;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h0;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h0;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h0;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h0;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h0;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h0;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h0;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h0;

        // Set Pattern
        reg_i_pattern[31+32*0:0+32*0]   = 32'hff78efa1;
        reg_i_pattern[31+32*1:0+32*1]   = 32'heb624e0d;
        reg_i_pattern[31+32*2:0+32*2]   = 32'h0;
        reg_i_pattern[31+32*3:0+32*3]   = 32'h0;
        reg_i_pattern[31+32*4:0+32*4]   = 32'h0;
        reg_i_pattern[31+32*5:0+32*5]   = 32'h0;
        reg_i_pattern[31+32*6:0+32*6]   = 32'h0; 
        reg_i_pattern[31+32*7:0+32*7]   = 32'h0;
        reg_i_pattern[31+32*8:0+32*8]   = 32'h0;
        reg_i_pattern[31+32*9:0+32*9]   = 32'h0;
        reg_i_pattern[31+32*10:0+32*10] = 32'h0;
        reg_i_pattern[31+32*11:0+32*11] = 32'h0;
        reg_i_pattern[31+32*12:0+32*12] = 32'h0;
        reg_i_pattern[31+32*13:0+32*13] = 32'h0;
        reg_i_pattern[31+32*14:0+32*14] = 32'h0;
        reg_i_pattern[31+32*15:0+32*15] = 32'h0;

        reg_i_pattern_size = 5'd2;

        reg_i_trigger = 1;

        #20
        reg_i_trigger = 0;  
    endtask :test_n3

    task test_n2();
        tb_reset = 1'b0;
        reg_i_trigger = 0;
        #10
        tb_reset = 1'b1;
        
        // Set Pattern
        reg_i_pattern[31+32*0:0+32*0]   = 32'hDEEDBEEF;
        reg_i_pattern[31+32*1:0+32*1]   = 32'h1FFFFFFF;
        reg_i_pattern[31+32*2:0+32*2]   = 32'hDEEDBEEF;
        reg_i_pattern[31+32*3:0+32*3]   = 32'h2FFFFFFF;
        reg_i_pattern[31+32*4:0+32*4]   = 32'hDEEDBEEF;
        reg_i_pattern[31+32*5:0+32*5]   = 32'h3FFFFFFF;
        reg_i_pattern[31+32*6:0+32*6]   = 32'hDEEDBEEF; 
        reg_i_pattern[31+32*7:0+32*7]   = 32'h4FFFFFFF;
        reg_i_pattern[31+32*8:0+32*8]   = 32'hDEEDBEEF;
        reg_i_pattern[31+32*9:0+32*9]   = 32'h5FFFFFFF;
        reg_i_pattern[31+32*10:0+32*10] = 32'hDEEDBEEF;
        reg_i_pattern[31+32*11:0+32*11] = 32'h6FFFFFFF;
        reg_i_pattern[31+32*12:0+32*12] = 32'hDEEDBEEF;
        reg_i_pattern[31+32*13:0+32*13] = 32'h7FFFFFFF;
        reg_i_pattern[31+32*14:0+32*14] = 32'hDEEDBEEF;
        reg_i_pattern[31+32*15:0+32*15] = 32'h8FFFFFFF;

        reg_i_pattern_size = 5'd16;

        // wait(w_fsm_devil_state == DEVIL_IDLE); // wait for idle state

        //----------------------------------------------------------------------
        // Match First Element Aligned - Full Match
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'h1FFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'h2FFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'h3FFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hDEEDBEEF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h4FFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h5FFFFFFF;
        reg_i_cache_line[31+32*10:0+32*10] = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h6FFFFFFF;
        reg_i_cache_line[31+32*12:0+32*12] = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h7FFFFFFF;
        reg_i_cache_line[31+32*14:0+32*14] = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h8FFFFFFF;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 2)
        //----------------------------------------------------------------------
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'h0;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'h0;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'h1FFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'h2FFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hDEEDBEEF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h3FFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h4FFFFFFF;
        reg_i_cache_line[31+32*10:0+32*10] = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h5FFFFFFF;
        reg_i_cache_line[31+32*12:0+32*12] = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h6FFFFFFF;
        reg_i_cache_line[31+32*14:0+32*14] = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h7FFFFFFF;

        reg_i_trigger = 1;  

        //----------------------------------------------------------------------
        // Match First Element Not Aligned
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hDEEDBEEF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'h8FFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'h0;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'h0;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'h0;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'h0;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'h0; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h0;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h0;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h0;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h0;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h0;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h0;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h0;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h0;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h0;

        // Set Pattern
        reg_i_pattern[31+32*0:0+32*0]   = 32'hDEEDBEEF;
        reg_i_pattern[31+32*1:0+32*1]   = 32'h8FFFFFFF;
        reg_i_pattern[31+32*2:0+32*2]   = 32'h0;
        reg_i_pattern[31+32*3:0+32*3]   = 32'h0;
        reg_i_pattern[31+32*4:0+32*4]   = 32'h0;
        reg_i_pattern[31+32*5:0+32*5]   = 32'h0;
        reg_i_pattern[31+32*6:0+32*6]   = 32'h0; 
        reg_i_pattern[31+32*7:0+32*7]   = 32'h0;
        reg_i_pattern[31+32*8:0+32*8]   = 32'h0;
        reg_i_pattern[31+32*9:0+32*9]   = 32'h0;
        reg_i_pattern[31+32*10:0+32*10] = 32'h0;
        reg_i_pattern[31+32*11:0+32*11] = 32'h0;
        reg_i_pattern[31+32*12:0+32*12] = 32'h0;
        reg_i_pattern[31+32*13:0+32*13] = 32'h0;
        reg_i_pattern[31+32*14:0+32*14] = 32'h0;
        reg_i_pattern[31+32*15:0+32*15] = 32'h0;

        reg_i_pattern_size = 5'd2;

        reg_i_trigger = 1;

        #20
        reg_i_trigger = 0; 
    endtask :test_n2

    task test_n1();
        tb_reset = 1'b0;
        reg_i_trigger = 0;
        #10
        tb_reset = 1'b1;
        
        // Set Pattern
        reg_i_pattern[31+32*0:0+32*0]   = 32'h00000001;
        reg_i_pattern[31+32*1:0+32*1]   = 32'h00000002;
        reg_i_pattern[31+32*2:0+32*2]   = 32'h00000003;
        reg_i_pattern[31+32*3:0+32*3]   = 32'h00000004;
        reg_i_pattern[31+32*4:0+32*4]   = 32'h00000005;
        reg_i_pattern[31+32*5:0+32*5]   = 32'h00000006;
        reg_i_pattern[31+32*6:0+32*6]   = 32'h00000007; 
        reg_i_pattern[31+32*7:0+32*7]   = 32'h00000008;
        reg_i_pattern[31+32*8:0+32*8]   = 32'h00000009;
        reg_i_pattern[31+32*9:0+32*9]   = 32'h0000000A;
        reg_i_pattern[31+32*10:0+32*10] = 32'h0000000B;
        reg_i_pattern[31+32*11:0+32*11] = 32'h0000000C;
        reg_i_pattern[31+32*12:0+32*12] = 32'h0000000D;
        reg_i_pattern[31+32*13:0+32*13] = 32'h0000000E;
        reg_i_pattern[31+32*14:0+32*14] = 32'h0000000F;
        reg_i_pattern[31+32*15:0+32*15] = 32'h00000010;

        reg_i_pattern_size = 5'd16;

        // wait(w_fsm_devil_state == DEVIL_IDLE); // wait for idle state

        //----------------------------------------------------------------------
        // Match First Element Aligned - Full Match
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'h00000001;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'h00000002;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'h00000003;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'h00000004;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'h00000005;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'h00000006;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'h00000007; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h00000008;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h00000009;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h0000000A;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h0000000B;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h0000000C;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h0000000D;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h0000000E;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h0000000F;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h00000010;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 1)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'h00000001;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'h00000002;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'h00000003;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'h00000004;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'h00000005;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'h00000006; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h00000007;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h00000008;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h00000009;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h0000000A;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h0000000B;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h0000000C;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h0000000D;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h0000000E;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h0000000F;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 2)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'h00000001;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'h00000002;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'h00000003;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'h00000004;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'h00000005; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h00000006;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h00000007;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h00000008;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h00000009;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h0000000A;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h0000000B;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h0000000C;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h0000000D;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h0000000E;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 3)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'h00000001;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'h00000002;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'h00000003;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'h00000004; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h00000005;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h00000006;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h00000007;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h00000008;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h00000009;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h0000000A;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h0000000B;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h0000000C;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h0000000D;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 4)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'h00000001;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'h00000002;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'h00000003; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h00000004;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h00000005;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h00000006;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h00000007;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h00000008;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h00000009;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h0000000A;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h0000000B;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h0000000C;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 5)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'h00000001;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'h00000002; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h00000003;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h00000004;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h00000005;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h00000006;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h00000007;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h00000008;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h00000009;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h0000000A;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h0000000B;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 6)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'h00000001; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h00000002;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h00000003;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h00000004;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h00000005;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h00000006;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h00000007;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h00000008;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h00000009;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h0000000A;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 7)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hFFFFFFFF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'h00000001;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h00000002;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h00000003;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h00000004;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h00000005;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h00000006;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h00000007;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h00000008;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h00000009;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 8)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hFFFFFFFF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'h00000001;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h00000002;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h00000003;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h00000004;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h00000005;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h00000006;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h00000007;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h00000008;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 9)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hFFFFFFFF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'h00000001;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h00000002;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h00000003;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h00000004;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h00000005;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h00000006;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h00000007;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 10)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hFFFFFFFF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*10:0+32*10] = 32'h00000001;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h00000002;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h00000003;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h00000004;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h00000005;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h00000006;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 11)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hFFFFFFFF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*10:0+32*10] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*11:0+32*11] = 32'h00000001;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h00000002;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h00000003;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h00000004;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h00000005;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 12)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hFFFFFFFF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*10:0+32*10] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*11:0+32*11] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*12:0+32*12] = 32'h00000001;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h00000002;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h00000003;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h00000004;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 13)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hFFFFFFFF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*10:0+32*10] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*11:0+32*11] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*12:0+32*12] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*13:0+32*13] = 32'h00000001;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h00000002;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h00000003;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 14)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hFFFFFFFF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*10:0+32*10] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*11:0+32*11] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*12:0+32*12] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*13:0+32*13] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*14:0+32*14] = 32'h00000001;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h00000002;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // Match Not Aligned - Partial Match (Element 15)
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hFFFFFFFF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*10:0+32*10] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*11:0+32*11] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*12:0+32*12] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*13:0+32*13] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*14:0+32*14] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*15:0+32*15] = 32'h00000001;

        reg_i_trigger = 1;

        //----------------------------------------------------------------------
        // No Match First Element
        //----------------------------------------------------------------------
        
        #20
        reg_i_trigger = 0;
        
        #10

        // Set 
        reg_i_cache_line[31+32*0:0+32*0]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*1:0+32*1]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*2:0+32*2]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*3:0+32*3]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*4:0+32*4]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*5:0+32*5]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*6:0+32*6]   = 32'hFFFFFFFF; 
        reg_i_cache_line[31+32*7:0+32*7]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*8:0+32*8]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*9:0+32*9]   = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*10:0+32*10] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*11:0+32*11] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*12:0+32*12] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*13:0+32*13] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*14:0+32*14] = 32'hFFFFFFFF;
        reg_i_cache_line[31+32*15:0+32*15] = 32'hFFFFFFFF;

        reg_i_trigger = 1;
    endtask :test_n1

endmodule
