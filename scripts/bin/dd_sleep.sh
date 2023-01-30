#!/usr/bin/env bash
rm -f $HOME/.cache/wallpaper_current.txt
touch $HOME/.cache/wallpaper_current.txt

PID=$(ps aux | grep -i "watch_wallpaper.sh" | head -1 | awk '{print $2}')
kill $PID >/dev/null 2>&1

#dex-notify.sh --action="Wake DermoDeX":~/.local/bin/dd_wake --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex is currently sleeping." "Changing your wallpaper at the moment will not reflect in your accent colors. Wake DermoDeX with the dd_wake command."