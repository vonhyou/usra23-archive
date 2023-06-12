#!/bin/bash

scriptDurationInMinutes=$1
timeIntervalInSeconds=$2

# If the duration is not provided, exit the script
if [ -z "$scriptDurationInMinutes" ]; then
  echo "Please provide the duration for the script to run (in minutes) as a command-line argument."
  exit 1
fi

read -p "The script will run for about $scriptDurationInMinutes minutes. Is this correct? (y/N) " confirmation

# Convert the confirmation to lowercase
confirmation=$(echo $confirmation | tr '[:upper:]' '[:lower:]')

# If the user confirms, start the script
if [ "$confirmation" = "y" ]; then
# Calculate the end time
  endTime=$(date -d "$scriptDurationInMinutes minutes" +%s)

  while [ $(date +%s) -lt $endTime ]; do
    # Execute the adb command and check for errors
    if ! adb shell input swipe 700 2300 700 1000; then
      echo "An error occurred while executing the adb command: $_"
      break
    fi

    # Log the delay before the next adb command
    echo "[Log] Next swipe: $timeIntervalInSeconds seconds."

    # Wait for the specified delay before repeating the loop
    sleep $timeIntervalInSeconds #$timeIntervalInSeconds
  done
fi