#!/usr/bin/env bash
rm -f $HOME/.cache/wallpaper_current.txt
touch $HOME/.cache/wallpaper_current.txt

PID=$(ps aux | grep -i "watch_wallpaper.sh" | head -1 | awk '{print $2}')
kill $PID >/dev/null 2>&1

$HOME/.local/share/dermodex/watch_wallpaper.sh

#xdotool key ctrl+alt+"Escape"
