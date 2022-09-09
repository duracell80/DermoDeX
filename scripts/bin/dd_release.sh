#!/usr/bin/env bash
rm -f ~/.cache/dermodex/dermodex_hold
rm -f ~/.local/share/dermodex/dermodex_swatch
rm -f ~/.local/share/dermodex/colors_rgb.txt
rm -f ~/.local/share/dermodex/colors_hex.txt
rm -f ~/.local/share/dermodex/colors_hex.txt
rm -f $HOME/.cache/dermodex/wallpaper_current.txt
touch $HOME/.cache/dermodex/wallpaper_current.txt

#dconf load /org/cinnamon/ < ~/cinnamon_dd.backup

HOLD_FILE="$HOME/.cache/dermodex/dermodex_hold"
if [ -f "$HOLD_FILE" ]; then 
    notify-send --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex Hold Still Active." "DermoDeX seems to be having trouble removing your hold file, go to ~/.cache/dermodex and manually remove the file dermodex_hold."
else
    notify-send --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex Hold No longer Active." "DermoDeX was respecting your held colors, this means that changing the wallpaper wouldn't have recalculated the accent colors. You can now wake DermoDeX if you would like assistance picking new colors."
fi
