#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 2.8"
# Special instructions:
arg2="siWhen you see the line Listening and serving HTTP on :8080, open
a browser and type localhost as the URL.  Then, press the Press to Test!
button next to Exercise 2.8 and press Ctrl-C (you should see Nice! The 
exercise is complete! next to the ✔  button next to Exercise 2.8)."
# Copy commands:
arg3="cp$pardir/scripts/getmatappsub.sh example-frontend
cp -f dockerfile_fe example-frontend/Dockerfile
$pardir/scripts/getmatappsub.sh example-backend
cp -f dockerfile_be example-backend/Dockerfile
cp docker_nginx.conf nginx.conf"
# Build and run commands:
arg4="brdocker compose up"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"
