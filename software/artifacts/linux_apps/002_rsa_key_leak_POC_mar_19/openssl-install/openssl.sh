rm #!/bin/bash

PATH=/root
PATH_OPENSSL=${PATH}/openssl

export LD_LIBRARY_PATH=${PATH}

${PATH_OPENSSL} version

# Check if a command is provided
if [ -z "$1" ]; then
    echo ""
    echo "Usage: $0 [enc/dec]"
    exit 1
fi

# Execute actions based on the command
case "$1" in
    "enc")
        echo "-----------------------------"
        echo "Generating a RSA private key" 
        ${PATH_OPENSSL} genpkey -algorithm RSA -out private.pem
        echo "-----------------------------"
        echo "Generating a RSA public key"
        ${PATH_OPENSSL} rsa -pubout -in private.pem -out public.pem
        echo "-----------------------------"
        echo "Encrypting a file"
        echo "Hello, World!" > file.txt
        ${PATH_OPENSSL} pkeyutl -encrypt -in file.txt -inkey public.pem -pubin -out file.enc
        ;;
    "dec")
        echo "-----------------------------"
        echo "Decrypting file with stolen key"
        ${PATH_OPENSSL} pkeyutl -decrypt -in file.enc -inkey stolen_private_key.pem -out file.dec
        ;;
    *)
        echo "Invalid command. Please specify a valid command."
        exit 1
        ;;
esac

