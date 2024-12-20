#!/bin/bash
pardir=$(dirname $PWD)
# Banner:
arg1='bnExercise 1.9: Volumes'
# Special instructions:
arg2='siAfter you see 6 or 7 Wrote text to ... text.log lines, Press Ctrl-C'
# Build and run commands:
arg3='brecho -n \"\" > text.log
docker run -v "./text.log:/usr/src/app/text.log" devopsdockeruh/simple-web-service'
# Show result commands:
arg4='srcat text.log | grep -i secret'
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"
