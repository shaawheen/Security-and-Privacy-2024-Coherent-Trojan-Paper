`timescale 1ns / 1ps

module QueueBRAM #(
        parameter DATA_SIZE = 8,
        parameter QUEUE_LENGTH = 4,
        parameter REGISTER_SIZE = 32
    )
    (
        input  wire                              clock,
        input  wire                              reset,
        input  wire        [REGISTER_SIZE-1 : 0] higher_threshold,
        input  wire            [DATA_SIZE-1 : 0] valueIn,
        input  wire                              valueInValid,
        input  wire                              consumed,
        output wire            [DATA_SIZE-1 : 0] valueOut,
        output reg                               empty,
        output reg                               full,
        input  wire                              hit,
        input  wire [$clog2(QUEUE_LENGTH)-1 : 0] hitIndex
    );
    
    // Internal registers
    reg [$clog2(QUEUE_LENGTH) : 0] counter;
    reg [$clog2(QUEUE_LENGTH) : 0] head;
    reg [$clog2(QUEUE_LENGTH) : 0] tail;
    
    UntrickedBRAM #(
        .RAM_WIDTH(DATA_SIZE),
        .RAM_DEPTH(QUEUE_LENGTH+1),
        .RAM_PERFORMANCE("LOW_LATENCY")
    ) bram (
        .addra(tail),
        .addrb((hit)? hitIndex : head),
        .dina(valueIn),
        .clka(clock),
        .wea(valueInValid),
        .enb(1),
        .rstb(reset),
        .regceb(),
        .doutb(valueOut)
    );

    always @(posedge clock)
    begin
        if(reset)
        begin
            tail <= 0;
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
            full <= 0;
            empty <= 1;
        end
        else
        begin
            if(consumed & valueInValid)
            begin
                counter <= counter;
                full <= full;
                empty <= empty;
            end
            else if(consumed)
            begin
                counter <= counter-1;
                full <= 0;
                empty <= (counter == 1);
            end
            else if(valueInValid)
            begin
                counter <= counter+1;
                full <= (counter == QUEUE_LENGTH-1);
                empty <= 0;
            end
        end
    end

endmodule