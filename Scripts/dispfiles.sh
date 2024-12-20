#!/bin/bash
dispCode=$1
# Create doArray (dispCode, text color, text color increment, match string, exclude string, display message)
data1=('df' '-3' '36' '[dD]ocker*' 'docker-compose.yml')
data2=('dc' '106' '36' 'docker-compose.yml' '<none>')
data3=('cf' '-10' '36' '*.conf' '<none>')
# Get doArray
dataCol=(data1 data2 data3)
for dispArray in "${dataCol[@]}"; do
    declare -n array="$dispArray"
    # Set text color and message when dispCode matches array[0]
    if [ ${array[0]} == $dispCode ]; then
        txtColor=${array[1]}
        txtIncr=${array[2]}
        mtchStrs=${array[3]}
        exStr=${array[4]}
    fi
done
# If each matching file that exists ...
for mtchStr in $mtchStrs; do
    # Find all matching files and place them into dispFiles as an  array
    dispFiles=( $(find . -iname $mtchStr -a ! -iname $exStr -type f ))
    # ${dispFiles[@]} denotes each element of the dispFiles array 
    for dispFile in ${dispFiles[@]}; do
        tput setaf 3 && echo Display $mtchStr 
        ((txtColor+=txtIncr)); tput setaf $txtColor
        # Remove all blank rows from dispFile
        sed -i '/^$/d' $dispFile
        # Put the last character of the dispFile variable into the a variable
        a=$(tail -c 1 $dispFile)
        # If the a variable is not a newline ...
        if [ -n $a ]; then
        # Add a newline to the end of the dispFile
            sed -i -e '$a\' $dispFile
        fi; set -x;
        cat $dispFile; set +x
    done
done
