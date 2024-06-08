# Deanonimization Attack

Deanonimization Trojan will be used to find when a specific portion of code is executing. We need this to launch an attack without knowing the Victim addresses. We assume the attacker knows the victim code. With that knowledge, the attacker configures the Coherent Trojan to monitor all snoops and search for a specific victim pattern, which uniquely identifies the victim.  
## Description 

The setup is built of two VMs, one linux + one baremetal. The baremetal is printing the value of one memory address. On the linux there are two applications; (1) one for configuring the Coherent Trojan; and (2) other that will act as a dummy victim. 

Setup SW components:
- `baremetal` -> reads and prints the value of address `0x40000100`. This will be used to see the poisoning.
- `find_pattern` -> configures the coherent Trojan and triggers the malicious IP
- `victim_match` -> dummy code to be monitored
## Setup
- Commit: [**EL1 Test**] [77b8b7a30990b7f4cc9d0f618fa6326fcf62f32c](https://github.com/ESCristiano/devil-in-the-fpga/tree/77b8b7a30990b7f4cc9d0f618fa6326fcf62f32c)
- Commit: [**EL2 Test**] [1006e3bbc17356cba52364d7726a85ee6aebee20](https://github.com/ESCristiano/devil-in-the-fpga/tree/1006e3bbc17356cba52364d7726a85ee6aebee20)
- Attack Scenario: Attack Cross-VMs ( But should work in all 3 scenarios)
- Board: zcu102/4 
 
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

## To Replicate "Meta-Evaluation"

### EL1

Load only linux -> `fatload mmc 0 0x00200000 linux.bin && go 0x00200000 `
- We need to have just the linux (not the hypervisor here) because we are getting the PA from linux to test if the deanonimization is being done correctly. If we had an hypervisor, we will have 2nd stage translation and we could do this validation in this way. 

If you want to run several times the experiments to get the rate of success, you can do so by run the following scripts:
- `run_eval.sh send` -> [**Host**] To send the scripts to the target board
- `eval.sh data` -> [**Board**] To run evaluation on data pattern match
- `eval.sh inst` -> [**Board**] To run evaluation on instruction pattern match
- `run_eval.sh results` -> [**Host**] To get the results and the success rate

### EL2

Load Hypervisor -> `fatload mmc 0 0x200000 bao.img; bootm start 0x200000; bootm loados; bootm go`

If you want to run several times the experiments to get the rate of success, you can do so by run the following scripts:
- `run_eval.sh send` -> [**Host**] To send the scripts to the target board
- `eval.sh data EL2` -> [**Board**] To run evaluation on data pattern match EL2
- `eval.sh inst EL2` -> [**Board**] To run evaluation on instruction pattern match EL2
- `run_eval.sh results` -> [**Host**] To get the results and the success rate