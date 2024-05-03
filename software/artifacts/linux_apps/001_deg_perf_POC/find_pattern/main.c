#include <stdio.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdlib.h>
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
    #define FUNC_DMY        5
#define CRRESP_pos  9
#define ACFLT_pos   14
#define ADDRFLT_pos 15
#define OSHEN_pos   16
#define CONEN_pos   17
#define ADLEN_pos   18
#define ADTEN_pos   19
#define PDTEN_pos   20
#define MONEN_pos   21
#define CMD_pos     22 
    #define CMD_LEAK        0
    #define CMD_POISON      1
    #define CMD_TAMPER_CL   2
    #define CMD_DELAY_CR    3
#define STENDEN_pos 26 

// Status Reg bits
#define OSH_END_pos 0
#define BUSY_pos 1

#define READ_ONCE           0b0000
#define WRITE_LINE_UNIQUE   0b001
#define WRITE_BACK          0b011

int main(int argc, char *argv[]) {

    if (argc < 4) {
        printf("Usage: %s <en|dis> <delay> <isol|dis>\n", argv[0]);
        return 1;
    }

    int mem_fd;
    int counter = 0;
    unsigned int *map_base;
    unsigned int devil_base = 0x80010000;
    static unsigned int *ctrl;
    static unsigned int *status;
    static unsigned int *p_delay;
    static unsigned int *acsnoop;
    static unsigned int *base_addr;
    static unsigned int *mem_size;
    static unsigned int *arsnoop;
    static unsigned int *l_araddr;
    static unsigned int *h_araddr;
    static unsigned int *awsnoop;
    static unsigned int *l_awaddr;
    static unsigned int *h_awaddr;
    static unsigned int *reserved1;
    static unsigned int *reserved2;
    static unsigned int *reserved3;
    static unsigned int *reserved4;
    static unsigned int *DATA0;       
    static unsigned int *DATA1;           
    static unsigned int *DATA2;           
    static unsigned int *DATA3;           
    static unsigned int *DATA4;           
    static unsigned int *DATA5;           
    static unsigned int *DATA6;           
    static unsigned int *DATA7;           
    static unsigned int *DATA8;           
    static unsigned int *DATA9;           
    static unsigned int *DATA10;          
    static unsigned int *DATA11;          
    static unsigned int *DATA12;          
    static unsigned int *DATA13;          
    static unsigned int *DATA14;          
    static unsigned int *DATA15;   
    static unsigned int *PATTERN0;       
    static unsigned int *PATTERN1;           
    static unsigned int *PATTERN2;           
    static unsigned int *PATTERN3;           
    static unsigned int *PATTERN4;           
    static unsigned int *PATTERN5;           
    static unsigned int *PATTERN6;           
    static unsigned int *PATTERN7;           
    static unsigned int *PATTERN8;           
    static unsigned int *PATTERN9;           
    static unsigned int *PATTERN10;          
    static unsigned int *PATTERN11;          
    static unsigned int *PATTERN12;          
    static unsigned int *PATTERN13;          
    static unsigned int *PATTERN14;          
    static unsigned int *PATTERN15; 
    static unsigned int *PATTERN_SIZE; 
    static unsigned int *WORD_INDEX; 
    static unsigned int *END_PATTERN0;       
    static unsigned int *END_PATTERN1;           
    static unsigned int *END_PATTERN2;           
    static unsigned int *END_PATTERN3;           
    static unsigned int *END_PATTERN4;           
    static unsigned int *END_PATTERN5;           
    static unsigned int *END_PATTERN6;           
    static unsigned int *END_PATTERN7;           
    static unsigned int *END_PATTERN8;           
    static unsigned int *END_PATTERN9;           
    static unsigned int *END_PATTERN10;          
    static unsigned int *END_PATTERN11;          
    static unsigned int *END_PATTERN12;          
    static unsigned int *END_PATTERN13;          
    static unsigned int *END_PATTERN14;          
    static unsigned int *END_PATTERN15; 
    static unsigned int *END_PATTERN_SIZE; 


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
    PATTERN0 = map_base+32;
    PATTERN1 = map_base+33;
    PATTERN2 = map_base+34;
    PATTERN3 = map_base+35;
    PATTERN4 = map_base+36;
    PATTERN5 = map_base+37;
    PATTERN6 = map_base+38;
    PATTERN7 = map_base+39;
    PATTERN8 = map_base+40;
    PATTERN9 = map_base+41;
    PATTERN10 = map_base+42;
    PATTERN11 = map_base+43;
    PATTERN12 = map_base+44;
    PATTERN13 = map_base+45;
    PATTERN14 = map_base+46;
    PATTERN15 = map_base+47;
    PATTERN_SIZE = map_base+48;
    WORD_INDEX = map_base+49;
    END_PATTERN0 = map_base+50;
    END_PATTERN1 = map_base+51;
    END_PATTERN2 = map_base+52;
    END_PATTERN3 = map_base+53;
    END_PATTERN4 = map_base+54;
    END_PATTERN5 = map_base+55;
    END_PATTERN6 = map_base+56;
    END_PATTERN7 = map_base+57;
    END_PATTERN8 = map_base+58;
    END_PATTERN9 = map_base+59;
    END_PATTERN10 = map_base+60;
    END_PATTERN11 = map_base+61;
    END_PATTERN12 = map_base+62;
    END_PATTERN13 = map_base+63;
    END_PATTERN14 = map_base+64;
    END_PATTERN15 = map_base+65;
    END_PATTERN_SIZE = map_base+66;
    
    if (strcmp(argv[3], "isol") == 0) // ISOL Patterns
    {
        // ISOL START
        *PATTERN0  = 0xa9bd7bfd; 
        *PATTERN1  = 0x52800000; 
        *PATTERN2  = 0x910003fd; 
        *PATTERN3  = 0xa90153f3; 
        *PATTERN4  = 0xf90013f5; 
        *PATTERN5  = 0xd0000053; 
        *PATTERN6  = 0x9100a275; 
        *PATTERN7  = 0x910082a1; 
        *PATTERN8  = 0x97fffc64; 
        *PATTERN9  = 0xd0000054; 
        *PATTERN10 = 0x91004280; 
        *PATTERN11 = 0xb9400406; 
        *PATTERN12 = 0x710000df; 
        *PATTERN13 = 0x5400030d; 
        *PATTERN14 = 0xf94006a7; 
        *PATTERN15 = 0x52800005; 

        *PATTERN_SIZE = 16;

         //ISOL STOP 
        *END_PATTERN0   = 0x9b028c21;   
        *END_PATTERN1   = 0xf9401663;
        *END_PATTERN2   = 0x9b020400;
        *END_PATTERN3   = 0x1e620082;
        *END_PATTERN4   = 0xb9400681;
        *END_PATTERN5   = 0xcb030000;
        *END_PATTERN6   = 0x9e630000;
        *END_PATTERN7   = 0x1e620021;
        *END_PATTERN8   = 0x1e621800;
        *END_PATTERN9   = 0x1e611800;
        *END_PATTERN10  = 0xfd002660;
        *END_PATTERN11  = 0xa94153f3;
        *END_PATTERN12  = 0xa8c37bfd;
        *END_PATTERN13  = 0xd65f03c0;
        *END_PATTERN14  = 0xd503201f;
        *END_PATTERN15  = 0xd503201f;

        *END_PATTERN_SIZE = 16;
    }

    if (strcmp(argv[3], "dis") == 0) // DIS Patterns
    {
        // DIS START -> benchmark_execution: first two words are 20 and 30 offset, 
        //and last two of the patter are 00 adn 10, because the acces is not aligned
        *PATTERN0  = 0xa9be7bfd;
        *PATTERN1  = 0x7100001f;
        *PATTERN2  = 0x910003fd;
        *PATTERN3  = 0xa90153f3;
        *PATTERN4  = 0x540003cd;
        *PATTERN5  = 0x90000054;
        *PATTERN6  = 0x9107e281;
        *PATTERN7  = 0x52800803;
        *PATTERN8  = 0x97ffe248;
        *PATTERN9  = 0x17fffff2;
        *PATTERN10 = 0xa90153f3;
        *PATTERN11 = 0xf90013f5;
        *PATTERN12 = 0x97ffe1e4;
        *PATTERN13 = 0xd503201f;
        *PATTERN14 = 0xd503201f;
        *PATTERN15 = 0xd503201f;

        *PATTERN_SIZE = 16;
    
        //DIS STOP -> the cache line that has the benchmark_execution
        *END_PATTERN0   = 0xb94082c0;
        *END_PATTERN1   = 0xf9403ec1;
        *END_PATTERN2   = 0x940012d6;
        *END_PATTERN3   = 0x97fff70d;
        *END_PATTERN4   = 0xf9006ac0;
        *END_PATTERN5   = 0x97fff70f;
        *END_PATTERN6   = 0x3d803ec0;
        *END_PATTERN7   = 0xf94082c0;
        *END_PATTERN8   = 0xf9401e81;
        *END_PATTERN9   = 0x91000400;
        *END_PATTERN10  = 0xf90082c0;
        *END_PATTERN11  = 0xb5000061;
        *END_PATTERN12  = 0xf9401a82;
        *END_PATTERN13  = 0xb4001302;
        *END_PATTERN14  = 0xf9406a82;
        *END_PATTERN15  = 0xf100005f;

        *END_PATTERN_SIZE = 16;
    }

    *p_delay = atoi(argv[2]);
    
    if (strcmp(argv[1], "en") == 0) {
        *ctrl = 0; // Disable IP
        *ctrl    =    (0b00001 << CRRESP_pos) 
                    // | (1 << ACFLT_pos) 
                    // | (1 << ADDRFLT_pos) 
                    | (CMD_DELAY_CR << CMD_pos)
                    | (FUNC_DMY << FUNC_pos) 
                    // | (1 << PDTEN_pos)               
                    | (1 << STENDEN_pos)               
                    | (1 << MONEN_pos)               
                    | (1<< EN_pos);
        printf(" Coherent Trojan Configured!\n");
    }

    if (strcmp(argv[1], "dis") == 0) {
        *ctrl = 0; // Disable IP
        printf(" Coherent Trojan Disable!\n");
    }

    // Wait for the end of the reply
    // printf(" status = 0x%08x\n", *status);   
    // while(!*status);
    // printf(" status = 0x%08x\n", *status);   
    // while(*status);
    // printf(" ctrl = 0x%08x\n", *ctrl);   
    // *ctrl = 0; // Disable IP

    // Unmap memory and close /dev/mem
    munmap(map_base, 4096);
    close(mem_fd);
    
    return 0;
}