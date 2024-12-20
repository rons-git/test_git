#!/bin/bash
. ./scripts/gitfunctions.sh && . ./scripts/utils.sh
# $1 (required), the name of the remote repository being reinitialized, must exist in github.
curRepoName="$1"  && longRepoName="$(chkRepoName "$curRepoName" 2>&1)"
[[ "$longRepoName" == *'Error'* ]] && setColor 'err' && echo "$longRepoName" && exit
# $2 (required), the name of the local repository directory, set to the current directory when null
subdir="$2" && [ -z "$subdir" ] && subdir=${PWD##*/}
dirMsg="$(chkSubdir "$subdir" 2>&1)" && [ "$dirMsg" != 'OK' ] && setColor 'err' && echo "$dirMsg" && exit
# Remove all existing .git's from the local repository directory
gitMsg="$(chgGits 'r' 2>&1)" && [ "$gitMsg" != 'OK' ] && setColor 'err' && echo "$gitMsg" && exit
# Initialize and commit the local repository
initMsg="$(initRepo 'ic' 2>&1)" && [ "$initMsg" != 'OK' ] && setColor 'err' && echo "$initMsg" && exit
# Remove aliases, add repo, and force push changes
setMsg="$(setRepo 'xaf' "$longRepoName" 2>&1)" && [ "$setMsg" != 'OK' ] && setColor 'err' && echo "$setMsg" && exit
# Display ok message
setColor 'ok' && echo 'Remote repository '"$curRepoName"' has been reinitialized'
