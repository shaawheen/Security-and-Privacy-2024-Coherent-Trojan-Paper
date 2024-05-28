rm #!/bin/bash

ROOT_DIR=$(realpath ".")

echo "--------------------------------------------------------------------------"
# Creat a File at root home directory, for test porpuses.
# The new users will try to write to that file to prove the priviledge escalation.
rm test_priv_escal.txt
touch test_priv_escal.txt

## 1000 iterations
# Adding a for loop
echo "Running the script 1000 times"
i=1
./find_pattern en
while [ $i -le 1000 ]
do
    echo "Iteration $i"
    echo "--------------------------------------------------------------------------"
    ./priv_escal_setup.sh "user$i"
    echo "--------------------------------------------------------------------------"
    i=$((i+1))
done
./find_pattern dis

