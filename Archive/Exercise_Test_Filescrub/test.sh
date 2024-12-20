#!/bin/bash
pardir="$(dirname "$PWD")"
# banner:
arg1="bnExercise Test: Remove files"
# remove files:
arg2="rmtest* subdirectories"
# skip backup
arg3="bux"
# execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3"
