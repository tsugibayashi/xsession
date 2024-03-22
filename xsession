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

# capslock -> ctrl
#setxkbmap -option ctrl:nocaps

# uim
#export GTK_IM_MODULE='uim'
#export QT_IM_MODULE='uim'
#export XMODIFIERS='@im=uim'
#uim-xim &

# backlight
#if [ -f $HOME/.lightrc ]; then
#    munsell.py light s `cat $HOME/.lightrc | grep ^brightness | gawk '{print($3)}'`
#else
#    munsell.py light s 3.5
#fi
if [ -f $HOME/.xbacklightrc ]; then
    munsell.py xbacklight s `cat $HOME/.xbacklightrc | grep ^brightness | gawk '{print($3)}'`
else
    munsell.py xbacklight s 3.5
fi

# screen saver off
xset s 3600 3600
xset -dpms

# Network Manager applet
#nm-applet &

# create $HOME/log
if [ ! -d $HOME/log ]; then
    mkdir $HOME/log
fi

# Start dwmstatusbar.py
if [ -e /usr/bin/dwmstatusbar.py ]; then
    date > $HOME/log/dwm_statusbar.log
    /usr/bin/dwmstatusbar.py --comps xbacklight bat hms --wait 1 >>$HOME/log/dwm_statusbar.log 2>&1 &
    #/usr/bin/dwmstatusbar.py --comps light bat hms --wait 1 >>$HOME/log/dwm_statusbar.log 2>&1 &
    #/usr/bin/dwmstatusbar.py --comps mpd light bat hms --wait 1 >>$HOME/log/dwm_statusbar.log 2>&1 &
    #/usr/bin/dwmstatusbar.py --comps mpd vol light bat hms --wait 1 >>$HOME/log/dwm_statusbar.log 2>&1 &
fi

#uim-toolbar-gtk3 &

# Window Manager
/usr/bin/dwm

# Quit dwmstatusbar.py
for i in $(pgrep -U $UID -f dwmstatusbar.py); do
    kill $i
done

