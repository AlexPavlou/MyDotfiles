#!/bin/sh

killall hyprpicker
img_name="screenshot-$(date +%T).png"
case $1 in
        window)
                hyprshot -sm window -f "$img_name"
        ;;
        full)
                hyprshot -sm output -m eDP-1 -f "$img_name"
        ;;
        region)
                hyprshot -sm region -f "$img_name"
    ;;
esac
if [[ -e /home/alex/"$img_name" ]]; then
        notify-send -t 1000 -i /home/alex/"$img_name" "Screenshot Taken"
        wl-copy < /home/alex/"$img_name"
fi
