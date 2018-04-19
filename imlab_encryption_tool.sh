#!/bin/bash

# Author: Jiamao Zheng, jiamaoz@yahoo.com, 2017

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

log_file="---------------------------------- start encrypting on $1 ----------------------------------"
echo $log_file
echo $log_file >> $LOG_FILE
echo 
echo  >> $LOG_FILE
counter=0 
start=$SECONDS

find $1 -not -path '*/\.*' -type f \( ! -iname '.*' \) -print0 | while read -d $'\0' file; do
	if [[ ${file: -4} != ".enc" ]] && [ -f $2 ]; then 
		log_file="encrypting $file ..."
		echo $log_file
		echo $log_file >> $LOG_FILE

		if $( openssl aes-256-cbc -in "$file" -out "$file.enc" -pass file:$2 ); then 

		    log_file="deleting $file ..."
	    	echo $log_file
	    	echo $log_file >> $LOG_FILE
	    	rm "$file"
	    	let counter++
	    	end=$SECONDS

	    	log_file="$counter files have been encrypted in $((end-start)) seconds"
	    	echo $log_file
	    	echo $log_file >> $LOG_FILE
	    	echo  
	    	echo  >> $LOG_FILE
   		else 
			log_file=$( openssl aes-256-cbc -in "$file" -out "$file.enc" -pass file:$2 2>&1)
			rm "$file.enc"
		    echo 
	    	echo $log_file >> $LOG_FILE
	    	break 
	    fi 	
	else 
		if [ ! -f $2 ]; then 
			log_file="password file doesn't exit!"
		    echo $log_file
	    	echo $log_file >> $LOG_FILE
	    	break 
    	fi 
    fi 
done

log_file="---------------------------------- finish encrypting on $1 ----------------------------------"
echo $log_file
echo $log_file >> $LOG_FILE
fi 

#------------------------Decryption--------------------------------
if [ $3 = "decrypt" ]; then

log_file="---------------------------------- start decrypting on $1 ----------------------------------"
echo $log_file
echo $log_file >> $LOG_FILE
echo 
echo  >> $LOG_FILE
counter=0  
start=$SECONDS

find $1 -not -path '*/\.*' -type f \( ! -iname '.*' \) -print0 | while read -d $'\0' file; do
	if [ ${file: -4} = ".enc" ] && [ -f $2 ]; then
		log_file="decrypting $file ..."
		echo $log_file
		echo $log_file >> $LOG_FILE

		if $( openssl aes-256-cbc -d -in "$file" -out "${file/%????}" -pass file:$2); then 

		    log_file="deleting $file ..."
		    echo $log_file
		    echo $log_file >> $LOG_FILE
		    rm "$file"
		    let counter++
		    end=$SECONDS

		    log_file="$counter files have been decrypted in $((end-start)) seconds"
		    echo $log_file
		    echo $log_file >> $LOG_FILE
		    echo
		    echo >> $LOG_FILE
		else

			log_file=$( openssl aes-256-cbc -d -in "$file" -out "${file/%????}" -pass file:$2 2>&1)
			rm "${file/%????}"
		    echo 
	    	echo $log_file >> $LOG_FILE
	    	break 
	    fi 	
	else 
		if [ ! -f $2 ]; then 
			log_file="password file doesn't exit!"
		    echo $log_file
	    	echo $log_file >> $LOG_FILE
	    	break 
    	fi
	fi 
done

log_file="---------------------------------- finish decrypting on $1 ----------------------------------"
echo $log_file
echo $log_file >> $LOG_FILE
fi
echo 
echo  >> $LOG_FILE



