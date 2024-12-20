#!/bin/bash
pardir=$(dirname $PWD)
# Banner:
arg1="bnExercise 1.8: Two Line Dockerfile"
# Special instructions:
arg2="siWhen you see the line [GIN-debug] ... :8080, Press Ctrl-C"
# Build and run commands:
arg3="brdocker build . -t web-server"
# Show result commands:
arg4="srdocker run web-server"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"
