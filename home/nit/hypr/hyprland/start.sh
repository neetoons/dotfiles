#!usr/bin/env bash

# setting wallpaper
#mpvpaper VGA-1 -o "loop-playlist" /home/nit/Pictures/wallpapers/homura.mp4 &
# you can install this by adding
# pkgs.networkmanagerapplet to your packages
swaybg -i "/home/nit/Pictures/2. Arte y Diseño/wallpapers/castlevania-2.jpg" &
swaybg -i "/home/nit/Pictures/2. Arte y Diseño/wallpapers/castlevania-2.jpg" &
EWW="eww -c $HOME/.config/eww/nit"
${EWW} daemon &
${EWW} open-many bar &
nm-applet --indicator &
dunst &
hypridle &
rclone mount nit: /home/nit/GoogleDrive &
zen-beta &
pulseeffects &
