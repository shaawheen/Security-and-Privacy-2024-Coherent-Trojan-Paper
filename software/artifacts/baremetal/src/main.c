
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

#define TIMER_INTERVAL (TIME_S(1))
// #define DATA_TAMPERING

spinlock_t print_lock = SPINLOCK_INITVAL;

#define SHMEM_IRQ_ID 52
int irq_count = 0;

char* const linux_buff    = (char*)0xf0002000;
char* const shmem_buff    = (char*)0xf0000000;
const size_t shmem_channel_size = 0x20; 

// void shmem_update_msg(int irq_count) {
//     printf("%d irqs!\n", irq_count);
//     // sprintf(shmem_buff, "%d irqs!\n",
//     //     irq_count);
// }

char* strnchr(const char* s, size_t n, char c) {
    for (size_t i = 0; i < n; i++) {
        if (s[i] == c) {
            return (char*)s + i;
        }
    }
    return NULL;
}

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
#define CRRESP_pos  9
#define ACFLT_pos   14
#define ADDRFLT_pos 15
#define OSHEN_pos   16
#define CONEN_pos   17
#define DELAY_pos   18

// Status Reg bits
#define OSH_END_pos 0

unsigned int *ctrl       = (unsigned int*)(0x80010000+0x00);
unsigned int *status     = (unsigned int*)(0x80010000+0x04);
unsigned int *p_delay    = (unsigned int*)(0x80010000+0x08);
unsigned int *acsnoop    = (unsigned int*)(0x80010000+0x0C);
unsigned int *base_addr  = (unsigned int*)(0x80010000+0x10);
unsigned int *mem_size   = (unsigned int*)(0x80010000+0x14);
unsigned int *rdata1     = (unsigned int*)(0x80010000+0x18);
unsigned int *rdata2     = (unsigned int*)(0x80010000+0x1C);
unsigned int *rdata3     = (unsigned int*)(0x80010000+0x20);
unsigned int *rdata4     = (unsigned int*)(0x80010000+0x24);


void osh_cr_delay(int delay){
    // *ctrl |= (delay << DELAY_pos); // max delay 8191, só tenho 13 bits para o delay
    printf(" ctrl = 0%x\n", ctrl);
    printf(" status = 0%x\n", status);
    printf(" p_delay = 0%x\n", p_delay);
    printf(" acsnoop = 0%x\n", acsnoop);
    printf(" base_addr = 0%x\n", base_addr);
    printf(" mem_size = 0%x\n", mem_size);
    *p_delay = delay;
    *acsnoop = delay+1;
    *base_addr = delay+2;
    *mem_size = delay+3;
    *ctrl |= (TEST_DELAY_CR << TEST_pos);
    *ctrl |= (FUNC_OSH << FUNC_pos); // One-shot Delay
    *ctrl |= (1 << OSHEN_pos); // Enable One-shot Delay
    *ctrl |= (1 << EN_pos); // Enable IP
    printf(" *ctrl = %d\n", *ctrl);
    printf(" *status = %d\n", *status);
    printf(" *p_delay = %d\n", *p_delay);
    printf(" *acsnoop = %d\n", *acsnoop);
    printf(" *base_addr = %d\n", *base_addr);
    printf(" *mem_size = %d\n", *mem_size);
    //  printf("ctrl      %d: %d\n", irq_count, *ctrl); 
    // printf("status    %d: %d\n", irq_count, *status); 
    // printf("delay     %d: %d\n", irq_count, *delay); 
    // printf("acsnoop   %d: %d\n", irq_count, *acsnoop); 
    // printf("base_addr %d: %d\n", irq_count, *base_addr); 
    // printf("mem_size  %d: %d\n", irq_count, *mem_size); 
    // for (unsigned int i = 0; i < 1000000000; i++);
    // __asm volatile("nop");
    //  printf("ctrl      %d: %d\n", irq_count, *ctrl); 
    // printf("status    %d: %d\n", irq_count, *status); 
    // printf("delay     %d: %d\n", irq_count, *delay); 
    // printf("acsnoop   %d: %d\n", irq_count, *acsnoop); 
    // printf("base_addr %d: %d\n", irq_count, *base_addr); 
    // printf("mem_size  %d: %d\n", irq_count, *mem_size); 
    // *ctrl &= ~(1 << OSHEN_pos); // Disable One-shot Delay
    // // *ctrl &= ~(1 << CONEN_pos); // Disable One-shot Delay
    // *ctrl &= ~(1 << EN_pos); // Disable IP
}


