#include "find_pa.h"

#define PAGE_SIZE 4096

static uint64_t virtual_to_physical(void* virtual_address) {
    int fd = open("/proc/self/pagemap", O_RDONLY);
    if (fd == -1) {
        perror("open");
        return 0;
    }
    uint64_t value;
    off_t page_offset = ((uintptr_t)virtual_address / PAGE_SIZE) * sizeof(value);
    if (pread(fd, &value, sizeof(value), page_offset) != sizeof(value)) {
        perror("pread");
        close(fd);
        return 0;
    }
    close(fd);

    return (value & ((1ULL << 54) - 1)) << 12 | ((uintptr_t)virtual_address & 0x3ff);
}

uint64_t getPhysicalAddress(void* virtual_address) {
    void* addr = virtual_address;
    printf("Virtual Addr 0x%08x\n", addr);
    uint64_t phys_addr = virtual_to_physical(addr);
    printf("Physical Addr: 0x%08x\n", phys_addr);
}