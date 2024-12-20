#!/bin/bash
pardir=$(dirname $PWD)
# Banner:
arg1='bnExercise 1.1: Getting Started'
# Build and run commands:
arg2='brdocker run -d --name nginx1 nginx
docker run -d --name nginx2 nginx
docker run -d --name nginx3 nginx
docker stop nginx1 nginx2
wait'
# Show result commands:
arg3='srdocker ps -a'
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3"
