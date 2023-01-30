#!/usr/bin/env bash
PID=$(ps aux | grep -i "watch_wallpaper.sh" | head -1 | awk '{print $2}')
kill $PID >/dev/null 2>&1

dconf reset /org/cinnamon
