#!/bin/sh
color=$(hyprpicker)
if [[ -n $color ]];then
        img_path="/home/alex/.cache/color_picker.png"
        convert -size 1x1 xc:"$color" "$img_path"
        notify-send -t 1500 -i "$img_path" "$color copied to clipboard"
        wl-copy "$color"
fi
