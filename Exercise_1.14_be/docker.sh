#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 1.14: Environment - Backend"
# Copy commands:
arg2="cp$pardir/scripts/getmatappsub.sh example-backend
cp Dockerfile_be -f example-backend/Dockerfile"
# Build and run commands:
arg3="brdocker build example-backend -t hello-backend"
# Show results:
arg4="srdocker run -dp 8080:8080 hello-backend"
# No backups
arg5="bux"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4" "$arg5"
