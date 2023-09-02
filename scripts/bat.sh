#!/bin/sh
while true; do
        perc=$(cat /sys/class/power_supply/BAT1/capacity)
        if [[ $perc -lt 30 ]]; then
                notify-send "Battery is low! Charge"
        elif [[ $perc -gt 80 ]]; then
                notify-send "Battery is charged! Remove plug"
        fi
        sleep 5
done
