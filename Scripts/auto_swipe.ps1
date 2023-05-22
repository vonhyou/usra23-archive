# Ask the user for the total duration for the script to run (in minutes)
$scriptDurationInMinutes = Read-Host -Prompt 'Enter the duration for the script to run (in minutes)'

# Confirm the user input
$confirmation = Read-Host -Prompt "You have entered $scriptDurationInMinutes minutes. Is this correct? (y/N)"

# Convert the confirmation to lowercase
$confirmation = $confirmation.ToLower()

# If the user confirms, start the script
if ($confirmation -eq 'y') {
  # Calculate the end time
  $endTime = (Get-Date).AddMinutes($scriptDurationInMinutes)

  while ((Get-Date) -lt $endTime) {
    # Generate a random delay between 0.5 and 3 minutes
    $randomDelayInMinutes = Get-Random -Minimum 0.1 -Maximum 2

    # Execute the adb command and check for errors
    try {
      adb shell input swipe 700 2300 700 1000
    }
    catch {
      Write-Host "An error occurred while executing the adb command: $_"
      break
    }

    # Convert the random delay to milliseconds (1 minute = 60000 milliseconds)
    $delayInMilliseconds = $randomDelayInMinutes * 60000

    # Log the delay before the next adb command
    $delayInSeconds = [math]::floor($randomDelayInMinutes * 60)
    Write-Host "[Log] Next swipe: $delayInSeconds seconds."


    # Wait for the specified delay before repeating the loop
    Start-Sleep -Milliseconds $delayInMilliseconds
  }
}