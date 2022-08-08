#!/usr/bin/env bash
WALL_FILE=$(cat ~/.cache/dermodex/wallpaper_current.txt | tr -d \' | sed 's-file:///-/-')
CONF_FILE="$HOME/.local/share/dermodex/config.ini"

cp -f $WALL_FILE ~/.local/share/dermodex/dermodex_hold
cp -f ~/Pictures/wallpaper_swatch.png ~/.local/share/dermodex/dermodex_swatch
cp -f ~/.cache/dermodex/colors_hex.txt ~/.local/share/dermodex/
cp -f ~/.cache/dermodex/colors_rgb.txt ~/.local/share/dermodex/
chmod a+r ~/.local/share/dermodex/dermodex_hold

dconf dump /org/cinnamon/ > ~/cinnamon_dd.backup

# READ THE CONFIG
shopt -s extglob

tr -d '\r' < $CONF_FILE | sed 's/[][]//g' > $CONF_FILE.unix
while IFS='= ' read -r lhs rhs
do
    if [[ ! $lhs =~ ^\ *# && -n $lhs ]]; then
        rhs="${rhs%%\#*}"    # Del in line right comments
        rhs="${rhs%%*( )}"   # Del trailing spaces
        rhs="${rhs%\"*}"     # Del opening string quotes 
        rhs="${rhs#\"*}"     # Del closing string quotes 
        declare $lhs="$rhs"
    fi
done < $CONF_FILE.unix
shopt -u extglob # Switching it back off after use


HOLD_FILE="$HOME/.local/share/dermodex/dermodex_hold"
if [ -f "$HOLD_FILE" ]; then
    dex-notify.sh --action="Release DermoDeX":~/.local/bin/dd_release --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex Hold Active." "DermoDeX is currently respecting your held colors (#$savehex0, #$savehex1, #$savehex2), this means that changing the wallpaper won't recalculate the accent colors. You can release DermoDeX here."
else
    dex-notify.sh --action="Wake DermoDeX":~/.local/bin/dd_wake --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex Released." "If it has been more than 15 minutes since using DermoDeX, it needs waking before it can read any wallpaper changes."
fi
