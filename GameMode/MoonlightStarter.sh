#!/bin/bash

# Setup System Utils:
sleep 1
killall swayidel

sleep 1

# Run Moonlight:
flatpak run com.moonlight_stream.Moonlight

killall swayidel
bash ~/.config/hypr/Scripts/IDEL.sh &> /dev/null & disown %-

sleep 1

exit