void con_cr_delay(int delay){
    *ctrl |= (delay << DELAY_pos);
    *ctrl |= (TEST_DELAY_CR << TEST_pos);
    *ctrl |= (FUNC_CON << FUNC_pos); // Cont. Delay
    *ctrl |= (1 << CONEN_pos); // Enable CON Delay
    *ctrl |= (1 << EN_pos); // Enable IP
    // *ctrl &= ~(1 << CONEN_pos); // Disable One-shot Delay
    // *ctrl &= ~(1 << EN_pos); // Disable IP
}

void shmem_handler() {

    // *ctrl &= ~(1 << CONEN_pos);
    // *ctrl &= ~(1 << EN_pos);
    // for (size_t i = 0; i < 1000; i++);      
    spin_lock(&print_lock);
    printf("shmem irq %d\n", irq_count);
    spin_unlock(&print_lock);
    linux_buff[shmem_channel_size-1] = '\0';
    char* end = strchr(linux_buff, '\n');
    if (end != NULL) {
        *end = '\0';
    }
    irq_count++;
    sprintf(shmem_buff, "%d", irq_count);
    // con_cr_delay(irq_count);
}

void shmem_init() {

    memset(shmem_buff, 0, shmem_channel_size);
    memset(linux_buff, 0, shmem_channel_size);

    irq_set_handler(SHMEM_IRQ_ID, shmem_handler);
    irq_set_prio(SHMEM_IRQ_ID, IRQ_MAX_PRIO);
    irq_enable(SHMEM_IRQ_ID);
}

// void ipi_handler(){
//     printf("cpu%d: %s\n", get_cpuid(), __func__);
//     irq_send_ipi(1ull << (get_cpuid() + 1));
// }

// void timer_handler(){
//     printf("cpu%d: %s\n", get_cpuid(), __func__);
//     sprintf(shmem_buff, "%d", irq_count);
//     irq_count++;
//     timer_set(TIMER_INTERVAL);
// }

void invalidateCache(void *address) {
    asm volatile (
        "dc ivac, %[addr]\n"  // Invalidate the data cache at address
        "dsb sy\n"            // Data Synchronization Barrier
        :                    // Output operands (none)
        : [addr] "r" (address)  // Input operands
        : "memory"            // Clobbered registers
    );
}

void invaliInstCache(void *address) {
    asm volatile (
        "ic ivau, %[addr]\n"  // Invalidate the instruction cache at address
        "dsb ish\n"            // Data Synchronization Barrier
        "isb sy\n"            // Instruction Synchronization Barrier
        :                    // Output operands (none)
        : [addr] "r" (address)  // Input operands
        : "memory"            // Clobbered registers
    );
}

void invalidate_all_instruction_cache() {
    asm volatile (
        "ic iallu\n"
        "dsb sy\n"
        "isb\n"
    );
}

int check_tamper = 0;

// CL 0
unsigned int *ptr   = (unsigned int*)(0x40000000);
unsigned int *ptr1  = (unsigned int*)(0x40000004);
unsigned int *ptr2  = (unsigned int*)(0x40000008);
unsigned int *ptr3  = (unsigned int*)(0x4000000C);
unsigned int *ptr4  = (unsigned int*)(0x40000010);
unsigned int *ptr5  = (unsigned int*)(0x40000014);
unsigned int *ptr6  = (unsigned int*)(0x40000018);
unsigned int *ptr7  = (unsigned int*)(0x4000001C);
unsigned int *ptr8  = (unsigned int*)(0x40000020);
unsigned int *ptr9  = (unsigned int*)(0x40000024);
unsigned int *ptr10 = (unsigned int*)(0x40000028);
unsigned int *ptr11 = (unsigned int*)(0x4000002C);
unsigned int *ptr12 = (unsigned int*)(0x40000030);
unsigned int *ptr13 = (unsigned int*)(0x40000034);
unsigned int *ptr14 = (unsigned int*)(0x40000038);
unsigned int *ptr15 = (unsigned int*)(0x4000003C);
// CL 1
unsigned int *ptr_1_0  = (unsigned int*)(0x40000000+0x40);
unsigned int *ptr_1_1  = (unsigned int*)(0x40000004+0x40);
unsigned int *ptr_1_2  = (unsigned int*)(0x40000008+0x40);
unsigned int *ptr_1_3  = (unsigned int*)(0x4000000C+0x40);
unsigned int *ptr_1_4  = (unsigned int*)(0x40000010+0x40);
unsigned int *ptr_1_5  = (unsigned int*)(0x40000014+0x40);
unsigned int *ptr_1_6  = (unsigned int*)(0x40000018+0x40);
unsigned int *ptr_1_7  = (unsigned int*)(0x4000001C+0x40);
unsigned int *ptr_1_8  = (unsigned int*)(0x40000020+0x40);
unsigned int *ptr_1_9  = (unsigned int*)(0x40000024+0x40);
unsigned int *ptr_1_10 = (unsigned int*)(0x40000028+0x40);
unsigned int *ptr_1_11 = (unsigned int*)(0x4000002C+0x40);
unsigned int *ptr_1_12 = (unsigned int*)(0x40000030+0x40);
unsigned int *ptr_1_13 = (unsigned int*)(0x40000034+0x40);
unsigned int *ptr_1_14 = (unsigned int*)(0x40000038+0x40);
unsigned int *ptr_1_15 = (unsigned int*)(0x4000003C+0x40);

