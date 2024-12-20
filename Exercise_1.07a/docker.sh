#!/bin/bash
pardir=$(dirname $PWD)
# Banner:
arg1='bnExercise 1.7a: Improved Curler'
# Build and run commands:
arg2='brdocker build . -t lister'
# Show result commands:
arg3='srdocker run -it lister helsinki.fi'
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3"
