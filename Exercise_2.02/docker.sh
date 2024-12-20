#!/bin/bash
pardir="$(dirname "$PWD")"
#banner:
arg1="bnExercise 2.2"
#special instructions:
arg2="siWhen you see the line [GIN debug] ... :8080 , open a Browser and enter the URL localhost:8080, then press Ctrl-C
(you should see { message: \"You connected to ... } on the web page)"
#build and run commands:
arg3="brdocker compose up"
#execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3"
