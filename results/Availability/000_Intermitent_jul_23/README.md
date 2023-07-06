# Continuous Delay

This test was conducted to see preliminary results on the Attack Use Case against Availability -> performance degradation/intermittent failure.

**Normal Operation**

<img src="https://svg.wavedrom.com/{signal: [{name: 'clock',    wave: 'p......'}, {name: 'acsnoop',  wave: 'x3.4.x.', data: '1 7'},  {name: 'acready',  wave: 'l.hlhl.'},  {name: 'acvalid',  wave: 'l.hlhl.'}, {name: 'crvalid',  wave: 'l..hlhl'},], head:{   text: ['tspan', {'font-size':'20'}, 'Normal Reply'],   tick:1 }, foot:{ text:'Fig: crvalid without a delay', },}"/>


**Evil Operation**

<img src="https://svg.wavedrom.com/{signal: [  {name: 'clock',    wave: 'p............'},  {name: 'acsnoop',  wave: 'x3.4....x.....', data: '1 7'},  {name: 'acready',  wave: 'l.hl...hl....'},  {name: 'acvalid',  wave: 'l.hl...hl....'},  {name: 'crvalid',  wave: 'l.....hl...hl'},], head:{   text: ['tspan', {'font-size':'20'}, 'Reply W/ Delay'],   tick:1 }, foot:{   text:'Fig: Delay crvalid N Cycles', }, }"/>

## Description 

In this first test, the Linux is controlling the devil-in-the-fpga IP. There is a shared memory between malicious VM and Linux, used to increase the delay every time the RT-bench is executed. 

## Setup
- Commit: [8d1c8f4b7bb0e0df9a4284935744720fb5164489](https://github.com/ESCristiano/devil-in-the-fpga/tree/8d1c8f4b7bb0e0df9a4284935744720fb5164489)
- Attack Scenario: Attack Cross-VMs  (baremetal against linux over bao)
- Base delay: `7ns`
- Each delay increment produces a new delay the following way: `7ns * (1<<delay)`
- Signal being delayed: `crvalid`
- Board: zcu102

## To Replicate
1. Switch to setup commit
2. `cd software  `
	- Issue a `nix-build` command
	- Plug the SD_card
	- Run `./result-9`
	- Power up the system, stop the u-boot and insert the command:
	    - `fatload mmc 0 0x200000 bao.img; bootm start 0x200000; bootm loados; bootm go`
3. `cd software/artifacts/rt-bench`
	- Run `2_send.sh`
	- Run `3_run.sh`
4. Run the script `3_run.sh` on embedded linux

## Results 
- The system does not crash, only slows down.
- Almost 1:1 relation between performance degradation and the size of the delay. See `results.xlsx`
- The linux, for big delays, is throwing warning from the RCU’s CPU Stall Detector, but the application keeps executing. See `output_linux.txt`
