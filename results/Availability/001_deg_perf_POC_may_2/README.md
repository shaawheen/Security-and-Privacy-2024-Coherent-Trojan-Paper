# Data Leak (Active new devil Ip design)

This elevates the privileges of a user application to root (priv. escalation). 

## Description 

Artifacts of this attack:
- `find_pattern` -> Configures the coherent Trojan and triggers the malicious IP
- `gain_root_priv` -> Sets the RUID, EUID and SUID to 0 (root)
- `priv_escal_setup.sh` -> Setup of the attack
- `priv_escal_attack.sh` -> Runs the attack
  
## Setup
- Commit: [8d92f2a29bf8d2d70e296bc65dd1d1e42231dd55](https://github.com/ESCristiano/devil-in-the-fpga/tree/8d92f2a29bf8d2d70e296bc65dd1d1e42231dd55)
- Attack Scenario: Attack Cross-Process ( But working in all 3 scenarios)
- Board: zcu104
  
## To Replicate (Automatically)
1. Run `send.sh` on host linux
2. Run `priv_escal_setup.sh` on boards's linux
3. Run `priv_escal_attack.sh` on boards's linux
4. User1 should have now gained root priv

## Results 
- We can corrupt arbitrary memory (EL1, EL2, EL3) breaking Integrity