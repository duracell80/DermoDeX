#!/usr/bin/env bash
mkdir -p $HOME/.cache/dermodex
touch $HOME/.cache/dermodex/wallpaper.jpg
touch $HOME/.cache/dermodex/wallpaper_swatch.png
touch $HOME/.cache/dermodex/resize_wallpaper.jpg
touch $HOME/.cache/dermodex/wallpaper_current.txt
touch $HOME/.cache/dermodex/bg.png
touch $HOME/.cache/dermodex/colors_hex.txt
touch $HOME/.cache/dermodex/colors_rgb.txt

if ! type "xdotool" > /dev/null 2>&1; then
	notify-send --urgency=normal --category=im.recieved --icon=help-info-symbolic "DermoDeX Color Extractor Active" "Looks for changes to the desktop wallpaper infrequently and upon reboot. DermoDeX reloads cinnamon with accent colors from that image! Press CTRL+Alt+Esc to reload the desktop environment."

else
	notify-send --urgency=normal --category=im.recieved --icon=help-info-symbolic "DermoDeX Color Extractor Active" "Looks for changes to the desktop wallpaper infrequently and upon reboot. DermoDeX reloads cinnamon with accent colors from that image! DermoDeX monitors the desktop wallpaper for accent colors for 15 minutes after launching."
fi

while true
do
 CUR=$(gsettings get org.cinnamon.desktop.background picture-uri)
 PAS=$(cat $HOME/.cache/dermodex/wallpaper_current.txt)

 if [ "$PAS" != "$CUR" ]; then
 	ACT="1"
    	echo $CUR > $HOME/.cache/dermodex/wallpaper_current.txt
	python3 $HOME/.local/share/dermodex/colors.py
	cp $HOME/.local/share/dermodex/cinnamon_base.css $HOME/.cache/dermodex/cinnamon.css

	COS=$(tail -n 2 $HOME/.cache/dermodex/colors_rgb.txt | head -1 | rev | cut -c2- | rev)
 	COE=$(head -n 2 $HOME/.cache/dermodex/colors_rgb.txt | tail -1 | rev | cut -c2- | rev)
    	HOS=$(tail -n 2 $HOME/.cache/dermodex/colors_hex.txt | head -1 | rev | cut -c1- | rev)
 	HOE=$(head -n 2 $HOME/.cache/dermodex/colors_hex.txt | tail -1 | rev | cut -c1- | rev)

	gsettings set org.cinnamon.desktop.background primary-color "${HOS}"
    	gsettings set org.cinnamon.desktop.background secondary-color "${HOE}"
    	gsettings set org.cinnamon.desktop.background color-shading-type "vertical"

    	CONF_SLIDESHOW=$(gsettings get org.cinnamon.desktop.background.slideshow slideshow-enabled)
    	CONF_SLIDETIME=$(gsettings get org.cinnamon.desktop.background.slideshow delay)
    	CONF_ASPECT=$(gsettings get org.cinnamon.desktop.background picture-options)

	sed -i "s|fav-background-gradient-end: rgba(0,0,0|background-gradient-end: rgba${COE}|g" $HOME/.cache/dermodex/cinnamon.css
	sed -i "s|fav-background-gradient-start: rgba(0,0,0|background-gradient-start: rgba${COS}|g" $HOME/.cache/dermodex/cinnamon.css
	cp $HOME/.cache/dermodex/cinnamon.css $HOME/.themes/DermoDeX/cinnamon
	notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic --hint=string:image-path:$HOME/.cache/dermodex/wallpaper_swatch.png "DermoDeX Recalculating Accent Colors!" "\nRestart Cinnamon with CTRL+Alt+Esc\n\nfile://${HOME}/.cache/dermodex/wallpaper_swatch.png"

	echo "[i] Updating Accent Colors ..."
	if ! type "xdotool" > /dev/null 2>&1; then
		echo "[i] Hot Keys not installed"
		notify-send --urgency=normal --category=im.receieved --icon=help-info-symbolic "Hot Keys Tool not installed ..." "Run 'sudo apt install xdotool' to automate shortcuts such as CTRL+Alt+Esc"
	else
		if [ "$(find $HOME/.cache/dermodex/wallpaper_current.txt -mmin +15)" != "" ]
 			UPT=$(uptime)
		then
			sleep 15
			xdotool key ctrl+alt+"Escape"
		fi
	fi

	# Workaround cinnamon 5.3 reloading with multiple monitors and making wallpaper aspect strange
    #sleep 7
    #gsettings set org.cinnamon.desktop.background picture-options "centered"
    #sleep 3
	#gsettings set org.cinnamon.desktop.background picture-options "zoom"



 else
	ACT="0"
 fi

 # Letting The Cables Sleep
 if [ "$(find $HOME/.cache/dermodex/wallpaper_current.txt -mmin +15)" != "" ]
 then
  echo "[i] DermoDex Color Extractor Less Active"
  UPT=$(uptime)
  notify-send.sh --action="Wake DermoDeX":~/.local/bin/dd_wake --urgency=normal --category=im.receieved --icon=help-info-symbolic "DermoDex is currently resting." "Changing your wallpaper at the moment will take a while to reflect in your accent colors. Logout and back in or reboot to wake up DermoDeX. You can also stop DermoDeX auto loading by searching for Startup Applications in the cinnamon menu. Your current system uptime is: ${UPT}"

  sleep 3600
 else
  # No Rush
  echo "[i] DermoDex Color Extractor More Active"
  sleep 10
 fi
done
