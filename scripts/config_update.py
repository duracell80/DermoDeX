#!/usr/bin/env python3
# github@duracell80

import os, sys, subprocess, configparser, getopt



HOME = str(os.popen('echo $HOME').read()).replace('\n', '')
CONF_FILE = HOME + '/.local/share/dermodex/config.ini'


def main(argv):
    try:
        opts, args = getopt.getopt(argv,"h:s:k:v:",["section=","key=","value="])
    except getopt.GetoptError:
        print('conf_update.py -s <section> -k <key> -v <value>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print ('conf_update.py -s <section> -k <key> -v <value>')
            sys.exit()
        elif opt in ("-s", "--section"):
            cfg_section = arg
        elif opt in ("-k", "--key"):
            cfg_key = arg
        elif opt in ("-v", "--value"):
            cfg_value = arg


    config = configparser.ConfigParser()
    config.read(CONF_FILE)
    config.set(cfg_section, cfg_key, cfg_value)
    
    with open(CONF_FILE, 'w') as configfile:
        config.write(configfile)
        
    if "override3" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_icons.sh "#' + cfg_value + '" icons');
        
    if "override4" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_icons.sh "#' + cfg_value + '" folders');
    
    if "mintpaper" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_wallpapers.sh ' + cfg_key.lower() + ' ' + cfg_value.lower());
        
        
    if "soundtheme" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/watch_sounds.sh');
    if "soundnotification" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_sounds.sh notification ' + cfg_value);
        
        p = str(subprocess.Popen("gsettings get org.cinnamon.sounds notification-file", shell=True, stdout = subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]).strip()
        
        SOUNDFILE = p.replace('"', '').replace("'", "").replace("b/", "/").replace("\\n", "")
        os.system('play "' + SOUNDFILE + '"')
        
    if "panelblur" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    elif "panelstyle" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    elif "panelshade" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    elif "paneltrans" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    elif "menubckgrd" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    elif "menutrans" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    elif "menuavatar" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    elif "flowsidebar" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    elif "flowheaderbar" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    elif "flowcolorsmenu" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    elif "actiontheme" in cfg_key:
        os.system(HOME + '/.local/share/dermodex/remix_themes.sh');
    else:
        x=1+1
    
    
if __name__ == "__main__":
    main(sys.argv[1:])