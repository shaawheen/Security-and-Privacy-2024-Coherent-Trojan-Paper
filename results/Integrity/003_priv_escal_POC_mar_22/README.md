# Data Leak (Active new devil Ip design)

This elevates the privileges of a user application to root (priv. escalation). 

## Description 

Artifacts of this attack:
- `find_pattern` -> Configures the coherent Trojan and triggers the malicious IP
- `gain_root_priv` -> Sets the RUID, EUID and SUID to 0 (root)
- `priv_escal_setup.sh` -> Setup of the attack
- `priv_escal_attack.sh` -> Runs the attack
  
## Setup
- Commit: [fe1f7b1fa5373540902b7f2ea334bf62d292debd](https://github.com/ESCristiano/devil-in-the-fpga/tree/fe1f7b1fa5373540902b7f2ea334bf62d292debd)
- Attack Scenario: Attack Cross-Process ( But working in all 3 scenarios)
- Board: zcu104
  
## To Replicate (Automatically)
1. Run `send.sh` on host linux
2. Run `priv_escal_setup.sh` on boards's linux
3. Run `priv_escal_attack.sh` on boards's linux
4. User1 should have now gained root priv

## To Replicate "Meta-Evaluation"

If you want to run several times the experiments to get the rate of success, you can do so by run the following scripts:
- `run_eval.sh send` -> [**Host**] To send the scripts to the target board
- `eval.sh` -> [**Board**] Run the following scripts
- `run_eval.sh results` -> [**Host**] To get the results and the success rate

## Results 
- We can corrupt arbitrary memory (EL1, EL2, EL3) breaking Integrity