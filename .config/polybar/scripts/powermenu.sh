#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu

# CMDs
uptime=$(uptime |awk {'print $3'}| sed 's/[^0-9:]*//g')

# Options
shutdown=''
reboot=''
lock=''
suspend='⏾'
logout=''
yes=''
no=''
# shutdown=''
# reboot=''
# lock=''
# suspend=''
# logout=''
# yes=''
# no=''

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "Uptime: $uptime" \
        -mesg "Uptime: $uptime" \
        -theme ~/.config/polybar/scripts/style-3.rasi
}

# Confirmation CMD
confirm_cmd() {
    rofi -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme ~/.config/polybar/scripts/shared/confirm.rasi
}

# Ask for confirmation
confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
            systemctl poweroff
        elif [[ $1 == '--reboot' ]]; then
            systemctl reboot
        elif [[ $1 == '--suspend' ]]; then
            mpc -q pause
            amixer set Master mute
            systemctl suspend
        elif [[ $1 == '--logout' ]]; then
            bspc quit
        fi
    else
        exit 0
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $lock)
        i3lock -ef -i ~/Pictures/Anime_Dark/saitama_ok.png
        ;;
    $suspend)
        run_cmd --suspend
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
