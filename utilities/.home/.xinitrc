#!/bin/sh
slstatus &
feh --bg-scale ~/.config/wallpapers/greekmyth.jpg &
picom -b &
brightnessctl -d amdgpu_bl1 set 255
redshift -O 4200 &
setxkbmap -option caps:escape
xrandr --output HDMI-1 --left-of eDP-1
exec dwm

