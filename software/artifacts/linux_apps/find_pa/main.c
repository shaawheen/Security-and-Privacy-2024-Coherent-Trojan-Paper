#include "find_pa.h"

int main(int argc, char *argv[]) {

    if (argc != 2) {
        printf("[Error] Usage: %s <virtual_address>\n", argv[0]);
        return 1;
    }

    getPhysicalAddress((void*)strtoul(argv[1], NULL, 0));
    return 0;
}