#!/bin/bash

#--------------------------Password file-----------------------------
# place password in the text file `pass'
# chmod 400 pass
# save it in a safe place (e.g. ~/.ssh/)

#--------------------------Encryption--------------------------------
# encrypt a single file
# usage one: sh imlab_encryption_openssl.sh ~/.ssh/pass test1 encrypt

# encrypt a folder 
# usage two: sh imlab_encryption_openssl.sh ~/.ssh/pass test1/README.md encrypt

if [ $3 = "encrypt" ]; then 
for file in $(find $1 -type f); do
	echo "encrypting $file ...\n"
    openssl aes-256-cbc -in "$file" -out "$file.enc" -pass file:$2
    echo "deleting $file ...\n"
    rm $file
done
fi 

#------------------------Decryption--------------------------------
# encrypt a single file
# usage three: sh imlab_encryption_openssl.sh ~/.ssh/pass test1 decrypt

# encrypt a folder 
# usage four: sh imlab_encryption_openssl.sh ~/.ssh/pass test1/README.md decrypt
if [ $3 = "decrypt" ]; then 
for file in $(find $1 -type f); do
	echo "decrypting $file ...\n"
    openssl aes-256-cbc -d -in "$file" -out "${file/%????}" -pass file:$2
    echo "deleting $file ...\n"
    rm $file
done
fi
