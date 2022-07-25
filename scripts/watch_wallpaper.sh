mkdir -p $HOME/.cache/dermodex
touch $HOME/.cache/dermodex/wallpaper.jpg
touch $HOME/.cache/dermodex/wallpaper_swatch.jpg
touch $HOME/.cache/dermodex/resize_wallpaper.jpg
touch $HOME/.cache/dermodex/wallpaper_current.txt
touch $HOME/.cache/dermodex/bg.png


while true
do
 CUR=$(gsettings get org.cinnamon.desktop.background picture-uri)
 PAS=$(cat $HOME/.cache/dermodex/wallpaper_current.txt)
 if [ "$PAS" == "$CUR" ]; then
 	ACT="0"
 else
 	ACT="1"
	echo $CUR > $HOME/.cache/dermodex/wallpaper_current.txt
	python3 $HOME/GitHub/DermoDeX/scripts/colors.py
	notify-send --urgency=normal --category=im.received --icon=checkbox-checked-symbolic --hint=string:image-path:$HOME/.cache/dermodex/wallpaper_swatch.png "Cinnamon Wallpaper Updated" "\nCapturing colors from the new wallpaper!\n\n file://${HOME}/.cache/dermodex/wallpaper_swatch.png"
 fi
 sleep 10
done
