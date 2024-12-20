#!/bin/bash
. ./scripts/gitfunctions.sh && . ./scripts/utils.sh
# $1 (required), the name of the local repository directory, set to the current directory when null
subdir="$1" && [ -z "$subdir" ] && subdir=${PWD##*/}
dirMsg="$(chkSubdir "$subdir" 'r' 2>&1)" && [ "$dirMsg" != 'OK' ] && setColor 'err' && echo "$dirMsg" && exit
# Remove all existing .git's from the local repository directory
gitMsg="$(chgGits 'r' 2>&1)" && [ "$gitMsg" != 'OK' ] && setColor 'err' && echo "$gitMsg" && exit
# Display ok message
setColor 'ok' && echo '.git files have been deleted in '"$subdir"' and all subdirectories'
