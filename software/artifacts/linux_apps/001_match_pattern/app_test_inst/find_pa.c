#include "find_pa.h"

#define PAGE_SIZE 4096

static uint64_t virtual_to_physical(void* virtual_address) {
    int fd = open("/proc/self/pagemap", O_RDONLY);
    if (fd == -1) {
        perror("open");
        return 0;
    }
    uint64_t value;
    
    // Get the page offset to later seek it into the pagemap file
    off_t page_offset = ((uintptr_t)virtual_address / PAGE_SIZE) * sizeof(value);

    // The pagemap returns a uint64_t with the following information:
    //
    //  Bits 0-54  page frame number (PFN) if present
    //  Bits 0-4   swap type if swapped
    //  Bits 5-54  swap offset if swapped
    //  Bit  55    pte is soft-dirty (see Documentation/vm/soft-dirty.txt)
    //  Bit  56    page exclusively mapped (since 4.2)
    //  Bits 57-60 zero
    //  Bit  61    page is file-page or shared-anon (since 3.5)
    //  Bit  62    page swapped
    //  Bit  63    page present
    //
    // Info from: https://www.kernel.org/doc/Documentation/vm/pagemap.txt
    // For more info: https://stackoverflow.com/questions/5748492/is-there-any-api-for-determining-the-physical-address-from-virtual-address-in-li

    if (pread(fd, &value, sizeof(value), page_offset) != sizeof(value)) {
        perror("pread");
        close(fd);
        return 0;
    }
    close(fd);

    // Get the page frame number (PFN) shift it 12 (Page size) and add the addr
    // offset within the page using the virtual address (VA and PA offset are 
    // the same)
    return (value & ((1ULL << 55) - 1)) << 12 | ((uintptr_t)virtual_address & 0xfff);
}

uint64_t getPhysicalAddress(void* virtual_address) {
    void* addr = virtual_address;
    printf("Virtual Addr: 0x%08x\n", addr);
    uint64_t phys_addr = virtual_to_physical(addr);
    printf("Physical Addr: 0x%08x\n", phys_addr);
}