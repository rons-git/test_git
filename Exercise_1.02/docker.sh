#!/bin/bash
pardir=$(dirname $PWD)
# Banner:
arg1='bnExercise 1.2: Cleanup'
# Show result commands:
arg2='srdocker ps -a'
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2"
