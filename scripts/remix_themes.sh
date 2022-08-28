#!/bin/bash

# SET THE STAGE
CINN_VERSION=$(cinnamon --version)
CWD=$(pwd)
LWD=$HOME/.local/share/dermodex
CCD=$HOME/.cache/dermodex
CINN_FILE=$CCD/cinnamon-ext.css

ACCENT=$1
BRIGHTEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2.2 --mode="hex")
BRIGHTER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2 --mode="hex")
BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1.3 --mode="hex")
DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.7 --mode="hex")
DARKER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.3 --mode="hex")
DARKEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.2 --mode="hex")

RGB_ACCENT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1 --mode="rgb")
RGB_BRIGHTEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2.2 --mode="rgb")
RGB_BRIGHTER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 2 --mode="rgb")
RGB_BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1.3 --mode="rgb")
RGB_DARK=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.7 --mode="rgb")
RGB_DARKER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.3 --mode="rgb")
RGB_DARKEST=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.2 --mode="rgb")





echo "[i] Colors to Apply - Accent: $ACCENT | Bright: $BRIGHT | Brightest: $BRIGHTEST | Dark: $DARKER | Darkest: $DARKEST"

# APPEND CINNAMON-EXT TO CINNAMON
cp -f $LWD/theme/cinnamon/cinnamon.css $LWD/theme/cinnamon/cinnamon.orig
cp $LWD/theme/cinnamon/cinnamon.css $CCD/cinnamon-base.css
cp $LWD/cinnamon-ext.css $CINN_FILE
chmod u+rw $CCD/cinnamon-base.css
chmod u+rw $CCD/cinnamon-ext.css

# SED - BRIGHTEST - #a0bfe8 rgb(160,191,232)
sed -i "s|#a0bfe8|${BRIGHTEST}|g" $CINN_FILE
sed -i "s|rgba(160,191,232|rgba(${RGB_BRIGHTEST}|g" $CINN_FILE

# SED - BRIGHT - #5b93de rgb(91,147,222)
sed -i "s|#3281ea|${BRIGHT}|g" $CINN_FILE
sed -i "s|rgba(91,147,222|rgba(${RGB_BRIGHT}|g" $CINN_FILE

# SED - ACCENT - #3281ea rgb(50,129,234)
sed -i "s|#3281ea|${ACCENT}|g" $CINN_FILE
sed -i "s|rgba(50,129,234|rgba(${RGB_ACCENT}|g" $CINN_FILE

# SED - DARK - #11386b rgb(17,56,107)
sed -i "s|#011a3b|${DARK}|g" $CINN_FILE
sed -i "s|rgba(17,56,107|rgba(${RGB_DARKER}|g" $CINN_FILE

# SED - DARKER - #011a3b rgb(1,26,59)
sed -i "s|#011a3b|${DARKER}|g" $CINN_FILE
sed -i "s|rgba(1,26,59|rgba(${RGB_DARKER}|g" $CINN_FILE

# SED - DARKEST - #011024 rgb(1,16,36)
sed -i "s|#011024|${DARKEST}|g" $CINN_FILE
sed -i "s|rgba(1,16,36|rgba(${RGB_DARKEST}|g" $CINN_FILE

# COMBINE THE MODS
cat $CINN_FILE >> $CCD/cinnamon-base.css
cp -f $CCD/cinnamon-base.css $LWD/theme/cinnamon/cinnamon.css


# COPY HYBRID AS DERMODEX
cp -rf $LWD/theme/* $HOME/.themes/DermoDeX

# IMPORTANT: RESTORE CINNAMON IN LOCAL BACK TO BASE WITHOUT MODS READY FOR NEXT RUN
cp -f $LWD/theme/cinnamon/cinnamon.orig $LWD/theme/cinnamon/cinnamon.css


xdotool key ctrl+alt+"Escape"
