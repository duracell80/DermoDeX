#!/usr/bin/env python3

import sys, getopt, math
from PIL import ImageColor


def main(argv):
    arg_color   = "#3281ea"
    arg_colormix= "#cccccc"
    arg_factor  = float(0.5)
    arg_mode    = "hex"
    
    try:
        opts, args = getopt.getopt(argv,"h:c:d:f:m",["color=","colormix=","factor=","mode="])
    except getopt.GetoptError:
        print('remix_color.py -c <hexcolor> -d <hexcolortomix> -f <factor> -m <hex|rgb>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('remix_color.py -c <hexcolor> -d <hexcolortomix> -f <factor> -m <hex|rgb|mix>')
            sys.exit()
        elif opt in ("-c", "--color"):
            arg_color = str(arg)
        elif opt in ("-d", "--colormix"):
            arg_colormix = str(arg)
        elif opt in ("-f", "--factor"):
            arg_factor = float(arg)
        elif opt in ("-m", "--mode"):
            arg_mode = str(arg)
            
    if arg_mode == "mix":
        blended = blend_hex(arg_color,arg_colormix)
        print(str(blended))
    elif arg_mode == "rgb":
        print(get_rgb(colorscale(arg_color, arg_factor)))
    elif arg_mode == "balance":
        rgb_bits = str(get_rgb(arg_color)).split(",")
        print(isLightOrDark(int(rgb_bits[0]), int(rgb_bits[1]), int(rgb_bits[2])))
    else:
        print(colorscale(arg_color, arg_factor))



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


def clamp(val, minimum=0, maximum=255):
    if val < minimum:
        return minimum
    if val > maximum:
        return maximum
    return val

def get_rgb(h):
    rgb = str(ImageColor.getcolor(h, "RGB"))
    rgb = rgb.replace("(", "").replace(")", "").replace(" ", "")
    
    return rgb

def get_hex(r, g, b):
    return ('{:X}{:X}{:X}').format(r, g, b)


def blend_hex(colorRGBA1,colorRGBA2):
    rgb_bits1 = str(get_rgb(colorRGBA1)).split(",")
    rgb_bits2 = str(get_rgb(colorRGBA2)).split(",")
    #alpha = 255 - ((255 - int(rgb_bits1[2])) * (255 - int(rgb_bits2[2])) / 255)
    
    red   = (int(rgb_bits1[0]) * (255 - int(rgb_bits2[2])) + int(rgb_bits2[0]) * int(rgb_bits2[2])) / 255
    green = (int(rgb_bits1[1]) * (255 - int(rgb_bits2[2])) + int(rgb_bits2[1]) * int(rgb_bits2[2])) / 255
    blue  = (int(rgb_bits1[2]) * (255 - int(rgb_bits2[2])) + int(rgb_bits2[2]) * int(rgb_bits2[2])) / 255
    
    return ("#" + get_hex(int(red), int(green), int(blue)))

def colorscale(hexstr, scalefactor):
    """
    Scales a hex string by ``scalefactor``. Returns scaled hex string.

    To darken the color, use a float value between 0 and 1.
    To brighten the color, use a float value greater than 1.

    >>> colorscale("#DF3C3C", .5)
    #6F1E1E
    >>> colorscale("#52D24F", 1.6)
    #83FF7E
    >>> colorscale("#4F75D2", 1)
    #4F75D2
    """

    hexstr = hexstr.strip('#')

    if scalefactor < 0 or len(hexstr) != 6:
        return hexstr

    r, g, b = int(hexstr[:2], 16), int(hexstr[2:4], 16), int(hexstr[4:], 16)

    r = clamp(r * scalefactor)
    g = clamp(g * scalefactor)
    b = clamp(b * scalefactor)

    return "#%02x%02x%02x" % (int(r), int(g), int(b))



if __name__ == "__main__":
   main(sys.argv[1:])