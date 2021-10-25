#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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

if [ -f $HOME/.xprofile ]; then
    source $HOME/.xprofile
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Setup IBux
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -dxr

# Setup IBus for `kitty` terminal emulator
export GLFW_IM_MODULE=ibus

# Set background image
# sh $HOME/.fehbg &
xset s 0
xset dpms 0 0 0
xset -dpms
xset -b
xscreensaver -no-splash &
systemctl --user start dunst
# Compositor with v-sync to prevent tearing
picom -b
# Default to i3wm
exec i3
