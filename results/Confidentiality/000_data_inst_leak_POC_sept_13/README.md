# Data and Instruction Leak

This test was conducted to see preliminary results on the Attack Use Case against Confidentiality -> data and instruction leak.
## Description 

In this first test, the Linux is controlling the devil-in-the-fpga IP. There is a shared memory between VM and Linux, used to test the data leak. 

There are two linux apps:
- `read_phys_addr` -> writes 0xdeadbeef to addr `0x40000000`,  shared with other VM
- `leak_phys_addr` -> triggers the malicious IP on the FPGA to read any addr (e.g., `0x40000000` e to leak data 0xdeadbeef)
## Setup
- Commit: [5216cf87caf834d36135dac3dc8f7a2931238370](https://github.com/ESCristiano/devil-in-the-fpga/tree/5216cf87caf834d36135dac3dc8f7a2931238370)
- Attack Scenario: Attack Cross-VMs ( But working in all 3 scenarios)
- Board: zcu104
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
4. Run on the board linux `read_phys_addr` and then `leak_phys_addr`
## Results 
- We can read arbitrary memory (EL1, EL2, EL3)
- No differences between Data and Instruction leak
- **Biggest challenge:** find the physical address of the code/data we want to leak.