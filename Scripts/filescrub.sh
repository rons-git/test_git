#!/bin/bash
# Put passed script arguments into an array
scriptargs=("$@")
tput setaf 3 && echo Remove All Unexcluded Files and Subdirectories && tput setaf 8 
# For each passed element ...
for i in $scriptargs; do
    # If the passed element name = subdirectories, add _ prefix on all subdirectories
    if [ $i == subdirectories ]; then
        echo Exclude Subdirectories
        for j in $(find . -type d); do if [ ! "${j:-1}" == '.' ]; then mv -- ${j:2} _${j:2}; fi; done
    else
    # Otherwise, add prefix to all files matching the passed element name
        for j in $(find . -iname $i -type f); do echo Exclude File ${j:2}; mv -- ${j:2} _${j:2}; done
    fi
done
# If files or subdirectories without a _ prefix exist ...
if [ "$(find . ! -name '_*' | wc -l)" -gt 0 ]; then
    # Remove all files and subdirectories without a _ prefix
    find . ! -name '_*' -exec rm -rf {} + &>/dev/null
fi
# Remove the first character (which is always _) from all files and subdirectories
for f in *; do mv -- $f ${f:1}; done
echo -n Remaining Files and Subdirectories:\ ; dir
