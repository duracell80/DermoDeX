#!/usr/bin/env bash

CINN_VERSION=$(cinnamon --version)
if awk "BEGIN {exit !($CINN_VERSION < 5.2)}"; then
    echo "[i] ERROR: Cinnamon version too low, this script was designed for Cinnamon 5.2 and above"
    exit
fi

CUR_WALL=$(gsettings get org.cinnamon.desktop.background picture-uri)
dd_sleep
echo "" > $HOME/.cache/wallpaper_current.txt
sleep 1
dd_wake
