#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
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
#define CRRESP_pos  9
#define ACFLT_pos   14
#define ADDRFLT_pos 15
#define OSHEN_pos   16
#define CONEN_pos   17
#define DELAY_pos   18

// Status Reg bits
#define OSH_END_pos 0


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
    unsigned int *rdata1;
    unsigned int *rdata2;
    unsigned int *rdata3;
    unsigned int *rdata4;

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
    rdata1 = map_base+6;
    rdata2 = map_base+7;
    rdata3 = map_base+8;
    rdata4 = map_base+9;

    *base_addr = 0x4000000;
    *mem_size = 0;
    printf(" ctrl = 0x%08x\n", *ctrl);
    *ctrl |= (1 << EN_pos); // Enable IP
    // // while (!(*ctrl & (1 << EN_pos)));
    for (size_t i = 0; i < 10000000; i++);   
    printf(" ctrl = 0x%08x\n", *ctrl);   
    printf(" rdata1 = 0x%08x\n", *rdata1);
    printf(" rdata2 = 0x%08x\n", *rdata2);
    printf(" rdata3 = 0x%08x\n", *rdata3);
    printf(" rdata4 = 0x%08x\n", *rdata4);
    *ctrl &= ~(1 << EN_pos); // Disable IP
    printf(" ctrl = 0x%08x\n", *ctrl);   


    // Unmap memory and close /dev/mem
    munmap(map_base, 4096);
    close(mem_fd);
    
    printf("Done!\n");

    return 0;
}
