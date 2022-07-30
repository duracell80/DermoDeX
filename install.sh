#!/bin/bash
#pip3 install easydev
#pip3 install colormap
#pip3 install opencv-python
#pip3 install colorgram.py
#pip3 install extcolors
#pip3 install matplotlib
#pip3 install configparser

dconf dump /org/cinnamon/ > ~/cinnamon_desktop.backup

cp -r ./theme ~/.themes/DermoDeX
cp ~/.cinnamon/configs/menu@cinnamon.org/0.json ~/.cinnamon/configs/menu@cinnamon.org/0.json.bak
cp -f ./scripts/config_menu.json ~/.cinnamon/configs/menu@cinnamon.org/0.json
cp ~/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json ~/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json.bak
cp -f ./scripts/config_workspace.json ~/.cinnamon/configs/workspace-switcher@cinnamon.org/27.json

cp -f ./scripts/cinnamon_reload ~/.local/bin
cp -f ./scripts/dd_sleep.sh ~/.local/bin/dd_sleep
cp -f ./scripts/dd_wake.sh ~/.local/bin/dd_wake
cp -f ./scripts/dd_hold.sh ~/.local/bin/dd_hold
cp -f ./scripts/dd_release.sh ~/.local/bin/dd_release
cp -f ./scripts/dd_rescue.sh ~/.local/bin/dd_rescue
cp -f ./scripts/dd_reload.sh ~/.local/bin/dd_reload
cp -f ./scripts/dd_refresh.sh ~/.local/bin/dd_refresh
cp -f ./scripts/dex-notify.sh ~/.local/bin
cp -f ./scripts/dex-action.sh ~/.local/bin
cp -f ./*.desktop ~/.config/autostart

mkdir -p ~/.local/share/dermodex
cp ./scripts/* ~/.local/share/dermodex

cp -r ./theme/cinnamon/common-assets ~/.local/share/dermodex

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

gsettings set org.cinnamon.desktop.interface icon-theme "White-Icons"
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y"
gsettings set org.cinnamon.theme name "DermoDeX"
gsettings set org.cinnamon.desktop.notifications bottom-notifications "true"
gsettings set org.cinnamon.desktop.notifications display-notifications "true"

echo "[i] Adjusting The Height Of The Panels"
dconf write /org/cinnamon/panels-height "['1:60']"
dconf load /org/cinnamon/ < ./scripts/cinnamon_dd.txt

#dd_release&
#dd_wake&

if ! type "xdotool" > /dev/null 2>&1; then
    echo "[i] Hot Keys not installed"
    notify-send --urgency=normal --category=im.receieved --icon=help-info-symbolic "Hot Keys Tool not installed ..." "Run 'sudo apt install xdotool' to automate shortcuts such as CTRL+Alt+Esc"

    echo "[i] Press Ctrl+Alt+Esc to Refresh Your Desktop ..."
    sudo apt-get install -y -q xdotool
else
    xdotool key ctrl+alt+"Escape"
    echo "[i] Cinnamon Refreshed!"
fi

echo "[i] Install Complete"
echo ""
echo "Run dd_wake to wake DermoDeX before changing the wallpaper."
echo "Run dd_hold to keep your accent colors static when changing the wallpaper"
echo "Run dd-sleep to turn DermoDeX off for this session"

mkdir -p ~/.local/share/dermodex/common-assets/sounds/
cd ~/.local/share/dermodex/common-assets/sounds/
git clone https://github.com/coffeeking/linux-a11y-sound-theme.git

echo ""
echo "As a final step, a directory in /usr/share/backgrounds needs to be writeable to allow for blured login backgrounds"

sudo mkdir -p /usr/share/backgrounds/dermodex
sudo chmod a+rw /usr/share/backgrounds/dermodex

cd ~/
