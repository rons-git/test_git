#!/bin/bash
subdir="$1" && tput setaf 213
# if curdir contains .git*, rename all .git* to tmp_.git*
[ -d ".git" ] && for file in .git*; do mv "$file" "tmp_$file"; done
# if curdir contains alt_.git, move all alt_.git* to .git*
[ -d "alt_.git" ] && for file in alt_.git*; do mv "$file" "${file:4}"; done
# if curdir does not contain alt_.git, make curdir into git repo
[ ! -d "alt_.git" ] && git init &>/dev/null
# remove all remote aliases
git remote | xargs -n1 git remote remove &>/dev/null
# remove uncommitted files
git reset --hard FETCH_HEAD &>/dev/null
# add the passed directory
git remote add -f origin git@github.com:docker-hy/material-applications.git
git config core.sparsecheckout true
echo $subdir >> .git/info/sparse-checkout
git pull origin main
# display error if passed directory was not added
[ ! -d $subdir ] && tput setaf 196 && echo ***Error***: $subdir does not exist
# remove all remote aliases
git remote | xargs -n1 git remote remove &>/dev/null
# move all .git* to alt_.git*
[ -d ".git" ] && for file in .git*; do mv "$file" "alt_$file"; done
# if curdir contains tmp_.git*, rename all tmp_.git* to .git*
[ -d "tmp_.git" ] && for file in tmp_.git*; do mv "$file" "${file:4}"; done
