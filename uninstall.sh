#!/bin/bash

gsettings set org.cinnamon.desktop.notifications display-notifications true

CWD=$(pwd)
SWD=/usr/share/sounds
LWD=$HOME/.local/share/dermodex/icons/breeze-dark_black
TWD=$HOME/.themes/DermoDeX

GTK=$HOME/.config/gtk-3.0/

rm -f $GTK/gtk.css
cp $GTK/gtk.css.orig $GTK/gtk.css


gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y"
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y"
gsettings set org.cinnamon.desktop.wm.preferences theme "cinnamon"
gsettings set org.cinnamon.theme name "cinnamon"