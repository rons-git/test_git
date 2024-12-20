#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 1.13: Hello, Backend!"
# Special instructions:
arg2="siWhen the script finishes, open a Browser and enter the URL localhost:8080/ping
(you should see the word pong on the web page)"
# Copy commands:
arg3="cp$pardir/scripts/getmatappsub.sh example-backend
cp Dockerfile_be -f example-backend/Dockerfile"
# Build and run commands:
arg4="brdocker build example-backend -t hello-backend"
# Show results:
arg5="srdocker run -dp 8080:8080 hello-backend"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4" "$arg5"
