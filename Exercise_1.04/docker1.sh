#!/bin/bash
pardir=$(dirname $PWD)
# Banner:
arg1='bnExercise 1.4.T1: Missing Dependencies'
# Display special instructions:
arg2='siWhen you see the message sh: #: curl: not found
1. Open a 2nd Terminal and press ./docker2.sh
2. When you see a block of html code in the 1st Terminal, press Ctrl-C'
# Show result commands:
arg3='srdocker run -it --name lister ubuntu sh -c "website=helsinki.fi; while true; do
echo Searching for \$website ..; sleep 5; curl http://\$website; sleep 30; done"'
# Execute it!
$pardir/scripts/master.sh "$arg1" "$arg2" "$arg3"
