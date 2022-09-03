#!/usr/bin/env bash

if [ ! -z $1 ] 
then 
    DIMENSION=$1
else
    DIMENSION="height"
fi

PRIMARY=$(xrandr | grep 'primary' | cut --delimiter=" " -f 4 | cut --delimiter="+" -f 1)
PRIMARY_WIDTH=$(xrandr | grep 'primary' | cut --delimiter=" " -f 4 | cut --delimiter="+" -f 1 | cut --delimiter="x" -f 1)
PRIMARY_HEIGHT=$(xrandr | grep 'primary' | cut --delimiter=" " -f 4 | cut --delimiter="+" -f 1 | cut --delimiter="x" -f 2)

if [ "$DIMENSION" == "width" ]; then
    echo $PRIMARY_WIDTH
elif [ "$DIMENSION" == "height" ]; then
    echo $PRIMARY_HEIGHT
else
    echo $PRIMARY
fi