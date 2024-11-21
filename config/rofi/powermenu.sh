#!/bin/sh

# Options for powermenu
reboot=""
shutdown=""
sleep=""
logoff=""
lock=""

# Get answer from user via rofi
selected_option=$(echo "$reboot
$shutdown
$sleep
$logoff
$lock" | rofi -dmenu\
                  -i\
                  -p "Power"\
		  -theme "powermenu.rasi")

# Perform action based on selected option
if [ "$selected_option" == "$lock" ]
then
    notify-send -i /home/alex/.config/rofi/images/lock.svg "locking device..."
    playerctl pause
    sleep 1
    swaylock
elif [ "$selected_option" == "$logoff" ]
then
    notify-send -i /home/alex/.config/rofi/images/logoff.svg "closing hyprland..."
    sleep 1
    hyprctl dispatch exit 1
elif [ "$selected_option" == "$shutdown" ]
then
    notify-send -i /home/alex/.config/rofi/images/power.svg "powering off..."
    sleep 1
    doas poweroff
elif [ "$selected_option" == "$reboot" ]
then
    notify-send -i /home/alex/.config/rofi/images/reboot.svg "rebooting..."
    sleep 1
    doas reboot
elif [ "$selected_option" == "$sleep" ]
then
    notify-send -i /home/alex/.config/rofi/images/sleep.svg "putting device to sleep..."
    playerctl pause
    sleep 1
    loginctl suspend
    hyprctl dispatch dpms off
    swaylock
fi
