#!/usr/bin/env python3

import sys, getopt

def main(argv):
    arg_color   = "#3281ea"
    arg_factor  = float(0.5)
    
    try:
        opts, args = getopt.getopt(argv,"hc:f:",["color=","factor="])
    except getopt.GetoptError:
        print('remix_color.py -c <hexcolor> -f <factor>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('remix_color.py -c <hexcolor> -f <factor>')
            sys.exit()
        elif opt in ("-c", "--color"):
            arg_color = arg
        elif opt in ("-f", "--factor"):
            arg_factor = float(arg)
            
    print(colorscale(arg_color, arg_factor))





def clamp(val, minimum=0, maximum=255):
    if val < minimum:
        return minimum
    if val > maximum:
        return maximum
    return val

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