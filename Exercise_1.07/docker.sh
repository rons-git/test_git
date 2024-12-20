#!/bin/bash
pardir=$(dirname $PWD)
# Banner:
arg1='bnExercise 1.7: Image for Script'
# Special instructions:
arg2='siWhen you see a block of html code, press Ctrl-C'
# Build and run commands:
arg3='brdocker build . -t lister'
# Show result commands:
arg4='srdocker run -it lister'
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"
