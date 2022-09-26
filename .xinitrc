# sets the resolution, refresh rate etc.
xrandr --output eDP-1 --mode 1920x1080 --rate 120 &

# sets the wallpaper
./.scripts/setbg &

# sets the bar
slstatus &

# sets my wifi and stuff
./.scripts/wifi.sh &

# makes typing a joy
xset r rate 300 50 &

# sets the compositor, in this case picom
picom -b --experimental-backends &

# loop
while true; do
	dwm >/dev/null 2>&1
done

# executes dwm
exec dwm
