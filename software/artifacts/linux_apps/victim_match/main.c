#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdint.h> 

#include "find_pa.h"


int main() {
    int dummy_var = 0;
    int dummy_var1 = 10;
    
    int mem_fd;
    int counter = 0;
    unsigned int *map_base;
    unsigned int base_addr = 0x40000000;

    // Open /dev/mem to access physical memory
    mem_fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (mem_fd == -1) {
        perror("Error opening /dev/mem");
        exit(1);
    }

    // Map physical memory into user space
    map_base = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, mem_fd, base_addr);
    if (map_base == MAP_FAILED) {
        perror("mmap() failed");
        close(mem_fd);
        exit(1);
    }

    printf("Done!\n");

    for(int i = 0; i < dummy_var1; i++)
        dummy_var +=2;

    printf("This is a very dummy code: %d %d\n", dummy_var, dummy_var1); 
    printf("ptr value: 0x%08x\n", *map_base); 

    *map_base = 0xdeadbeef;

    // VA to PA just works for EL1 to EL0 translations. If there
    // is an hypervisor in EL2, it will not work. Because we are
    // only decoding the first level VA translation.
    printf("                                                                  \n\r");
    printf("WARNING: VA to PA just works for EL0 to EL1 translations. If there\n\r");
    printf("        is an hypervisor in EL2, it will not work. Because we are \n\r");
    printf("        only decoding the first level VA translation.             \n\r");
    printf("                                                                  \n\r");
    getPhysicalAddress((void*) &main);

    // Unmap memory and close /dev/mem
    munmap(map_base, 4096);
    close(mem_fd);
    

    return 0;
}


