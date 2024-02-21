`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Cristiano
// 
// Create Date: 02/19/2024 05:53:17 PM
// Design Name: 
// Module Name: match_pattern
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This Module receives a pattern and a pattern_size between 1 and
// 16 (i.e., 1 up to 16 words) and search for that pattern in a cache line. The 
// module returns a signal indicating a pattern match, when there is a full pat-
// tern match, i.e., pattern[0:pattern_size] = cache_line[0:pattern_size]. If 
// there is only a partial pattern match, i,e., the pattern is not cache aligned,
// the module returns the word offset within cache line where the pattern was 
// found. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module match_pattern#(
    parameter integer CL_SIZE = 64 
    )
    (
    input [(CL_SIZE*8)-1:0] i_pattern,
    input             [4:0] i_pattern_size,
    input [(CL_SIZE*8)-1:0] i_cache_line,
    input                   i_trigger,
    output reg              o_full_match,
    output reg              o_partial_match,
    output reg        [3:0] o_match_offset,
    output reg              o_op_end
    );

    // Position of the first march of the pattern with the cache line 
    `define WORD_0    16'b0000000000000001
    `define WORD_1    16'b0000000000000010
    `define WORD_2    16'b0000000000000100
    `define WORD_3    16'b0000000000001000
    `define WORD_4    16'b0000000000010000
    `define WORD_5    16'b0000000000100000
    `define WORD_6    16'b0000000001000000
    `define WORD_7    16'b0000000010000000
    `define WORD_8    16'b0000000100000000
    `define WORD_9    16'b0000001000000000
    `define WORD_10   16'b0000010000000000
    `define WORD_11   16'b0000100000000000
    `define WORD_12   16'b0001000000000000
    `define WORD_13   16'b0010000000000000
    `define WORD_14   16'b0100000000000000
    `define WORD_15   16'b1000000000000000

    // Size of the Match Pattern, from 1 word to 16 words (i.e., cache line)
    `define FULL_MATCH_1     16'b0000000000000001
    `define FULL_MATCH_2     16'b0000000000000011
    `define FULL_MATCH_3     16'b0000000000000111
    `define FULL_MATCH_4     16'b0000000000001111
    `define FULL_MATCH_5     16'b0000000000011111
    `define FULL_MATCH_6     16'b0000000000111111
    `define FULL_MATCH_7     16'b0000000001111111
    `define FULL_MATCH_8     16'b0000000011111111
    `define FULL_MATCH_9     16'b0000000111111111
    `define FULL_MATCH_10    16'b0000001111111111
    `define FULL_MATCH_11    16'b0000011111111111
    `define FULL_MATCH_12    16'b0000111111111111
    `define FULL_MATCH_13    16'b0001111111111111
    `define FULL_MATCH_14    16'b0011111111111111
    `define FULL_MATCH_15    16'b0111111111111111
    `define FULL_MATCH_16    16'b1111111111111111

    // Partial Match Size, is the inverse of the FULL Match, because we have to
    //discount the offset of the first match and count till the end of the cache
    //line. E.g., if we have first match on word 5, we have the partial pattern
    //from word 5 until 15, cache_line[15:5], which gives us MATCH on word 5, 
    // i.e., we find the first element of the pattern at word 5 
    `define PARTIAL_MATCH_1     `FULL_MATCH_15
    `define PARTIAL_MATCH_2     `FULL_MATCH_14
    `define PARTIAL_MATCH_3     `FULL_MATCH_13
    `define PARTIAL_MATCH_4     `FULL_MATCH_12
    `define PARTIAL_MATCH_5     `FULL_MATCH_11
    `define PARTIAL_MATCH_6     `FULL_MATCH_10
    `define PARTIAL_MATCH_7     `FULL_MATCH_9
    `define PARTIAL_MATCH_8     `FULL_MATCH_8
    `define PARTIAL_MATCH_9     `FULL_MATCH_7
    `define PARTIAL_MATCH_10    `FULL_MATCH_6
    `define PARTIAL_MATCH_11    `FULL_MATCH_5
    `define PARTIAL_MATCH_12    `FULL_MATCH_4
    `define PARTIAL_MATCH_13    `FULL_MATCH_3
    `define PARTIAL_MATCH_14    `FULL_MATCH_2
    `define PARTIAL_MATCH_15    `FULL_MATCH_1

    wire [15:0] w_cache_line_word, w_match_word[15:0];   

    // Detect first pattern element 
    generate
        for(genvar i = 0; i < CL_SIZE/4; i = i + 1)
            begin 
                assign w_cache_line_word[i] = (i_cache_line[31+32*i:0+32*i]   ==  i_pattern[31:0]);
            end
    endgenerate
    
    // Detect Pattern
    generate
        for(genvar i = 0; i < CL_SIZE/4; i = i + 1)
            for(genvar j = 0; j < CL_SIZE/4; j = j + 1)
                begin 
                    if(j+i < CL_SIZE/4)
                        assign w_match_word[i][j] = (i_cache_line[31+32*(j+i):0+32*(j+i)] == i_pattern[31+32*j:0+32*j]);
                    else
                        assign w_match_word[i][j] = 0;
                end
    endgenerate

    always @(posedge i_trigger or negedge i_trigger ) begin 
        if(i_trigger == 0) // reset
        begin 
            o_op_end <= 0; 
            o_full_match <= 0;
            o_match_offset <= 0;  
            o_partial_match <= 0; 
        end else 
        begin
            case (w_cache_line_word)
                `WORD_0: 
                begin
                    case (w_match_word[0])
                    `FULL_MATCH_1:  begin if(i_pattern_size == 1)  o_full_match <= 1; else o_full_match <= 0; end
                    `FULL_MATCH_2:  begin if(i_pattern_size == 2)  o_full_match <= 1; else o_full_match <= 0; end  
                    `FULL_MATCH_3:  begin if(i_pattern_size == 3)  o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_4:  begin if(i_pattern_size == 4)  o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_5:  begin if(i_pattern_size == 5)  o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_6:  begin if(i_pattern_size == 6)  o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_7:  begin if(i_pattern_size == 7)  o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_8:  begin if(i_pattern_size == 8)  o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_9:  begin if(i_pattern_size == 9)  o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_10: begin if(i_pattern_size == 10) o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_11: begin if(i_pattern_size == 11) o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_12: begin if(i_pattern_size == 12) o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_13: begin if(i_pattern_size == 13) o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_14: begin if(i_pattern_size == 14) o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_15: begin if(i_pattern_size == 15) o_full_match <= 1; else o_full_match <= 0; end 
                    `FULL_MATCH_16: begin if(i_pattern_size == 16) o_full_match <= 1; else o_full_match <= 0; end 
                    default: begin o_full_match <= 0; end // No Match
                    endcase
                    o_op_end <= 1; 
                    o_match_offset <= 0;  
                    o_partial_match <= 0; 
                end
                `WORD_1: 
                begin // Partial Match (Not Aligned)
                    if(w_match_word[1] == `PARTIAL_MATCH_1) begin 
                        o_match_offset <= 1;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_2: 
                begin // Partial Match (Not Aligned)
                    if(w_match_word[2] == `PARTIAL_MATCH_2) begin 
                        o_match_offset <= 2;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_3: 
                begin // Partial Match (Not Aligned)
                    if(w_match_word[3] == `PARTIAL_MATCH_3) begin 
                        o_match_offset <= 3;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end  
                `WORD_4: 
                begin // Partial Match (Not Aligned)
                    if(w_match_word[4] == `PARTIAL_MATCH_4) begin 
                        o_match_offset <= 4;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_5: 
                begin // Partial Match (Not Aligned)
                    if(w_match_word[5] == `PARTIAL_MATCH_5) begin 
                        o_match_offset <= 5;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end  
                `WORD_6:  
                begin // Partial Match (Not Aligned)
                    if(w_match_word[6] == `PARTIAL_MATCH_6) begin 
                        o_match_offset <= 6;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_7:  
                begin // Partial Match (Not Aligned)
                    if(w_match_word[7] == `PARTIAL_MATCH_7) begin 
                        o_match_offset <= 7;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_8:  
                begin // Partial Match (Not Aligned)
                    if(w_match_word[8] == `PARTIAL_MATCH_8) begin 
                        o_match_offset <= 8;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_9:  
                begin // Partial Match (Not Aligned)
                    if(w_match_word[9] == `PARTIAL_MATCH_9) begin 
                        o_match_offset <= 9;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_10:  
                begin // Partial Match (Not Aligned)
                    if(w_match_word[10] == `PARTIAL_MATCH_10) begin 
                        o_match_offset <= 10;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_11:  
                begin // Partial Match (Not Aligned)
                    if(w_match_word[11] == `PARTIAL_MATCH_11) begin 
                        o_match_offset <= 11;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_12:  
                begin // Partial Match (Not Aligned)
                    if(w_match_word[12] == `PARTIAL_MATCH_12) begin 
                        o_match_offset <= 12;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_13:  
                begin // Partial Match (Not Aligned)
                    if(w_match_word[13] == `PARTIAL_MATCH_13) begin 
                        o_match_offset <= 13;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_14:  
                begin // Partial Match (Not Aligned)
                    if(w_match_word[14] == `PARTIAL_MATCH_14) begin 
                        o_match_offset <= 14;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                `WORD_15:  
                begin // Partial Match (Not Aligned)
                    if(w_match_word[15] == `PARTIAL_MATCH_15) begin 
                        o_match_offset <= 15;  
                        o_full_match <= 0; 
                        o_partial_match <= 1;
                    end
                    o_op_end <= 1;
                end 
                default: 
                begin // No Match 
                    o_op_end <= 1; 
                    o_full_match <= 0;
                    o_match_offset <= 0;  
                    o_partial_match <= 0; 
                end 
            endcase
        end
    end

endmodule
