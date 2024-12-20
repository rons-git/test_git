#!/bin/bash
# Move $1 to $copycmds and strip comments from variable
copycmds=$(echo "$1" | egrep "^[[:blank:]]*[^[:blank:]#]")
# If copycmds variable is not empty ...
if [ ! -z "$copycmds" ]; then
    tput setaf 3 && echo "Copy Application Code from Source Repository" && tput setaf 11 && set -x
    # Evaluate copycmds variable as bash commands
    eval "$copycmds"
    dir
fi
