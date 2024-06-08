#include "find_pa.h"

#define CACHE_LINE_SIZE 64
#define N_WORDS CACHE_LINE_SIZE/sizeof(int)
// #define VECTOR_SIZE 1024*1024 // 1MB -> L2 cache size
#define VECTOR_SIZE 128*1024 // 128KB
// #define VECTOR_SIZE 64*1024 // 64KB
// #define VECTOR_SIZE 4*1024 // 4KB

int *vector;


int main(int argc, char *argv[]) {

    // int vector[N_WORDS];
    vector = (int*)aligned_alloc(CACHE_LINE_SIZE, VECTOR_SIZE);
    for (int i = 0; i < (VECTOR_SIZE)/4; i++) {
    // for (int i = 0; i < N_WORDS; i++) {
        vector[i] = 0xFF00FF00 + i+1;
        printf("vector[%d] (0x%08x) = 0x%08x\n", i, &vector[i], vector[i]);
    }
    
    getPhysicalAddress((void*)&vector[0]);

    free(vector); 

    return 0;
}