#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 2.1"
# Special instructions:
arg2="siAfter you see 6 or 7 logger | Wrote text to ... text.log lines, Press Ctrl-C"
# Build and run commands:
arg3="brmkdir -p log
echo -n \"\" > log/text.log
docker compose up"
# Show results commands:
arg4="srcat log/text.log | grep -i secret 2> /dev/null"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"

