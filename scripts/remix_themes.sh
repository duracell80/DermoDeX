#!/bin/bash

# SET THE STAGE
CINN_VERSION=$(cinnamon --version)
CWD=$(pwd)
LWD=$HOME/.local/share/dermodex
CCD=$HOME/.cache/dermodex
CINN_FILE=$CCD/cinnamon-ext.css

ACCENT=$1
BRIGHTEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2)
BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1.3)
DARKER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.7)

echo "[i] Colors to Apply - Accent: $ACCENT | Brighter: $BRIGHT | Darker: $DARKER"

# APPEND CINNAMON-EXT TO CINNAMON
cp -f $LWD/theme/cinnamon/cinnamon.css $LWD/theme/cinnamon/cinnamon.orig
cp $LWD/theme/cinnamon/cinnamon.css $CCD/cinnamon-base.css
cp $LWD/cinnamon-ext.css $CINN_FILE
chmod u+rw $CCD/cinnamon-base.css
chmod u+rw $CCD/cinnamon-ext.css

# SED - BRIGHT - #5b93de
sed -i "s|#a0bfe8|${BRIGHTEST}|g" $CINN_FILE

# SED - ACCENT - #3281ea
sed -i "s|#3281ea|${BRIGHT}|g" $CINN_FILE



# COMBINE THE MODS
cat $CINN_FILE >> $CCD/cinnamon-base.css
cp -f $CCD/cinnamon-base.css $LWD/theme/cinnamon/cinnamon.css


# COPY HYBRID AS DERMODEX
cp -rf $LWD/theme/* $HOME/.themes/DermoDeX

# IMPORTANT: RESTORE CINNAMON IN LOCAL BACK TO BASE WITHOUT MODS READY FOR NEXT RUN
cp -f $LWD/theme/cinnamon/cinnamon.orig $LWD/theme/cinnamon/cinnamon.css


xdotool key ctrl+alt+"Escape"
