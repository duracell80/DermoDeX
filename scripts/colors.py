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

import extcolors, colorsys
from colormap import rgb2hex, rgb2hls, hls2rgb




global cfg, cfg_colorcollect, cfg_pastel, cfg_vibrancy, cfg_tollerance, cfg_splitimage, cfg_splitfocus, cfg_override0, cfg_override1, cfg_override2

CONF_FILE = HOME + '/.local/share/dermodex/config.ini'

cfg = configparser.ConfigParser()
cfg.sections()
cfg.read(CONF_FILE)


cfg_colorcollect = str(cfg.get('dd_conf', 'colorcollect', fallback=8))
cfg_tollerance = int(cfg.get('dd_conf', 'tollerance', fallback=24))
cfg_override0 = str(cfg.get('colors', 'override0', fallback="none"))
cfg_override1 = str(cfg.get('colors', 'override1', fallback="none"))
cfg_override2 = str(cfg.get('colors', 'override2', fallback="none"))

cfg_saturation = str(cfg.get('dd_conf', 'saturation', fallback=1.2))
cfg_brightness = str(cfg.get('dd_conf', 'brightness', fallback=1.2))
cfg_contrast = str(cfg.get('dd_conf', 'contrast', fallback=1.1))
cfg_vibrancy = str(cfg.get('dd_conf', 'vibrancy', fallback=0.1))

cfg_splitimage = str(cfg.get('dd_conf', 'splitimage', fallback=2))
cfg_splitfocus = str(cfg.get('dd_conf', 'splitfocus', fallback="v2"))


cin_panelstyle = str(cfg.get('cinnamon', 'panelstyle', fallback="modern"))
cin_paneltrans = str(cfg.get('cinnamon', 'paneltrans', fallback=0.9))
cin_panellocat = str(cfg.get('cinnamon', 'panellocat', fallback="bottom"))
cin_panelblur = str(cfg.get('cinnamon', 'panelblur', fallback="true"))
panel_blur = str(cfg.get('cinnamon', 'pblur', fallback="100"))
login_blur = str(cfg.get('login', 'lblur', fallback="100"))

cin_textfactor = str(cfg.get('cinnamon', 'textfactor', fallback=0.9))
cin_menubckgrd = str(cfg.get('cinnamon', 'menubckgrd', fallback="true"))
cin_menuavatar = str(cfg.get('cinnamon', 'menuavatar', fallback="true"))
cin_flowcolors = str(cfg.get('cinnamon', 'flowcolors', fallback="false"))
  



def get_rgb(h):
    return ImageColor.getcolor(h, "RGB")

def get_rgb_strip(h):
    rgb_raw = str(ImageColor.getcolor(h, "RGB"))
    return rgb_raw.replace("(", "").replace(")", "").replace(" ", "")

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





# https://stackoverflow.com/questions/56729710/how-to-generate-dark-shades-of-hex-color-codes-in-python
def adjust_color_lightness(r, g, b, factor):
    h, l, s = rgb2hls(r / 255.0, g / 255.0, b / 255.0)
    l = max(min(l * factor, 1.0), 0.0)
    r, g, b = hls2rgb(h, l, s)
    return rgb2hex(int(r * 255), int(g * 255), int(b * 255))

def darken_color(r, g, b, factor=0.1):
    return adjust_color_lightness(r, g, b, float(1 - float(factor)))

def lighten_color(r, g, b, factor=0.1):
    return adjust_color_lightness(r, g, b, float(1 + float(factor)))

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
    imgpanel_pre = img.filter(ImageFilter.GaussianBlur(int(panel_blur)))
    imgpanel = adjust_brightness(imgpanel_pre, float("0.8"))
    imggauss.save(HOME + '/.local/share/dermodex/login_blur.jpg')
    imgpanel.save(HOME + '/.local/share/dermodex/panel_blur.jpg')
    img.save(HOME + '/.local/share/dermodex/wallpaper.jpg')
    img.save(HOME + '/Pictures/wallpaper.jpg')
    
    # Darken For Menu Blur
    if cin_menubckgrd == "true":
        wpercent = (int(output_width)/float(img.size[0]))
        hsize = int((float(img.size[1])*float(wpercent)))
        
        imgmenublur = adjust_brightness(imggauss, float("0.4"))
        imgmenu = imgmenublur.resize((int(output_width),hsize))
        imgmenu.save(HOME + '/.local/share/dermodex/menu_blur.jpg')
    
    
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
    
    print("\n\nDermoDeX found these colors in the image: ")
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
        new_hex = "#" + str(get_hex(int(list_bits[0]), int(list_bits[1]), int(list_bits[2])))
        
        if new_hex.lower() == "#ffffff":
            list_hex.append(list_color[0])
        else:
            list_hex.append(new_hex)
    
    
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
    
    #ax2.text(x = 150, y = -350, s = "Main Shade: " + shade_hex, fontdict={'fontsize': 275})
    #ax2.text(x = 150, y = -200, s = "Shade1: " + list_hex[1] + " Shade2: " + list_hex[-1], fontdict={'fontsize': 190})

    
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

