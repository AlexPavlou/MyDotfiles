#!/bin/bash
doas wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
doas dhclient wlan0
