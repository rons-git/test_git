#!/bin/bash
# If a Dockerfile exists ...
if [ "$(find . -iname "Dockerfile" -type f | wc -l)" -gt 0 ]; then
    numfnt=60
    tput setaf 3 && echo "Display Dockerfiles"
    # Find all Dockerfiles and place them into dfiles as an  array
    dfiles=($(find . -iname "Dockerfile" -type f))
    # "${dfiles[@]}" denotes each element of the dfiles array 
    for dfile in "${dfiles[@]}"; do 
        ((numfnt+=12)); tput setaf $numfnt
        # Remove all blank rows from dfile (Dockerfile)
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
