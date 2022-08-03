#!/usr/bin/env python3

import os, sys
from PIL import Image
from PIL import ImageFilter

if len(sys.argv) != 2:
    wallpaper_file = str(os.popen('gsettings get org.cinnamon.desktop.background picture-uri').read()).replace("\n", "")
    wallpaper_file = wallpaper_file.replace("file://", "").replace("'", "")
else:
    wallpaper_file = sys.argv[1]



HOME = str(os.popen('echo $HOME').read()).replace('\n', '')
os.system('mkdir -p ' + HOME +'/.local/share/dermodex')

login_blur=100
panel_blur=100

img = Image.open(wallpaper_file)

# Blur Copy
img_gauss = img.filter(ImageFilter.GaussianBlur(int(login_blur)))
img_panel = img.filter(ImageFilter.GaussianBlur(int(panel_blur)))
img_gauss.save(HOME + '/.local/share/dermodex/login_blur.jpg')
img_panel.save(HOME + '/.local/share/dermodex/panel_blur.jpg')

