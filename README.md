# DermoDeX - Linux Mint Desktop Experience
A Cinnamon Theme Engine built for Linux Mint

Newly updated for Mint 21 and WIP

This project could serve as inspiration for what might be possible to modernize cinnamon and came from noodling around with cinnamon as a front end dev, seeing what I could do. I figured I'd like to have this automation across devices and installs and to also level up with some wallpaper accent extraction.

DermoDeX is a dynamic cinnamon theme that responds to the currently selected background wallpaper (it can be set to auto detect changes for 15 minutes or you can right click the desktop to refresh). It uses a function based python script to determine not quite the main color in a wallpaper but a color that may be considered an accent. For example in an image of the milkyway with brown mountains in the foreground, DermoDeX will attempt to extract a color that would be complimentary to the image.

This accent color is then passed to the cinnamon.css using cat on a copy of the cinnamon.css file. The GTK stylesheets are also run through sed too. You can override the colors if there's a near miss with the extraction!

DermoDeX will also reshade icons and the GTK colors too.

## One Theme, Infinite Shades
![Screenshot](https://raw.githubusercontent.com/duracell80/DermoDeX/main/documentation/screens/brown.png)
![Screenshot](https://raw.githubusercontent.com/duracell80/DermoDeX/main/documentation/screens/blue.png)

This whole thing is work in progress and isn't gauranteed to work in your install at all. I do highly encourage reports since I only have the hardware I have, I may have not accounted for certain situations. I also need to get better at trying to run the main branch in a VM with a fresh mint install to see what dependencies may be missing.

## Main Features:
- Install previous Mint wallpapers from the offical packages! (why isn't this an option already?)
- Cinnamon Ext to tweak the configuration settings
- Now based on Fluent GTK theme
- Accent color extraction from wallpaper
- Color picker overrides
- Desktop shortcuts
- Enhanced productivity with hot corners, expo in center and workspace switcher
- Panel configuration (transparency sliders)
- Panel and menu faux blur
- Login screen blur
- Rofi based power menu and radio++ integration
- Complimentary icon install (Color and Royal-Z Icons)
- Folder icon remix, replaces places icons with Breeze
- Several sound themes (split into seperate repo)

To note, backup your /usr/share/sounds directory and if you use the Colors - White icon theme take a backup of that too. The sound themes I have created use modified index.theme files to enhance cinnamon sound theming. For example trash sounds work as do sound events for battery status and unplugging and replugging the power adapter. This requires adding modded sound themes into /usr/share/sounds for all users.

![Screenshot](https://raw.githubusercontent.com/duracell80/DermoDeX/main/documentation/screens/rofi-powermenu.png)
Add Super+S as a shortcut to dd_power

![Screenshot](https://raw.githubusercontent.com/duracell80/DermoDeX/main/documentation/screens/rofi-radio.png)
(Have the Radio++ applet installed) Add Super+R as a shortcut to dd_radio


## How to Install?
Run the install.sh script which runs most things as the current user, a few need sudo for example to transfer sounds to /usr/share/sounds and make /usr/share/backgrounds writable for the login image blur.

- Use the start menu or open the system settings panel and search for "extensions"
- Select the DermoDex Configuration item
- Click the plus icon to enable
- Click the settings icon or right click the desktop to open the configuration
- After making changes right click the desktop and select "DermoDeX - Refresh"

## How Does it Work?
DermoDex uses files in the ~/.local/share/dermodex directory to overwrite the stylesheets and assets in the ~/.themes/DermoDeX directory when a change is detected. The main scripts are more like sed on steroids; using a find and replace to rebuild a theme file. By default DermoDeX scans the right half of a wallpaper since a lot of desktop wallpapers have a focus area in that part of the screen. A pallete and color wheel will appear in the notifcations area and shortly after cinnamon will be refreshed.

If cinnamon doesn't refresh after about a minute or two; use the Ctrl+Alt+Esc shortcut.

There is also some inkscape stuff going on in the background to recolor the GTK assets which takes about 30 seconds on my hardware.

Directly after login DermoDeX will remain active for about 15 minutes if set to autostart in the Startup Applications (if not you can always right click the desktop and do a refresh after changing settings and/or changing the wallpaper). If it falls asleep you can right click on the desktop and refresh DermoDeX after changing the wallpaper.

Does it work when the slideshow of wallpapers is active? No that would be insane, cool but insane.

## Helpful Shortcuts
Press Alt+F2 to bring up the run box
- dd_wake (Wakes DermoDeX from slumber)
- dd_hold (Once you like the result, holding it means that changing the wallpaper again won't change the theme colors)
- dd_release (Release the color hold)
- dd_swatch (See what DermoDeX is seeing!)
- dd_reload (Attempts to rebuild the enitre theme and icons again from local copies and refresh cinnamon)
- dd_power (run the rofi powermenu with blurry background)

## Dependencies
- python3-pip
- configparser
- easydev
- numpy
- pandas
- matplotlib
- colormap
- extcolors
- colorgram
- libsass1 
- sassc 
- rofi 
- imagemagick 
- xz-utils 
- xdotool
- inkscape
- sox

## Credits for Image Processing
- https://towardsdatascience.com/image-color-extraction-with-python-in-4-steps-8d9370d9216e
- https://www.alanzucconi.com/2015/09/30/colour-sorting/

- medium:borih.k
- medium:programming-fever
- stackoverflow:Aidan
- Many others on Stackoverflow and various other help forums


## Caution
The image processing with python may produce a stylesheet that can crash Cinnamon (though I try to avoid this), when using the brightness and contrast sliders. For example using a very bright background or a background with not a lot of color variation may result in a narrow color selection. The routines do detect #ffffff which can be problematic for things like menu hover backgrounds. There are also routines to detect if the text color needs inverting at certain shades.

## Commit to Cinnamon Spices?
If asked, yeah I would love to have DermoDeX as Cinnamon Extension. For now it's a playground. It looks like they favour stability which is understandable. These scripts can make a lot of significant changes to the environment. The project offers a lot of inspiration for advanced themeing in Cinnamon.

## Mint 21?
Done and with Fluent there is at least a choice of two styles of window titlebar style (rounded, with mint style close icon or flat with windows style close icon).

## Excited? We should be yeah, we need these options
Yes messing with cinnamon this much is pretty scary, or freaking cool. You don't have to daily drive it, I do and I like the personalization it can bring. Try it in a VM before daily driving.
