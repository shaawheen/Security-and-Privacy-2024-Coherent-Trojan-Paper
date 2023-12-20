#!/bin/bash

src=/home/cris/Documents/obsdian/2nd_brain/0_Projects/0_Papers/Devil_In_FPGA
out=/home/cris/Documents/0_Projects/MancusoCollab/devil-in-the-fpga-documentation

# rsync -r --exclude 'tests' $src/ $out 
rsync -r $src/* $out 

# Get current directory
current_dir=$(pwd)

# Change directory to $out
cd "$out" || exit

# Get current date and time
current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

# Commit with date and time
git add .
git commit -m "[$current_datetime] - Sync"
git push

# Return to the original directory
cd "$current_dir" || exit
