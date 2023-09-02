#!/bin/bash
doas wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
doas ip link set wlan0 down
doas macchanger -r wlan0
doas ip link set wlan0 up
doas dhcpcd wlan0
