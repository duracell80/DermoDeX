touch ~/.cache/wallpaper_current.txt

while true
do
 CUR=$(gsettings get org.cinnamon.desktop.background picture-uri)
 PAS=$(cat ~/.cache/wallpaper_current.txt)
 if [ "$PAS" = "$CUR" ]; then
 	ACT="0"
 else
 	ACT="1"
	echo $CUR > ~/.cache/wallpaper_current.txt
	python3 ~/GitHub/DermoDeX/scripts/colors.py
	notify-send --urgency=normal --category=im.received --icon=checkbox-checked-symbolic --hint=string:image-path:/tmp/wallpaper_swatch.png "Cinnamon Wallpaper Updated" "\nCapturing colors from the new wallpaper!\n\n file:///tmp/wallpaper_swatch.png"
 fi
 sleep 10
done
