#!/usr/bin/env bash
CUR_WALL=$(gsettings get org.cinnamon.desktop.background picture-uri)
dd_sleep
echo "" > $HOME/.cache/dermodex/wallpaper_current.txt
sleep 2
dd_wake

