`timescale 1ns / 1ps

module QueueLUTRAM #(
        parameter DATA_SIZE = 8,
        parameter QUEUE_LENGTH = 4,
        parameter REGISTER_SIZE = 32,
        parameter ADDR_WIDTH = 40
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
        input  wire                              poke,
        input  wire           [ADDR_WIDTH-1 : 0] pokeAddr,
        output wire                              hit,
        output wire [$clog2(QUEUE_LENGTH)-1 : 0] hitIndex
    );
    
    // Internal registers
    reg [$clog2(QUEUE_LENGTH) : 0] counter;
    reg [$clog2(QUEUE_LENGTH) : 0] head;
    reg [$clog2(QUEUE_LENGTH) : 0] tail;
    
    reg [QUEUE_LENGTH-1 : 0][DATA_SIZE-1 : 0] ram;
    
    wire [QUEUE_LENGTH-1 : 0] hit_checks;
    genvar i;
    for (i = 0; i < QUEUE_LENGTH; i += 1)
        assign hit_checks[i] = (ram[i] == pokeAddr) && (pokeAddr != 0);
    assign hit = (|hit_checks) && poke;
    
    wire [QUEUE_LENGTH-1 : 0][$clog2(QUEUE_LENGTH)-1 : 0] hit_indices;
    genvar j;
    for (j = 0; j < QUEUE_LENGTH; j += 1)
        assign hit_indices[j] = (ram[j] == pokeAddr)? j : 0;
    assign hitIndex = |hit_indices;

    always @(posedge clock)
    begin
        if (reset)
        begin
            for (int i = 0; i < QUEUE_LENGTH; i += 1)
                ram[i] <= 0;
        end
        else
        begin
            if (valueInValid)
                ram[tail] <= valueIn;
            if (consumed)
                ram[head] <= 0;
        end
    end
    
    assign valueOut = ram[head];

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