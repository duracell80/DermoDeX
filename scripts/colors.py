# Credits:
# Matplotlib https://towardsdatascience.com/image-color-extraction-with-python-in-4-steps-8d9370d9216e
# OpenCV https://medium.com/programming-fever/color-detection-using-opencv-python-6eec8dcde8c7
# Sorting Colors: https://www.alanzucconi.com/2015/09/30/colour-sorting/


# medium@borih.k
# medium@programming-fever
# stackoverflow@Aidan
# github@duracell80

import os, math, configparser

global HOME
HOME = str(os.popen('echo $HOME').read()).replace('\n', '')

    
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import matplotlib.image as mpimg

from PIL import Image
from PIL import ImageColor
from matplotlib.offsetbox import OffsetImage, AnnotationBbox

#import cv2
import extcolors, colorsys
from colormap import rgb2hex












global cfg, cfg_colorcollect, cfg_pastel, cfg_tollerance, override1, override2, override3
cfg = configparser.ConfigParser()
cfg.sections()
cfg.read(HOME + '/.local/share/dermodex/config.ini')


try:
    cfg['dd_conf']['colorcollect']
except KeyError:
    cfg_colorcollect = int("13")
else:
    cfg_colorcollect = int(cfg['dd_conf']['colorcollect'])

    
try:
    cfg['dd_conf']['pastel']
except KeyError:
    cfg_pastel = float("0.15")
else:
    cfg_pastel = float(cfg['dd_conf']['pastel'])
    

try:
    cfg['dd_conf']['tollerance']
except KeyError:
    cfg_tollerance = int("30")
else:
    cfg_tollerance = int(cfg['dd_conf']['tollerance'])
    

try:
    cfg['dd_conf']['override1']
except KeyError:
    cfg_override1 = str("#744976")
else:
    cfg_override1 = str(cfg['dd_conf']['override1'])   
    
try:
    cfg['dd_conf']['override2']
except KeyError:
    cfg_override2 = str("#744976")
else:
    cfg_override2 = str(cfg['dd_conf']['override2'])

try:
    cfg['dd_conf']['override3']
except KeyError:
    cfg_override3 = str("#744976")
else:
    cfg_override3 = str(cfg['dd_conf']['override3'])    


def get_rgb(h):
    return ImageColor.getcolor(h, "RGB")

def get_hex(r, g, b):
    
    # helper function
    def help(c):
        if c<0: return 0
        if c>255: return 255
        return c
    
    # make sure that values are within bounds
    r = help(r)
    g = help(g)
    b = help(b)
    
    # convert to hex
    # maintain 2 spaces each
    val = "%02x%02x%02x" % (r, g, b)
    
    # return UpperCase string
    return val.upper()

def get_lum(r,g,b):
    return math.sqrt( .241 * r + .691 * g + .068 * b )

def step (r,g,b, repetitions=4):
    lum = math.sqrt( .241 * r + .691 * g + .068 * b )

    h, s, v = colorsys.rgb_to_hsv(r,g,b)

    h2 = int(h * repetitions)
    lum2 = int(lum * repetitions)
    v2 = int(v * repetitions)

    if h2 % 2 == 1:
        v2 = repetitions - v2
        lum = repetitions - lum

    return (h2, lum, v2)

#https://stackoverflow.com/questions/141855/programmatically-lighten-a-color
def lighten_color(hex, amount):
    """ Lighten an RGB color by an amount (between 0 and 1),

    e.g. lighten('#4290e5', .5) = #C1FFFF
    """
    hex = hex.replace('#','')
    red = min(255, int(hex[0:2], 16) + 255 * amount)
    green = min(255, int(hex[2:4], 16) + 255 * amount)
    blue = min(255, int(hex[4:6], 16) + 255 * amount)
    return "#%X%X%X" % (int(red), int(green), int(blue))

def color_to_df(input):
    colors_pre_list = str(input).replace('([(','').split(', (')[0:-1]
    df_rgb = [i.split('), ')[0] + ')' for i in colors_pre_list]
    df_percent = [i.split('), ')[1].replace(')','') for i in colors_pre_list]
    
    #convert RGB to HEX code
    df_color_up = [rgb2hex(int(i.split(", ")[0].replace("(","")),
                          int(i.split(", ")[1]),
                          int(i.split(", ")[2].replace(")",""))) for i in df_rgb]
    
    df = pd.DataFrame(zip(df_color_up, df_percent), columns = ['c_code','occurence'])
    return df


