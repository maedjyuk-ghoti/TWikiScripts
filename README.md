TWikiScripts
============

Bash scripts to manipulate files in a TWiki website

These were created to move files into a directory of TWiki where a search function existed.

Please pardon the messy bash scripting. Most of the code can be cleaned up and made more efficient, but it was already
taking longer than it should have to write this so I skipped optimization so that I could deliver something asap.

A few of the sed commands were found by searching google and then adjusting the results until the desired result appeared.

In addition to being cleaned up this can probably be split apart into a small collection of scripts that can help keep
a TWiki instance clean.

------------

DESCRIPTION OF THE SCRIPTS
==========================

setuptest.sh controls the directories that are processed in the the 2 main scripts.

removeurl.sh replaces urls used in the twiki with twiki links to make the twiki usable offline as much as possible.

kbasetransfer moves the files from the given directory into the CSOKBase, gives them a KBaseU name, changes all links
to the file to point to its new name, and inserts the KBase table at the bottom to allow searching through the KBase
search tool.
