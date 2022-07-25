mkdir -p $HOME/.cache/dermodex
touch $HOME/.cache/dermodex/wallpaper.jpg
touch $HOME/.cache/dermodex/wallpaper_swatch.png
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
	cp cinnamon_base.css $HOME/.cache/dermodex/cinnamon.css

	COS=$(tail -n 2 $HOME/.cache/dermodex/colors_rgb.txt | head -1 | rev | cut -c2- | rev)
 	COE=$(head -n 3 $HOME/.cache/dermodex/colors_rgb.txt | tail -1 | rev | cut -c2- | rev)

	sed -i "s|fav-background-gradient-end: rgba(0,0,0|background-gradient-end: rgba${COE}|g" $HOME/.cache/dermodex/cinnamon.css
	sed -i "s|fav-background-gradient-start: rgba(0,0,0|background-gradient-start: rgba${COS}|g" $HOME/.cache/dermodex/cinnamon.css
	cp $HOME/.cache/dermodex/cinnamon.css $HOME/.themes/DermoDeX/cinnamon
	notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic --hint=string:image-path:$HOME/.cache/dermodex/wallpaper_swatch.png "Cinnamon Wallpaper Updated" "\nCapturing colors from the new wallpaper. Restart Cinnamon with Alt+F2 then type r\n\nfile://${HOME}/.cache/dermodex/wallpaper_swatch.png"
 fi

 # Letting The Cables Sleep
 if [ "$(find $HOME/.cache/dermodex/wallpaper_current.txt -mmin +5)" == "" ]
 then
  sleep 10
 else
  # No Rush
  sleep 3600
 fi
done