def exact_color(input_image, resize, tolerance, zoom):
    #background
    bg = HOME + '/.cache/dermodex/bg.png'
    fig, ax = plt.subplots(figsize=(192,108),dpi=10)
    fig.set_facecolor('white')
    plt.savefig(bg)
    plt.close(fig)
    
    #resize
    output_width = resize
    img = Image.open(input_image)
    if img.size[0] >= resize:
        wpercent = (output_width/float(img.size[0]))
        hsize = int((float(img.size[1])*float(wpercent)))
        img = img.resize((output_width,hsize))
        resize_name = HOME + '/.cache/dermodex/resize_'+ input_image.replace(HOME + '/.cache/dermodex/', '')
        img.save(resize_name)
    else:
        resize_name = input_image
    
    #crate dataframe
    img_url = resize_name
    colors_x = extcolors.extract_from_path(img_url, tolerance = cfg_tollerance, limit = cfg_colorcollect)
    df_color = color_to_df(colors_x)

    
    #annotate text
    list_color = list(df_color['c_code'])
    length = len(list_color)
    
    
    
    global list_rgb
    global list_hex
    global shade_rgb
    global shade_hex
    
    list_rgb=[]
    list_hex=[]
    
    for i in range(length):
        r, g, b = get_rgb(list_color[i])
        list_rgb.append([r, g, b])
        
    #list_rgb.sort(key=lambda rgb: get_lum(*rgb))
    list_rgb.sort(key=lambda rgb: step(*rgb))
    for i in range(length):
        list_bits = str(list_rgb[i]).replace("[", "").replace("]", "").split(",")
        new_hex = str(lighten_color(get_hex(int(list_bits[0]), int(list_bits[1]), int(list_bits[2])), float(cfg_pastel)))
        list_hex.append(new_hex)
    
    
    shade_hex = str(lighten_color(list_color[0], float(cfg_pastel)))
    shade_rgb = str(get_rgb(shade_hex))
    
    
    os.system('rm -rf '+ HOME +'/.cache/dermodex/colors_hex.txt')
    os.system('touch '+ HOME +'/.cache/dermodex/colors_hex.txt')
    os.system('rm -rf '+ HOME +'/.cache/dermodex/colors_rgb.txt')
    os.system('touch '+ HOME +'/.cache/dermodex/colors_rgb.txt')
    
    os.system('echo "' + shade_hex + '" > '+ HOME +'/.cache/dermodex/colors_hex.txt')
    os.system('echo "' + shade_rgb + '" > '+ HOME +'/.cache/dermodex/colors_rgb.txt')
    for i in range(length):
        os.system('echo "' + list_hex[i] + '" >> '+ HOME +'/.cache/dermodex/colors_hex.txt')
        os.system('echo "' + str(get_rgb(list_hex[i])) + '" >> '+ HOME +'/.cache/dermodex/colors_rgb.txt')
    
    
    list_precent = [int(i) for i in list(df_color['occurence'])]
    text_c = [c + ' ' + str(round(p*100/sum(list_precent),1)) +'%' for c, p in zip(list_color, list_precent)]
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(160,120), dpi = 10)
    
    #donut plot
    wedges, text = ax1.pie(list_precent,
                           labels= text_c,
                           labeldistance= 1.05,
                           colors = list_color,
                           textprops={'fontsize': 150, 'color':'black'})
    plt.setp(wedges, width=0.3)

    #add image in the center of donut plot
    img = mpimg.imread(resize_name)
    imagebox = OffsetImage(img, zoom=zoom)
    ab = AnnotationBbox(imagebox, (0, 0))
    ax1.add_artist(ab)
    
    #color palette
    x_posi, y_posi, y_posi2 = 160, -170, -170
    for c in list_color:
        if list_color.index(c) <= 5:
            y_posi += 180
            rect = patches.Rectangle((x_posi, y_posi), 360, 160, facecolor = c)
            ax2.add_patch(rect)
            ax2.text(x = x_posi+400, y = y_posi+100, s = c, fontdict={'fontsize': 190})
        else:
            y_posi2 += 180
            rect = patches.Rectangle((x_posi + 1000, y_posi2), 360, 160, facecolor = c)
            ax2.add_artist(rect)
            ax2.text(x = x_posi+1400, y = y_posi2+100, s = c, fontdict={'fontsize': 190})
    
    ax2.text(x = 150, y = -350, s = "Main Shade: " + shade_hex, fontdict={'fontsize': 275})
    if len(list_hex) < 2:
        ax2.text(x = 150, y = -200, s = "Shade1: " + list_hex[0] + " Shade2: " + list_hex[0], fontdict={'fontsize': 190})
    else:
        ax2.text(x = 150, y = -200, s = "Shade1: " + list_hex[1] + " Shade2: " + list_hex[-1], fontdict={'fontsize': 190})

    
    fig.set_facecolor('white')
    ax2.axis('off')
    bg = plt.imread(HOME + '/.cache/dermodex/bg.png')
    plt.imshow(bg)
    plt.tight_layout()
    plt.savefig(HOME + '/.cache/dermodex/wallpaper_swatch.png', transparent=False)
    os.system('cp '+ HOME +'/.cache/dermodex/wallpaper_swatch.png ~/Pictures')
    #return plt.show()
    return


wallpaper_file = str(os.popen('gsettings get org.cinnamon.desktop.background picture-uri').read()).replace("\n", "")
wallpaper_file = wallpaper_file.replace("file://", "").replace("'", "")

os.system('cp '+ wallpaper_file +' '+ HOME +'/.cache/dermodex/wallpaper.jpg')

exact_color(HOME +'/.cache/dermodex/wallpaper.jpg', 900, int(cfg_tollerance), 2.5)

if len(list_hex) < 2:
    print("Shade0: " + shade_hex + " - rgb" + str(shade_rgb))
    print("Shade1: " + list_hex[0] + " - rgb" + str(get_rgb(list_hex[0])))
    print("Shade2: " + list_hex[0] + " - rgb" + str(get_rgb(list_hex[0])))
else:
    print("Shade0: " + shade_hex + " - rgb" + str(shade_rgb))
    print("Shade1: " + list_hex[1] + " - rgb" + str(get_rgb(list_hex[1])))
    print("Shade2: " + list_hex[-1] + " - rgb" + str(get_rgb(list_hex[-1])))


os.system('rm -rf '+ HOME +'/.cache/dermodex/bg.jpg')
os.system('rm -rf '+ HOME +'/.cache/dermodex/wallpaper.jpg')
os.system('rm -rf '+ HOME +'/.cache/dermodex/resize_wallpaper.jpg')
