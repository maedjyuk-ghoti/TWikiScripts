#! /bin/bash

#
#Funtions
#

# Used as a boolean in the function 'ignoreFiles'
#  if this can be changed from a global, please do.
query=0

# ignoreFiles takes a single parameter and checks to see if
#  if it is the name of a file that is supposed to be moved.
#  This function changes the global variable 'query'.
function ignoreFiles {
	query=1
	case "$1" in
		WebAtom) ;;
		WebChanges) ;;
		WebCreateNewTopic) ;;
		WebHome) ;;
		WebIndex) ;;
		WebLeftBar) ;;
		WebNotify) ;;
		WebPreferences) ;;
		WebRss) ;;
		WebSearchAdvanced) ;;
		WebSearch) ;;
		WebStatistics) ;;
		WebTopMenu) ;;
		KBase*) ;;
		ActionLog*) ;;
		*) query=0; ;;
	esac
}

#
# Main script
#

# Check to see if there are directories to move documents from and to
if [ "$#" -ne 1 ]
then
	echo "Usage: $0 <full_path_to_dir_to_move>"
	exit 1
fi

# put the directories in usable names
dirName="$1"
newDirName="/var/www/html/twiki/data/CSOKBase"

# Remove spaces from local link names for later comparisons
sed -i -e :1 -e 's/\(\[[^]]*\)[[:space:]]/\1/g;t1' $dirName/*
sed -i -e :1 -e 's/\(\[[^]]*\)[[:space:]]/\1/g;t1' $newDirName/*

# Loop through the directory
for filename in `ls $dirName`
do

	# Split filename
	front=${filename%.*}
	back=${filename#*.}

	# Don't need to move these files
	if [ "$back" == "lease" ]
	then
		continue
	fi

	# These files are directory specific
	ignoreFiles $front
	if [[ $query == 1 ]]
	then
		continue
	fi

	# IMPORTANT NOTE!
	# On *nix systems, because files are sorted in alphabetical order, including file tags (".*"),
	#  ".txt,v" will always come after ".txt". Also, there should be no ".txt,v" in the twiki without
	#  a corresponding ".txt" because ".txt,v" is a type of version control.

	# Needs to have the same name as its related .txt files	
	if [ "$back" == "txt,v" ]
	then
		KBaseName="KBaseU$epoc.$back"
		mv -f $dirName/$filename $newDirName/$KBaseName
	fi
	
	# If this is the original (Just a way to limit searches)
	if [ "$back" == "txt" ]
	then

		# Give the file a KBase name and move to CSOKBase
		epoc=`date +%s`
		KBaseName="KBaseU$epoc"
		mv -f $dirName/$filename $newDirName/$KBaseName.$back

		# Search and replace links with new KBaseName
		# Need to check entirety of [[...]] for urls or lack-there-of.
		# Need input on whether to remove urls completely or deal with them.

		# Create display name
		sed -i "s/\[\[$front\]\]/\[\[$front\]\[$front\]\]/gI" $dirName/*
		sed -i "s/\[\[$front\]\]/\[\[$front\]\[$front\]\]/gI" $newDirName/*

		# Replace with new link name
		sed -i "s/\[\[$front\]/\[\[$KBaseName\]/gI" $dirName/*
		sed -i "s/\[\[$front\]/\[\[$KBaseName\]/gI" $newDirName/*

		KBaseName="KBaseU$epoc.$back"

		# Add the KBase Table to end of file
		echo " " >> $newDirName/$KBaseName
		echo %META:FORM{name=\"KBaseFieldTable\"}% >> $newDirName/$KBaseName
		echo %META:FIELD{name=\"KBaseTitle\" attributes=\"\" title=\"KBaseTitle\" value=\"$front\"}% >> $newDirName/$KBaseName
		echo %META:FIELD{name=\"KBaseReviewDate\" attributes=\"\" title=\"KBaseReviewDate\" value=\"\"}% >> $newDirName/$KBaseName
		echo %META:FIELD{name=\"KBaseOwner\" attributes=\"\" title=\"KBaseOwner\" value=\"\"}% >> $newDirName/$KBaseName
		echo %META:FIELD{name=\"KBaseAreaGroup\" attributes=\"\" title=\"KBaseAreaGroup\" value=\"\"}% >> $newDirName/$KBaseName
		echo %META:FIELD{name=\"KBaseKeywords\" attributes=\"\" title=\"KBaseKeywords\" value=\"\"}% >> $newDirName/$KBaseName

		# Ensure different file names
		sleep 1
	fi

done

# Change directory to CSOKBase if it begins with KBaseU
sed -i "s/\[\[KBaseU/\[\[CSOKBase.KBaseU/g" $dirName/*
