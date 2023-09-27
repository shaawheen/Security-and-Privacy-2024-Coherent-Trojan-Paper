#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

int main() {
    int mem_fd;
    uint phy_addr = 0x40000000;
    int *map_base;

    // Open /dev/mem to access physical memory
    mem_fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (mem_fd == -1) {
        perror("Error opening /dev/mem");
        exit(1);
    }

    // Map physical memory into user space
    map_base = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, mem_fd, phy_addr);
    if (map_base == MAP_FAILED) {
        perror("mmap() failed");
        close(mem_fd);
        exit(1);
    }

    // Access physical memory (example: read a 32-bit value)
    printf("Value at physical address 0x%08x: 0x%08x\n", phy_addr, *map_base);

    *map_base = 0xdeadbeef; 
    printf("Value at physical address 0x%08x: 0x%08x\n", phy_addr, *map_base);

    // Unmap memory and close /dev/mem
    munmap(map_base, 4096);
    close(mem_fd);

    return 0;
}
