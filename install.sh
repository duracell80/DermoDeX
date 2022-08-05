#!/bin/bash
#sudo apt install python3-pip

#pip3 install easydev
#pip3 install colormap
#pip3 install pandas
#pip3 install numpy
#pip3 install colorgram.py
#pip3 install extcolors
#pip3 install matplotlib
#pip3 install configparser

dconf dump /org/cinnamon/ > ~/cinnamon_desktop.backup

dd_sleep
CWD=$(pwd)

mkdir -p ~/.local/share/dermodex
mkdir -p ~/.themes/DermoDeX

# GRANULAR CONTROL OVER WHICH SUB THEMES TO COPY OVER
cp -r $CWD/theme/cinnamon ~/.themes/DermoDeX
cp -r $CWD/theme/gtk-2.0 ~/.themes/DermoDeX
cp -r $CWD/theme/gtk-3.0 ~/.themes/DermoDeX
cp -r $CWD/theme/gtk-3.20 ~/.themes/DermoDeX
cp -r $CWD/theme/metacity-1 ~/.themes/DermoDeX
cp -r $CWD/theme/openbox-3 ~/.themes/DermoDeX
cp -r $CWD/theme/unity ~/.themes/DermoDeX
cp -r $CWD/theme/xfwm4 ~/.themes/DermoDeX

