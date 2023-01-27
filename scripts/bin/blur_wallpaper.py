#!/usr/bin/env python3

import os, sys, getopt
from PIL import Image
from PIL import ImageFilter


def main(argv):
    
    wallpaper_file = str(os.popen('gsettings get org.cinnamon.desktop.background picture-uri').read()).replace("\n", "")
    wallpaper_file = wallpaper_file.replace("file://", "").replace("'", "")




    HOME = str(os.popen('echo $HOME').read()).replace('\n', '')
    os.system('mkdir -p ' + HOME +'/.local/share/dermodex')

    login_blur=100
    panel_blur=100

    img = Image.open(wallpaper_file)

    # Blur Copy
    img_gauss = img.filter(ImageFilter.GaussianBlur(int(login_blur)))
    img_panel = img.filter(ImageFilter.GaussianBlur(int(panel_blur)))
    img_gauss.save(HOME + '/.local/share/dermodex/login_blur.jpg')
    img_gauss.save(HOME + '/.local/share/dermodex/wallpaper_blur.jpg')
    img_panel.save(HOME + '/.local/share/dermodex/panel_blur.jpg')
    img_panel.save(HOME + '/.local/share/dermodex/panel_blur.png')
    img_panel.save(HOME + '/.local/share/dermodex/menu_blur.jpg')
    img_panel.save(HOME + '/.local/share/dermodex/menu_blur.png')

    print("[i] Rendering blurry version of current wallpaper complete! Look for " + HOME + "/.local/share/dermodex/wallpaper_blur.jpg")
    os.system('notify-send --urgency=normal --category=transfer.complete --icon=cs-backgrounds-symbolic "DermoDeX Blurry Panel" "Rendering complete! Look for '+ HOME +'/.local/share/dermodex/wallpaper_blur.jpg" to copy to use for the login screen.')
    
    os.system('cp '+ HOME +'/.local/share/dermodex/login_blur.jpg /usr/share/backgrounds/dermodex')



if __name__ == "__main__":
    main(sys.argv[1:])