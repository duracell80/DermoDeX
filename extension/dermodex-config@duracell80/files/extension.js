/* -*- mode: js2; js2-basic-offset: 4; indent-tabs-mode: nil -*- */

// DermoDeX Configuration: Configuration for the DermoDeX Scripts.
// Does not affect background dimming.

// Copyright (C) 2022 Lee Jordan

// This program is free software: you can redistribute it and/or m odify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// Author: Lee Jordan aka duracell80

const uuid = "dermodex-config@duracell80";
const ModalDialog = imports.ui.modalDialog;
const Settings = imports.ui.settings;
let settings;

let ShellUtils;
if (typeof require !== 'undefined') {
    ShellUtils = require('./shellUtils');
} else {
    const ExtensionDirectory = imports.ui.extensionSystem.extensions[uuid];
    ShellUtils = ExtensionDirectory.shellUtils;
}



function DermoDeXSettings(uuid) {
    this._init(uuid);
    
    
}

DermoDeXSettings.prototype = {
    _init: function(uuid) {
        this.settings = new Settings.ExtensionSettings(this, uuid);
        
        this.settings.bindProperty(Settings.BindingDirection.IN, 'vibrancy', 'vibrancy', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'saturation', 'saturation', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'brightness', 'brightness', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'contrast', 'contrast', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'mainshade', 'mainshade', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'soundtheme', 'soundtheme', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'soundnotification', 'soundnotification', null);
        
        this.settings.bindProperty(Settings.BindingDirection.IN, 'panelstyle', 'panelstyle', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'panelshade', 'panelshade', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'paneltrans', 'paneltrans', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'panellocat', 'panellocat', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'menutrans', 'menutrans', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'menubckgrd', 'menubckgrd', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'menuavatar', 'menuavatar', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'flowcolors', 'flowcolors', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'flowcolorsmenu', 'flowcolorsmenu', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'flowsidebar', 'flowsidebar', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'flowicons', 'flowicons', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'colorcollect', 'colorcollect', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'splitimage', 'splitimage', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'splitfocus', 'splitfocus', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'splitdirection', 'splitdirection', null);
        
        this.settings.bindProperty(Settings.BindingDirection.IN, 'pblur', 'pblur', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'lblur', 'lblur', null);
        
        
        this.settings.bindProperty(Settings.BindingDirection.IN, 'coloroverrides', 'coloroverrides', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'override0', 'override0', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'override1', 'override1', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'override2', 'override2', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'override3', 'override3', null);
        
        this.settings.bindProperty(Settings.BindingDirection.IN, 'mintpaper', 'mintpaper', null);
        
        
        
        
        this.settings.bind('vibrancy', 'vibrancy', this.on_vibrancy_changed);
        this.settings.bind('saturation', 'saturation', this.on_saturation_changed);
        this.settings.bind('brightness', 'brightness', this.on_brightness_changed);
        this.settings.bind('contrast', 'contrast', this.on_contrast_changed);
        this.settings.bind('soundtheme', 'soundtheme', this.on_soundtheme_changed);
        this.settings.bind('soundnotification', 'soundnotification', this.on_soundnotification_changed);
        this.settings.bind('mainshade', 'mainshade', this.on_mainshade_changed);
        this.settings.bind('colorcollect', 'colorcollect', this.on_colorcollect_changed);
        
        this.settings.bind('panelstyle', 'panelstyle', this.on_panelstyle_changed);
        this.settings.bind('panelshade', 'panelshade', this.on_panelshade_changed);
        this.settings.bind('paneltrans', 'paneltrans', this.on_paneltrans_changed);
        this.settings.bind('panellocat', 'panellocat', this.on_panellocat_changed);
        this.settings.bind('panelblur', 'panelblur', this.on_panelblur_changed);
        this.settings.bind('menutrans', 'menutrans', this.on_menutrans_changed);
        this.settings.bind('menubckgrd', 'menubckgrd', this.on_menubckgrd_changed);
        this.settings.bind('menuavatar', 'menuavatar', this.on_menuavatar_changed);
        this.settings.bind('flowcolors', 'flowcolors', this.on_flowcolors_changed);
        this.settings.bind('flowcolorsmenu', 'flowcolorsmenu', this.on_flowcolorsmenu_changed);
        this.settings.bind('flowsidebar', 'flowsidebar', this.on_flowsidebar_changed);
        this.settings.bind('flowicons', 'flowicons', this.on_flowicons_changed);
        this.settings.bind('splitimage', 'splitimage', this.on_splitimage_changed);
        this.settings.bind('splitfocus', 'splitfocus', this.on_splitfocus_changed);
        this.settings.bind('splitdirection', 'splitdirection', this.on_splitfocus_changed);
        
        this.settings.bind('pblur', 'pblur', this.on_pblur_changed);
        this.settings.bind('lblur', 'lblur', this.on_lblur_changed);
        
        this.settings.bind('coloroverrides', 'coloroverrides', this.on_coloroverrides_changed);
        this.settings.bind('override0', 'override0', this.on_override0_changed);
        this.settings.bind('override1', 'override1', this.on_override1_changed);
        this.settings.bind('override2', 'override2', this.on_override2_changed);
        this.settings.bind('override3', 'override3', this.on_override3_changed);
        
        this.settings.bind('mintpaper', 'mintpaper', this.on_mintpaper_changed);
    },
    
    on_vibrancy_changed: function () {
        var cfg_vibrancy = this.settings.getValue('vibrancy')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'vibrancy', '-v' + cfg_vibrancy]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_saturation_changed: function () {
        var cfg_saturation = this.settings.getValue('saturation')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'saturation', '-v' + cfg_saturation]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_brightness_changed: function () {
        var cfg_brightness = this.settings.getValue('brightness')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'brightness', '-v' + cfg_brightness]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_contrast_changed: function () {
        var cfg_contrast = this.settings.getValue('contrast')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'contrast', '-v' + cfg_contrast]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_paneltrans_changed: function () {
        var cfg_paneltrans = this.settings.getValue('paneltrans')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'paneltrans', '-v' + cfg_paneltrans]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_menutrans_changed: function () {
        var cfg_menutrans = this.settings.getValue('menutrans')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'menutrans', '-v' + cfg_menutrans]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_panelblur_changed: function () {
        var cfg_panelblur = this.settings.getValue('panelblur')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'panelblur', '-v' + cfg_panelblur]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_menubckgrd_changed: function () {
        var cfg_menubckgrd = this.settings.getValue('menubckgrd')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'menubckgrd', '-v' + cfg_menubckgrd]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_flowcolors_changed: function () {
        var cfg_flowcolors = this.settings.getValue('flowcolors')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'flowcolors', '-v' + cfg_flowcolors]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_flowcolorsmenu_changed: function () {
        var cfg_flowcolorsmenu = this.settings.getValue('flowcolorsmenu')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'flowcolorsmenu', '-v' + cfg_flowcolorsmenu]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_flowsidebar_changed: function () {
        var cfg_flowsidebar = this.settings.getValue('flowsidebar')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'flowsidebar', '-v' + cfg_flowsidebar]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_flowicons_changed: function () {
        var cfg_flowicons = this.settings.getValue('flowicons')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'flowicons', '-v' + cfg_flowicons]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_menuavatar_changed: function () {
        var cfg_menuavatar = this.settings.getValue('menuavatar')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'menuavatar', '-v' + cfg_menuavatar]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_mainshade_changed: function () {
        var cfg_mainshade = this.settings.getValue('mainshade')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'mainshade', '-v' + cfg_mainshade]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_colorcollect_changed: function () {
        var cfg_colorcollect = this.settings.getValue('colorcollect')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'colorcollect', '-v' + cfg_colorcollect]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_splitimage_changed: function () {
        var cfg_splitimage = this.settings.getValue('splitimage')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'splitimage', '-v' + cfg_splitimage]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_panelstyle_changed: function () {
        var cfg_panelstyle = this.settings.getValue('panelstyle')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'panelstyle', '-v' + cfg_panelstyle]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_panelshade_changed: function () {
        var cfg_panelshade = this.settings.getValue('panelshade')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'panelshade', '-v' + cfg_panelshade]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_panellocat_changed: function () {
        var cfg_panellocat = this.settings.getValue('panellocat')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'panellocat', '-v' + cfg_panellocat]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_pblur_changed: function () {
        var cfg_pblur = this.settings.getValue('pblur')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'pblur', '-v' + cfg_pblur]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_lblur_changed: function () {
        var cfg_lblur = this.settings.getValue('lblur')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'login', '-k', 'lblur', '-v' + cfg_lblur]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_coloroverrides_changed: function () {
        var cfg_coloroverrides = this.settings.getValue('coloroverrides')
        var cfg_override0 = this.settings.getValue('override0')
        var cfg_override1 = this.settings.getValue('override1')
        var cfg_override2 = this.settings.getValue('override2')
        var cfg_override3 = this.settings.getValue('override3')
        
        
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'colors', '-k', 'coloroverrides', '-v' + cfg_coloroverrides]);
        let error = process.spawn_sync_and_get_error();
        
        
        if(cfg_coloroverrides == false) {
            let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'colors', '-k', 'override0', '-v' + 'none']);
            let error = process.spawn_sync_and_get_error();
            
            process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'colors', '-k', 'override1', '-v' + 'none']);
            error = process.spawn_sync_and_get_error();
            
            process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'colors', '-k', 'override2', '-v' + 'none']);
            error = process.spawn_sync_and_get_error();
            
            process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'colors', '-k', 'override3', '-v' + 'none']);
            error = process.spawn_sync_and_get_error();
            
            this.settings.setValue('override0', 'none');
            this.settings.setValue('override1', 'none');
            this.settings.setValue('override2', 'none');
            this.settings.setValue('override3', 'none');
            
        } else if(cfg_coloroverrides == true) {
            if(cfg_override0 == "aN"){
                cfg_override0 = "none";
            }
            if(cfg_override1 == "aN"){
                cfg_override1 = "none";
            }
            if(cfg_override2 == "aN"){
                cfg_override2 = "none";
            }
            if(cfg_override3 == "aN"){
                cfg_override3 = "none";
            }
            this.settings.setValue('override0', cfg_override0);
            this.settings.setValue('override1', cfg_override1);
            this.settings.setValue('override2', cfg_override2);
            this.settings.setValue('override3', cfg_override3);
            
        } else {
            cfg_coloroverrides = 'false';
        }
        
        
        
        
        
	},
    
    on_override0_changed: function () {
        var cfg_override0 = this.settings.getValue('override0')
        
        const rgba = cfg_override0.replace(/^rgba?\(|\s+|\)$/g, '').split(',');
        const hex = `${((1 << 24) + (parseInt(rgba[0]) << 16) + (parseInt(rgba[1]) << 8) + parseInt(rgba[2])).toString(16).slice(1)}`;
        
        if(hex == "aN"){
            hex = "none";
        }
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'colors', '-k', 'override0', '-v' + hex]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_override1_changed: function () {
        var cfg_override1 = this.settings.getValue('override1')
        
        const rgba = cfg_override1.replace(/^rgba?\(|\s+|\)$/g, '').split(',');
        const hex = `${((1 << 24) + (parseInt(rgba[0]) << 16) + (parseInt(rgba[1]) << 8) + parseInt(rgba[2])).toString(16).slice(1)}`;

        if(hex == "aN"){
            hex = "none";
        }
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'colors', '-k', 'override1', '-v' + hex]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_override2_changed: function () {
        var cfg_override2 = this.settings.getValue('override2')
        
        const rgba = cfg_override2.replace(/^rgba?\(|\s+|\)$/g, '').split(',');
        const hex = `${((1 << 24) + (parseInt(rgba[0]) << 16) + (parseInt(rgba[1]) << 8) + parseInt(rgba[2])).toString(16).slice(1)}`;
        
        if(hex == "aN"){
            hex = "none";
        }
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'colors', '-k', 'override2', '-v' + hex]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_override3_changed: function () {
        var cfg_override3 = this.settings.getValue('override3')
        
        const rgba = cfg_override3.replace(/^rgba?\(|\s+|\)$/g, '').split(',');
        const hex = `${((1 << 24) + (parseInt(rgba[0]) << 16) + (parseInt(rgba[1]) << 8) + parseInt(rgba[2])).toString(16).slice(1)}`;
        
        if(hex == "aN"){
            hex = "none";
        }
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'colors', '-k', 'override3', '-v' + hex]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_splitfocus_changed: function () {
        var cfg_splitimage = this.settings.getValue('splitimage')
        var cfg_splitdirection = this.settings.getValue('splitdirection')
        var cfg_splitfocus = this.settings.getValue('splitfocus')
        
        
        if(cfg_splitfocus > cfg_splitimage) {
            cfg_splitfocus = cfg_splitimage;
        }
        
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'splitfocus', '-v' + cfg_splitdirection + cfg_splitfocus]);
        let error = process.spawn_sync_and_get_error();
	},
    on_soundtheme_changed: function () {
        var cfg_soundtheme = this.settings.getValue('soundtheme')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'soundtheme', '-v' + cfg_soundtheme]);
        let error = process.spawn_sync_and_get_error();
	},
    on_soundnotification_changed: function () {
        var cfg_soundnotification = this.settings.getValue('soundnotification')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'soundnotification', '-v' + cfg_soundnotification]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_mintpaper_changed: function () {
        var cfg_mintpaper = this.settings.getValue('mintpaper')
        let process = new ShellUtils.ShellOutputProcess(['~/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'mintpaper', '-v' + cfg_mintpaper]);
        let error = process.spawn_sync_and_get_error();
	}
    
};

function init(extensionMeta) {
    settings = new DermoDeXSettings(extensionMeta.uuid);

}

function enable() {
    
    //let dialog_message = "Welcome to DermoDex, to get started read the introduction on github.com";
    //let dialog = new ModalDialog.NotifyDialog(dialog_message);
    //dialog.open();
}

function disable() {
    
}

