xrandr --output  Virtual1 --mode 1360x768 &
setbg &
dwmblocks &
xset r rate 300 50 &

# loop
while true; do
	dwm >/dev/null 2>&1
done

exec dwm
