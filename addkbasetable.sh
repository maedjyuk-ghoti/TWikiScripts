#! /bin/bash

#Adds the kbase table to bottoms of files

#Currently the -s argument is the only way this program accomplishes anything.
# Future versions will allow it to be passed a single argument (full path to a file).

#Argument check
if [ "$1" == "-s" ]
then
	if [ $# -eq 3 ]
	then
		split=1
	else
		echo "Usage: $0 -s <full_path_dir> <filename>"
		exit 1
	fi
elif [ $# -eq 1 ]
then
	split=0
else
	echo "Usage: $0 <full_path_filename>"
	exit 1
fi

#Assign arguments to appropriate fileds
if [ $split -eq 1 ]
then
	DirName=$2
	
	#Remove the full path
	array=(${2//\// })
	length=${#array[@]}
	pos=$((length - 1))
	dir=${array[${pos}]}

	FileName=$3

	#Remove .* from FileName
	array=(${3//./ })
	file=${array[0]}
else
	echo "Not yet implemented"
	exit 1
fi

#Append the KBase table to the end of the file
echo " " >> $DirName/$FileName
echo %META:FORM{name=\"KBaseFieldTable\"}% >> $DirName/$FileName
echo %META:FIELD{name=\"KBaseTitle\" attributes=\"\" title=\"KBaseTitle\" value=\"$file\"}% >> $DirName/$FileName
echo %META:FIELD{name=\"KBaseReviewDate\" attributes=\"\" title=\"KBaseReviewDate\" value=\"\"}% >> $DirName/$FileName
echo %META:FIELD{name=\"KBaseOwner\" attributes=\"\" title=\"KBaseOwner\" value=\"\"}% >> $DirName/$FileName
echo %META:FIELD{name=\"KBaseAreaGroup\" attributes=\"\" title=\"KBaseAreaGroup\" value=\"$dir\"}% >> $DirName/$FileName
echo %META:FIELD{name=\"KBaseKeywords\" attributes=\"\" title=\"KBaseKeywords\" value=\"\"}% >> $DirName/$FileName

#test
#echo $DirName $dir $FileName $file


