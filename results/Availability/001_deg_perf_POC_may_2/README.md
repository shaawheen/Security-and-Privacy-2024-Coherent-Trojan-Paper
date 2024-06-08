# Performance Degradation

This attack inflicts arbitrary delays. We measure the performance degradation with [RT-Bench](https://gitlab.com/rt-bench/rt-bench).

## Description 

Artifacts of this attack:
- `send.sh` -> sends to the board all necessary artifacts to run the attack
- `performance_degradation.sh` -> script to run the attack on the board
- `get_results.sh` -> script to read the results of the test (copy the csv files from board to PC)
  
## Setup
- Commit: [5135da9f2b757391c52214c84a7bf8d61e0d0a05](https://github.com/ESCristiano/devil-in-the-fpga/tree/5135da9f2b757391c52214c84a7bf8d61e0d0a05)
- Attack Scenario: Attack Cross-Process ( But should work in all 3 scenarios)
- Board: zcu102/4
  
## To Replicate 
1. Run `send.sh` on host linux
2. Run `performance_degradation.sh` on boards's linux
3. Run `get_results.sh` on host linux
4. You should get a `results` folder with all the csv from the experiments

