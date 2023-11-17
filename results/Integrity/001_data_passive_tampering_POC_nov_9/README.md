# Data and Instruction Tampering (Passive Devil)

This test was conducted to see preliminary results on the Attack Use Case against Integrity -> data and instruction tampering in passive mode, i.e., wait for to snoop requests.

## Description 

The Linux is controlling the devil-in-the-fpga IP. The "victim" code is inside
the baremetal VM. There is a filter applied to snoops and addresses. Thus, only
the snoops and address we specified will be tampered with.

Linux apps:
- `passive_tamp_phys_addr` -> triggers the malicious IP on the FPGA to poison/change any addr when a snoop requests arrives
  
## Setup
- Commit: [48e673e7758c8afbdb1d7998195eea5b769a1ff5](https://github.com/ESCristiano/devil-in-the-fpga/tree/48e673e7758c8afbdb1d7998195eea5b769a1ff5)
- Attack Scenario: Attack Cross-VMs ( But working in all 3 scenarios)
- Devil type: Passive Devil
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
	- `./passive_tamp_phys_addr`
		- Run `2_send.sh`
4. Run on the board linux the `tampering_phys_addr` app
5. You should see the values printed by the baremetal VM  change to other value once you run `tampering_phys_addr` 

## Results 
- We can write memory arbitrarily (EL1, EL2, EL3). 
- No differences between Data and Instruction tampering/poisoning.
- **Biggest challenge:** find the physical address of the code/data we want to poison/change.