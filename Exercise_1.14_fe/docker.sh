#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 1.14: Environmeent - Frontend"
# Special instructions:
arg2="si*** Run the backend script before running this script ***
When you see the line INFO Accepting connections at http://localhost:5000,
press the Press to Test! button next to Exercise 1.14, then press Ctrl-C three times
(you should see Success! Great job! next to the ✔ button next to Exercise 1.14 on the web page)"
# No dockerscrub:
arg3="ndx"
# Copy commands:
arg4="cp$pardir/scripts/getmatappsub.sh example-frontend
cp Dockerfile_fe -f example-frontend/Dockerfile"
# Build and run commands:
arg5="brdocker build example-frontend -t hello-frontend"
# Show results:
arg6="srdocker run -p 5000:5000 hello-frontend"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4" "$arg5" "$arg6"
