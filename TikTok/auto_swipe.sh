#!/bin/bash

scriptDurationInMinutes=$1

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
    # Generate a random delay between 10 and 60 seconds
    randomDelayInMinutes=$(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')

    # Execute the adb command and check for errors
    if ! adb shell input swipe 700 2300 700 1000; then
      echo "An error occurred while executing the adb command: $_"
      break
    fi

    # Convert the random delay to seconds (1 minute = 60 seconds)
    delayInSeconds=$(awk "BEGIN {print int($randomDelayInMinutes*60)}")

    # Log the delay before the next adb command
    echo "[Log] Next swipe: $delayInSeconds seconds."

    # Wait for the specified delay before repeating the loop
    sleep 3 #$delayInSeconds
  done
fi