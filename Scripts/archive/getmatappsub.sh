#!/bin/bash
subdir=$1 && tput setaf 20
# If the current directory contains .git*, rename all .git* to tmp_.git*
[ -d '.git' ] && for file in .git*; do mv "$file" "tmp_$file"; done
# If the current directory contains alt_.git, move all alt_.git* to .git*
[ -d 'alt_.git' ] && for file in alt_.git*; do mv "$file" "${file:4}"; done
# If the current directory is not a repository, make it a repository
[ ! -d '.git' ] && git init &>/dev/null
# Remove all remote aliases
git remote | xargs -n1 git remote remove &>/dev/null
# Add the source of truth remote repository
git remote add -f origin git@github.com:docker-hy/material-applications.git
# Remove all but the subdirectory and its files from the remote repository
git config core.sparsecheckout true
echo $subdir >> .git/info/sparse-checkout
# Pull changes from the subdirectory and its files to the local repository
git pull origin main
git reset --hard FETCH_HEAD &>/dev/null
# Display error if the subdirectory was not added
[ ! -d $subdir ] && tput setaf 196 && echo ***Error***: $subdir does not exist && tput setaf 20
# Remove all remote aliases
git remote | xargs -n1 git remote remove &>/dev/null
# Move all .git* to alt_.git*
[ -d '.git' ] && for file in .git*; do mv "$file" "alt_$file"; done
# If the current directory contains tmp_.git*, rename all tmp_.git* to .git*
[ -d 'tmp_.git' ] && for file in tmp_.git*; do mv "$file" "${file:4}"; done
