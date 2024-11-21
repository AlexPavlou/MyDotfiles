#!/bin/bash
while true; do
        cat /sys/class/power_supply/BAT1/current_now /sys/class/power_supply/BAT1/voltage_now | xargs | awk '{print $1*$2/1e12 " W"}'
        sleep 2
done
