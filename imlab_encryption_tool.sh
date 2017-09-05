#!/bin/bash

#--------------------------Password file-----------------------------
# place password in the text file `pass'
# chmod 400 pass
# save it in a safe place (e.g. ~/.ssh/)

#--------------------------Encryption--------------------------------
if [ $3 = "encrypt" ]; then 
for file in $(find $1 -type f); do
	echo "encrypting $file ...\n"
    openssl aes-256-cbc -in "$file" -out "$file.enc" -pass file:$2
    echo "deleting $file ...\n"
    rm $file
done
fi 

#------------------------Decryption--------------------------------
if [ $3 = "decrypt" ]; then 
for file in $(find $1 -type f); do
	echo "decrypting $file ...\n"
    openssl aes-256-cbc -d -in "$file" -out "${file/%????}" -pass file:$2
    echo "deleting $file ...\n"
    rm $file
done
fi
