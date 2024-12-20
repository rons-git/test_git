#!/bin/bash
. ./test_git/scripts/gitfunctions.sh && . ./test_git/scripts/utils.sh
# $1 (required), the name of the remote repository being deleted, must exist in github.
curRepoName="$1"  && longRepoName="$(chkRepoName "$curRepoName" 2>&1)"
[[ "$longRepoName" == *'Error'* ]] && setColor 'err' && echo "$longRepoName" && exit
# $2 (required), the name of the local repository directory, set to the current directory when null
subdir="$2" && [ -z "$subdir" ] && subdir='./'"$curRepoName"
dirMsg="$(chkSubdir "$subdir" 'n' 2>&1)" && [ "$dirMsg" != 'OK' ] && setColor 'err' && echo "$dirMsg" && exit
# Initialize the local repository
initMsg="$(initRepo 'i' 2>&1)" && [ "$initMsg" != 'OK' ] && setColor 'err' && echo "$initMsg" && exitgit init 1>/dev/null
# Clone the remote repository
setMsg="$(setRepo 'd' "$longRepoName" 2>&1)" && [ "$setMsg" != 'OK' ] && setColor 'err' && echo "$setMsg" && exit
# Display ok message
setColor 'ok' && echo Local repository "$subdir" has been created and populated
