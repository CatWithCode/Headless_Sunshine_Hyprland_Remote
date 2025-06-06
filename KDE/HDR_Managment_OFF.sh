#!/bin/bash

# This Script automates HDR Hotkeys.
echo 'SDR'
	
# HDR:
kscreen-doctor output.DP-1.hdr.disable
sleep 2

kscreen-doctor output.DP-1.wcg.disable
sleep 2

# Brightness:
kscreen-doctor output.DP-1.brightness.60

exit
