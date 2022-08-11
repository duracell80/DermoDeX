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
        
        this.settings.bindProperty(Settings.BindingDirection.IN, 'panelstyle', 'panelstyle', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'paneltrans', 'paneltrans', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'panellocat', 'panellocat', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'menubckgrd', 'menubckgrd', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'menuavatar', 'menuavatar', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'flipcolors', 'flipcolors', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'colorcollect', 'colorcollect', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'splitimage', 'splitimage', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'pblur', 'pblur', null);
        this.settings.bindProperty(Settings.BindingDirection.IN, 'lblur', 'lblur', null);
        
        this.settings.bind('vibrancy', 'vibrancy', this.on_vibrancy_changed);
        this.settings.bind('saturation', 'saturation', this.on_saturation_changed);
        this.settings.bind('brightness', 'brightness', this.on_brightness_changed);
        this.settings.bind('contrast', 'contrast', this.on_contrast_changed);
        this.settings.bind('mainshade', 'mainshade', this.on_mainshade_changed);
        this.settings.bind('colorcollect', 'colorcollect', this.on_colorcollect_changed);
        
        this.settings.bind('panelstyle', 'panelstyle', this.on_panelstyle_changed);
        this.settings.bind('paneltrans', 'paneltrans', this.on_paneltrans_changed);
        this.settings.bind('panellocat', 'panellocat', this.on_panellocat_changed);
        this.settings.bind('panelblur', 'panelblur', this.on_panelblur_changed);
        this.settings.bind('menubckgrd', 'menubckgrd', this.on_menubckgrd_changed);
        this.settings.bind('menuavatar', 'menuavatar', this.on_menuavatar_changed);
        this.settings.bind('flipcolors', 'flipcolors', this.on_flipcolors_changed);
        this.settings.bind('splitimage', 'splitimage', this.on_splitimage_changed);
        this.settings.bind('pblur', 'pblur', this.on_pblur_changed);
        this.settings.bind('lblur', 'lblur', this.on_lblur_changed);
    },
    
    on_vibrancy_changed: function () {
        var cfg_vibrancy = this.settings.getValue('vibrancy')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'vibrancy', '-v' + cfg_vibrancy]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_saturation_changed: function () {
        var cfg_saturation = this.settings.getValue('saturation')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'saturation', '-v' + cfg_saturation]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_brightness_changed: function () {
        var cfg_brightness = this.settings.getValue('brightness')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'brightness', '-v' + cfg_brightness]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_contrast_changed: function () {
        var cfg_contrast = this.settings.getValue('contrast')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'contrast', '-v' + cfg_contrast]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_paneltrans_changed: function () {
        var cfg_paneltrans = this.settings.getValue('paneltrans')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'paneltrans', '-v' + cfg_paneltrans]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_panelblur_changed: function () {
        var cfg_panelblur = this.settings.getValue('panelblur')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'panelblur', '-v' + cfg_panelblur]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_menubckgrd_changed: function () {
        var cfg_menubckgrd = this.settings.getValue('menubckgrd')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'menubckgrd', '-v' + cfg_menubckgrd]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_flipcolors_changed: function () {
        var cfg_flipcolors = this.settings.getValue('flipcolors')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'flipcolors', '-v' + cfg_flipcolors]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_menuavatar_changed: function () {
        var cfg_menuavatar = this.settings.getValue('menuavatar')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'menuavatar', '-v' + cfg_menuavatar]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_mainshade_changed: function () {
        var cfg_mainshade = this.settings.getValue('mainshade')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'mainshade', '-v' + cfg_mainshade]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_colorcollect_changed: function () {
        var cfg_colorcollect = this.settings.getValue('colorcollect')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'colorcollect', '-v' + cfg_colorcollect]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_splitimage_changed: function () {
        var cfg_splitimage = this.settings.getValue('splitimage')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'dd_conf', '-k', 'splitimage', '-v' + cfg_splitimage]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_panelstyle_changed: function () {
        var cfg_panelstyle = this.settings.getValue('panelstyle')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'panelstyle', '-v' + cfg_panelstyle]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_panellocat_changed: function () {
        var cfg_panellocat = this.settings.getValue('panellocat')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'panellocat', '-v' + cfg_panellocat]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_pblur_changed: function () {
        var cfg_pblur = this.settings.getValue('pblur')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'cinnamon', '-k', 'pblur', '-v' + cfg_pblur]);
        let error = process.spawn_sync_and_get_error();
	},
    
    on_lblur_changed: function () {
        var cfg_lblur = this.settings.getValue('lblur')
        let process = new ShellUtils.ShellOutputProcess(['/home/lee/.local/share/dermodex/config_update.py', '-s', 'login', '-k', 'lblur', '-v' + cfg_lblur]);
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

