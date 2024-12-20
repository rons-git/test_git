#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 1.11: Spring"
# Special instructions:
arg2="siOnce you see the Spring banner, wait until the terminal stops displaying lines, then open a Browser and enter the 
URL localhost:8080. Press the button Press here, then press Ctrl-C (you should see Success under the button on the web page)"
# Copy commands:
arg3="cp$pardir/scripts/getmatappsub.sh spring-example-project
cp Dockerfile_spring -f spring-example-project/Dockerfile"
# Build and run commands:
arg4="brdocker build spring-example-project -t spring-project"
# Show results:
arg5="srdocker run -p 8080:8080 spring-project"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4" "$arg5"
