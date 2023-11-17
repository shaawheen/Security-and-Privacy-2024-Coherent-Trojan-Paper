# Data Tampering (Active Devil)

This test was conducted to see preliminary results on the Attack Use Case against Integrity -> data and instruction tampering in passive mode, i.e., wait for to snoop requests.

## Description 

The Linux is controlling the devil-in-the-fpga IP. The "victim" code is inside
the baremetal VM. 

**Test:** Firts mmap on linux a shared address (mmap is not cacheable, I will see the data on DDR). Then change the data through the AWSNOOP using the devil IP and if data tampering is correct, we should see the data change on the VM (cache) and on DDR, but when we write to DDR, we should see only data changing on the DDR.  

There are two linux apps:
- `read_phys_addr` -> triggers the malicious IP on the FPGA to read and write to any addr (e.g., `0x40000000`)
- `tampering_phys_addr` -> chnages data on cache at addr `0x40000000`
- `read_phys_addr` -> triggers the malicious IP on the FPGA to read any addr again (e.g., `0x40000000`) and we should see that both cache + DDR changed with `tampering_phys_addr`, but only DDR changed with `read_phys_addr`

## Setup
- Commit: [728c5a6bf4b8c5952fcfdfc9da4eb483a0c73323](https://github.com/ESCristiano/devil-in-the-fpga/tree/728c5a6bf4b8c5952fcfdfc9da4eb483a0c73323)
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
	- `./tampering_phys_addr`
		- Run `2_send.sh`
4. Run on the board linux: 1) `read_phys_addr`; 2) `tampering_phys_addr`; and 3)`read_phys_addr`.
 
## Results 
- We can write arbitrary cached memory (EL1, EL2, EL3)
- `rea d_phys_addr` changes only DDR 
- `tampering_phys_addr` changes both cache and DDR. Cache is in write-back ( AWSNOOP we are using invalidates data before changing it) 
