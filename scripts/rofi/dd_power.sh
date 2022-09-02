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



selected="$(echo -e "$options" |
            rofi -theme ${script_abs_dir_path}/dd_power.rasi \
                 -fake-background '/usr/share/backgrounds/dermodex/login_blur.png' \
                 -font "WeblySleek UI Light, $fontsize" \
                 -p "See you later, ${USER^}!" -dmenu -selected-row ${preselection})"

case $selected in
    "${poweroff}")
        systemctl poweroff
        ;;
    "${reboot}")
        systemctl reboot
        ;;
    "${sleep}")
        systemctl suspend
        ;;
    "${logout}")
        cinnamon-session-quit --logout --no-prompt || ( xfce4-session-logout --logout || mate-session-save --logout )
        ;;
    "${lock}")
        cinnamon-screensaver-command --lock || ( xflock4 || mate-screensaver-command -l )
        ;;
esac