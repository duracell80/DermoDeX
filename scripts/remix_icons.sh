#!/bin/bash

# bottom: stop-color:#000
# top: stop-color:#666
# tab: fill:#999
LWD=$HOME/.local/share/dermodex/icons/breeze-dark_black
IWD=$HOME/.local/share/icons/White-Icons/scalable
CWD=$HOME/.cache/dermodex/icons/breeze-dark_black
FILE="$CWD/list.txt"

mkdir -p $CWD/places/outline
mkdir -p $CWD/emblems
mkdir -p $CWD/mimetypes

cp -f $LWD/mimetypes/*.svg $CWD/mimetypes

ACCENT=$1
BRIGHT=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 1.3)
DARKER=$($HOME/.local/share/dermodex/remix_color.py -c "${ACCENT}" -f 0.7)


# PLACES
cp -f $LWD/places/*.svg $CWD/places
ls $CWD/places/*.svg > $FILE

echo "[i] Remixing Icons: Places"
while read -r LINE; do
    sed -i "s|stop-color:#000|stop-color:${ACCENT}|g" ${LINE}
    sed -i "s|stop-color:#666|stop-color:${BRIGHT}|g" ${LINE}
    sed -i "s|fill:#999|fill:${DARKER}|g" ${LINE}
done < $FILE
rm -f $FILE

# PLACES - OUTLINED
cp -f $LWD/places/outline/*.svg $CWD/places/outline
ls $CWD/places/outline/*.svg > $FILE

echo "[i] Remixing Icons: Places Outlined"
while read -r LINE; do
    sed -i 's|#000000|'${ACCENT}'|g' ${LINE}
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


# MIMETYPES
ls $CWD/mimetypes/*.svg > $FILE

echo "[i] Remixing Icons: Mimetypes"
while read -r LINE; do
    sed -i 's|#000000|'${DARKER}'|g' ${LINE}
done < $FILE
rm -f $FILE

cp -n $CWD/places/outline/*.svg $CWD/places
mv -f $CWD/places/*.svg $HOME/.local/share/icons/White-Icons/scalable/places
mv -f $CWD/emblems/*.svg $HOME/.local/share/icons/White-Icons/scalable/emblems
mv -f $CWD/mimetypes/*.svg $HOME/.local/share/icons/White-Icons/scalable/mimetypes

#xdotool key ctrl+alt+"Escape"