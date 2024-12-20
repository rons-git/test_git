#!/bin/bash
# Move $1 to $buildcmds and strip comments from variable 
buildcmds=$(echo "$1" | egrep "^[[:blank:]]*[^[:blank:]#]")
# If buildcmds variable is not empty ...
if [ ! -z "$buildcmds" ]; then
    tput setaf 3 && echo "Execute Docker Image and Container Commands" && tput setaf 12 && set -x
    # Evaluate buildcmds variable as bash commands
    eval "$buildcmds"
fi
