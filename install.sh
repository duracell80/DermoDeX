#!/bin/bash
pip3 install easydev
pip3 install colormap
#pip3 install opencv-python
pip3 install colorgram.py
pip3 install extcolors
pip3 install matplotlib

dconf dump /org/cinnamon/ > ~/cinnamon_desktop_backup

echo "[i] Setting Up The Start Menu"
cp -r ./theme ~/.themes/DermoDeX
cp ~/.cinnamon/configs/menu@cinnamon.org/0.json ~/.cinnamon/configs/menu@cinnamon.org/0.json.bak
cp -f ./scripts/config_menu.json ~/.cinnamon/configs/menu@cinnamon.org/0.json
cp -f ./scripts/cinnamon_reload ~/.local/bin
cp -f ./scripts/dd_wake.sh ~/.local/bin/dd_wake
cp -f ./scripts/notify-send.sh ~/.local/bin
cp -f ./scripts/notify-action.sh ~/.local/bin
cp -f ./*.desktop ~/.config/autostart

echo "[i] Installing DermoDex to .local/share"
mkdir -p ~/.local/share/dermodex
cp ./scripts/* ~/.local/share/dermodex

if [ -d ~/Color-Icons ] ; then
    echo ""

else
    echo "[i] Installing Icons"

	cd ~/
	git clone https://github.com/wmk69/Color-Icons
	cd ~/Color-Icons
	tar -xvzf Color-Icons.tar.gz
	cp -r Color-Icons/White-Icons ~/.local/share/icons
	cp -r Color-Icons/Black-Icons ~/.local/share/icons
fi

echo "[i] Setting The Icons and Theme"
gsettings set org.cinnamon.desktop.interface icon-theme "White-Icons"
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y"
gsettings set org.cinnamon.theme name "DermoDeX"


echo "[i] Adjusting The Height Of The Panels"
dconf write /org/cinnamon/panels-height "['1:60']"


if ! type "xdotool" > /dev/null 2>&1; then
    echo "[i] Hot Keys not installed"
    notify-send --urgency=normal --category=im.receieved --icon=help-info-symbolic "Hot Keys Tool not installed ..." "Run 'sudo apt install xdotool' to automate shortcuts such as CTRL+Alt+Esc"
    
    echo "[i] Press Ctrl+Alt+Esc to Refresh Your Desktop ..."
    sudo apt-get install -y -q xdotool
else
    xdotool key ctrl+alt+"Escape"
    echo "[i] Cinnamon Refreshed!"
fi
