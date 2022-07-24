#!/bin/bash
dconf dump /org/cinnamon/ > ~/cinnamon_desktop_backup

echo "[i] Setting Up The Start Menu"
cp -r ./theme ~/.themes/DermoDeX
cp ~/.cinnamon/configs/menu@cinnamon.org/0.json ~/.cinnamon/configs/menu@cinnamon.org/0.json.bak
cp -f 0.json ~/.cinnamon/configs/menu@cinnamon.org/

if [ -d ~/Color-Icons ] ; then
# Things to do
echo ""

else
# Things to do
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
gsettings set org.cinnamon.theme name "DermoDeX"

echo "[i] Adjusting The Height Of The Panels"
dconf write /org/cinnamon/panels-height "['1:60']"

#clear
#echo "Attempting to refresh Cinnamon using xdotool. Install if not already installed ..."
#apt-get install -y -q xdotool
#clear
#xdotool key ctrl+alt+"Escape"
#clear
echo "[i] Press Ctrl+Alt+Esc to Refresh Your Desktop ..."
#echo "Cinnamon Refreshed!"
