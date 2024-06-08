#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdint.h> 

int main() {
    int mem_fd;
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

    // wait for the VM handshake
    while(*map_base == 0xdeadbeef); 
    
    printf("REAL PA:0x%08x\n", *map_base); 

    *map_base = 0xdeadbeef;

    // Unmap memory and close /dev/mem
    munmap(map_base, 4096);
    close(mem_fd);
    

    return 0;
}


