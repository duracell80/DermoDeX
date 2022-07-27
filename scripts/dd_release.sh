#!/usr/bin/env bash
rm -f ~/.local/share/dermodex/dermodex_hold
rm -f ~/.local/share/dermodex/dermodex_swatch
rm -f ~/.local/share/dermodex/colors_rgb.txt
rm -f ~/.local/share/dermodex/colors_hex.txt

HOLD_FILE="~/.local/share/dermodex/dermodex_hold"
if [ -f "$HOLD_FILE" ]; then 
    notify-send.sh --action="Wake DermoDeX":~/.local/bin/dd_wake --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex Hold Still Active." "DermoDeX seems to be having trouble removing your hold file, go to ~/.local/share/dermodex and manually remove the file dermodex_hold."
else
    notify-send.sh --action="Wake DermoDeX":~/.local/bin/dd_wake --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex Hold No longer Active." "DermoDeX was respecting your held colors, this means that changing the wallpaper wouldn't have recalculated the accent colors. You can now wake DermoDeX if you would like assistance picking new colors."
fi