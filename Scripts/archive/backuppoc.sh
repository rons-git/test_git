#!/bin/bash
set +x && tput setaf 3 && echo Backup POC Directory and Subdirectories && tput setaf 177 
source='mnt/d/leaguex/POCs'
dest='/mnt/d/onedrive/backups'
now=$(date +%y-%m-%d_%H_%M_%S)
basecopy='/mnt/e/leaguex/POCs'
copy="$basecopy"_$now
archive=$(basename $source)_Backup_$now.tgz
echo Creating file $archive
tar czf $dest'/'$archive -C / $source/
# Remove all but the 100 most recent files
ls -dt $dest/* | tail -n +101 | xargs -d '\n' rm 2>/dev/null
echo Copying $source directory to $copy
cp -r /$source/. $copy/
# Remove all but the 100 most recent directories
ls -dt "$(dirname "$basecopy")"/* | tail -n +101 | xargs -d '\n' rm -rf 2>/dev/null
tput setaf 177 && echo -n "$(dirname "$basecopy")" contains "$(ls "$(dirname "$basecopy")" | wc -l)" directories \
and uses  $(du -sh --apparent-size "$(dirname "$basecopy")" | cut -f1) of disk space && echo
echo
