#!/bin/bash
customName=$1
# Get length of customname variable
topbtm='* * * * * * * * * * * * * * * * * * * * * * *'
padded='*                                           *'
# Get length of customname variable
mlen=${#customName}
# Get width of banner
blen=${#topbtm}
# Determine padding needed to true up row containing customname variable
len=$(($blen-$mlen-4))
# Build row with passed variable and correct padding
custom='*  '$customName$(printf "%*s" $len)'*'
tput setaf 196
echo "$topbtm"
echo "$padded"
echo "*  Execution Script for Devops with Docker  *"
echo "$custom"
echo "$padded"
echo "$topbtm"
