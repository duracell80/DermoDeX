#!/bin/bash


CINN_VERSION=$(cinnamon --version)

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

# SYMLINK WALLPAPERS TO PICTURES WITHOUT COPYING WALLPAPERS ACROSS
simlink? () {
  test "$(readlink "${1}")";
}

FILE=~/Pictures/DermoDeX

if simlink? "${FILE}"; then
  echo " "
else
  echo "[i] Creating DermoDex Symlink in Pictures"
  ln -s ~/.local/share/dermodex/wallpapers ~/Pictures/DermoDeX
  echo "$HOME/Pictures/DermoDeX" >> "$HOME/.cinnamon/backgrounds/user-folders.lst"
fi

# COPY OVER THE EXTENSION
mkdir -p ~/.local/share/cinnamon/extensions/dermodex-config@duracell80
cp -r extension/dermodex-config@duracell80/files/* ~/.local/share/cinnamon/extensions/dermodex-config@duracell80


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

cp -f ./scripts/cinnamon_base.css ~/.local/share/dermodex
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

cp -r $CWD/theme/gtk-3.0/colors.css ~/.local/share/dermodex/gtk-3.0
cp -r $CWD/theme/gtk-3.20/dist ~/.local/share/dermodex/gtk-3.20
cp ./scripts/watch_sounds.sh ~/.local/share/dermodex
cp ./scripts/watch_wallpaper.sh ~/.local/share/dermodex
cp ./scripts/cinnamon_dd.txt ~/.local/share/dermodex
cp ./scripts/config_update.py ~/.local/share/dermodex
cp ./scripts/*.ini ~/.local/share/dermodex
cp ./scripts/colors.py ~/.local/share/dermodex
touch ~/.local/share/dermodex/text_hover.txt
cp -r ./theme/cinnamon/common-assets ~/.local/share/dermodex

mkdir -p ~/.local/share/dermodex/wallpapers
cp -r ./theme/cinnamon/wallpapers ~/.local/share/dermodex



cp -r ./theme/gtk-3.0/assets ~/.local/share/dermodex/gtk-3.0
cp -r ./theme/gtk-3.0/assets ~/.cache/dermodex/gtk-3.0
cp -r ./theme/gtk-3.20/gtk.gresource ~/.local/share/dermodex/gtk-3.20
cp -r ./theme/icons ~/.local/share/dermodex/
cp -r ./theme/cinnamon/common-assets/user-avatar.png ~/.local/share/dermodex/


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

# gsettings set org.cinnamon.desktop.interface text-scaling-factor "1"

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

echo ""
echo ""
echo "[i] Cinnamon Version ${CINN_VERSION}"
echo ""
echo "[i] Install Complete"
echo ""
echo "Run dd-wake to wake DermoDeX before changing the wallpaper."
echo "Run dd-hold to keep your accent colors static when changing the wallpaper"
echo "Run dd-sleep to turn DermoDeX off for this session"
echo
echo "Check the Startup Applications to toggle DermoDeX Monitor on/off at startup"
echo ""
echo "Login screen can be 'blured' using the login_blur.png file in ~/.local/share/dermodex. To do this search for Login Window in the Control Panel."
echo ""

#mkdir -p ~/.cache/dermodex/common-assets/sounds/

    # SOUND - ZORIN
    sudo cp -fr $CWD/sounds/zorin/ /usr/share/sounds/
    sudo chmod -R a+rx /usr/share/sounds/zorin/
    
    # SOUND - X11
    sudo cp -fr $CWD/sounds/x11/ /usr/share/sounds/
    sudo chmod -R a+rx /usr/share/sounds/x11/
    
    # SOUND - MACOS
    sudo cp -fr $CWD/sounds/macos/ /usr/share/sounds/
    sudo chmod -R a+rx /usr/share/sounds/macos/
    
    # SOUND - MIUI
    sudo cp -fr $CWD/sounds/miui/ /usr/share/sounds/
    sudo chmod -R a+rx /usr/share/sounds/miui/
    
    # SOUND - DEEPIN
    sudo cp -fr $CWD/sounds/deepin/ /usr/share/sounds/
    sudo chmod -R a+rx /usr/share/sounds/deepin/
    
    # SOUND - Enchanted
    sudo cp -fr $CWD/sounds/enchanted/ /usr/share/sounds/
    sudo chmod -R a+rx /usr/share/sounds/enchanted/
    
    # SOUND - LINUX-A11Y
    sudo cp -fr $CWD/sounds/linux-a11y/ /usr/share/sounds/
    sudo chmod -R a+rx /usr/share/sounds/linux-a11y/
    
    # SOUND - LINUX-UBUNTU
    sudo cp -fr $CWD/sounds/linux-ubuntu/ /usr/share/sounds/
    sudo chmod -R a+rx /usr/share/sounds/linux-ubuntu/

if simlink? "${FILE}"; then
    echo "[i] DermoDeX Background Location and Sound Location Already Set"
else
    echo ""
    echo "[i] A directory in /usr/share/backgrounds needs to be writeable to allow for blured login backgrounds. A soft set of sounds from the linux-a11y sound theme project will also be dropped into the /usr/share/sounds directory. This too would need sudo to complete."
    echo ""
    echo ""
    
    #cd ~/.cache/dermodex/common-assets/sounds/
    #git clone --quiet https://github.com/coffeeking/linux-a11y-sound-theme.git
    
    sudo mkdir -p /usr/share/backgrounds/dermodex
    sudo chmod a+rw /usr/share/backgrounds/dermodex
    #sudo cp -fr ~/.cache/dermodex/common-assets/sounds/linux-a11y-sound-theme/linux-a11y/ /usr/share/sounds/

    
    # SOUND - LINUX-A11Y
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
    gsettings set org.cinnamon.sounds unmaximize-file /usr/share/sounds/linux-a11y/stereo/window-minimized.oga
    gsettings set org.cinnamon.sounds login-file /usr/share/sounds/linux-a11y/stereo/desktop-login.oga
    
    
    # SOUND - LINUX-UBUNTU
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/linux-ubuntu/question.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/linux-ubuntu/disconnect.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/linux-ubuntu/connect.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/linux-ubuntu/default.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/linux-ubuntu/default.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/linux-ubuntu/menu-popup.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/linux-a11y/stereo/desktop-logout.oga'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/linux-ubuntu/menu-popup.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/linux-ubuntu/default.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/linux-ubuntu/new-mail.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/linux-ubuntu/menu-popup.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/linux-a11y/stereo/desktop-login.oga'
    
    # SOUND - MACOS
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/macos/restore-up.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/macos/device-connect.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/macos/device-disconnect.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/macos/open.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/macos/close.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/macos/minimize.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/macos/logoff.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/macos/maximize.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/macos/close.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/macos/contact-online.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/macos/restore-down.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/macos/logon.ogg'
    
    # SOUND - ZORIN
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/zorin/stereo/button-pressed.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/zorin/stereo/device-added.oga'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/zorin/stereo/device-removed.oga'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/zorin/stereo/message.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/zorin/stereo/message.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/zorin/stereo/button-toggle-off.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/zorin/stereo/desktop-login.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/zorin/stereo/button-toggle-on.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/zorin/stereo/window-slide.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/zorin/stereo/message-new-instant.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/zorin/stereo/button-toggle-off.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/zorin/stereo/desktop-logout.ogg'
    
    # SOUND - x11
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/x11/stereo/system-ready.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/x11/stereo/device-added.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/x11/stereo/device-removed.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/x11/stereo/desktop-login.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/x11/stereo/message-new-instant.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/x11/stereo/camera-shutter.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/x11/stereo/complete.ogg'
    
    # SOUND - miui
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/miui/stereo/dialog-information.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/miui/stereo/power-plug.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/miui/stereo/power-unplug.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/miui/stereo/window-close.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/miui/stereo/window-close.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/miui/stereo/window-close.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/miui/stereo/device-removed.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/miui/stereo/window-close.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/miui/stereo/count-down.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/miui/stereo/message-sent-instant.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/miui/stereo/window-close.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/miui/stereo/device-added.ogg'
    
    # SOUND - deepin
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/deepin/dialog-error-critical.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/deepin/device-added.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/deepin/device-removed.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/deepin/power-unplug.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/deepin/audio-volume-change.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/deepin/dialog-error-serious.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/deepin/system-shutdown.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/deepin/dialog-error-serious.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/deepin/audio-volume-change.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/deepin/suspend-resume.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/deepin/dialog-error-serious.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/deepin/desktop-login.ogg'
    
    # SOUND - enchanted
    #gsettings set org.cinnamon.sounds tile-file '/usr/share/sounds/enchanted/bell.ogg'
    #gsettings set org.cinnamon.sounds plug-file '/usr/share/sounds/enchanted/dialog-question.ogg'
    #gsettings set org.cinnamon.sounds unplug-file '/usr/share/sounds/enchanted/dialog-error.ogg'
    #gsettings set org.cinnamon.sounds close-file '/usr/share/sounds/enchanted/button-released.ogg'
    #gsettings set org.cinnamon.sounds map-file '/usr/share/sounds/enchanted/menu-replace.ogg'
    #gsettings set org.cinnamon.sounds minimize-file '/usr/share/sounds/enchanted/window-minimized.ogg'
    #gsettings set org.cinnamon.sounds logout-file '/usr/share/sounds/enchanted/button-toggle-on.ogg'
    #gsettings set org.cinnamon.sounds maximize-file '/usr/share/sounds/enchanted/window-maximized.ogg'
    #gsettings set org.cinnamon.sounds switch-file '/usr/share/sounds/enchanted/window-switch.ogg'
    #gsettings set org.cinnamon.sounds notification-file '/usr/share/sounds/enchanted/message-sent-instant.ogg'
    #gsettings set org.cinnamon.sounds unmaximize-file '/usr/share/sounds/enchanted/window-unmaximized.ogg'
    #gsettings set org.cinnamon.sounds login-file '/usr/share/sounds/enchanted/system-ready.ogg'
    
fi

gsettings set org.cinnamon.sounds notification-enabled "true"




#rm -rf ~/.cache/dermodex/common-assets/sounds/linux-a11y-sound-theme

cd $CWD
#cd $CWD/deps

#echo ""
#echo "[i] Finally we need to install a theme customizer called themix (oomox), you may need to configure this with dpkg to get all the dependencies met. DermoDeX believes in you!"
#echo ""
#echo ""
#sudo dpkg -i oomox_1.13.3_18.10+.deb
#sudo apt --fix-broken install

dd_reload
