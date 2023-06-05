# Hellofy
Windows Hello Manager

Description:
This app was designed to resolve useability problems in regards to Windows Hello.
As a heavy user of Windows Hello (HA) I was always running into performance and useability bugs.
These were across many devices with different apps and many people online complained of similar if not identical issues.
I set out to design an app that would mitigate or resolve these pain points.
It worked so well I became dependent on using it, realising others might benefit I created Hellofy.
I chose to write the app in AutoIt because it was one of the programing languages I know and it has Windows UI management.
It also makes the useability easier as the barrier for knowing how to install/use scripts is eliminated.

How does it work:
Hellofy runs on the Windows system looking for the Windows Hello activation.
Once triggered through a login/authentication it controls the window to make the login a smooth as possible.
This involves keeping the window front facing and making sure the app requesting the sign in is also front facing.
By doing this it ensures as soon as your authenticated your loged in.

What Windows Hello issues does it address:
- Windows Hello prompt hiding or behind other windows
- Windows Hello prompt requires clicking or interaction before login in, even if your already authenticated (basically it's stuck on screen)
- Reduces the login glitches from fingerprint based accessories and apps using the above

What Windows Hello types are supported:
- Fingerprint
- Face
- PIN

What version of Windows are supported:
- Windows 10
- Windows 11 (not tested but should work)

What about my privacy and security:
- There is no polling to the internet, it will work completely offline
- There is no logging, data collection or any information collected
- There is no mouse or keyboard control
- It doesn't have any affect at the login screen
- Only Window Hello and the app that triggered the login are "controlled" and only in regards to making them remain active for your input
- Until the Windows Hello app is triggered the Hellofy app does nothing but sleep
- There is no admin access or writing to your computer other than the config file on run.
- Antivirus unlikely to have issues, feel to run it through VirusTotal. When I did the only reported false alerts where from random AVs
- Block it from accessing the internet if your concerned 😊

What's the performance cost:
- Even in the highest performance mode it uses less than 1% CPU and 4 MB RAM
- You can pause or close it at any time from the system tray

![image](https://github.com/ados8/Hellofy/assets/49982433/6351fb1e-5793-4c61-829e-761ef4eabaf9)

How do I install it:
1. Download the app
2. Place the app anywhere on your Windows drive except your startup location i.e. `C:\Program Files (x86)\Hellofy`
3. Copy the app EXE and then go to `shell:startup` and paste a shortcut
4. Now when your device starts so will the app

Things to note:
- Configuring the app is simple enough, on first run the app will make a config file in the location of itself
- It wasn't possible to Windows Hello Fingerprint and Face unlock managed while also having PIN unlock managed.
- Don't change any values other than those proceeding `:`
- `Polling frequency` controls the check rate of the app, basically how often it should check if the Windows Hello app is running. Default is `2` seconds, while it doesn't seem to impact performance it shouldn't be changed. With default Hellofy checks every `2` seconds if the Windows Hello app is running, when not checking it sleeps. Setting to low is wasteful, to high will mean when the Windows Hello app is running Hellofy might be asleep delaying its job.
- `PIN mode` is used to override the face and fingerprint modes.
IMPORTANT: only use this mode if you never use fingerprint or face to login. Setting `Yes` will enable PIN mode and disables fingerprint and face mode.
Important: it will not disable or block the use of fingerprint or face login but will not use its magic to make the login smooth, it will be as if the app isn't running. It will apply magic to the PIN login experience.
