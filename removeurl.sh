#! /bin/bash

# Removes a specified url from the url links in twiki
#  This allows a twiki to be more viewable offline
#
# Usage: removeurl.sh <directory_name>
#
# Does not look into folders inside the given directory

if [ "$#" -ne 1 ]
then
        echo "Usage: $0 <directory_to_look_in>"
        exit 1
fi

# Replace 'address to remove>'. Make sure to escape
#  characters where applicable (eg: '.', '/', '\')
# ex 'https://twiki.clemson.edu/bin/view/' becomes
#    'https:\/\/twiki\.clemson\.edu\/bin\/view\/'
sed -i 's/\[\[<address to remove>/\[\[/g' $1/*

# Remove directory name if it exists in the same directory
array=(${1//\// })      #seperate the given path by the '/' mark
length=${#array[@]}     #obtain the number of elements in the array
length=$((length - 1))  #locate the part that we will use with sed
sed -i "s/\[\[${array[${length}]}[./]/\[\[/g" $1/*
