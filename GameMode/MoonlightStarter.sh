#!/bin/bash

# Setup System Utils:
sleep 1
killall swayidle

# Disable EyeCandy:
sleep 1
bash ~/.config/hypr/Scripts/GameMode/GameMode.sh

# Run Moonlight:
sleep 1
flatpak run com.moonlight_stream.Moonlight

# Return to Default:
killall swayidle
sleep1

bash ~/.config/hypr/Scripts/GameMode/GameMode.sh notReset

bash ~/.config/hypr/Scripts/IDLE.sh &> /dev/null & disown %-

sleep 1

exit
