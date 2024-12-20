#!/bin/bash
# Create array of script codes used by docker*.sh files
scriptArray=($(grep ^arg ./docker*.sh | cut -d"'" -f2 | cut -c1-2 | sort -u)) && declare -a scriptArray 
scrdir=$(dirname $PWD)/scripts
txtColor=-17 && txtIncr=36
# Get the remaining data that matches the first 2 characters of the passed argument
getData() {
    retval=""
    for i in ${scriptArray[@]}; do
        # Check whether the passed argument is in the scriptArray
        if [[ $i == $1 ]]; then
            # If so, return the passed argument characters
            retval=$i; return
        fi
    done
}
dispFile() {
    passedFile=$1
    message=($(echo $passedFile | rev | cut -d'/' -f 1 | rev))
    tput setaf 3 && echo Display $message
    ((txtColor+=txtIncr)) && ((txtColor=txtColor%139)) && tput setaf $txtColor
    # Remove all blank rows from passedFile
    sed -i '/^$/d' $passedFile
    # Put the last character of the passedFile variable into the a variable
    a=$(tail -c 1 $passedFile)
    # If the a variable is not a newline ...
    if [ -n $a ]; then
    # Add a newline to the end of the passedFile
        sed -i -e '$a\' $passedFile
    fi; set -x;
    cat $passedFile; set +x
}
#*** Display master.sh and dispscripts.sh
dispFile $scrdir/master.sh
dispFile $scrdir/dispscripts.sh
#*** Display banner.sh ***
getData bn && [[ -n $retval ]] && set +x && dispFile $scrdir/banner.sh
#*** Display instructions.sh ***
getData si && [[ -n $retval ]] && set +x && dispFile $scrdir/instructions.sh
#*** Display dockerscrub.sh ***
getData nd && [[ -z $retval ]] && set +x && dispFile $scrdir/dockerscrub.sh
#*** Display filescrub.sh ***
getData rm && [[ -n $retval ]] && set +x && dispFile $scrdir/filescrub.sh 
#*** Display dispfiles.sh ***
getData ds && [[ -z $retval ]] && set +x && dispFile $scrdir/dispfiles.sh
#*** Display dofiles.sh ***
getData cp && [[ -z $retval ]] && getData br && [[ -z $retval ]] && getData sr
[[ -n $retval ]] && set +x && dispFile $scrdir/dofiles.sh
#*** Display backupPOC.sh ***
getData bu && [[ -n $retval ]] && set +x && dispFile $scrdir/backupPOC.sh
