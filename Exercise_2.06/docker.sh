#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 2.6"
# Special instructions:
arg2="siWhen you see the line INFO Accepting connections at http://localhost:5000,
open a browser and enter localhost:5000 as the URL. Then, press the Press to Test! 
button next to Exercises 1.14, 2.4, and 2.6, then press Ctrl-C (you should see 
Success! Great job! next to the ✔ button next to Exercise 1.14, Nice! The exercise
is complete! next to the ✔  button next to Exercise 2.4, and Working! Messages 
below also work. next to the ✔ button next to Exercise 2.6 on the web page).  You 
can then Write, Send and Get All Messages."
# Copy commands:
arg3="cp$pardir/scripts/getmatappsub.sh example-frontend
cp -f dockerfile_fe example-frontend/Dockerfile
$pardir/scripts/getmatappsub.sh example-backend
cp -f dockerfile_be example-backend/Dockerfile"
# Build and run commands:
arg4="brdocker compose up"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"
