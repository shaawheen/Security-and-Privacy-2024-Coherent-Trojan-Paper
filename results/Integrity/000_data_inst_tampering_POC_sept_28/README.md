# Data and Instruction Tampering (Active Devil)

This test was conducted to see preliminary results on the Attack Use Case against Integrity -> data and instruction tampering.

## Description 

In this first test, the Linux is controlling the devil-in-the-fpga IP. There is a shared memory between VM and Linux, used to test the data leak. 

There are two linux apps:
- `read_phys_addr` -> writes 0xdeadbeef to addr `0x40000000`,  shared with other VM
- `tampering_phys_addr` -> triggers the malicious IP on the FPGA to poison/change any addr
  
## Setup
- Commit: [7e581d16ed2701ad8fa937702999aa3ec25b0b96](https://github.com/ESCristiano/devil-in-the-fpga/tree/7e581d16ed2701ad8fa937702999aa3ec25b0b96)
- Attack Scenario: Attack Cross-VMs ( But working in all 3 scenarios)
- Devil type: Active Devil
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
	- `./tampering_phys_addr`
		- Run `2_send.sh`
4. Run on the board linux `read_phys_addr` and then `tampering_phys_addr`
5. You should see the addr change from value 0xdeadbeef written by `read_phys_addr` to other value changed by `tampering_phys_addr` 

## Results 
- We can write memory arbitrarily (EL1, EL2, EL3). 
- No differences between Data and Instruction tampering/poisoning.
- **Biggest challenge:** find the physical address of the code/data we want to poison/change.