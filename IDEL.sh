#!/bin/bash
# Idel Starter.

swayidle -w timeout 180 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' &> /dev/null & disown %-
swayidle -w timeout 240 'sh ~/.config/hypr/Scripts/Sleeper/Lock-Loader.sh' &> /dev/null & disown %-

echo 'Idel Started'
exit
