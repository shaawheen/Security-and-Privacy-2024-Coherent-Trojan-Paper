
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

void main(void){

    static volatile bool master_done = false;
    int beat = 0;
    
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
        osh_cr_delay(4);
    }

    while(!master_done);

    // while(1){
    //     spin_lock(&print_lock);
    //     printf("cpu%d: Heart Beat %d | IRQ: %d \n", get_cpuid(), beat++, irq_count);
    //     spin_unlock(&print_lock);
    //     // asm volatile("dc ivac, %0" : : "r" (0x80010004));
    //     // printf("status    %d: %d\n", irq_count, *status); 
    //     for (size_t i = 0; i < 100000000; i++);        
    // }

    while(1) wfi();    
}
