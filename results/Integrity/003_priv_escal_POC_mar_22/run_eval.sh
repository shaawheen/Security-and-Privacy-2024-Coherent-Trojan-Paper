
#!/bin/bash

# Switch case based on arguments
case $# in
    0)
        echo "$0 <send|results> "
        exit 1
        ;;
    1)
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
                scp -r root@192.168.42.15:/root/test_priv_escal.txt ./results/

                # Analyze the results
                python3 ./scripts/get_stats.py ./results/test_priv_escal.txt 1000
                ;;
            *)
                echo "$0 <send|results> "
                exit 1
                ;;
        esac
        ;;
esac