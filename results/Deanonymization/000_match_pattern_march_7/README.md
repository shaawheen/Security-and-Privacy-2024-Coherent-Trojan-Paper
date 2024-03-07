# Match Pattern 

Match patter will be used to find when a specific portion of code is executing. We need this to launch an attack without knowing the Victim addresses. We assume the attacker knows the victim code. With that knowledge, the attacker configures the Coherent Trojan to monitor all snoops and search for a specific victim pattern, which uniquely identifies the victim.  
## Description 

The setup is built of two VMs, one linux + one baremetal. The baremetal is printing the value of one memory address. On the linux there are two applications; (1) one for configuring the Coherent Trojan; and (2) other that will act as a dummy victim. 

Setup SW components:
- `baremetal` -> reads and prints the value of address `0x40000100`. This will be used to see the poisoning.
- `find_pattern` -> configures the coherent Trojan and triggers the malicious IP
- `victim_match` -> dummy code to be monitored
## Setup
- Commit: [379150b0974c756c65781a1397654ff3e6b386d5](https://github.com/ESCristiano/devil-in-the-fpga/tree/379150b0974c756c65781a1397654ff3e6b386d5)
- Attack Scenario: Attack Cross-VMs ( But should work in all 3 scenarios)
- Board: zcu102 or zcu104 
 
## To Replicate
1. Switch to setup commit
2. `cd software  `
	- Issue a `nix-build` command
	- Plug the SD_card
	- Run `./result-9`
	- Power up the system, stop the u-boot and insert the command:
	    - `fatload mmc 0 0x200000 bao.img; bootm start 0x200000; bootm loados; bootm go`
3. `cd software/artifacts/linux-apps`
	- `./find_pattern`
		- Run `2_send.sh`
	- `./victim_match`
		- Run `2_send.sh`
4. Run on the board linux: 1) `find_pattern`; 2) `victim_match`; 
5. You should see the value of the value printed by the baremetal change when you run the `victim_match`
 
## Results 
- We can detect the execution of a target code  (EL1, EL2, EL3)