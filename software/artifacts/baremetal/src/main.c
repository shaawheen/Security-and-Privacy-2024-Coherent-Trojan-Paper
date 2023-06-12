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
int *ptr_sh = (int*)0x80010000;
int delay = 0;
void shmem_handler() {

    spin_lock(&print_lock);
    printf("shmem irq %d\n", irq_count);
    spin_unlock(&print_lock);
    linux_buff[shmem_channel_size-1] = '\0';
    char* end = strchr(linux_buff, '\n');
    if (end != NULL) {
        *end = '\0';
    }
    sprintf(shmem_buff, "%d", irq_count);
    // 0b0011111010000100000 -> 1ms
    // 0b00100111000100000100000 -> 10ms
    // 0b110000110101000000100000 -> 100ms
    // if(irq_count < 3)
     
    // Enable [30] | Delay [29:7] | Signal to delay [6:5] | CRRESP [4:0]  
    // *ptr_sh =  (0b1 << 30) | (delay << 7) | ( 0b01 << 5 ) | 0b10000;;
    
    // irq_count++;
    // printf("sh: %d\n", delay);
    // delay = delay+100;
    //  while (1)
    {
        *ptr_sh =  (0b1 << 30) | (delay << 7) | ( 0b01 << 5 ) | 0b00000;;
        printf("sh: %d\n", delay);
        delay = delay+100;
    }
}

void shmem_init() {

    memset(shmem_buff, 0, shmem_channel_size);
    memset(linux_buff, 0, shmem_channel_size);

    irq_set_handler(SHMEM_IRQ_ID, shmem_handler);
    irq_set_prio(SHMEM_IRQ_ID, IRQ_MAX_PRIO);
    irq_enable(SHMEM_IRQ_ID);
}

void ipi_handler(){
    printf("cpu%d: %s\n", get_cpuid(), __func__);
    irq_send_ipi(1ull << (get_cpuid() + 1));
}

void timer_handler(){
    printf("cpu%d: %s\n", get_cpuid(), __func__);
    sprintf(shmem_buff, "%d", irq_count);
    irq_count++;
    timer_set(TIMER_INTERVAL);
}

void main(void){

    static volatile bool master_done = false;
    // int *ptr = (int*)0x80001000;
    
    if(cpu_is_master()){
        spin_lock(&print_lock);
        printf("Bao bare-metal test guest\n");
        spin_unlock(&print_lock);

        irq_set_handler(TIMER_IRQ_ID, timer_handler);

        timer_set(TIMER_INTERVAL);
        // irq_enable(TIMER_IRQ_ID);
        // irq_set_prio(TIMER_IRQ_ID, IRQ_MAX_PRIO);

        shmem_init();

        master_done = true;
        printf("IPC\n");
        sprintf(shmem_buff, "%d", irq_count);
        irq_count++;
    }

    while(!master_done);

    while(1) wfi();    
}
