#!/bin/bash

# Script to use old iMacs as an overly complicated display:

# Delay to wait for the main PC:
sleep 10

# Remote PC:
TARGET_IP="IP_OF_PC"

# Retries:
MAX_RETRIES=3

# Initialize counter:
retry_count=0

# Loop:
while true; do
	# Check if online:
	output=$(moonlight list $TARGET_IP)
	
	# Fail to find:
	if echo "$output" | grep -q "Failed to connect"; then
		((retry_count++))
		
		# Max Retries:
		if [ $retry_count -ge $MAX_RETRIES ]; then
			echo "PC no found."
			systemctl poweroff
		fi
		
		# Wait for 10 seconds before retrying
		sleep 10
	else # FOUND PC:
		# Check for profile:
		if echo "$output" | grep -q "EXTEND"; then
			# Start Remote:
			moonlight "$TARGET_IP" Remote

			# Done with Monitor use. Exit:
			systemctl poweroff
			break
		else
			# IDK:
			break
		fi
	fi
done
