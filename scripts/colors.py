#!/usr/bin/env python3

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

from matplotlib.offsetbox import OffsetImage, AnnotationBbox

from PIL import Image
from PIL import ImageColor
from PIL import ImageEnhance
from PIL import ImageFilter


#import cv2
import extcolors, colorsys
from colormap import rgb2hex












global cfg, cfg_colorcollect, cfg_pastel, cfg_tollerance, cfg_splitimage, cfg_splitfocus, override1, override2, override3, RES_PRIMARY
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
    
try:
    cfg['dd_conf']['saturation']
except KeyError:
    cfg_saturation = str("0")
else:
    cfg_saturation = str(cfg['dd_conf']['saturation'])
    
try:
    cfg['dd_conf']['brightness']
except KeyError:
    cfg_brightness = str("0")
else:
    cfg_brightness = str(cfg['dd_conf']['brightness'])
    
try:
    cfg['dd_conf']['contrast']
except KeyError:
    cfg_contrast = str("0")
else:
    cfg_contrast = str(cfg['dd_conf']['contrast'])
    
try:
    cfg['dd_conf']['splitimage']
except KeyError:
    cfg_splitimage = str("2")
else:
    cfg_splitimage = str(cfg['dd_conf']['splitimage'])
    
    
try:
    cfg['dd_conf']['splitfocus']
except KeyError:
    cfg_splitfocus = str("v2")
else:
    cfg_splitfocus = str(cfg['dd_conf']['splitfocus'])    
    
try:
    cfg['cinnamon']['panelstyle']
except KeyError:
    cin_panelstyle = str("modern")
else:
    cin_panelstyle = str(cfg['cinnamon']['panelstyle'])
    
    
try:
    cfg['cinnamon']['paneltrans']
except KeyError:
    cin_paneltrans = str("0.85")
else:
    cin_paneltrans = str(cfg['cinnamon']['paneltrans'])

try:
    cfg['cinnamon']['panellocat']
except KeyError:
    cin_panellocat = str("bottom")
else:
    cin_panellocat = str(cfg['cinnamon']['panellocat'])    
    
try:
    cfg['cinnamon']['panelblur']
except KeyError:
    cin_panelblur = str("false")
else:
    cin_panelblur = str(cfg['cinnamon']['panelblur'])

try:
    cfg['cinnamon']['blur']
except KeyError:
    panel_blur = str("100")
else:
    panel_blur = str(cfg['cinnamon']['blur'])    
    
try:
    cfg['cinnamon']['textfactor']
except KeyError:
    cin_textfactor = str("1.0")
else:
    cin_textfactor = str(cfg['cinnamon']['textfactor'])
    
try:
    cfg['login']['blur']
except KeyError:
    login_blur = str("100")
else:
    login_blur = str(cfg['login']['blur'])

    
RES_PRIMARY = os.system('xrandr | grep -i "primary" | cut --delimiter=" " -f 4 | cut --delimiter="+" -f 1 | cut --delimiter="x" -f 2')




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

def get_step (r,g,b, repetitions=4):
    lum = math.sqrt( .241 * r + .691 * g + .068 * b )

    h, s, v = colorsys.rgb_to_hsv(r,g,b)

    h2 = int(h * repetitions)
    lum2 = int(lum * repetitions)
    v2 = int(v * repetitions)

    if h2 % 2 == 1:
        v2 = repetitions - v2
        lum = repetitions - lum

    return (h2, lum, v2)

# StackOverflow kardi-teknomo
def isLightOrDark(r,g,b):
    r = int(r)
    g = int(g)
    b = int(b)
    hsp = math.sqrt(0.299 * (r * r) + 0.587 * (g * g) + 0.114 * (b * b))
    if (hsp>127.5):
        return 'light'
    else:
        return 'dark'



# Saturation, Contrast and Brightness of the image (apply before analysing for colors)
def adjust_saturation(img, saturation_factor):
    enhancer = ImageEnhance.Color(img)
    img = enhancer.enhance(saturation_factor)
    return img

def adjust_contrast(img, contrast_factor):
    enhancer = ImageEnhance.Contrast(img)
    img = enhancer.enhance(contrast_factor)
    return img 

def adjust_brightness(img, brightness_factor):
    enhancer = ImageEnhance.Brightness(img)
    img = enhancer.enhance(brightness_factor)
    return img



