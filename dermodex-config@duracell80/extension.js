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
        
        this.settings.bind('vibrancy', 'vibrancy', this.on_vibrancy_changed);
        this.settings.bind('saturation', 'saturation', this.on_saturation_changed);
        this.settings.bind('brightness', 'brightness', this.on_brightness_changed);
        this.settings.bind('contrast', 'contrast', this.on_contrast_changed);
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