unsigned int *ptr8b  = (unsigned int*)(0x40000100);
unsigned int *ptr9b  = (unsigned int*)(0x40000104);
unsigned int *ptr10b = (unsigned int*)(0x40000108);
unsigned int *ptr11b = (unsigned int*)(0x4000010C);
unsigned int *ptr12b = (unsigned int*)(0x40000110);
unsigned int *ptr13b = (unsigned int*)(0x40000114);
unsigned int *ptr14b = (unsigned int*)(0x40000118);
unsigned int *ptr15b = (unsigned int*)(0x4000011C);

void data_tamper(void){
    int counter = 0, init_value  = 0;

    #ifdef DATA_TAMPERING
        if(!counter)
            init_value = *ptr;
            
        if (init_value == *ptr8) 
        {
            invalidateCache(ptr8);
        }

        spin_lock(&print_lock);
        printf(" counter = %d\n", counter++);
        printf(" ptr    = 0x%08x | 0x%08x | 0x%08x | 0x%08x \n", *ptr, *ptr1, *ptr2, *ptr3);
        printf(" ptr    = 0x%08x | 0x%08x | 0x%08x | 0x%08x \n", *ptr4, *ptr5, *ptr6, *ptr7);
        printf(" ptr8   = 0x%08x | 0x%08x | 0x%08x | 0x%08x \n", *ptr8, *ptr9, *ptr10, *ptr11);
        printf(" ptr12  = 0x%08x | 0x%08x | 0x%08x | 0x%08x \n", *ptr12, *ptr13, *ptr14, *ptr15);
        printf(" ptr8b  = 0x%08x | 0x%08x | 0x%08x | 0x%08x \n", *ptr8b, *ptr9b, *ptr10b, *ptr11b);
        printf(" ptr12b = 0x%08x | 0x%08x | 0x%08x | 0x%08x \n", *ptr12b, *ptr13b, *ptr14b, *ptr15b);
        spin_unlock(&print_lock);
    #endif
        // while(init_value == *ptr){
        //     invalidateCache(0x40000000);
        // };

    // invaliInstCache(0x200015c0);
    
    // __asm volatile("ldr x0, =check_tamper ");
    // __asm volatile("mov x1, #0xBEEF");
    // // // Trying to fill a cache line, for now the devil has only a cache granularity 
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]"); 
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]"); 
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]"); 
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");

    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]"); 
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]"); 
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]"); 
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    // __asm volatile("ldr x1, [x0]"); __asm volatile("ldr x1, [x0]");
    
    // print result
    // FIXME: Cannot use here the spin_lock, otherwise the system hangs/crashes
    //when I do the instruction tampering. I don't know why!!! 
    // spin_lock(&print_lock); 
    // printf("Spin = 0x%08x\n", &print_lock);
    // printf("0x%08x\n", check_tamper);
    // spin_unlock(&print_lock);
}

/*
* Test: Let the address be cached (and then I can change the address on the 
* cache, assuming the cache is in a write back policy. The cache will be changed 
* and the ddr not, so if the data leak is correct, it will read the most update 
* value of that address) 
*/
void active_data_leak(){
    *ptr = 0x12345678;
    *ptr1 = *ptr1 + 1; 
    spin_lock(&print_lock);
    printf("Ptr = 0x%08x\n", *ptr);
    printf("Ptr1 = 0x%08x\n", *ptr1);
    printf("\n");
    spin_unlock(&print_lock);
    invalidateCache(ptr);
    for (int i = 0; i < 1000000000; i++);    
    
}

/*
* Test: I can mmap on linux the var, as the mmap is not cacheable, I will see 
* the data on DDR. Then I change the data through the AWSNOOP using the devil IP 
* and if data tampering is correct, I should see the data change on the VM and on 
* ddr, but when I write to memory, I should data only change on the linux app 
* which is looking at the memory  
*/
void active_data_tampering(){
    spin_lock(&print_lock);
    printf("Ptr = 0x%08x\n", *ptr);
    spin_unlock(&print_lock);
    for (int i = 0; i < 1500000000; i++); 
}