cp -r $CWD/theme/index.theme ~/.themes/DermoDeX
#cp -r $CWD/theme/metadata.json ~/.themes/DermoDeX
#cp -r $CWD/theme/LICENSE ~/.themes/DermoDeX

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
cp -f ./scripts/dd_swatch.sh ~/.local/bin/dd_swatch
cp -f ./scripts/dex-notify.sh ~/.local/bin
cp -f ./scripts/dex-action.sh ~/.local/bin
cp -r ./nemo/actions/*.nemo_action ~/.local/share/nemo/actions
cp -r ./nemo/scripts/* ~/.local/share/nemo/scripts
cp -f ./*.desktop ~/.config/autostart


mkdir -p ~/.cache/dermodex/gtk-3.0
mkdir -p ~/.local/share/dermodex/gtk-3.0
mkdir -p ~/.local/share/dermodex/gtk-3.20/dist
chmod u+rw ~/.cache/dermodex/gtk-3.0
chmod u+rw ~/.local/share/dermodex/gtk-3.0

cp -r $CWD/theme/gtk-3.20/dist ~/.local/share/dermodex/gtk-3.20

cp ./scripts/* ~/.local/share/dermodex
touch ~/.local/share/dermodex/text_hover.txt
cp -r ./theme/cinnamon/common-assets ~/.local/share/dermodex
cp -r ./theme/gtk-3.0/assets ~/.local/share/dermodex/gtk-3.0
cp -r ./theme/gtk-3.0/assets ~/.cache/dermodex/gtk-3.0
cp -r ./theme/gtk-3.20/gtk.gresource ~/.local/share/dermodex/gtk-3.20
cp -r ./theme/icons ~/.local/share/dermodex/


if [ -d ~/Color-Icons ] ; then
    echo ""

else
    echo "[i] Installing Icons"

	cd ~/
	git clone --quiet https://github.com/wmk69/Color-Icons
	cd ~/Color-Icons
	tar -xvzf Color-Icons.tar.gz
	cp -r Color-Icons/White-Icons ~/.local/share/icons
	cp -r Color-Icons/Black-Icons ~/.local/share/icons
fi

mkdir -p ~/.local/share/icons/White-Icons/scalable
cp -rf $CWD/theme/icons/breeze-dark_white/places ~/.local/share/icons/White-Icons/scalable

gsettings set org.cinnamon.desktop.interface icon-theme "White-Icons"
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.wm.preferences theme "Mint-Y"
gsettings set org.cinnamon.theme name "Mint-Y-Dark-Aqua"
gsettings set org.cinnamon.desktop.notifications bottom-notifications "true"
gsettings set org.cinnamon.desktop.notifications display-notifications "true"

echo "[i] Adjusting The Height Of The Panels"
dconf load /org/cinnamon/ < ./scripts/cinnamon_dd.txt
dconf write /org/cinnamon/panels-height "['1:60']"

# Enhance user privacy
gsettings set org.cinnamon.desktop.privacy remember-recent-files "false"
gsettings set org.cinnamon.desktop.screensaver lock-enabled "true"
gsettings set org.cinnamon.desktop.screensaver lock-delay 0

#dd_release&
#dd_wake&

if ! type "xdotool" > /dev/null 2>&1; then
    echo "[i] Hot Keys not installed"
    notify-send --urgency=normal --category=im.receieved --icon=help-info-symbolic "Hot Keys Tool not installed ..." "Run 'sudo apt install xdotool' to automate shortcuts such as CTRL+Alt+Esc"

    echo "[i] Press Ctrl+Alt+Esc to Refresh Your Desktop ..."
    sudo apt-get install -y -q xdotool
else
    #xdotool key ctrl+alt+"Escape"
    echo "[i] Cinnamon is Ready to be reloaded by pressing CTRL+Alt+Esc!"
fi

echo "[i] Install Complete"
echo ""
echo "Run dd-wake to wake DermoDeX before changing the wallpaper."
echo "Run dd-hold to keep your accent colors static when changing the wallpaper"
echo "Run dd-sleep to turn DermoDeX off for this session"
echo
echo "Check the Startup Applications to toggle DermoDeX Monitor on/off at startup"
echo ""
echo "Login screen can be 'blured' using the login_blur.png file in ~/.local/share/dermodex. To do this search for Login Window in the Control Panel."

mkdir -p ~/.cache/dermodex/common-assets/sounds/
cd ~/.cache/dermodex/common-assets/sounds/
git clone --quiet https://github.com/coffeeking/linux-a11y-sound-theme.git

echo ""
echo "A directory in /usr/share/backgrounds needs to be writeable to allow for blured login backgrounds. A soft set of sounds from the linux-a11y sound theme project will also be dropped into the /usr/share/sounds directory. This too would need sudo to complete."
echo ""
echo ""

sudo mkdir -p /usr/share/backgrounds/dermodex
sudo chmod a+rw /usr/share/backgrounds/dermodex
sudo cp -fr ~/.cache/dermodex/common-assets/sounds/linux-a11y-sound-theme/linux-a11y/ /usr/share/sounds/


gsettings set org.cinnamon.sounds tile-file /usr/share/sounds/linux-a11y/stereo/window-switch.oga
gsettings set org.cinnamon.sounds plug-file /usr/share/sounds/linux-a11y/stereo/message-sent.oga
gsettings set org.cinnamon.sounds unplug-file /usr/share/sounds/linux-a11y/stereo/message.oga
gsettings set org.cinnamon.sounds close-file /usr/share/sounds/linux-a11y/stereo/tooltip-popup.oga
gsettings set org.cinnamon.sounds map-file /usr/share/sounds/linux-a11y/stereo/tooltip-popup.oga
gsettings set org.cinnamon.sounds minimize-file /usr/share/sounds/linux-a11y/stereo/window-minimized.oga
gsettings set org.cinnamon.sounds logout-file /usr/share/sounds/linux-a11y/stereo/desktop-logout.oga
gsettings set org.cinnamon.sounds maximize-file /usr/share/sounds/linux-a11y/stereo/window-minimized.oga
gsettings set org.cinnamon.sounds switch-file /usr/share/sounds/linux-a11y/stereo/menu-popup.oga
gsettings set org.cinnamon.sounds notification-file /usr/share/sounds/linux-a11y/stereo/window-attention.oga
gsettings set org.cinnamon.sounds notification-enabled "true"
gsettings set org.cinnamon.sounds unmaximize-file /usr/share/sounds/linux-a11y/stereo/window-minimized.oga
gsettings set org.cinnamon.sounds login-file /usr/share/sounds/linux-a11y/stereo/desktop-login.oga

rm -rf ~/.cache/dermodex/common-assets/sounds/linux-a11y-sound-theme

cd $CWD
#cd $CWD/deps

#echo ""
#echo "[i] Finally we need to install a theme customizer called themix (oomox), you may need to configure this with dpkg to get all the dependencies met. DermoDeX believes in you!"
#echo ""
#echo ""
#sudo dpkg -i oomox_1.13.3_18.10+.deb
#sudo apt --fix-broken install

dd_reload