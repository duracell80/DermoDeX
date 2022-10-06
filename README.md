# DermoDeX - Linux Mint Desktop Experience
A Cinnamon Theme Engine built for Linux Mint

Newly updated for Mint 21

DermoDeX is a dynamic cinnamon theme that responds to the currently selected background wallpaper. It uses a function based python script to determine not quite the main color in a wallpaper but a color that may be considered an accent. For example in an image of the milkyway with brown mountains in the forground, DermoDeX will attempt to extract a color that would be complimentary to the image.

This accent color is then passed to the cinnamon.css using sed on a cinnamon_base.css file and the gtk stylesheets too. You can override the colors also!

## One Theme, Infinite Shades
![Screenshot](https://raw.githubusercontent.com/duracell80/DermoDeX/main/documentation/screens/brown.png)
![Screenshot](https://raw.githubusercontent.com/duracell80/DermoDeX/main/documentation/screens/blue.png)

Recolor your icons based on the wallpaper or color overrides, right click the desktop to get to DermoDeX - Configuration.

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

If cinnamon doesn't refresh use the Ctrl+Alt+Esc shortcut

Directly after login DermoDeX will remain active for about 15 minutes. If it falls asleep you can right click on the desktop and refresh DermoDeX after changing the wallpaper.

## Helpful Shortcuts
Press Alt+F2 to bring up the run box
- dd_wake (Forces a rebuild of the theme)
- dd_hold (Once you like the result, holding it means that changing the wallpaper again won't change the theme colors)
- dd_release (Release the color hold)
- dd_swatch (See what DermoDeX is seeing!)
- dd_reload (Attempts to refresh cinnamon and reheck the colors)

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
- scrot (possible not needed since I have blurring with python) 
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