inline void monitor_transaction_test(){
    __asm volatile("ldr x0, =0x40000000");
    // IF 
    __asm volatile("IF:");
        __asm volatile("ldr x1, [x0]"); 
        __asm volatile("cbz x1, ACC"); 
    // ELse
    __asm volatile("ELSE:");
        __asm volatile("ldr x1, [x0]"); 
        __asm volatile("b NO_ACC"); 

    // IF statement
    __asm volatile("ACC:"); 
        printf("Access!!\n");
        __asm volatile("b END"); 

    // Else statement
    __asm volatile("NO_ACC:"); 
        printf("No Access\n");
        
    __asm volatile("END:"); 
}


void main(void){

    static volatile bool master_done = false;
    int beat = 0, key = 1, count = 0;

    if(cpu_is_master()){
        spin_lock(&print_lock);
        printf("Malicious Baremetal Guest\n");
        spin_unlock(&print_lock);

        // irq_set_handler(TIMER_IRQ_ID, timer_handler);

        // timer_set(TIMER_INTERVAL);
        // irq_enable(TIMER_IRQ_ID);
        // irq_set_prio(TIMER_IRQ_ID, IRQ_MAX_PRIO);

        shmem_init();

        master_done = true;
        // spin_lock(&print_lock);
        // printf("IPC\n");
        // spin_unlock(&print_lock);
        // sprintf(shmem_buff, "%d", irq_count);
        // irq_count++;
        // osh_cr_delay(4);
    }

    while(!master_done);

    while (1)
    {   
        // Pattern Slip between two cache lines
        // CL 0
        // *ptr   = 0xDEEDBEEF;
        // *ptr1  = 0x1FFFFFFF;
        // *ptr2  = 0xDEEDBEEF;
        // *ptr3  = 0x2FFFFFFF;
        // *ptr4  = 0xDEEDBEEF;
        // *ptr5  = 0x3FFFFFFF;
        // *ptr6  = 0xDEEDBEEF;
        // *ptr7  = 0x4FFFFFFF;
        // *ptr8  = 0xDEEDBEEF;
        // *ptr9  = 0x5FFFFFFF;
        // *ptr10 = 0xDEEDBEEF;
        // *ptr11 = 0x6FFFFFFF;
        // *ptr12 = 0xDEEDBEEF;
        // *ptr13 = 0x7FFFFFFF;
        // *ptr14 = 0xDEEDBEEF;
        // *ptr15 = 0x8FFFFFFF;
        // // CL 1
        // *ptr_1_0  = 0xff78efa1; 
        // *ptr_1_1  = 0xeb624e0d;
        // *ptr_1_2  = 0;
        // *ptr_1_3  = 0;
        // *ptr_1_4  = 0;
        // *ptr_1_5  = 0;
        // *ptr_1_6  = 0;
        // *ptr_1_7  = 0;
        // *ptr_1_8  = 0;
        // *ptr_1_9  = 0;
        // *ptr_1_10 = 0;
        // *ptr_1_11 = 0;
        // *ptr_1_12 = 0;
        // *ptr_1_13 = 0;
        // *ptr_1_14 = 0;
        // *ptr_1_15 = 0;

        // *ptr8b  = 0xF00DBABE; // 0x40000100
        // *ptr9b  = 0xF00DBABE;
        // *ptr10b = 0xF00DBABE;
        // *ptr11b = 0xF00DBABE;
        // *ptr12b = 0xF00DBABE;
        // *ptr13b = 0xF00DBABE;
        // *ptr14b = 0xF00DBABE;
        // *ptr15b = 0xF00DBABE;
        for (size_t i = 0; i < 3000000000; i++);  
        // invalidateCache(ptr15);
        // invalidateCache(ptr_1_0); // this is needed for the data to be written to memory
        // monitor_transaction_test();
        printf("Count   = 0x%08x\n", count++);
        printf("Ptr8b   = 0x%08x\n", *ptr8b);
        // printf("Ptr8b   = 0x%08x\n", *ptr8b);
        // printf("Ptr9b   = 0x%08x\n", *ptr9b);
        // printf("Ptr10b  = 0x%08x\n", *ptr10b);
        // printf("Ptr11b  = 0x%08x\n", *ptr11b);
        // active_data_leak();
        // active_data_tampering();
        // data_tamper();
    }

    while(1) wfi();    
}