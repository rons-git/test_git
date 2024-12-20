#!/bin/bash
tput setaf 196
# $1 (required), the URL of the remote repository being copied, must exist in github.
remoteURL="$1"
# Exit with error message when the remote repository URL is null
[ -z "$remoteURL" ] && echo '***Error***: Repository URL is null' && exit
longRepoName=git@github.com:"$remoteURL".git
errMsg='***Error***: Repository '"$longRepoName"' does not exist or is not accessible'
# Exit with error message when the remote repository does not exist
git ls-remote "$longRepoName" > /dev/null 2>&1
[ "$?" -ne 0 ] && echo "$errMsg" && exit
# $2 (required), the name of the remote repository subdirectory, must exist in github
remotesubdir=$2
# Exit with error message when the remote subdirectory name is null
[ -z "$remotesubdir" ] && echo '***Error***:'" Remote subdirectory is null" && exit
# Check whether $rmsdURL exists on the web
rmsdURL='https://github.com/'"$remoteURL"'/tree/main/'"$remotesubdir"
rmsdResult=$(curl --head --silent --write-out "%{http_code}" --output /dev/null "$rmsdURL")
rmsdExists='false' && [ "$rmsdResult" -eq 200 ] && rmsdExists='true'
# When remote repository does not exist in github, display error and exit
errMsg='***Error***: Remote subdirectory '"$remotesubdir"' does not exist in repository '"$longRepoName"
[ "$rmsdExists" == 'false' ] && echo "$errMsg" && exit
# $3 (optional), the name of the local repository directory, is the current directory by default
subdir="$3"
# Exit with error message when the local repository directory does not exist
if [ -n "$subdir" ]; then
    [ ! -d "$subdir" ] && echo '***Error***: Local directory '"$subdir" does not exist && exit
    cd "$subdir"
fi
# If the current directory contains .git*, rename all .git* to main_.git*
[ -d '.git' ] && for file in .git*; do mv "$file" "main_$file"; done
# If the current directory contains alt_.git, move all alt_.git* to .git*
[ -d 'alt_.git' ] && for file in alt_.git*; do mv "$file" "${file:4}"; done
# If the current directory is not a repository, make it a repository
gitExists='true' && [ ! -d '.git' ] && git init 1>/dev/null && gitExists='false' 
# Remove all remote aliases
git remote | xargs -n1 git remote remove &>/dev/null
# Add and fetch the source of truth remote repository
git remote add -f origin "$longRepoName" &>/dev/null
[ -z "$subdir" ] && subdir=${PWD##*/}
# Remove $remotesubdir (if it exists) when $gitExists="false"
[ "$gitExists" == 'false' ] && rm -rf "$remotesubdir"
# Remove all but the subdirectory and its files from the remote repository
git sparse-checkout set --no-cone /"$remotesubdir"
# Pull changes from the subdirectory and its files to the local repository
git pull origin main &>/dev/null
git reset --hard FETCH_HEAD 1>/dev/null
# Display error if the subdirectory was not added
[ ! -d "$remotesubdir" ] && tput setaf 196 && echo '***Error***: '"$remotesubdir" does not exist && tput setaf 20
msgOK='Remote subdirectory '"$remotesubdir"' has been added to local subdirectory '"$subdir"
[ -d "$remotesubdir" ] && tput setaf 40 && echo "$msgOK"
# Move all .git* to alt_.git*
[ -d '.git' ] && for file in .git*; do mv "$file" "alt_$file"; done
# If the current directory contains main_.git*, rename all main_.git* to .git*
[ -d 'main_.git' ] && for file in main_.git*; do mv "$file" "${file:5}"; done
