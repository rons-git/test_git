#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 1.12: Hello, Frontend!"
# Special instructions:
arg2="siWhen you see the line INFO Accepting connections at http://localhost:5000,
open a Browser and enter the URL localhost:5000, then press Ctrl-C three times
(you should see Exercise 1.12: Congratulations! You configured your ports correctly! on the web page)"
# Copy commands:
arg3="cp$pardir/scripts/getmatappsub.sh example-frontend
cp Dockerfile_fe -f example-frontend/Dockerfile"
# Build and run commands:
arg4="brdocker build example-frontend -t hello-frontend"
# Show results:
arg5="srdocker run -p 5000:5000 hello-frontend"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4" "$arg5"
