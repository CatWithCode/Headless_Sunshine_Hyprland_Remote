#!/bin/bash

# Setup System Utils:
sleep 1

killall waybar

sleep 1

waybar &
disown

killall swayidle
bash ~/.config/hypr/Scripts/IDEL.sh &> /dev/null & disown %-

sleep 1

exit
