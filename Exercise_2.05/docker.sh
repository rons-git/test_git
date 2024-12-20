#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 2.5"
# Special instructions:
arg2="siWhen you see the line INFO Accepting connections at http://localhost:3000,
open a browser, type localhost:3000 as the URL, then press the orange Press here to test your solution button.
After the timer completes, press Ctrl-C (you should see Congratulations! next to the green
Press here to test your solution button)."
# Copy commands:
arg3="cp$pardir/scripts/getmatappsub.sh scaling-exercise"
# Build and run commands:
arg4="brcd scaling-exercise
docker compose up --scale compute=2"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"
