#!/bin/sh
s='0'
while true; do
        # s is a variable which holds the latest battery status, it compares it with the current status to see whether it should perform the xrandr commands or not
        status=$(cat /sys/class/power_supply/BAT1/status)
        if [[ "$s" != "$status" ]]; then
                # sets corresponding configs
                if [[ "$status" != "Charging" ]]; then
                        wlr-randr --output eDP-1 --mode 1920x1080@60.007000
                        light -S 80
                        s="Charging"
                elif [[ "$status" != "Discharging" ]]; then
                        wlr-randr --output eDP-1 --mode 1920x1080@120.001999
                        light -S 100
                        s="Discharging"
                fi
        fi
        sleep 5
done
