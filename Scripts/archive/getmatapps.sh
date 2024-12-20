#!/bin/bash
curdir="$(pwd)"
set -x
cd ..
if test -d ./material-applications; then
    cd material-applications
    git fetch
    git reset --hard HEAD
    git merge '@{u}'; else
    git clone git@github.com:docker-hy/material-applications.git
fi
cd $curdir
