#!/bin/bash
pardir=$(dirname $PWD)
# Banner:
arg1='bnExercise 1.6: Hello Docker Hub'
# Special instructions:
arg2='siWhen you see the prompt Give me the password:, type basics'
# Build and run commands:
arg3='brdocker run -dit --name looper devopsdockeruh/pull_exercise'
# Show result commands:
arg4='srdocker attach looper'
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4"