os.system('cp "'+ wallpaper_file +'" '+ HOME +'/.cache/dermodex/wallpaper.jpg')


extract_color(HOME +'/.cache/dermodex/wallpaper.jpg', 900, int(cfg_tollerance), 2.5, cfg_splitfocus)




config = configparser.ConfigParser()
config.read(CONF_FILE)


if list_hex[2].lower() == "#ffffff":
    shade1 = list_hex[0]
else:
    shade1 = list_hex[2]

if cfg_override1 != "aN":
    config.set('colors', 'savehex1', cfg_override1.replace("#", ""))
    shade1 = "#" + cfg_override1
    shade_txt = get_rgb(shade1)
    print(shade1)
else:
    shade_txt = get_rgb(shade1)
    
shade_1_bits = str(get_rgb(shade1)).replace("(", "").replace(")", "").split(",")
shade_1_lighter = lighten_color(int(shade_1_bits[0]), int(shade_1_bits[1]), int(shade_1_bits[2]), 0.2)
shade_1_darker  = darken_color(int(shade_1_bits[0]), int(shade_1_bits[1]), int(shade_1_bits[2]), 0.2)


if isLightOrDark(int(shade_1_bits[0]), int(shade_1_bits[1]), int(shade_1_bits[2])) == "light":
    #shade_1 = shade_1_darker
    shade_1 = list_hex[1]
elif isLightOrDark(int(shade_1_bits[0]), int(shade_1_bits[1]), int(shade_1_bits[2])) == "dark":
    #shade_1 = shade_1_lighter
    shade_1 = list_hex[2]
else:
    shade_1 = shade1


    
    
shade_2 = list_hex[-1]
shade_2_bits = str(get_rgb(shade_2)).replace("(", "").replace(")", "").split(",")
shade_2_lighter = lighten_color(int(shade_2_bits[0]), int(shade_1_bits[1]), int(shade_1_bits[2]), 0.2)
shade_2_darker  = darken_color(int(shade_2_bits[0]), int(shade_2_bits[1]), int(shade_2_bits[2]), 0.2)

if cin_flowcolors == "true":
    shade_2 = shade_1
else:
    shade_2 = shade_2

shade_hex_bits = str(get_rgb(shade_hex)).replace("(", "").replace(")", "").split(",")
shade_hex_lighter = lighten_color(int(shade_hex_bits[0]), int(shade_hex_bits[1]), int(shade_hex_bits[2]), 0.3)
shade_hex_darker  = darken_color(int(shade_hex_bits[0]), int(shade_hex_bits[1]), int(shade_hex_bits[2]), 0.5)

print("\n\nDermoDeX thinks these are some really great base colors: ")

print("- Shade0: " + shade_hex + " - rgb" + str(shade_rgb))
print("- Shade1: " + shade_1 + " - rgb" + str(get_rgb(shade_1)))
print("- Shade2: " + shade_2 + " - rgb" + str(get_rgb(shade_2)) + "\n\n")


# LOOK FOR OVERRIDES, IF SO THEN SET THOSE
if cfg_override0 != "aN":
    print("[i] Color Override Active for Shade 0: " + cfg_override0)
    config.set('colors', 'savehex0', cfg_override0.replace("#", ""))
else:
    config.set('colors', 'savehex0', shade_hex.replace("#", ""))
    
if cfg_override1 != "aN":
    print("[i] Color Override Active for Shade 1: " + cfg_override1)
    config.set('colors', 'savehex1', cfg_override1.replace("#", ""))
else:
    config.set('colors', 'savehex1', shade_1.replace("#", ""))

if cfg_override2 != "aN":
    print("[i] Color Override Active for Shade 2: " + cfg_override2)
    config.set('colors', 'savehex2', cfg_override1.replace("#", ""))
else:
    config.set('colors', 'savehex2', shade_2.replace("#", ""))



config.set('colors', 'savergb0', str(get_rgb_strip(shade_hex)))
config.set('colors', 'savergb1', str(get_rgb_strip(shade_1)))
config.set('colors', 'savergb2', str(get_rgb_strip(shade_2)))

print("\n")



config.set('cinnamon', 'background', wallpaper_file)
    
with open(CONF_FILE, 'w') as configfile:
    config.write(configfile)    
    

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