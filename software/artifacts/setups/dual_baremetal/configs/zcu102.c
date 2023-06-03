#include <config.h>

VM_IMAGE(baremetal1_image, XSTR(BAO_WRKDIR_IMGS/baremetal1.bin));
VM_IMAGE(baremetal2_image, XSTR(BAO_WRKDIR_IMGS/baremetal2.bin));


struct config config = {
    
    CONFIG_HEADER

    .vmlist_size = 2,
    .vmlist = {   
        { 
            .image = {
                .base_addr = 0x00000000,
                .load_addr = VM_IMAGE_OFFSET(baremetal1_image),
                .size = VM_IMAGE_SIZE(baremetal1_image)
            },
            
            .entry = 0x00000000,
            
            .platform = {
                .cpu_num = 1,
                
                .region_num = 1,
                .regions =  (struct vm_mem_region[]) {
                    {
                        .base = 0x00000000,
                        .size = 0x4000000 
                    }
                },
                .dev_num = 2,
                .devs =  (struct vm_dev_region[]) {
                    {   
                        /* UART */
                        .pa = 0xFF000000,
                        .va = 0xFF000000,
                        .size = 0x10000,                   
                    },
                    {
                        /* Arch timer interrupt */
                        .interrupt_num = 1,
                        .interrupts = 
                            (irqid_t[]) {27}      
                    }
                },
                .arch = {
                    .gic = {
                        .gicd_addr = 0xF9010000,
                        .gicc_addr = 0xF9020000,
                    }
                }
            },
        },
        { 
            .image = {
                .base_addr = 0x00000000,
                .load_addr = VM_IMAGE_OFFSET(baremetal2_image),
                .size = VM_IMAGE_SIZE(baremetal2_image)
            },
            
            .entry = 0x00000000,
            
            .platform = {
                .cpu_num = 3,
                
                .region_num = 1,
                .regions =  (struct vm_mem_region[]) {
                    {
                        .base = 0x00000000,
                        .size = 0x4000000 
                    }
                },
                .dev_num = 2,
                .devs =  (struct vm_dev_region[]) {
                    {   
                        /* UART */
                        .pa = 0xFF000000,
                        .va = 0xFF000000,
                        .size = 0x10000,                   
                    },
                    {
                        /* Arch timer interrupt */
                        .interrupt_num = 1,
                        .interrupts = 
                            (irqid_t[]) {27}      
                    }
                },
                .arch = {
                    .gic = {
                        .gicd_addr = 0xF9010000,
                        .gicc_addr = 0xF9020000,
                    }
                }
            },
        }, 

    },
};
