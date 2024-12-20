#!/bin/bash
doCode=$1
# Create doArray (doCode, text color, doFile message)
data1=('cp' '20' 'Copy Application code from Source Repository')
data2=('br' '4' 'Execute Docker Image and Container Commands')
data3=('sr' '45' 'Show Results')
# Get doArray
dataCol=(data1 data2 data3)
for doArray in ${dataCol[@]}; do
    declare -n array=$doArray
    # Set text color and doFile message when doCode matches array[0]
    if [ ${array[0]} == $doCode ]; then
        txtColor=${array[1]}
        message=${array[2]}
    fi
done
# Move $2 to $doCmds and strip comments from variable
doCmds=$(echo "$2" | egrep '^[[:blank:]]*[^[:blank:]#]')
# If doCmds variable is not empty ...
if [ -n "$doCmds" ]; then
    tput setaf 3 && echo $message && tput setaf $txtColor && set -x
    # Evaluate doCmds variable as bash commands
    eval "$doCmds"
fi
