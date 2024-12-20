#!/bin/bash
pardir="$(dirname "$PWD")"
# Banner:
arg1="bnExercise 2.10 - Terminal 2"
# Build and run commands:
arg2="srdocker run -it --rm --network host networkstatic/nmap localhost"
# Disable docker scrub
arg3="ndx"
# Disable file scrub
arg4="nfx"
# Disable file displays
arg5="dsx"
# Disable backup
arg6="bux"
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3" "$arg4" "$arg5" "$arg6"
