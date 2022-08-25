#!/bin/bash

# bottom: stop-color:#000
# top: stop-color:#666
# tab: fill:#999
LWD=$HOME/.local/share/dermodex/icons/breeze-dark_black
CWD=$HOME/.cache/dermodex/icons/breeze-dark_black
FILE="$CWD/list.txt"

mkdir -p $CWD/places
mkdir -p $CWD/emblems

ACCENT=$1
BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1.3)
DARKER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.7)


# PLACES
cp -f $LWD/places/*.svg $CWD/places
ls $CWD/places/*.svg > $FILE

echo "[i] Remixing Icons: Folders"
while read -r LINE; do
    sed -i "s|stop-color:#000|stop-color:${ACCENT}|g" ${LINE}
    sed -i "s|stop-color:#666|stop-color:${BRIGHT}|g" ${LINE}
    sed -i "s|fill:#999|fill:${DARKER}|g" ${LINE}
done < $FILE
rm -f $FILE

# EMBLEMS
cp -f $LWD/emblems/*.svg $CWD/emblems
ls $CWD/emblems/*.svg > $FILE

echo "[i] Remixing Icons: Emblems"
while read -r LINE; do
    sed -i "s|#333333|${DARKER}|g" ${LINE}
done < $FILE
rm -f $FILE

mv -f $CWD/places/*.svg $HOME/.local/share/icons/White-Icons/scalable/places
mv -f $CWD/emblems/*.svg $HOME/.local/share/icons/White-Icons/scalable/emblems

#xdotool key ctrl+alt+"Escape"