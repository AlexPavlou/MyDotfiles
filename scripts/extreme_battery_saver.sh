#!/bin/sh
doas rfkill block bluetooth
doas modprobe -r uvcvideo
doas gsettings set org.gnome.desktop.peripherals.touchpad send-events 'disabled'
doas modprobe -r usbcore usb_common btusb btintel
doas rmmod rtw88_8821ce rtw88_pci rtw88_8821c rtw88_core mac80211
doas killall pipewire,pipewire-pulse,wireplumber
doas modprobe -r snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel snd_hda_scodec_component snd_hda_codec snd_hda_core snd
