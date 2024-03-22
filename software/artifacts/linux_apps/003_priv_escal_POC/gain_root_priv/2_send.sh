#!/bin/bash
ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R "192.168.42.15"

scp -r ./gain_root_priv user1@192.168.42.15:
