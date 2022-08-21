# DermoDeX - Linux Mint Desktop Experience
A Cinnamon Theme Engine built on Linux Mint 20

DermoDeX is a dynamic cinnamon theme that responds to the currently selected background wallpaper. It uses a function based python script to determine not quite the main color in a wallpaper but a color that may be considered an accent. For example in an image of the milkyway with brown mountains in the forground, DermoDeX will attempt to extract a color that would be complimentary to the image.

This accent color is then passed to the cinnamon.css using sed on a cinnamon_base.css file and the gtk stylesheets too. You can override the colors also!

## One Theme, Infinite Colors

![Winterball](https://raw.githubusercontent.com/duracell80/DermoDeX/master/deps/001.png)
The Una Winterball wallpaper

![Lush](https://raw.githubusercontent.com/duracell80/DermoDeX/master/deps/002.png)
The Una Lush wallpaper

## Main Features:
- Cinnamon Extention to tweak the configuration settings
- Privacy focused install script changes some cinnamon settings for enhanced privacy
- Accent color extraction from wallpaper
- Color picker overrides
- Desktop shortcuts
- Enhanced productivity with hot corners, expo in center and workspace switcher
- Panel configuration
- Panel and menu faux blur
- Login screen blur
- Complimentary icon install (Color Icons - White)
- Folder icon remix, replaces places icons with Breeze
- Several sound themes

## How to Install?
Run the install.sh script which runs most things as the current user, a few need sudo for example to transfer sounds to /usr/share/sounds and make /usr/share/backgrounds writable for the login image blur.

## How Does it Work?
DermoDex uses files in the ~/.local/share/dermodex directory to completly overrites the stylesheets and assets in the ~/.themes/DermoDeX directory when a change is detected. Is it Sass? Nope it's more like sed on steroids. It uses a series of Python functions to analyse a section of the wallpaper. By default this is the right half of the image since a lot of desktop wallpapers have a focus area in that part of the screen. A pallete and color wheel will appear in the notifcations area and shortly after cinnamon will be refreshed.

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

## Credits for Image Processing
- https://towardsdatascience.com/image-color-extraction-with-python-in-4-steps-8d9370d9216e
- https://www.alanzucconi.com/2015/09/30/colour-sorting/

- medium:borih.k
- medium:programming-fever
- stackoverflow:Aidan
- Many others on Stackoverflow and various other help forums


## Caution
The image processing with python may produce a stylesheet that can crash Cinnamon, when using the brightness and contrast sliders. For example using a very bright background or a background with not a lot of color variation may result in a narrow color selection. The routines do detect #ffffff which can be problematic for things like menu hover backgrounds. There are also routines to detect if the text color needs inverting at certain shades.

## Commit to Cinnamon Spices?
Nope, it looks like they favour stability which is understandable. These scripts can make a lot of significant changes to the environment. I wouldn't be confident in submitting DermoDeX to Spices though it offers a lot of inspiration for advanced themeing in Cinnamon.

## Mint 21?
Working on it, I haven't upgraded yet
