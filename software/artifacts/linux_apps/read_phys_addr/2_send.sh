#!/bin/bash
ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R "192.168.42.15"
# scp -r ./vision/benchmarks/disparity/data/vga ./IsolBench/latency root@192.168.42.15:
scp -r ./read_phys_addr root@192.168.42.15:
