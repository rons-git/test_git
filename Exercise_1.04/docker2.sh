#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 1.4.T2: Missing Dependencies"
# No dockerscrub:
arg2="ndx"
# Build and run commands:
arg3="brdocker exec -it lister bash -c 'apt-get -y update; apt-get -y install curl'"
# No backup
arg4="bux"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"
