`define NUM_OF_CYCLES   1 // 7 ns  -> 1/150Mhz
// `define NUM_OF_CYCLES   150 // 1 us 
`define OKAY                2'b00

// Control Reg bits
`define EN_pos      0
`define TEST_pos    1
// Devil-in-the-fpga Tests
    `define FUZZING                     0
    `define REPLY_WITH_DELAY_CRVALID    1
    `define REPLY_WITH_DELAY_CDVALID    2
    `define REPLY_WITH_DELAY_CDLAST     3
`define FUNC_pos 5
// Devil-in-the-fpga Functions
    `define OSH         0
    `define CON         1
    `define READ_SNOOP  2 
    `define WRITE_SNOOP 3
    `define PDT         4
    `define DMY         5
`define CRRESP_pos  9
`define ACFLT_pos   14
`define ADDRFLT_pos 15
`define OSHEN_pos   16
`define CONEN_pos   17
`define ADLEN_pos   18
`define ADTEN_pos   19
`define PDTEN_pos   20

    // Filters
`define NO_FILTER       2'b00
`define AC_FILTER       2'b01
`define ADDR_FILTER     2'b10
`define AC_ADDR_FILTER  2'b11  

`define DATA_REPLY 1 
`define DUMMY_REPLY 0  

`define READONCE            4'b0000 
`define READSHARED          4'b0001 
`define READCLEAN           4'b0010
`define READNOTSHAREDDIRTY  4'b0011         
`define READUNIQUE          4'b0111 
`define CLEANUNIQUE         4'b1011 
`define MAKEUNIQUE          4'b1100 
`define CLEANSHARED         4'b1000 
`define CLEANINVALID        4'b1001     
`define MAKEINVALIDE        4'b1101     
