#!/bin/sh

# runs the 'bat_stuff.sh' script which checks to see if the laptop is charging or discharging, it then sets the corresponding refresh rate and brightness with xrandr. This script also sends a battery notiffication if your battery percentage is lower than 30
sh .scripts/bat_stuff.sh &

# sets the wallpaper
sh .scripts/setbg.sh &

# sets the bar
slstatus &

# sets the wifi and also changes the card's temporary MAC address using macchanger, it then assigns an ip address with dhcpcd
sh .scripts/wifi.sh &

# sets the sound
sh .scripts/sound.sh &

# makes typing a joy
xset r rate 300 50 &

# sets the compositor, in this case picom
picom -b &

# loop
while true; do
	dwm >/dev/null 2>&1
done

# executes dwm
exec dwm
