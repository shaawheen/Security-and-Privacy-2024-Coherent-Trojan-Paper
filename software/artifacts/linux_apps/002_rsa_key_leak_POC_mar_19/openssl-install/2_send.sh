#!/bin/bash
ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R "192.168.42.15"

scp openssl.sh  ./bin/openssl libssl.so.3 libcrypto.so.3 root@192.168.42.15:
