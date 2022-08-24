#!/bin/bash

# SET THE STAGE
CINN_VERSION=$(cinnamon --version)
CWD=$(pwd)
LWD=$HOME/.local/share/dermodex

# APPEND CINNAMON-EXT TO CINNAMON
cat $LWD/cinnamon-ext.css >> $LWD/theme/cinnamon/cinnamon.css

# COPY HYBRID AS DERMODEX
cp -rf $LWD/theme/* $HOME/.themes/DermoDeX