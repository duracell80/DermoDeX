#!/usr/bin/env bash

CINN_VERSION=$(cinnamon --version)
if awk "BEGIN {exit !($CINN_VERSION < 5.2)}"; then
    echo "[i] ERROR: Cinnamon version too low, this script was designed for Cinnamon 5.2 and above"
    exit
fi

rm -f $HOME/.cache/wallpaper_current.txt
touch $HOME/.cache/wallpaper_current.txt

PID=$(ps aux | grep -i "watch_wallpaper.sh" | head -1 | awk '{print $2}')
kill $PID >/dev/null 2>&1

$HOME/.local/share/dermodex/watch_wallpaper.sh

#xdotool key ctrl+alt+"Escape"
