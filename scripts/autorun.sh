#! /usr/bin/env zsh

waybar &
nm-applet &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
lxpolkit &

# export __EGL_VENDOR_LIBRARY_FILENAMES=/nix/store/dax001xkrfy0s09v98ha0rsz4i9cdz8z-mesa-24.3.4-drivers/share/glvnd/egl_vendor.d/50_mesa.json:/nix/store/k17h8daax10lh01x9byf0dzlchgmf8aj-mesa-24.3.4-drivers/share/glvnd/egl_vendor.d/50_mesa.json && linux-wallpaperengine --silent --screen-root "DP-4" --assets-dir "/home/mz/.steam/steam/steamapps/common/wallpaper_engine/assets" --bg "2931236842" --fps 10 &

# linux-wallpaperengine --silent --screen-root "HDMI-A-2" --assets-dir "/home/mz/.steam/steam/steamapps/common/wallpaper_engine/assets" --bg "2931236842" --fps 10 &
