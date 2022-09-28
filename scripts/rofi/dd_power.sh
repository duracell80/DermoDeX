#!/usr/bin/env bash

#
# Powermenu made with Rofi
# adapted from https://github.com/lu0

show_usage() {
    echo -e "\nTrigger a blurry powermenu made with rofi."
    echo -e "\nUSAGE:"
    echo -e "   blurry-powermenu [OPTIONS]"
    echo -e "\nOPTIONS:"
    echo -e "       -h | --help     Show this manual.\n"
    echo -e "       -p | --poweroff   Highlight 'poweroff' option."
    echo -e "       -r | --reboot     Highlight 'reboot' option."
    echo -e "       -s | --sleep      Highlight 'sleep' option."
    echo -e "       -l | --logout     Highlight 'logout' option."
    echo -e "       -k | --lock       Highlight 'lock' option (default).\n"
}

# Options as unicode characters of
# the custom-compiled version of Feather icons
poweroff=$(echo -ne "\uE9DA");
reboot=$(echo -ne "\uE9DE");
sleep=$(echo -ne "\uE9BD");
logout=$(echo -ne "\uE9AB");
lock=$(echo -ne "\uE9A9");
options="$poweroff\n$reboot\n$sleep\n$logout\n$lock"


script_abs_dir_path="~/.local/share/dermodex"

# Parse CLI selection, defaults to logout
preselection=2
while getopts prslkh-: OPT; do
    [ "${OPT}" = "-" ] && OPT=${OPTARG}
    case "$OPT" in
        p | poweroff)   preselection=0 ;;
        r | reboot)     preselection=1 ;;
        s | sleep)      preselection=2 ;;
        l | logout)     preselection=3 ;;
        k | lock)       preselection=4 ;;
        *) show_usage; exit 1 ;;
    esac
done


# Get dimensions of the current display using `xdisplayinfo`, calling
# once with option `--all` and then parsing it for further optimization.
displayinfo=$(xdisplayinfo --all)
x="$(echo "$displayinfo" | grep "offset-x" | cut -d" " -f2-)"
y="$(echo "$displayinfo" | grep "offset-y" | cut -d" " -f2-)"
width="$(echo "$displayinfo" | grep "width" | cut -d" " -f2-)"
height="$(echo "$displayinfo" | grep "height" | cut -d" " -f2-)"


# Compute font size based on display dimensions
default_width=1920
default_font_size=40
fontsize=$(echo "$width*$default_font_size/$default_width" | bc)

SOUND_SHUTDOWN=$(gsettings get org.cinnamon.sounds logout-file | tr -d \'\")
SOUND_LOGOUT=$(gsettings get org.cinnamon.sounds logout-file | tr -d \'\")
SOUND_LOCK="/usr/share/sounds/teampixel/state-change_confirm-up.ogg"


selected="$(echo -e "$options" |
            rofi -theme ${script_abs_dir_path}/rofi/themes/dd_power.rasi \
                 -font "WeblySleek UI Light, $fontsize" \
                 -p "See you later, ${USER^}!" -dmenu -selected-row ${preselection})"

case $selected in
    "${poweroff}")
        play -v 0.6 "$SOUND_LOGOUT"&
        sleep 6
        systemctl poweroff
        ;;
    "${reboot}")
        play -v 0.6 "$SOUND_SHUTDOWN"&
        sleep 6
        systemctl reboot
        ;;
    "${sleep}")
        play -v 0.6 "$SOUND_LOCK"&
        sleep 1
        systemctl suspend
        ;;
    "${logout}")
        play -v 0.6 "$SOUND_LOGOUT"&
        sleep 6
        cinnamon-session-quit --logout --no-prompt || ( xfce4-session-logout --logout || mate-session-save --logout )
        ;;
    "${lock}")
        play -v 0.6 "$SOUND_LOCK"&
        sleep 1
        cinnamon-screensaver-command --lock || ( xflock4 || mate-screensaver-command -l )
        ;;
esac