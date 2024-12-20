#!/bin/bash
. ./scripts/gitfunctions.sh && . ./scripts/utils.sh
# $1 (required), the name of the remote repository being deleted, must exist in github.
delRepoName="$1"  && longRepoName="$(chkRepoName "$delRepoName" 2>&1)"
[[ "$longRepoName" == *'Error'* ]] && setColor 'err' && echo "$longRepoName" && exit
# $2 (required), the name of the local repository directory, set to the current directory when null
subdir="$2" && [ -z "$subdir" ] && subdir=${PWD##*/}
dirMsg="$(chkSubdir "$subdir" 2>&1)" && [ "$dirMsg" != 'OK' ] && setColor 'err' && echo "$dirMsg" && exit
# If $2 is set to none, the local repository is not deleted
if [ "$subdir" != 'none' ]; then
    # Remove aliases
    setMsg="$(setRepo 'x' 2>&1)" && [ "$setMsg" != 'OK' ] && setColor 'err' && echo "$setMsg" && exit
    # Remove all existing .git's from the local repository directory
    gitMsg="$(chgGits 'r' 2>&1)" && [ "$gitMsg" != 'OK' ] && setColor 'err' && echo "$gitMsg" && exit
fi
# Authenticate the remote repository deletion
setColor 'info' && NO_COLOR=true gh auth refresh -h github.com -s delete_repo
# Delete the remote repository
setColor 'ok' && NO_COLOR=true gh repo delete "$delRepoName" --yes &>/dev/null
# Display ok message
setColor 'ok' &&  echo -n 'Remote repository '"$delRepoName"' has been deleted'
[ "$subdir" != 'none' ] &&  echo '  and .git files have been deleted from '"$subdir"' and all subdirectories'
