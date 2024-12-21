#!/bin/bash
# Put passed arguments into an array
scriptargs=("$@")
pardir="$(dirname $PWD)"
scrdir="$pardir"'/scripts'
# Get the remaining data that matches the first 2 characters of the passed argument
getData() {
    retval=''
    # "${scriptargs[@]}" denotes each passed argument line
    for i in "${scriptargs[@]}"; do
        # Check until the first 2 characters of each passed argument line matches the data passed to the getData function
        [[ "$i" == "$1"?* ]] && retval="${i:2}" && return
    done
    return
}
#*** Process banner data ***
getData 'bn' || [[ -n "$retval" ]] && set +x && "$scrdir"'/banner.sh' "$retval"
#*** Process special instructions data ***
getData 'si' || [[ -n "$retval" ]] && set +x && "$scrdir"'/instructions.sh' "$retval"
#*** Skip docker cleanup if $retval has data ***
getData 'nd' || [[ -z "$retval" ]] && set +x && "$scrdir"'/dockerscrub.sh'
#*** Remove files and/or subdirectories ***
getData 'rm' || [[ -n "$retval" ]] && set +x && "$scrdir"'/filescrub.sh' "$retval"
#*** Process copy code from source data ***
getData 'cp' || [[ -n "$retval" ]] && set +x && "$scrdir"'/dofiles.sh' cp "$retval"
#*** Display Dockerfiles ***
getData 'ds' || [[ -z "$retval" ]] && set +x && "$scrdir"'/dispfiles.sh' df
#*** Skip display script files if $retval has data ***
getData 'ns' || [[ -z "$retval" ]] && set +x && "$scrdir"'/dispscripts.sh'
#*** Display docker-compose.yml ***
getData 'ds' || [[ -z "$retval" ]] && set +x && "$scrdir"'/dispfiles.sh' dc
#*** Display configuration files ***
getData 'ds' || [[ -z "$retval" ]] && set +x && "$scrdir"'/dispfiles.sh' cf
#*** Process execute docker build and run data ***
getData 'br' || [[ -n "$retval" ]] && set +x && "$scrdir"'/dofiles.sh' br "$retval"
#*** Process show results data ***
getData 'sr' || [[ -n "$retval" ]] && set +x && "$scrdir"'/dofiles.sh' sr "$retval"
#*** Backup all POC files ***
getData 'bu'
if [[ -z "$retval" ]]; then
    set +x && "$scrdir"'/backupPOC.sh'
elif [ "${retval:0}" != x ]; then
    set +x && nohup "$scrdir"'/backupPOC.sh'
fi
cd "$pardir"
"$scrdir"'/syncrepos.sh' "$(basename "$pardir")"
