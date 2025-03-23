#!/bin/bash

# Setup System Utils:
sleep 1
killall swayidle

sleep 1

# Run Moonlight:
flatpak run com.moonlight_stream.Moonlight

killall swayidle
bash ~/.config/hypr/Scripts/IDLE.sh &> /dev/null & disown %-

sleep 1

exit
