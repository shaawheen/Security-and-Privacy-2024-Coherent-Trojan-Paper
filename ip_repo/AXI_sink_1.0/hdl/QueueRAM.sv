`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Technische Universitat Munchen. Chair of Cyber-Physical Systems
// Engineer: Denis Hoornaert
//
// Create Date: 01/17/2020 02:22:57 PM
// Design Name: Queue
// Module Name: Queue
// Project Name: MemorEDF
// Target Devices: Generic
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


module QueueRAM #(
        parameter     DATA_SIZE = 8,
        parameter  QUEUE_LENGTH = 4,
        parameter REGISTER_SIZE = 32
    )
    (
        input                            clock,
        input                            reset,
        input          [DATA_SIZE-1 : 0] valueIn,
        input                            valueInValid,
        input                            consumed,
        output         [DATA_SIZE-1 : 0] valueOut,
        output wire                      empty,
        output wire                      full
    );
    
    // Internal registers
    reg            [$clog2(QUEUE_LENGTH) : 0] counter;
    reg            [$clog2(QUEUE_LENGTH) : 0] head;
    reg            [$clog2(QUEUE_LENGTH) : 0] tail;
    
    reg [QUEUE_LENGTH-1 : 0][DATA_SIZE-1 : 0] ram;
    
    reg                                       int_full;
    reg                                       int_empty;
    
    assign full  = int_full;
    assign empty = int_empty;

    always @(posedge clock)
    begin
        if (reset)
            for (int i = 0; i < QUEUE_LENGTH; i += 1)
                ram[i] <= 0;
        else
        begin
            if(valueInValid)
                ram[tail] <= valueIn;
            if(consumed)
                ram[head] <= 0;
        end
    end

    assign valueOut = ram[head];

    always @(posedge clock)
    begin
        if(reset)
        begin
            tail <= 0; //INIT_COUNTER-1;
            head <= 0;
        end
        else
        begin
            if(consumed)
                head <= (head+1)%QUEUE_LENGTH;
            if(valueInValid)
                tail <= (tail+1)%QUEUE_LENGTH;
        end
    end

    always @(posedge clock)
    begin
        if(reset)
        begin
            counter <= 0;
            int_full <= 0;
            int_empty <= 1;
        end
        else
        begin
            if(consumed & valueInValid)
            begin
                counter <= counter;
                int_full <= full;
                int_empty <= empty;
            end
            else if(consumed)
            begin
                counter <= counter-1;
                int_full <= 0;
                int_empty <= (counter == 1);
            end
            else if(valueInValid)
            begin
                counter <= counter+1;
                int_full <= (counter == QUEUE_LENGTH-1);
                int_empty <= 0;
            end
        end
    end

endmodule