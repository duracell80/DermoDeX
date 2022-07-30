#!/usr/bin/env bash
rm -f $HOME/.cache/dermodex/wallpaper_current.txt
touch $HOME/.cache/dermodex/wallpaper_current.txt

PID=$(ps aux | grep -i "watch_wallpaper.sh" | head -1 | awk '{print $2}')
kill $PID >/dev/null 2>&1

~/.local/share/dermodex/watch_wallpaper.sh