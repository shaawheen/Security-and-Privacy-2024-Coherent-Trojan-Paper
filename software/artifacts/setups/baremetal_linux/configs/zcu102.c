#include <config.h>

VM_IMAGE(linux_VM, XSTR(BAO_WRKDIR_IMGS/linux.bin));
VM_IMAGE(baremetal, XSTR(BAO_WRKDIR_IMGS/baremetal.bin));

struct config config = {
    
    CONFIG_HEADER


    .shmemlist_size = 1,
    .shmemlist = (struct shmem[]) {
        [0] = { 
                .size = 0x00010000,
            }
    },

    .vmlist_size = 2,
    .vmlist = {
        { 
            .image = {
                .base_addr = 0x00200000,
                .load_addr = VM_IMAGE_OFFSET(linux_VM),
                .size = VM_IMAGE_SIZE(linux_VM)
            },

            .entry = 0x00200000,
            .cpu_affinity=0b0001,
            
            .platform = {
                .cpu_num = 1,

                .region_num = 1,
                .regions =  (struct vm_mem_region[]) {
                    {
                        .base = 0x00000000,
                        .size = 0x40000000
                    },
                },

                .ipc_num = 1,
                .ipcs = (struct ipc[]) {
                    {
                        .base = 0xf0000000,
                        .size = 0x00010000,
                        .shmem_id = 0,
                        .interrupt_num = 1,
                        .interrupts = (irqid_t[]) {52}
                    }
                },

                .dev_num = 4,
                .devs =  (struct vm_dev_region[]) {
                    {   
                        /* UART1 */
                        .pa = 0xFF010000,
                        .va = 0xFF010000,
                        .size = 0x1000,
                        .interrupt_num = 1,
                        .interrupts = 
                            (irqid_t[]) {54}                         
                    },
                    {   
                        /* Arch timer interrupt */
                        .interrupt_num = 1,
                        .interrupts = 
                            (irqid_t[]) {27}                         
                    },
                    {
                        /* GEM3 */
                        .id = 0x877, /* smmu stream id */
                        .pa = 0xff0e0000,
                        .va = 0xff0e0000,
                        .size = 0x1000,
                        .interrupt_num = 2,
                        .interrupts = 
                            (irqid_t[]) {95, 96}                           
                    },
                    {   /* PL */
                        .pa = 0x80000000,
                        .va = 0x80000000,
                        .size = 0x30000
                    },
                },

                .arch = {
                    .gic = {
                        .gicc_addr = 0xF9020000,
                        .gicd_addr = 0xF9010000
                    },
                }
            },
        },
        
        { 
            .image = {
                .base_addr = 0x00000000,
                .load_addr = VM_IMAGE_OFFSET(baremetal),
                .size = VM_IMAGE_SIZE(baremetal)
            },

            .entry = 0x00000000,
            .cpu_affinity=0b0010,


            .platform = {
                .cpu_num = 1,

                .region_num = 1,
                .regions =  (struct vm_mem_region[]) {
                    {
                        .base = 0x00000000,
                        .size = 0x8000000
                    }

                },

                .ipc_num = 1,
                .ipcs = (struct ipc[]) {
                    {
                        .base = 0xf0000000,
                        .size = 0x00010000,
                        .shmem_id = 0,
                        .interrupt_num = 1,
                        .interrupts = (irqid_t[]) {52}
                    }
                },

                .dev_num = 3,
                .devs =  (struct vm_dev_region[]) {
                    {   
                        /* UART0 */
                        .pa = 0xFF000000,
                        .va = 0xFF000000,
                        .size = 0x10000                          
                    },
                    {   
                        /* Arch timer interrupt */
                        .interrupt_num = 1,
                        .interrupts = 
                            (irqid_t[]) {27}                         
                    },
                    {   /* PL */
                        .pa = 0x80000000,
                        .va = 0x80000000,
                        .size = 0x30000
                    },
                },

                .arch = {
                    .gic = {
                        .gicd_addr = 0xF9010000,
                        .gicc_addr = 0xF9020000,
                    }
                }
            },
        }
    },
};
