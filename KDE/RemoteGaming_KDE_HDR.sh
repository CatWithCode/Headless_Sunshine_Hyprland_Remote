#!/bin/bash

# This Script automates as far as possible the Headless Hyprland Remote Desktop setup.

# Assign the first parameter to a variable
param=$1

# ExtID:
extendScreenID="2"
# RemoteID:
remoteScreenID="0"

# "e"   = EXIT
# "ext" = EXTEND MODE
# ""    = Remote

# Check if a parameter was provided:
if [ "$param" == "e" ]; then # END REMOTE:
    echo "EXIT REMOTE NOW"
    
    # Enable Real Displays (Your values here):
    # Main first
    kscreen-doctor output.DP-1.enable
    sleep 4
    kscreen-doctor output.DP-1.position.1080,240
    sleep 4
    kscreen-doctor output.HDMI-A-1.enable
    sleep 4
    kscreen-doctor output.HDMI-A-1.position.0,0
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

elif [ "$param" == "ext" ]; then # LOAD REMOTE-Extend:
    echo 'This extends the main Displays. This is to reuse an Integrated PC Display.'

    # Load fake Display (Your values here):
    # Enable:
    kscreen-doctor output.DP-2.enable
    sleep 4
    # Remove HDR:
    kscreen-doctor output.DP-2.hdr.disable
    sleep 4
    # Res:
    kscreen-doctor output.DP-2.mode.2560x1440@60
    sleep 4
    # Pos:
    kscreen-doctor output.DP-2.position.4720,240
    sleep 4
    # Scale:
    kscreen-doctor output.DP-2.scale.1
    sleep 4
    
    # Real Displays (Your values here):
    # Main first
    kscreen-doctor output.DP-1.enable
    sleep 4
    kscreen-doctor output.DP-1.position.1080,240
    sleep 4
    kscreen-doctor output.HDMI-A-1.enable
    sleep 4
    kscreen-doctor output.HDMI-A-1.position.0,0
    sleep 4
    kscreen-doctor output.DP-3.enable
    sleep 4
    kscreen-doctor output.DP-3.position.3640,0
    sleep 4

    # Set Main to Fake (DOSE NOTHING):
    kscreen-doctor ouput.DP-2.priority.99
    sleep 4

    # Set Output (Theoretically not needed as long as the internal Method is used by sunshine and the ID is always 0 because it is the only Display):
    sed -i "s/^output_name = .*/output_name = $extendScreenID/" ~/.config/sunshine/sunshine.conf

    # Wait to make sure everthing is saved:
    sleep 1

    # Start Sunshine:
    systemctl --user start sunshine

    # Done (Bug):
    echo 'If you can read this everthing worked. This dose not close itself for some reason. You can close me now safly :)!'
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
    # Res:
    kscreen-doctor output.DP-2.mode.3840x2160@60
    sleep 4
    # Pos:
    kscreen-doctor output.DP-2.position.4720,240
    sleep 4
    # Scale:
    kscreen-doctor output.DP-2.scale.2
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

    # Set Output (Theoretically not needed as long as the internal Method is used by sunshine and the ID is always 0 because it is the only Display):
    sed -i "s/^output_name = .*/output_name = $remoteScreenID/" ~/.config/sunshine/sunshine.conf

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

