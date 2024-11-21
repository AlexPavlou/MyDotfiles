#!/bin/sh

# Gracefully handle SIGINT and SIGTERM
trap 'echo "Script interrupted, exiting..."; exit 0' SIGINT SIGTERM

# Initialize variables
s='a'
k=0
notified_20=false
notified_10=false
first_run_done=false
previous_bat=-1  # To track previous battery level for notification logic

# Function to set up swayidle and hyprctl based on power status
setup_swayidle() {
    local status=$1
    #if pgrep -x "swayidle" > /dev/null; then
    #    killall swayidle
    #fi
    if [[ "$status" == "1" ]]; then
        #swayidle -w timeout 90 'swaylock -f' timeout 95 'hyprctl -q dispatch dpms off' timeout 105 'loginctl suspend' resume 'hyprctl -q dispatch dpms on' before-sleep 'swaylock -f' lock 'swaylock -f'
        hyprctl -q --batch "\
            keyword monitor eDP-1,1920x1080@120,0x0,1.25;\
            keyword decoration:drop_shadow true;\
            keyword animations:enabled true;\
            keyword misc:vfr false;\
            keyword decoration:blur:enabled true"
        light -S 80
    else
        #swayidle -w timeout 60 'swaylock -f' timeout 65 'hyprctl -q dispatch dpms off' timeout 70 'loginctl suspend' resume 'hyprctl -q dispatch dpms on' before-sleep 'swaylock -f' lock 'swaylock -f'
        hyprctl -q --batch "\
            keyword monitor eDP-1,1920x1080@60,0x0,1.25;\
            keyword decoration:drop_shadow false;\
            keyword animations:enabled false;\
            keyword misc:vfr true;\
            keyword decoration:blur:enabled false;\
            keyword decoration:inactive_opacity 0.9"
        light -S 50
    fi
}

# Perform initial setup
status=$(< /sys/class/power_supply/ACAD/online) 2>/dev/null
bat=$(< /sys/class/power_supply/BAT1/capacity) 2>/dev/null

# Check the initial battery status and notify if needed (only once)
if [[ -z "$status" ]] || [[ -z "$bat" ]]; then
    echo "Error: AC or battery status file not found, exiting."
    exit 1
fi

# Notify based on the current battery level (only once)
if [[ $bat -le 10 ]] && [ "$notified_10" = false ]; then
    notify-send "Battery is critically low! Plug in the power" -u critical
    notified_10=true
elif [[ $bat -le 20 ]] && [ "$notified_20" = false ]; then
    notify-send "Battery is low! Plug in the power" -u critical
    notified_20=true
fi

# Reset notification flags if battery goes above thresholds
if [[ $bat -gt 20 ]] && [ "$notified_20" = true ]; then
    notified_20=false
fi
if [[ $bat -gt 10 ]] && [ "$notified_10" = true ]; then
    notified_10=false
fi

# Run initial swayidle setup (first loop)
if [ "$first_run_done" = false ]; then
    setup_swayidle "$status"
    first_run_done=true
fi

# Store the initial status
s=$status

# Monitor for file changes and act accordingly
while true; do
    # Wait for changes in the battery or AC status
    inotifywait -e modify /sys/class/power_supply/BAT1/capacity /sys/class/power_supply/ACAD/online > /dev/null 2>&1

    # Read current battery and AC status again
    status=$(< /sys/class/power_supply/ACAD/online) 2>/dev/null
    bat=$(< /sys/class/power_supply/BAT1/capacity) 2>/dev/null

    # If the status files are missing, skip the iteration
    if [ -z "$status" ] || [ -z "$bat" ]; then
        continue
    fi

    # Handle battery notifications (only when crossing thresholds)
    if [[ $bat -le 10 ]] && [ "$notified_10" = false ]; then
        notify-send "Battery is critically low! Plug in the power" -u critical
        notified_10=true
    elif [[ $bat -le 20 ]] && [ "$notified_20" = false ]; then
        notify-send "Battery is low! Plug in the power" -u critical
        notified_20=true
    fi

    # Reset notification flags if battery levels increase
    if [[ $bat -gt 20 ]] && [ "$notified_20" = true ]; then
        notified_20=false
    fi
    if [[ $bat -gt 10 ]] && [ "$notified_10" = true ]; then
        notified_10=false
    fi

    # Only update swayidle configuration if AC status has changed
    if [[ "$s" != "$status" ]]; then
        setup_swayidle "$status"  # Only run this if the AC power status changes
    fi

    # Store the current status for next iteration comparison
    s=$status
done
