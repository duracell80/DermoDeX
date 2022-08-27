#!/bin/bash

# bottom: stop-color:#000
# top: stop-color:#666
# tab: fill:#999
LWD=$HOME/.local/share/dermodex/icons/breeze-dark_black
IWD=$HOME/.local/share/icons/White-Icons/scalable
CWD=$HOME/.cache/dermodex/icons/breeze-dark_black
CCA=$HOME/.cache/dermodex/common-assets/cinnamon/assets
TCD=$HOME/.themes/DermoDeX
FILE="$CWD/list.txt"

mkdir -p $CWD/places/outline
mkdir -p $CWD/emblems
mkdir -p $CWD/mimetypes
mkdir -p $CWD/controlpanel/cats
mkdir -p $CWD/controlpanel/apps
mkdir -p $HOME/.cache/dermodex/common-assets/cinnamon

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

# SYSTEM CONTROL PANEL
cp -f $LWD/controlpanel/cats/*.svg $CWD/controlpanel/cats/
ls $CWD/controlpanel/cats/*.svg > $FILE

echo "[i] Remixing Icons: Control Panel - Categories"
while read -r LINE; do
    sed -i 's|#cccccc|'${ACCENT}'|g' ${LINE}
done < $FILE
rm -f $FILE

cp -f $LWD/controlpanel/apps/*.svg $CWD/controlpanel/apps
ls $CWD/controlpanel/apps/*.svg > $FILE

echo "[i] Remixing Icons: Control Panel - Applications"
while read -r LINE; do
    sed -i 's|#cccccc|'${ACCENT}'|g' ${LINE}
done < $FILE
rm -f $FILE


cp -n $CWD/places/outline/*.svg $CWD/places
mv -f $CWD/places/*.svg $HOME/.local/share/icons/White-Icons/scalable/places
mv -f $CWD/emblems/*.svg $HOME/.local/share/icons/White-Icons/scalable/emblems
mv -f $CWD/mimetypes/*.svg $HOME/.local/share/icons/White-Icons/scalable/mimetypes

cp -f $CWD/controlpanel/cats/cs* $HOME/.local/share/icons/White-Icons/scalable/categories
cp -f $CWD/controlpanel/apps/csd* $HOME/.local/share/icons/White-Icons/scalable/apps

# COPY CINNAMON ASSETS FOR MANIPULATION
cp -rf $HOME/.local/share/dermodex/theme-ext/cinnamon/assets/dermodex $HOME/.themes/DermoDeX/cinnamon/assets

cp -rf $HOME/.local/share/dermodex/theme/cinnamon/assets/*.svg $CCA
cp -rf $HOME/.local/share/dermodex/theme/cinnamon/assets/calendar-arrow-left.svg $CCA/calendar-arrow-left-hover.svg
cp -rf $HOME/.local/share/dermodex/theme/cinnamon/assets/calendar-arrow-right.svg $CCA/calendar-arrow-right-hover.svg

# RECOLOR CINNAMON CLOSE ICONS
sed -i "s|#f75a61|${ACCENT}|g" $CCA/close.svg
sed -i "s|#d8354a|${DARKER}|g" $CCA/close-active.svg
sed -i "s|#ff7a80|${BRIGHT}|g" $CCA/close-hover.svg
sed -i "s|#1a73e8|${BRIGHT}|g" $CCA/corner-ripple.svg
sed -i "s|#3476cf|${ACCENT}|g" $CCA/toggle-on.svg
sed -i "s|#0860f2|${ACCENT}|g" $CCA/add-workspace-active.svg
sed -i "s|#3476cf|${ACCENT}|g" $CCA/checkbox.svg
sed -i "s|#1a73e8|${ACCENT}|g" $CCA/radiobutton.svg
sed -i "s|#3281ea|${ACCENT}|g" $CCA/grouped-window-dot-active.svg
sed -i "s|#e6e6e6|${BRIGHT}|g" $CCA/calendar-arrow-left-hover.svg
sed -i "s|#e6e6e6|${BRIGHT}|g" $CCA/calendar-arrow-right-hover.svg
#rm -rf $CCA/*.svg


#xdotool key ctrl+alt+"Escape"