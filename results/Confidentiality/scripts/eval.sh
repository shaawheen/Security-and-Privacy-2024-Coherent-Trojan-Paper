rm #!/bin/bash

ROOT_DIR=$(realpath ".")

# File to store the results
rm results.txt
touch results.txt

## 1000 iterations
echo "Running the script 100 times"
i=1
./find_pattern en
while [ $i -le 1000 ]
do
    echo "Iteration $i"
    rm file.* dummy *.pem
    echo "--------------------------------------------------------------------------"
    ./rsa_attack.sh $i
    echo "--------------------------------------------------------------------------"
    i=$((i+1))
done
./find_pattern dis

