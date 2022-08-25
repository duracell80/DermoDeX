#!/bin/bash

# SET THE STAGE
CINN_VERSION=$(cinnamon --version)
CWD=$(pwd)
LWD=$HOME/.local/share/dermodex

# APPEND CINNAMON-EXT TO CINNAMON
rm -rf $LWD/theme/cinnamon/cinnamon_base.css

cp $LWD/theme/cinnamon/cinnamon.css $LWD/theme/cinnamon/cinnamon.orig
cp $LWD/theme/cinnamon/cinnamon.css $LWD/theme/cinnamon/cinnamon_base.css

chmod u+rw $LWD/theme/cinnamon/cinnamon_base.css

cat $LWD/cinnamon-ext.css >> $LWD/theme/cinnamon/cinnamon_base.css
cp -f $LWD/theme/cinnamon/cinnamon_base.css $LWD/theme/cinnamon/cinnamon.css


# COPY HYBRID AS DERMODEX
cp -rf $LWD/theme/* $HOME/.themes/DermoDeX
cp -f $LWD/theme/cinnamon/cinnamon.orig $LWD/theme/cinnamon/cinnamon.css


xdotool key ctrl+alt+"Escape"