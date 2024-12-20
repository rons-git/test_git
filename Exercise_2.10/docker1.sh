#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 2.10 - Terminal 1"
# Special instructions:
arg2="siWhen you see the line Listening and serving HTTP on :8080, open a browser
and type localhost as the URL.  Then, press all the Press to Test! buttons to make
sure they work.  Next, run ./docker2.sh in another terminal. Port 80/tcp should be
the only port open.  Then, return to this session and press Ctrl-C"
# Copy commands:
arg3="cp$pardir/scripts/getmatappsub.sh example-frontend
cp -f dockerfile_fe example-frontend/Dockerfile
$pardir/scripts/getmatappsub.sh example-backend
cp -f dockerfile_be example-backend/Dockerfile"
# Build and run commands:
arg4="brdocker compose up"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"
