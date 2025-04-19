#!/bin/bash

# This Script automates as far as possible the Headless Hyprland Remote Desktop setup.

# Check if a parameter was provided:
if [ $# -eq 1 ]; then # END REMOTE:
    echo "EXIT REMOTE NOW"
    
    # Enable Real Displays (Your values here):
    kscreen-doctor output.HDMI-A-1.enable
    sleep 4
    kscreen-doctor output.HDMI-A-1.position.0,0
    sleep 4
    kscreen-doctor output.DP-1.enable
    sleep 4
    kscreen-doctor output.DP-1.position.1080,50
    sleep 4
    kscreen-doctor output.DP-3.enable
    sleep 4
    kscreen-doctor output.DP-3.position.3640,0
    sleep 4
    
    # UnLoad fake Display:
    kscreen-doctor output.DP-2.disable
    sleep 4

    # Set Main to Main (DOSE NOTHING):
    kscreen-doctor ouput.DP-1.priority.99
    sleep 4
    
    # Exit Sunshine:
    sleep 5
    systemctl --user stop sunshine

else # LOAD REMOTE:

    # This Script automates as far as possible the Headless KDE Remote Desktop setup.
    echo 'This turns off the displays so Remote saves power!'
    echo 'MAKE SURE EVERY WINDOW IS CLOSED!'

    # Making sure User is ready:
    read -n 1 -s -r -p "Press any key to continue or CTRL+C exit..."

    sleep 4

    # Load fake Display (Your values here):
    kscreen-doctor output.DP-2.enable
    sleep 4
    kscreen-doctor output.DP-2.position.4720,0
    sleep 4
    
    # Disable Real Displays:
    kscreen-doctor output.HDMI-A-1.disable
    sleep 4
    kscreen-doctor output.DP-1.disable
    sleep 4
    kscreen-doctor output.DP-3.disable
    sleep 4

    # Set Main to Fake (DOSE NOTHING):
    kscreen-doctor ouput.DP-2.priority.99
    sleep 4

    # Path to sunshine config file:
    config_file="~/.config/sunshine/sunshine.conf"

    # Set Output (Theoretically not needed as long as the internal Method is used by sunshine and the ID is always 0 because it is the only Display):
    sed -i "s/^output_name = .*/output_name = 0/" "$config_file"

    # Wait to make sure everthing is saved:
    sleep 1

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

