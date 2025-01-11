# TrustZone Attack

This attack demonstrates the extraction of secrets from TrustZone, which are encrypted in main memory.

## Description 

The attack emulates a scenario where a Non-Secure, malicious OS invokes a secure service to perform authentication. During this process, the secure service decrypts a payload for processing. A Trojan monitors the secure service's execution and extracts plaintext from the cache during decryption.
  
## Setup
- Commit: [ffc9c19093113bbf81a438ee8353bec8aa58f0bc](https://github.com/ESCristiano/devil-in-the-fpga/tree/ffc9c19093113bbf81a438ee8353bec8aa58f0bc)
- Attack Scenario: Attack Cross-World
- Board: zcu104
  
## To Replicate 
1. Switch to setup commit
2. `cd software  `
	- Issue a `nix-build` command
	- Plug the SD_card
	- Run `./result-9`
	- Power up the system, stop the u-boot and insert the command:
	    - `fatload mmc 0 0x20000000 baremetal.bin && go 0x20000000`
3. You should see the following output from an EL1 test application
   - Authentication Success 
   - The plaintext, the cyphertext and the leaked plaintext 
   - The success rate 
