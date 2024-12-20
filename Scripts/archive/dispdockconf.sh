#!/bin/bash
# If a configuration file exists ...
if [ "$(find . -iname "*.conf" -a ! -iname "docker_*.conf" -type f | wc -l)" 2> /dev/null -gt 0 ]; then
    numfnt=130
    tput setaf 3 && echo "Display configuration files"
    # Find all configuration files and place them into dfiles as an  array
    dfiles=($(find . -iname "*.conf" -a ! -iname "docker_*.conf" -type f))
    # "${dfiles[@]}" denotes each element of the dfiles array 
    for dfile in "${dfiles[@]}"; do 
        ((numfnt+=12)); tput setaf $numfnt
        # Remove all blank rows from dfile (configuration file)
        sed -i '/^$/d' "$dfile"
        # Put the last character of the dfile variable into the a variable
        a="$(tail -c 1 "$dfile")"
        # If the a variable is not a newline ...
        if [ "$a" != "" ]; then
        # Add a newline to the end of the dfile
            sed -i -e '$a\' "$dfile"
        fi; set -x;
        cat "$dfile" | egrep "^[[:blank:]]*[^[:blank:]#]" 2> /dev/null; set +x
    done
fi
