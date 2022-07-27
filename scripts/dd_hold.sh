#!/usr/bin/env bash
WALL_FILE=$(cat ~/.cache/dermodex/wallpaper_current.txt | tr -d \' | sed 's-file:///-/-')

cp -f $WALL_FILE ~/.local/share/dermodex/dermodex_hold
cp -f ~/Pictures/wallpaper_swatch.png ~/.local/share/dermodex/dermodex_swatch
cp -f ~/.cache/dermodex/colors_hex.txt ~/.local/share/dermodex/
cp -f ~/.cache/dermodex/colors_rgb.txt ~/.local/share/dermodex/


HOLD_FILE="~/.local/share/dermodex/dermodex_hold"
if [ -f "$HOLD_FILE" ]; then
    notify-send.sh --action="Release DermoDeX":~/.local/bin/dd_release --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex Hold Active." "DermoDeX is currently respecting your held colors, this means that changing the wallpaper won't recalculate the accent colors. You can release DermoDeX here."
else 
    notify-send.sh --action="Release DermoDeX":~/.local/bin/dd_release --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex Hold Active." "DermoDeX is currently respecting your held colors, this means that changing the wallpaper won't recalculate the accent colors. You can release DermoDeX here."
fi