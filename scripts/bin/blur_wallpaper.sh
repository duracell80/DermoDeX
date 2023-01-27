#!/usr/bin/env bash
TCD=$HOME/.themes/DermoDeX
CINN_FILE=$TCD/cinnamon/cinnamon.css

$HOME/.local/bin/blur_wallpaper.py

ISBLUR=$(cat $HOME/.themes/DermoDeX/cinnamon/cinnamon.css | grep -i "dd-panel-background-image" | wc -l)
echo $ISBLUR

if [ $ISBLUR == "1" ]; then
    sed -i "s|dd-panel-background-image|background-image|g" $CINN_FILE
    sed -i "s|dd-panel-background-position|background-position|g" $CINN_FILE
fi
    
if [ $ISBLUR == "0" ]; then
    sed -i "s|background-image : url(${HOME}/.local/share/dermodex/panel_blur.png);|dd-panel-background-image : url(${HOME}/.local/share/dermodex/panel_blur.png);|g" $CINN_FILE
    sleep 1
    sed -i "s|dd-panel-dd-panel-background-image|dd-panel-background-image|g" $CINN_FILE
fi
sleep 3

xdotool key ctrl+alt+"Escape"