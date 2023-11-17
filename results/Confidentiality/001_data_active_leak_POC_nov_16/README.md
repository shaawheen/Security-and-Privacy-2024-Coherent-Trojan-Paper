# Data Leak (Active new devil Ip design)

This test was conducted to see preliminary results on the Attack Use Case against Confidentiality -> data leak.

## Description 

In this first test, the Linux is controlling the devil-in-the-fpga IP. There is a shared memory between baremetal VM and Linux VM, used to test the data leak. 

**Test:** Let the shared memory be cached by the baremetal VM, and then we can change the address on the cache, assuming the cache is in a write back policy. The cache will be changed and the DDR not, so if the data leak is correct, it will read the most update value of that address.

There are two linux apps:
- `leak_phys_addr` -> triggers the malicious IP on the FPGA to read any addr (e.g., `0x40000000`)
- `read_phys_addr` -> prints addr `0x40000000`, we can see data on DDR was changed, but we see that data on VM is not changed
- `leak_phys_addr` -> triggers the malicious IP on the FPGA to read any addr again (e.g., `0x40000000`) and we will see it reads the same data (baremetal VM cached data) 

## Setup
- Commit: [6f3e4cb863628fd35350757d2b7482965bb39744](https://github.com/ESCristiano/devil-in-the-fpga/tree/6f3e4cb863628fd35350757d2b7482965bb39744)
- Attack Scenario: Attack Cross-VMs ( But working in all 3 scenarios)
- Board: zcu102
 
## To Replicate
1. Switch to setup commit
2. `cd software  `
	- Issue a `nix-build` command
	- Plug the SD_card
	- Run `./result-9`
	- Power up the system, stop the u-boot and insert the command:
	    - `fatload mmc 0 0x200000 bao.img; bootm start 0x200000; bootm loados; bootm go`
3. `cd software/artifacts/linux-apps`
	- `./read_phys_addr`
		- Run `2_send.sh`
	- `./leak_phys_addr`
		- Run `2_send.sh`
4. Run on the board linux: 1) `leak_phys_addr`; 2) `read_phys_addr`; and 3)`leak_phys_addr`.
 
## Results 
- We can read arbitrary cached memory (EL1, EL2, EL3)