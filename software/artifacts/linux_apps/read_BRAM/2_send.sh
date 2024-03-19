#!/bin/bash
ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R "192.168.42.15"

scp -r ./read_BRAM root@192.168.42.15:
