#!/bin/bash

# This Script automates as far as HDR Remote startup as much as possble.

# Assign the first parameter to a variable
param=$1

# ExtID:
extendScreenID="2"
# RemoteID:
remoteScreenID="0"

# "e"   = EXIT
# ""    = Remote

# Check if a parameter was provided:
if [ "$param" == "e" ]; then # END REMOTE:
	# Disable HDR:
	kscreen-doctor output.DP-2.hdr.disable
	sleep 2

	kscreen-doctor output.DP-2.wcg.disable
	sleep 2

	# Brightness (Will Reset on restart. Must be as low as possible (HDR settings look the same as Nativ. For me Remote Nativ 800, fake 2000)):
	kscreen-doctor output.DP-2.brightness.90
	sleep 2
	kscreen-doctor output.DP-2.hdr-brightness.200
	sleep 2
	kscreen-doctor output.DP-2.sdr-brightness.200
else # LOAD REMOTE:
	# Enable HDR:
	kscreen-doctor output.DP-2.hdr.enable
	sleep 2

	kscreen-doctor output.DP-2.wcg.enable
	sleep 2

	# Brightness (Will Reset on restart. Must be as low as possible (HDR settings look the same as Nativ. For me Remote Nativ 800, fake 2000)):
	kscreen-doctor output.DP-2.brightness.90
	sleep 2
	kscreen-doctor output.DP-2.hdr-brightness.200
	sleep 2
	kscreen-doctor output.DP-2.sdr-brightness.200
fi

exit
