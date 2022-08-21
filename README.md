# DermoDeX - Mint 20
Linux Mint Cinnamon Theme Engine

DermoDeX is a dynamic cinnamon theme that responds to the currently selected background wallpaper. It uses a function based python script to determin not the main color in a wallpaper but a color that may be considered an accent. For example in an image of the milkyway with brown mountains in the forground, DermoDeX will attempt to extract a color that would be complimentary to the image.

This accent color is then passed to the cinnamon.css and the gtk stylesheets too. You can override the colors also!

## Main Features:
- Cinnamon Extention to tweak the configuration settings
- Accent color extraction from wallpaper
- Color picker overrides
- Desktop shortcuts
- Panel configuration
- Panel and menu faux Blur
- Complimentary icon install (Color Icons - White)
- Folder icon remix, replaces places icons with Breeze
- Several sound themes

## How Does it Work?
It uses a series of Python functions to analyse a section of the wallpaper. By default this is the right half of the image since a lot of desktop wallpapers have a focus area in that part of the screen. A pallete and color wheel will appear in the notifcations area and shortly after cinnamon will be refreshed.

Directly after login DermoDex will remain active for about 15 minutes. If it falls asleep you can right click on the desktop and refresh DermoDex after changing the wallpaper.

## Helpful shortcuts
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

## Caution
The image processing with python may produce a stylesheet that can crash Cinnamon, when using the brightness and contrast sliders. For example using a very bright background or a background with not a lot of color variation may result in a narrow color selection. The routines do detect #ffffff which can be problematic for things like menu hover backgrounds. There are also routines to detect if the text color needs inverting at certain shades.
