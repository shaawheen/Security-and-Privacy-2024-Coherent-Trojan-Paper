#!/bin/bash
ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R "192.168.42.15"
scp -r ./3_run.sh ./vision/benchmarks/disparity/data/vga ./IsolBench/latency root@192.168.42.15:
