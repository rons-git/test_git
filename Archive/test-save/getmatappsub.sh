#!/bin/bash
subdir="$1"
# if current directory is not a git repository, make it one
[ ! -d ".git" ] && git init &>/dev/null
# remove all remote aliases
git remote | xargs -n1 git remote remove &>/dev/null
# remove uncommitted files
git reset --hard FETCH_HEAD &>/dev/null
# add the passed directory
git remote add -f origin git@github.com:docker-hy/material-applications.git &>/dev/null
git config core.sparseCheckout true &>/dev/null
.git/info/sparse-checkout set $subdir #&>/dev/null
git pull origin main &>/dev/null
# display error if passed directory was not added
[ ! -d $subdir ] && tput setaf 196 && echo ***Error***: $subdir does not exist
# remove all remote aliases
git remote | xargs -n1 git remote remove &>/dev/null
