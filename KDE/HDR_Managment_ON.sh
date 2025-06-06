#!/bin/bash

# This Script automates HDR Hotkeys.
echo "HDR"

# HDR:
kscreen-doctor output.DP-1.hdr.enable
sleep 2

kscreen-doctor output.DP-1.wcg.enable
sleep 2

# Brightness:
kscreen-doctor output.DP-1.brightness.80

exit