#https://stackoverflow.com/questions/141855/programmatically-lighten-a-color
def lighten_color(hex, amount):
    """ Lighten an RGB color by an amount (between 0 and 1),

    e.g. lighten('#4290e5', .5) = #C1FFFF
    """
    if amount < 0.1:
        amount = 0.1
    if amount > 1:
        amount = 1
        
    hex = hex.replace('#','')
    red = min(255, int(hex[0:2], 16) + 255 * amount)
    green = min(255, int(hex[2:4], 16) + 255 * amount)
    blue = min(255, int(hex[4:6], 16) + 255 * amount)
    return "#%X%X%X" % (int(red), int(green), int(blue))


#https://stackoverflow.com/questions/64838050/how-to-split-an-image-horizontally-into-equal-sized-pieces
def save_crops(image_file, image_slices = 2):
    
    
    outputPath = HOME + "/.cache/dermodex/"
    im = Image.open(image_file)
    x_width, y_height = im.size
    outputFileFormat = "{0}{1}.jpg"
    baseName = "wallpaper_v"

    i=0
    edges = np.linspace(0, x_width, image_slices+1)
    for start, end in zip(edges[:-1], edges[1:]):
        box = (start, 0, end, y_height)
        io = im.crop(box)
        io.load()
        outputName = os.path.join(outputPath, outputFileFormat.format(baseName, i + 1))
        
        io.save(outputName, "JPEG")
        i+=1
        
    baseName = "wallpaper_h"

    i=0
    edges = np.linspace(0, y_height, image_slices+1)
    for start, end in zip(edges[:-1], edges[1:]):
        box = (0, start, y_height, end)
        io = im.crop(box)
        io.load()
        outputName = os.path.join(outputPath, outputFileFormat.format(baseName, i + 1))
        
        io.save(outputName, "JPEG")
        i+=1




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


def extract_color(input_image, resize, tolerance, zoom, crop_variant = "h_1"):
    # Background
    bg = HOME + '/.cache/dermodex/bg.png'
    fig, ax = plt.subplots(figsize=(192,108),dpi=10)
    fig.set_facecolor('white')
    plt.savefig(bg)
    plt.close(fig)
    
    # Open Image
    output_width = resize
    img = Image.open(input_image)

    # Blur Copy
    imggauss = img.filter(ImageFilter.GaussianBlur(int(login_blur)))
    imgpanel = img.filter(ImageFilter.GaussianBlur(int(panel_blur)))
    imggauss.save(HOME + '/.local/share/dermodex/login_blur.jpg')
    imgpanel.save(HOME + '/.local/share/dermodex/panel_blur.jpg')
    img.save(HOME + '/.local/share/dermodex/wallpaper.jpg')
    img.save(HOME + '/Pictures/wallpaper.jpg')
    
    # Crop Into Sections
    save_crops(HOME + '/.local/share/dermodex/wallpaper.jpg', int(cfg_splitimage))
    
    img = Image.open(HOME + '/.cache/dermodex/wallpaper_'+ str(crop_variant) +'.jpg')
    
    # Apply Filters
    if cfg_saturation != "0":
        img = adjust_saturation(img, float(cfg_saturation))

    if cfg_brightness != "0":
        img = adjust_brightness(img, float(cfg_brightness))

    if cfg_contrast != "0":
        img = adjust_contrast(img, float(cfg_contrast))
    
    #img.show()
    
    # Resize
    if img.size[0] >= resize:
        wpercent = (output_width/float(img.size[0]))
        hsize = int((float(img.size[1])*float(wpercent)))
        img = img.resize((output_width,hsize))
        resize_name = HOME + '/.cache/dermodex/resize_'+ input_image.replace(HOME + '/.cache/dermodex/', '')
        img.save(resize_name)
    else:
        resize_name = input_image
    
    # Create dataframe
    img_url = resize_name
    colors_x = extcolors.extract_from_path(img_url, tolerance = cfg_tollerance, limit = cfg_colorcollect)
    df_color = color_to_df(colors_x)

    
    # Annotate text
    list_color = list(df_color['c_code'])
    length = len(list_color)
    
    print(list_color)
    
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
    list_rgb.sort(key=lambda rgb: get_step(*rgb))
    for i in range(length):
        list_bits = str(list_rgb[i]).replace("[", "").replace("]", "").split(",")
        if float(cfg_pastel) != 0:
            new_hex = str(lighten_color(get_hex(int(list_bits[0]), int(list_bits[1]), int(list_bits[2])), float(cfg_pastel)))
        else:
            new_hex = "#" + str(get_hex(int(list_bits[0]), int(list_bits[1]), int(list_bits[2])))
        
        list_hex.append(new_hex)
    
    
    if float(cfg_pastel) != 0:
        shade_hex = str(lighten_color(list_color[0], float(cfg_pastel)))
    else:
        shade_hex = str(list_color[0])
    
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
    
    # Donut plot
    wedges, text = ax1.pie(list_precent,
                           labels= text_c,
                           labeldistance= 1.05,
                           colors = list_color,
                           textprops={'fontsize': 150, 'color':'black'})
    plt.setp(wedges, width=0.3)

    # Add image in the center of donut plot
    img = mpimg.imread(resize_name)
    imagebox = OffsetImage(img, zoom=zoom)
    ab = AnnotationBbox(imagebox, (0, 0))
    ax1.add_artist(ab)
    
    # Color palette
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
    os.system('cp '+ HOME +'/.local/share/dermodex/login_blur.jpg ~/Pictures/wallpaper_blur.jpg')
    os.system('cp '+ HOME +'/.local/share/dermodex/login_blur.jpg /usr/share/backgrounds/dermodex')
    #return plt.show()
    return


