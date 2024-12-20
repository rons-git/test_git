#!/bin/bash
. ../scripts/gitfunctions.sh  && . ../scripts/utils.sh
# $1 (required), the URL of the remote repository being copied, must exist in github.
remoteURL="$1"  && longRepoName="$(chkRepoName "$remoteURL" 2>&1)"
[[ "$longRepoName" == *'Error'* ]] && setColor 'err' && echo "$longRepoName" && exit
# $2 (required), the name of the remote repository subdirectory, must exist in github
remotesubdir=$2 && [ -z "$remotesubdir" ] && echo '***Error***:'" Remote subdirectory is null" && exit
# Check whether remote subdirectory URL exists on the web
rmsdURL='https://github.com/'"$remoteURL"'/tree/main/'"$remotesubdir"
rmsdResult=$(curl --head --silent --write-out "%{http_code}" --output /dev/null "$rmsdURL")
rmsdExists='false' && [ "$rmsdResult" -eq 200 ] && rmsdExists='true'
# When remote repository does not exist in github, display error and exit
errMsg='***Error***: Remote subdirectory '"$remotesubdir"' does not exist in repository '"$longRepoName"
[ "$rmsdExists" == 'false' ] && setColor 'err' && echo "$errMsg" && exit
# $3 (required), the name of the local repository directory, set to the current directory when null
subdir="$3" && [ -z "$subdir" ] && subdir=${PWD##*/}
dirMsg="$(chkSubdir "$subdir" 2>&1)" && [ "$dirMsg" != 'OK' ] && setColor 'err' && echo "$dirMsg" && exit
# Move gits to temp locations
gitMsg="$(chgGits 't' 2>&1)" && [ "$gitMsg" != 'OK' ] && setColor 'err' && echo "$gitMsg" && exit
# If the current directory is not a repository, make it a repository
gitExists='true' && [ ! -d '.git' ] && gitExists='false'
initMsg="$(initRepo 'i' 2>&1)" && [ "$initMsg" != 'OK' ] && setColor 'err' && echo "$initMsg" && exit 
# Remove aliases and replace repo
setMsg="$(setRepo 'xr' "$longRepoName" 2>&1)" && [ "$setMsg" != 'OK' ] && setColor 'err' && echo "$setMsg" && exit
# Remove $remotesubdir (if it exists) when $gitExists="false"
[ "$gitExists" == 'false' ] && rm -rf "$remotesubdir"
# Remove all but the subdirectory and its files from the remote repository
git sparse-checkout set --no-cone /"$remotesubdir"
# Pull changes from the subdirectory and its files to the local repository
setMsg="$(setRepo 'l' 2>&1)" && [ "$setMsg" != 'OK' ] && setColor 'err' && echo "$setMsg" && exit
git reset --hard FETCH_HEAD 1>/dev/null
# Display error if the remote subdirectory was not added
[ ! -d "$remotesubdir" ] && setColor 'err' && echo '***Error***: '"$remotesubdir"' does not exist'
# Display ok message
msgOK='Remote subdirectory '"$remotesubdir"' has been added to local subdirectory '"$subdir"
[ -d "$remotesubdir" ] && setColor 'ok'  && echo "$msgOK"
# Move gits back
gitMsg="$(chgGits 'b' 2>&1)" && [ "$gitMsg" != 'OK' ] && setColor 'err' && echo "$gitMsg" && exit
