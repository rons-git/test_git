#!/bin/bash
chkRepoName () {
    # $1 (required), the remote repository name
    remoteRepo="$1"
    # $2 (optional), function options
    options="$2"
    # n=repo must not exist, default is repo must exist
    repoExists='must' && [[ "$options" == *'n'* ]] && repoExists='must not'
    # if remoteName has a slash, it's a 3rd pty git, default is rons-git
    remoteName='rons-git/' && [[ "$remoteRepo" == *'/'* ]] && remoteName=''
    # Exit with error message when the remote repository name is null
    [ -z "$remoteRepo" ] && echo '***Error***: Repository Name is null' >&2  && exit
    # Create repo URL
    longRepoName='git@github.com:'"$remoteName""$remoteRepo"'.git'
    # Create error Message
    errMsg='***Error***: Repository '"$longRepoName"' does not exist or is not accessible in github'
    [ "$repoExists" == 'must not' ] && errMsg='***Error***: Repository '"$longRepoName"' already exists in github'
    # "$?" indicates whether remote repository exists
    git ls-remote "$longRepoName" > /dev/null 2>&1
    # Determine whether repo name exists when it shouldn't or doesn't exist when it should
    [[ ("$?" -ne 0 && "$repoExists" == 'must') || ("$?" -eq 0 && "$repoExists" == 'must not') ]] && echo "$errMsg" >&2 && exit
    echo "$longRepoName"
}
chkSubdir () {
    # $1 (required), the name of the local repository directory, is the current directory by default
    subdir="$1"
    # $2 (optional), function options
    options="$2"
    # n=subdir must not exist, default is subdir  must exist
    subdirExists='must' && [[ "$options" == *'n'* ]] && subdirExists='must not'
    # r=subdir must be a git repo, default is subdir may or may not be git repo
    # isRepo='' && [[ "$options" == *'r'* ]] && isRepo='must'
    # Exit with error message when the subdirectory name is null
    [ -z "$subdir" ] && echo '***Error***: Subdirectory Name is null' >&2 && exit
    # Create error message
    errMsg='***Error***: Local directory '"$subdir"' does not exist'
    [ "$subdirExists" == 'must not' ] && errMsg='***Error***: Subdirectory '"$subdir"' already exists'
    # Exit with error message if subdir exists when it shouldn't or doesn't exist when it should
    isErr='false' && [[ ! -d "$subdir" && "$subdir" != "${PWD##*/}" && "$subdirExists" == 'must' ]] && isErr='true'
    [[ (-d "$subdir"  ||  "$subdir" == "${PWD##*/}") && "$subdirExists" == 'must not' ]] && isErr='true'
    [ "$isErr" == 'true' ] && echo "$errMsg" >&2 && exit
    # Make subdir when it doesn't exist
    [ "$subdirExists" == 'must not' ] && mkdir "$subdir"
    # Navigate to subdir
    [ "$subdir" != "${PWD##*/}" ] && cd "$subdir"
    # Exit with error message if subdir must be a git repo but isn't
    [[ ! -d '.git' && "$options" == *'r'* ]] && echo '***Error***: Local directory '"$subdir"' is not a git repository' >&2 && exit
    # Return OK
    echo 'OK'
}
chgGits () {
    # $1 (required), function options
    options="$1" && [ -z "$1" ] && echo '***Error***: No options were passed' >&2 && exit
    # Move gits to temporary location
    if [[ "$options" == *'t'* ]]; then
        # If the current directory contains .git*, move all .git* to main_.git*
        [ -d '.git' ] && for file in .git*; do mv "$file" "main_$file"; done
        # If the current directory contains alt_.git, move all alt_.git* to .git*
        [ -d 'alt_.git' ] && for file in alt_.git*; do mv "$file" "${file:4}"; done
    fi
    # Move gits back to permanent location
    if [[ "$options" == *'b'* ]]; then
        # Move all .git* to alt_.git*
        [ -d '.git' ] && for file in .git*; do mv "$file" "alt_$file"; done
        # If the current directory contains main_.git*, rename all main_.git* to .git*
        [ -d 'main_.git' ] && for file in main_.git*; do mv "$file" "${file:5}"; done
    fi
    # Remove all existing .git's from the local repository directory
    [[ "$options" == *'r'* ]] && find . -name .git -prune -exec rm -rf {} \;
    # Return OK
    echo 'OK'
}
setRepo () {
    # $1 (required), function options
    options="$1" && [ -z "$options" ] && echo '***Error***: No options were passed' >&2 && exit
    # $2 (optional), the remote repository URL for git add/clone or the remote repository name for gh repo create
    repoName="$2"
    # Exit with error message when repo is being added but repoName is null
    errMsg='***Error***: The repoName was not passed'
    [[ ("$options" == *'a'* || "$options" == *'r'* || "$options" == *'c'* || "$options" == *'d'*) && -z "$repoName" ]] && echo "$errMsg" >&2 && exit 
    # x=remove aliases
    [[ "$options" == *'x'* ]] && git remote | xargs -n1 git remote remove &>/dev/null
    # a=add repo
    [[ "$options" == *'a'* ]] && git remote add origin "$repoName" &>/dev/null
    # r=replace repo
    [[ "$options" == *'r'* ]] && git remote add -f origin "$repoName" &>/dev/null
    # d=clone repo
    [[ "$options" == *'d'* ]] && git clone "$repoName" &>/dev/null
    # c=create repo
    [[ "$options" == *'c'* ]] && NO_COLOR=true gh repo create "$repoName" --public --source=. &>/dev/null
    # l=pull changes 
    errMsg='***Error***: Merge conflicts exist that must be resolved'
    [[ "$options" == *'l'* ]] && result="$(git pull origin main 1>/dev/null 2>&1)" && [ -n "$result" ] &&  echo "$result"'>>>'"$errMsg" >&2 && exit
    # h=push changes
    [[ "$options" == *'h'* ]] && git push origin main &>/dev/null
    # f=force push changes
    [[ "$options" == *'f'* ]] && git push -f origin main &>/dev/null
    echo 'OK'
}
initRepo () {
    # $1 (required), function options
    options="$1" && [ -z "$options" ] && echo '***Error***: No options were passed' &>2 && exit
    # If the current directory is not a local repo and options contains i, make it a repo
    [[ ! -d '.git' && "$options" == *'i'* ]] && git init 1>/dev/null
    # If options contains c, commit and add the local file changes to the local repo
    if [[ "$options" == *'c' ]]; then
        # Create commit message
        now=$(date +%y-%m-%d_%H_%M_%S)
        commitMsg="$now"_commit
        # Add and commit changes to the local repository
        git add-commit -m "$commitMsg" 1>/dev/null
    fi
    echo 'OK'
}
