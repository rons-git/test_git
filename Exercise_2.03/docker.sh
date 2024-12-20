#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 2.3"
# Special instructions:
arg2="siWhen you see the line INFO Accepting connections at http://localhost:5000,
open a browser and enter localhost:5000 as the URL, press the Press to Test!
button next to Exercise 1.14, then press Ctrl-C (you should see Success! Great job!
next to the ✔ button next to Exercise 1.14 on the web page)"
# Copy commands:
arg3="cp$pardir/scripts/getmatappsub.sh example-frontend
cp -f dockerfile_fe example-frontend/Dockerfile
$pardir/scripts/getmatappsub.sh example-backend
cp -f dockerfile_be example-backend/Dockerfile"
# Build and run commands:
arg4="brdocker compose up"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"
