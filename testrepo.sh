#!/bin/bash
. ./scripts/gitfunctions.sh && . ./scripts/utils.sh
setColor 'title' && echo Copying test_git to test_git_history ...
now=$(date +%y-%m-%d_%H_%M_%S)
source='mnt/d/active/leaguex/POCs/test_git'
basecopy='/mnt/d/active/leaguex/POCs/test_git_history/test_git'
copy="$basecopy"_$now
cp -r /$source/. $copy/
ls -dt "$(dirname "$basecopy")"/* | tail -n +21 | xargs -d '\n' rm -rf 2>/dev/null
#
setColor 'title' && echo Testing getremoterepodata.sh ...
scriptfile="$(realpath ./scripts/getremoterepodata.sh)"
testdir=Exercise_1.11
cd "$testdir"
[ ${PWD##*/} != "$testdir" ] && setColor 'err' && echo ***Error: "$testdir" does not exist && exit
"$scriptfile" a
"$scriptfile" docker-hy/material-applications b
"$scriptfile" docker-hy/material-applications spring-example-project ./fred
"$scriptfile" docker-hy/material-applications spring-example-project
cd ..
#
setColor 'title' && echo Testing mkremoterepo.sh ...
./scripts/mkremoterepo.sh
./scripts/mkremoterepo.sh Test-Git
./scripts/mkremoterepo.sh Test ./fred
#
setColor 'title' && echo Testing dellocalrepo.sh ...
./scripts/dellocalrepo.sh
./scripts/dellocalrepo.sh Test-Git
./scripts/dellocalrepo.sh ./fred
#
setColor 'title'  && echo Testing rpremoterepo.sh ...
./scripts/rpremoterepo.sh
./scripts/rpremoterepo.sh Test-Git
./scripts/rpremoterepo.sh Test
./scripts/rpremoterepo.sh Test-Git ./fred
#
setColor 'title' && echo Testing syncrepos.sh ...
./scripts/syncrepos.sh
./scripts/syncrepos.sh Test-Git
./scripts/syncrepos.sh Test
./scripts/syncrepos.sh Test-Git ./fred
#
setColor 'title' && echo Testing delremoterepo.sh ...
./scripts/delremoterepo.sh
./scripts/delremoterepo.sh Test-Git
./scripts/delremoterepo.sh test_git
./scripts/delremoterepo.sh Test ./fred
./scripts/delremoterepo.sh Test none
#
setColor 'title' && echo Testing mklocalrepo.sh ...
cd ..
./test_git/scripts/mklocalrepo.sh
./test_git/scripts/mklocalrepo.sh Test-Git
./test_git/scripts/mklocalrepo.sh ScorpionDrive-System-Integration
rm -rf scorpiondrive-system-integration
setColor 'ok' && echo Local directory ./scorpiondrive-system-integration has been deleted
