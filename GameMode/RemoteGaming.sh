#!/bin/bash

# This Script automates as far as possible the Headless Hyprland Remote Desktop setup.

# Check if a parameter was provided:
if [ $# -eq 1 ]; then # END REMOTE:
    echo "EXIT REMOTE NOW"

    # Reload Default:
    hyprctl reload

    # Wait for clean State:
    sleep 2

    # Setup System Utils (Unneeded? Dose now work, gets killed with Sunshine together.):
    #bash  ~/.config/hypr/Scripts/GameMode/WayBarMaker.sh & disown

    # ReRun SleepService:
    bash ~/.config/hypr/Scripts/IDEL.sh &> /dev/null & disown %-
    
    # Lock Screen (Only after unlocking Sunshine will close. I could no fix the Disown issue. This also closes swayidle and other executed scripts that still run.):
    sleep 1
    bash ~/.config/hypr/Scripts/Sleeper/Lock-Loader.sh
    sleep 1
    
    # Exit Sunshine:
    #sleep 5
    systemctl --user stop sunshine
else # LOAD REMOTE:
    # What will happen:
    echo 'This turns off the displays so Remote saves power!'
    echo 'MAKE SURE EVERY WINDOW IS CLOSED!'

    # Making sure User is ready:
    read -n 1 -s -r -p "Press any key to continue or CTRL+C exit..."

    # Load fake Display:
    hyprctl keyword monitor DP-2,1920x1080@60,1080x70,1,transform,0

    # Disable Real Displays:
    hyprctl keyword monitor DP-1,disable
    hyprctl keyword monitor DP-3,disable
    hyprctl keyword monitor HDMI-A-1,disable

    # Pause to make sure everthing has happend:
    sleep 4

    # Path to sunshine config file:
    config_file="~/.config/sunshine/sunshine.conf"

    # Set Output (Theoretically not needed as long as the internal Method is used by sunshine and the ID is always 0 because it is the only Display):
    sed -i "s/^output_name = .*/output_name = 0/" "$config_file"

    # Wait to make sure everthing is saved:
    sleep 1

    # Prevent Sleep:
    killall swayidle

    # Start Sunshine:
    systemctl --user start sunshine

    # Done (Bug):
    echo 'If you can read this everthing worked. This dose not close itself for some reason. You can close me now safly :)!'
fi

exit

# UNUSED:
# DYNAMIC ID (IS DIFFERENT AFTER SWITCH OFF AND DOSE NOT USE WAY-ID ANYWAY...):
# ###

# Get monitor info:
# output=$(hyprctl monitors)

# # GetID of Display DP-2:
# monitor_id=$(echo "$output" | grep "DP-2" | awk -F 'ID ' '{print $2}' | awk '{print $1}' | sed 's/):.*//')

# # Path to sunshine config file:
# config_file="~/.config/sunshine/sunshine.conf"

# # Set Output Dynamicly:
# sed -i "s/^output_name = .*/output_name = $monitor_id/" "$config_file"

# ###

