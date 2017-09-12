#!/bin/bash

#--------------------------Password file-----------------------------
# place password in the text file `pass'
# chmod 400 pass
# save it in a safe place (e.g. ~/.ssh/)

#--------------------------Encryption--------------------------------

if [ $3 = "encrypt" ]; then 
find $1 -not -path '*/\.*' -type f \( ! -iname '.*' \) -print0 | while read -d $'\0' file; do
	if [[ ${file: -4} != ".enc" ]]; then 
		echo "encrypting $file ...\n"
    	openssl aes-256-cbc -in "$file" -out "$file.enc" -pass file:$2
    	echo "deleting $file ...\n"
    	rm "$file"
    fi 
done
fi 

#------------------------Decryption--------------------------------
if [ $3 = "decrypt" ]; then 
find $1 -not -path '*/\.*' -type f \( ! -iname '.*' \) -print0 | while read -d $'\0' file; do
	if [ ${file: -4} = ".enc" ]; then 
		echo "decrypting $file ...\n"
	    openssl aes-256-cbc -d -in "$file" -out "${file/%????}" -pass file:$2
	    echo "deleting $file ...\n"
	    rm "$file"
	fi 
done
fi