wallpaper_file = str(os.popen('gsettings get org.cinnamon.desktop.background picture-uri').read()).replace("\n", "")
wallpaper_file = wallpaper_file.replace("file://", "").replace("'", "")

os.system('cp '+ wallpaper_file +' '+ HOME +'/.cache/dermodex/wallpaper.jpg')




extract_color(HOME +'/.cache/dermodex/wallpaper.jpg', 900, int(cfg_tollerance), 2.5, cfg_splitfocus)










if len(list_hex) < 2:
    print("Shade0: " + shade_hex + " - rgb" + str(shade_rgb))
    print("Shade1: " + list_hex[0] + " - rgb" + str(get_rgb(list_hex[0])))
    print("Shade2: " + list_hex[0] + " - rgb" + str(get_rgb(list_hex[0])))
    shade_txt = get_rgb(list_hex[0])
    shade_1 = list_hex[0]
    
    shade_1_bits = str(get_rgb(list_hex[0])).replace("(", "").replace(")", "").split(",")
    shade_1_lighter = str(lighten_color(get_hex(int(shade_1_bits[0]), int(shade_1_bits[1]), int(shade_1_bits[0])), 0.1)) 
    
    shade_2 = shade_1
    shade_2_lighter = shade_1_lighter
    
    shade_hex_lighter = shade_hex_lighter
else:
    print("Shade0: " + shade_hex + " - rgb" + str(shade_rgb))
    print("Shade1: " + list_hex[1] + " - rgb" + str(get_rgb(list_hex[1])))
    print("Shade2: " + list_hex[-1] + " - rgb" + str(get_rgb(list_hex[-1])))
    shade_txt = get_rgb(list_hex[1])
    
    shade_1 = list_hex[1]
    shade_1_bits = str(get_rgb(list_hex[1])).replace("(", "").replace(")", "").split(",")
    shade_1_lighter = str(lighten_color(get_hex(int(shade_1_bits[0]), int(shade_1_bits[1]), int(shade_1_bits[2])), 0.1)) 
    
    shade_2 = list_hex[-1]
    shade_2_bits = str(get_rgb(list_hex[-1])).replace("(", "").replace(")", "").split(",")
    shade_2_lighter = str(lighten_color(get_hex(int(shade_2_bits[0]), int(shade_2_bits[1]), int(shade_2_bits[2])), 0.1))

    shade_hex_bits = str(get_rgb(shade_hex)).replace("(", "").replace(")", "").split(",")
    shade_hex_lighter = str(lighten_color(get_hex(int(shade_hex_bits[0]), int(shade_hex_bits[1]), int(shade_hex_bits[2])), 0.1))
    

tri = str(shade_txt).replace('(', '').replace(')', '').replace(' ', '').split(',')

