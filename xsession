#!/bin/bash
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/usr/lib/X11/xinit/.Xresources
sysmodmap=/usr/lib/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# background
#xsetroot -solid SteelBlue
xsetroot -solid '#008080'

# key repeat
xset r rate 300 25

# fcitx
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'
fcitx5 &
#flatpak run --branch=master --arch=x86_64 --command=/app/bin/fcitx5 org.fcitx.Fcitx5 &

# backlight
#if [ -f $HOME/.lightrc ]; then
#    munsell.py light s `cat $HOME/.lightrc | grep ^brightness | gawk '{print($3)}'`
#else
#    munsell.py light s 3.0
#fi
if [ -f $HOME/.xbacklightrc ]; then
    munsell.py xbacklight s `cat $HOME/.xbacklightrc | grep ^brightness | gawk '{print($3)}'`
else
    munsell.py xbacklight s 3.0
fi

# screen saver off
xset s 1800 1800
xset -dpms

# Statubar loop for dwm
while true; do
	/usr/bin/dwm_statusbar.py xbacklight_bat_hms
	#/usr/bin/dwm_statusbar.py mpd_light_bat_hms

	sleep 1s    # Update every second
	#sleep 5s    # Update every 5 seconds
	#sleep 1m    # Update every minute
done &

# Window Manager
/usr/bin/dwm

