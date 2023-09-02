#!/bin/zsh

# profile file. Runs on login. Environmental variables are set here.

# If you don't plan on reverting to bash, you can remove the link in ~/.profile
# to clean up.

unsetopt PROMPT_SP

# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox-bin"

# hacks to get as many apps as possible to run wayland-natively
export "QT_QPA_PLATFORM"="wayland-egl" # required by qt5 applications
export "MOZ_ENABLE_WAYLAND"=1
export "_JAVA_AWT_WM_NONREPARENTING"=1 # to fix glitches for java UI apps under xwayland
export "XDG_SESSION_TYPE"="wayland"
export "XDG_CURRENT_DESKTOP"="dwl"
export "GDK_BACKEND"="wayland"

dbus-run-session dwl -s dwlb
