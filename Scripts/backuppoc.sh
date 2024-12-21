#!/bin/bash
. "$(dirname "$PWD")"'/scripts/utils.sh'
prnCmd 'n'  && setColor 'title'  && echo 'Backup POC directory and subdirectories'
source="$(dirname "$(dirname "$PWD")")"
dest='/mnt/d/onedrive/backups'
now=$(date +%y-%m-%d_%H_%M_%S)
archive="$(basename "$source")"'_Backup_'"$now"'.tgz'
setColor 'info' && echo 'Creating file '"$archive"
tar czf "$dest"'/'"$archive" -C / "$(basename "$source")"'/'
# Remove all but the 100 most recent files
ls -dt "$dest"/* | tail -n +101 | xargs -d '\n' rm 2>/dev/null
