#! /usr/bin/env zsh

waybar &
nm-applet &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
lxpolkit &
otd-daemon &