if isLightOrDark(tri[0],tri[1],tri[2]) == "light":
    os.system('echo "dark" > ' + HOME + '/.local/share/dermodex/text_hover.txt')
    os.system('sed -i "s|--popmenu-color: #ffffff;|color: #000000;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    os.system('sed -i "s|--menu-text-selected-color: #202020;|color: #000000;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
else:
    os.system('echo "light" > ' + HOME + '/.local/share/dermodex/text_hover.txt')
    os.system('sed -i "s|--popmenu-color: #ffffff;|color: #ffffff;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    os.system('sed -i "s|--menu-text-selected-color: #202020;|color: #ffffff;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')

tri = str(get_rgb(shade_1)).replace('(', '').replace(')', '').replace(' ', '').split(',')
if isLightOrDark(tri[0],tri[1],tri[2]) == "dark":
    os.system('sed -i "s|--slider-active-background-color: #ffffff;|-slider-active-background-color: '+ shade_1_lighter +';|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
else:
    os.system('sed -i "s|--slider-active-background-color: #ffffff;|-slider-active-background-color: '+ shade_hex_lighter +';|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    
#os.system('rm -rf '+ HOME +'/.cache/dermodex/*.jpg')


# MAKE SOME CINNAMON TWEAKS

# TEXT SCALE
os.system('gsettings set org.cinnamon.desktop.interface text-scaling-factor "' + cin_textfactor +'"')

# PANNEL STYLE
if cin_panelstyle == "flat":
    print("[i] Panel Style: Flat")
    os.system('sed -i "s|--panel-border-radius : 32px;|border-radius : 0px;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    os.system('sed -i "s|--panel-background-color : transparent;|background-color : rgba(64, 64, 64, ' + cin_paneltrans + ');|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    os.system('sed -i "s|--panel-inner-background-color : rgba(64, 64, 64, 0.9);|background-color : transparent;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    os.system('sed -i "s|--panel-blur-background-color : rgba(64, 64, 64, 0.6);|background-color : rgba(64, 64, 64, 0);|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    
    os.system('sed -i "s|--panel-border-top : 10px solid transparent;|border-top : 0px solid transparent;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    os.system('sed -i "s|--panel-border-bottom : 10px solid transparent;|border-bottom : 0px solid transparent;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')   
    
else:
    print("[i] Panel Style: Modern")
    os.system('sed -i "s|--panel-border-radius : 32px;|border-radius : 32px;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    os.system('sed -i "s|--panel-background-color : transparent;|background-color : transparent;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    os.system('sed -i "s|--panel-inner-background-color : rgba(64, 64, 64, 0.9);|background-color : rgba(64, 64, 64, ' + cin_paneltrans + ');|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    os.system('sed -i "s|--panel-border-top : 10px solid transparent;|border-top : 10px solid transparent;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    os.system('sed -i "s|--panel-border-bottom : 10px solid transparent;|border-bottom : 10px solid transparent;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    
if cin_panelblur == "true":
    os.system('sed -i "s|background-image : url(/usr/share/backgrounds/dermodex/panel_blur.jpg);|background-image : url('+ HOME +'/.local/share/dermodex/panel_blur.jpg);|g" ' + HOME + '/.cache/dermodex/cinnamon.css')

    os.system('sed -i "s|--panel-blur-background-color : rgba(64, 64, 64, 0.6);|background-color : rgba(64, 64, 64, 0.6);|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    
    if cin_panellocat == "top" or cin_panellocat == "left" or cin_panellocat == "right":
        os.system('sed -i "s|--panel-blur-background-position: 0px -700px;|background-position: 0px 0px;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    else:
        os.system('sed -i "s|--panel-blur-background-position: 0px -700px;|--panel-blur-background-position: 0px -0px;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    
        
else:
    if float(cin_paneltrans) == 0:
        os.system('sed -i "s|--panel-blur-background-color : rgba(64, 64, 64, 0.6);|background-color : rgba(64, 64, 64, 0);|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    else:
        os.system('sed -i "s|--panel-blur-background-color : rgba(64, 64, 64, 0.6);|background-color : rgba(64, 64, 64, '+ str(cin_paneltrans) +');|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    
    os.system('sed -i "s|--panel-blur-background-position: 0px -700px;|background-position: 0px -1080px;|g" ' + HOME + '/.cache/dermodex/cinnamon.css')
    