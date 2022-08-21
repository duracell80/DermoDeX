# DermoDeX - Mint 20
Linux Mint Cinnamon Theme Engine

DermoDeX is a dynamic cinnamon theme that responds to the currently selected background wallpaper. It uses a function based python script to determin not the main color in a wallpaper but a color that may be considered an accent. For example in an image of the milkyway with brown mountains in the forground, DermoDeX will attempt to extract a color that would be complimentary to the image.

This accent color is then passed to the cinnamon.css and the gtk stylesheets too.

DermoDeX tries to remain active for only 15 minutes at a time and directly after boot because changes to wallpapers don't happen all that often.

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
The image processing with python may produce a stylesheet that can crash Cinnamon, when using the brightness and contrast sliders. For example using a very bright background or a background with not a lot of color variation may result in a narrow color selection. The routines do detect #ffffff which can be problematic for things like menu hover backgrounds. There are also routines to detect if the text color needs inverting at cerrtain shades.
