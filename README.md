# MyDotfiles
Simple configurations I use on my daily driver

![image1](images/pic1.jpg)
![image2](images/pic2.jpg)

## What even is this?

All my suckless programs have luke smith's builds as their base, dwm has been patched a bit and the source code has been altered quite a bit, especially with certain functions and parts from MentalOutlaw's build which has fixed it for me a few times. Another person I must thank is siduck because his build of dwm (github.com/siduck/chadwm) gave me lots of ideas like the colorfultag patch and the bar/statuspadding patches which really helped my dwm take off. Other than dwm, st/dmenu and dwmblocks are pretty much just how I got them with a couple of things changed like the colors/modules and I defined a little variable in dwmblocks so I don't have to flood /usr/local/bin/ with scripts. Any xresources/xrdb patches have been pretty much removed and StickyTags or whatever have been turned useless.

## Patches applied

I applied the following patches to DWM:

- statuspadding
- barpadding
- colorfultag patch (https://github.com/fitrh/dwm/issues/1 and siduck's chadwm)
- preserveonrestart patch
- Most of the patches that came with Luke Smith's build like vanitygaps and the many many layouts
- notitle
- underline tags
- status2d

### Requirements

- imlib2
- any font patched with nerd font symbols, only reason I use a nerd font is for the arch logo and the cooler retro cpu character. You can get away with font-awesome
- the bar needs xsetroot
- other scripts could need acpi etc
- movie script needs 2 programs for downloading the movie and the subtitle (if asked to)

## Other configurations

- zshrc with zsh plugins and zprofile
- my startup script
- all I care about from the /etc/default/grub like the kernel params, which make booting up a little quicker and much quieter.
- some wallpapers I found while ricing at r/unixporn that just look amazing, perhaps not the best quality but you can search for the original images
- a couple dozen scripts, both for dwmblocks and other useful ones. Most come from Luke Smith but I have written and edited a few.
- My config for firefox (simply Arkenfox with a user-override.js from www.youtube.com/watch?v=GVOcElOPs8E )
- Cava, with gruvbox colors
- dunst, no other dunstrc worked as well so yeah, good enough
- iptables, which is still under work and not even sure if I will use it
- lf, Luke Smith's config with lfimg scripts etc. (cirala/lfimg)
- mpd, uncomment and comment alsa or pulse, also has the visualizer
- mpv, simple enough, it doesn't lag and plays nicely + resumes any videos
- ncmpcpp, nothing crazy, just luke smith's with vim bindings
- newsboat
- nsxiv, control+x and then control-d deletes the current image, or well, moves it to ~/.trash
- nvim, gruvbox colors, nice indenting, completion, lualine, web-devicons and colorizer. I wish to convert to init.lua but for now this config does everything I want it to.
- zathura, just a dark background and the basic bindings.

## Current Issues

- None

## Usage

Simply compile these programs or put the config files in the .config directory.
I have tried compiling the suckless programs with the -03 flag but the resource usage was too high for the performance boost which was barely noticeable.
To run dwm simply use my .xinitrc script or append "exec dwm" to yours after compiling it.

## Possible Improvements

- Make as many appplications transparent
- Make transparent applications and the terminal blurry
- rounded corners on all windows, pretty sure this build has it if you disable the border px to 0
- give dwmblocks on the bar in general some color, I have tried to do so and it just doesn't work, my tags are already colorful so I just don't know what's going on, you could try something like luastatus or slstatus but they aren't as customizable and I don't care if my stats are a second behind.
- init.vim to init.lua from scratch, only improvement I am even considering to try out.
