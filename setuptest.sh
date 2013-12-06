#! /bin/bash

path=/var/www/html/twiki/data

# Reset the test directories from the backups
echo "Setting up data from backup"
rm -rf $path/*
cp -r /var/www/html/twiki/dataBackup/* $path

# Remove URLs from the test directories
for dir in $path/*
do
	if [[ $dir == $path/CSOKBase || -f "$dir" || $dir == $path/Main || $dir == $path/_* || $dir == $path/Chgmgmt ]]
	then
		continue
	fi
	echo "Removing URLS from $dir"
	removeurl.sh $dir
done

# Transfer files between the test directories
for dir in $path/*
do
	if [[ $dir == $path/CSOKBase || -f "$dir" || $dir == $path/Main || $dir == $path/_* || $dir == $path/Chgmgmt ]]
	then
		continue
	fi
	echo "Transferring $dir"
	kbasetransfer.sh $dir 
done

