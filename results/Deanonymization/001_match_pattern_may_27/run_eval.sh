
#!/bin/bash

if [ -z "$1" ]; then
    echo "$0 <send|results> <path>"
    exit 1
fi

case $1 in
    "send")
        # Send scripts and code to run the tests/attacks
        ./scripts/send.sh

        echo "----------------------------------------------------------"
        echo "Log on the target board and execute ./eval.sh"
        echo "----------------------------------------------------------"
        ;;
    "results")
        # Retrieve the results from the target board
        # scp -r root@192.168.42.15:/root/results.txt $2

        # Analyze the results
        python3 ./scripts/get_stats.py $2 1000
        ;;
    *)
        echo "$0 <send|results> "
        exit 1
        ;;
esac
