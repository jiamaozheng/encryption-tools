#!/bin/bash

#--------------------------Password file-----------------------------
# place password in the text file `pass'
# chmod 400 pass
# save it in a safe place (e.g. ~/.ssh/)

#--------------------------Encryption--------------------------------
day=$(date +%F)
LOG_FILE="$day.txt"

echo 
echo  >> $LOG_FILE
if [ $3 = "encrypt" ]; then 
echo "---------------------------------- start encrypting files in $1 ----------------------------------"
echo "---------------------------------- start encrypting files in $1 ----------------------------------" >> $LOG_FILE
echo 
echo  >> $LOG_FILE
counter=0 
start=$SECONDS
find $1 -not -path '*/\.*' -type f \( ! -iname '.*' \) -print0 | while read -d $'\0' file; do
	if [[ ${file: -4} != ".enc" ]]; then 
		echo "encrypting $file ..."
		echo "encrypting $file ..." >> $LOG_FILE
    	openssl aes-256-cbc -in "$file" -out "$file.enc" -pass file:$2
    	echo "deleting $file ..."
    	echo "deleting $file ..." >> $LOG_FILE
    	rm "$file"
    	let counter++
    	end=$SECONDS
    	echo "$counter files have been encrypted in $((end-start)) seconds"
    	echo "$counter files have been encrypted in $((end-start)) seconds" >> $LOG_FILE
    	echo  
    	echo  >> $LOG_FILE
    fi 
done
echo "---------------------------------- finish encrypting files in $1 ----------------------------------"
echo "---------------------------------- finish encrypting files in $1 ----------------------------------" >> $LOG_FILE
fi 

#------------------------Decryption--------------------------------
if [ $3 = "decrypt" ]; then
echo "---------------------------------- start decrypting files in $1 ----------------------------------"
echo "---------------------------------- start decrypting files in $1 ----------------------------------" >> $LOG_FILE
echo 
echo  >> $LOG_FILE
counter=0  
start=$SECONDS
find $1 -not -path '*/\.*' -type f \( ! -iname '.*' \) -print0 | while read -d $'\0' file; do
	if [ ${file: -4} = ".enc" ]; then
		echo "decrypting $file ..." 
		echo "decrypting $file ..." >> $LOG_FILE
	    openssl aes-256-cbc -d -in "$file" -out "${file/%????}" -pass file:$2
	    echo "deleting $file ..."
	    echo "deleting $file ..." >> $LOG_FILE
	    rm "$file"
	    let counter++
	    end=$SECONDS
	    echo "$counter files have been decrypted in $((end-start)) seconds"
	    echo "$counter files have been decrypted in $((end-start)) seconds" >> $LOG_FILE
	    echo
	    echo >> $LOG_FILE
	fi 
done
echo "---------------------------------- finish decrypting files in $1 ----------------------------------"
echo "---------------------------------- finish decrypting files in $1 ----------------------------------" >> $LOG_FILE
fi
echo 
echo  >> $LOG_FILE