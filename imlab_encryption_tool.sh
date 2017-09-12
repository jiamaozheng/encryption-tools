#!/bin/bash

#--------------------------Password file-----------------------------
# place password in the text file `pass'
# chmod 400 pass
# save it in a safe place (e.g. ~/.ssh/)

#--------------------------Encryption--------------------------------
echo "\n"
if [ $3 = "encrypt" ]; then 
counter=0 
start=$SECONDS
find $1 -not -path '*/\.*' -type f \( ! -iname '.*' \) -print0 | while read -d $'\0' file; do
	if [[ ${file: -4} != ".enc" ]]; then 
		echo "encrypting $file ..."
    	openssl aes-256-cbc -in "$file" -out "$file.enc" -pass file:$2
    	echo "deleting $file ..."
    	rm "$file"
    	let counter++
    	end=$SECONDS
    	echo "$counter files have been encrypted in $((end-start)) seconds \n"
    fi 
done
fi 

#------------------------Decryption--------------------------------
if [ $3 = "decrypt" ]; then
counter=0  
start=$SECONDS
find $1 -not -path '*/\.*' -type f \( ! -iname '.*' \) -print0 | while read -d $'\0' file; do
	if [ ${file: -4} = ".enc" ]; then 
		echo "decrypting $file ..."
	    openssl aes-256-cbc -d -in "$file" -out "${file/%????}" -pass file:$2
	    echo "deleting $file ..."
	    rm "$file"
	    let counter++
	    end=$SECONDS
	    echo "$counter files have been decrypted in $((end-start)) seconds\n"
	fi 
done
fi