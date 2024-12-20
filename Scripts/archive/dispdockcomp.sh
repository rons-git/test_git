#!/bin/bash
# If the docker-compose-yml file exists ...
if [ "$(find . -iname "docker-compose.yml" -type f | wc -l)" -gt 0 ]; then
    tput setaf 3 && echo "Display docker-compose.yml" && tput setaf 178
    dfile="docker-compose.yml"
    # Put the last character of the dfile into the a variable
    a="$(tail -c 1 $dfile)"
    # If the a variable is not a newline ...
    if [ "$a" != "" ]; then
        # Add a newline to the end of the dfile 
        sed -i -e '$a\' $dfile
    fi
    set -x && cat docker-compose.yml | egrep "^[[:blank:]]*[^[:blank:]#]" 2> /dev/null
fi
