
#!/bin/bash

# Send scripts and code to run the tests/attacks
./send.sh

# Log on to root@192.168.42.15 via SSH and execute the scripts
ssh root@192.168.42.15 << EOF
        ./eval.sh
    exit
EOF

# Retrieve the results from the target board
scp -r root@192.168.42.15:/root/test_priv_escal.txt ./results/

# Analyze the results
python3 get_results.py ./results/test_priv_escal.txt 1000