# Switchvox Bell System

## Summary of Setup:
This code assumes that you have a PA system setup with an extension or route in your Switchvox already configured for it.  It also assumes that the TIM of your PA is setup to automatically answer calls that are sent to it.

In a nutshell, the Powershell scripts are setup with Windows Task Scheduler that places a call to your PA system extension and connects it directly to an IVR on your Switchvox.  The IVR is configured to do what it needs to navigate the PA system's TIM to broadcast a recorded/stored audio file from the Switchvox, and then terminates the call.

## Setup Instructions:

### Install SwitchvoxAPI Powershell Module:
First, you'll need to install the Powershell Module for the Switchvox API from here: https://github.com/lordmilko/SwitchvoxAPI.  The easiest way to do this is with NuGet:

```powershell
Install-Package SwitchvoxAPI
```

### Setup / Record Sound Files for your Bells:
Before you can make any pages with your bells, you'll need to record or upload them to the Switchvox.  I would recommend making a folder for them on your Switchvox under your Sound Manager, and then making a new sound for each bell you want to be played.  When making a new sound, you can record a message with a phone by entering an extension to dial, and the phone will ring with instructions on how to finish the recording.

**Tip: Don't hang up the phone by setting it onto the reciever.  Press the # key to end the call, so you don't get that clank noise from the receiver hitting the phone base.**

### Setup Switchvox IVRs:

Next, you'll need to setup the IVRs on your Switchvox.  Setup an IVR for each bell you want to play, and the actions should mimic how you would manually make a page.  In my setup, I do the following:

1. **Wait 1 second:**  This gives a short buffer for the call to be answered.
1. **Send DTMF tones "00":**  Change this to match how your TIM handles sending a page and setting the corresponding zone (if your PA has zone paging).  In my case, 0 for page, 0 for All zones.
1. **Wait 2 seconds:**  I include a 2 second wait here because my PA system is setup to perform a built-in pre-page tone that sounds before you can actually speak.
1. **Play sound:** SelPlays the corresponding sound file from your stored sounds on the Switchvox.
1. **End the call:** This is pretty self explanatory.

### Create Your Bell Scripts:
Use the *BellExample.ps1* file to create scripts for each of your bells.

### Make a Scheduled Task for Each Bell:
Change the following Powershell commands for each bell you want to setup, and run it from a Powershell terminal:
```powershell
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument 'C:\Path\To\Your\Bell.ps1'
$trigger = New-ScheduledTaskrigger --Weekly -WeeksInterval 2 -DaysOfWeek Monday,Tuesday,Wednesday,Thursday,Friday -At 10am
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Bell Name" -Description "This is a scheduled bell."
```