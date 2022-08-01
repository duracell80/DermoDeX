#!/usr/bin/env bash

PRIMARY=$(xrandr | grep 'primary' | cut --delimiter=" " -f 4 | cut --delimiter="+" -f 1)
echo $PRIMARY
