#!/bin/bash

#commands to run on remote host
ssh -tt root@192.168.42.15 << ENDSSH
    cd vga
	./disparity -p 1 -d 0.5 -t 2 -c 0 -f 99 -m 10M -l 3 -b .
    echo "Done!"
    exit
ENDSSH
# end of commands to run on remote host