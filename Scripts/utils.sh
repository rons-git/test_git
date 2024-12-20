#!/bin/bash
prnCmd () {
    prnOn="$1"
    if [ prnOn == 'y' ]; then
        echo set -x
    else set +x
    fi
}
setColor () {
    colorNumber=6
    colorType="$1"
    [ $colorType == title ] && colorNumber=214
    [ $colorType == err ] && colorNumber=196
    [ $colorType == warn ] && colorNumber=226
    [ $colorType == info ] && colorNumber=6
    [ $colorType == ok ] && colorNumber=40
    tput setaf $colorNumber
}
