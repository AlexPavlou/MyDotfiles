xrandr --output Alalallalalallalalal --mode 1920x1080 --rate 120 &
./.scripts/setbg &
dwmblocks &
./.scripts/wifi.sh &
xset r rate 300 50 &
picom -b --experimental-backends &

# loop
while true; do
	dwm >/dev/null 2>&1
done

exec dwm
