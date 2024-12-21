#!/bin/bash
# Put passed arguments into an array
scriptargs=("$@")
pardir="$(dirname $PWD)"
scrdir="$pardir"'/scripts'
# Get the remaining data that matches the first 2 characters of the passed argument
getData() {
    # "${scriptargs[@]}" denotes each passed argument line
    for i in "${scriptargs[@]}"; do
        # Check until the first 2 characters of each passed argument line matches the data passed to the getData function
        [[ "$i" == "$1"?* ]] && echo "${i:2}" && return
    done
    echo ""
}
#*** Process banner data ***
data="$(getData 'bn')" && [ -n "$data" ] && set +x && "$scrdir"'/banner.sh' "$data"
#*** Process special instructions data ***
data="$(getData 'si')" && [ -n "$data" ] && set +x && "$scrdir"'/instructions.sh' "$data"
#*** Skip docker cleanup if $retval has data ***
[ -z "$(getData 'nd')" ] && set +x && "$scrdir"'/dockerscrub.sh'
#*** Remove files and/or subdirectories ***
data="$(getData 'rm')" && [ -n "$data" ] && set +x && "$scrdir"'/filescrub.sh' "$data"
#*** Process copy code from source data ***
data="$(getData 'cp')" && [ -n "$data" ] && set +x && "$scrdir"'/dofiles.sh' 'cp' "$data"
#*** Display Dockerfiles ***
[ -z "$(getData 'ds')" ] && set +x && "$scrdir"'/dispfiles.sh' 'df'
#*** Skip display script files if $retval has data ***
[ -z "$(getData 'ns')" ] && set +x && "$scrdir"'/dispscripts.sh'
#*** Display docker-compose.yml ***
[ -z "$(getData 'ds')" ] && set +x && "$scrdir"'/dispfiles.sh' 'dc'
#*** Display configuration files ***
[ -z "$(getData 'ds')" ] && set +x && "$scrdir"'/dispfiles.sh' 'cf'
#*** Process execute docker build and run data ***
data="$(getData 'br')" && [ -n "$data" ] && set +x && "$scrdir"'/dofiles.sh' 'br' "$data"
#*** Process show results data ***
data="$(getData 'sr')" && [ -n "$data" ] && set +x && "$scrdir"'/dofiles.sh' 'sr' "$data"
#*** Backup all POC files ***
data="$(getData 'bu')"
if [ -z "$data" ]; then
    set +x && "$scrdir"'/backupPOC.sh'
elif [ "${data:0}" != 'x' ]; then
    set +x && nohup "$scrdir"'/backupPOC.sh'
fi
[ "${data:0}" != 'x' ] && cd "$pardir" && "$scrdir"'/syncrepos.sh' "$(basename "$pardir")"
