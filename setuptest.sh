#! /bin/bash

path=/var/www/html/twiki/data

# Reset the test directories from the backups
echo "Setting up data from backup"
rm -rf $path/*
cp -r /var/www/html/twiki/dataBackup/* $path

# Remove URLs from the test directories
echo "Removing URLs"
removeurl.sh $path/AIM
removeurl.sh $path/Banner
removeurl.sh $path/Chgmgmt
removeurl.sh $path/Client
removeurl.sh $path/CRLT
removeurl.sh $path/CSO
removeurl.sh $path/CSOActionlog
removeurl.sh $path/DAPS
removeurl.sh $path/Dir
removeurl.sh $path/EA
removeurl.sh $path/ETS
removeurl.sh $path/ISD
removeurl.sh $path/MVS
removeurl.sh $path/Netserv
removeurl.sh $path/Sandbox
removeurl.sh $path/SDI
removeurl.sh $path/Serviceapps
removeurl.sh $path/Services
removeurl.sh $path/Shibboleth
removeurl.sh $path/SIG
removeurl.sh $path/SSG
removeurl.sh $path/Storage
removeurl.sh $path/UNIX
removeurl.sh $path/VM
removeurl.sh $path/Webservices
removeurl.sh $path/Windows

# Transfer files between the test directories
echo "Transferring files"
kbasetransfer.sh $path/AIM
kbasetransfer.sh $path/Banner
kbasetransfer.sh $path/Chgmgmt
kbasetransfer.sh $path/Client
kbasetransfer.sh $path/CRLT
kbasetransfer.sh $path/CSO
kbasetransfer.sh $path/CSOActionlog
kbasetransfer.sh $path/DAPS
kbasetransfer.sh $path/Dir
kbasetransfer.sh $path/EA
kbasetransfer.sh $path/ETS
kbasetransfer.sh $path/ISD
kbasetransfer.sh $path/MVS
kbasetransfer.sh $path/Netserv
kbasetransfer.sh $path/Sandbox
kbasetransfer.sh $path/SDI
kbasetransfer.sh $path/Serviceapps
kbasetransfer.sh $path/Services
kbasetransfer.sh $path/Shibboleth
kbasetransfer.sh $path/SIG
kbasetransfer.sh $path/SSG
kbasetransfer.sh $path/Storage
kbasetransfer.sh $path/UNIX
kbasetransfer.sh $path/VM
kbasetransfer.sh $path/Webservices
kbasetransfer.sh $path/Windows
