# Hellofy
Windows Hello Manager

Description:

This app was designed to mitigate/workaround the useability problems in regards to Windows Hello.
As a heavy user of Windows Hello I was always running into performance and useability bugs.
These were across many devices with different apps and many people online complained of similar if not identical issues.
I set out to design an app that would mitigate or resolve these pain points.
It worked so well I became dependent on using it, realising others might benefit I created Hellofy.
I chose to write the app in AutoIt because it was one of the programing languages I know and it has Windows UI management.
It also makes the useability easier as the barrier for knowing how to install/use scripts is eliminated. The 'source code' for the script has been provided `Hellofy.au3
`.

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
- The only disk writing is to the config file on run
- There is no admin access required.
- It doesn't have any affect at the login screen
- Only Windows Hello and the app that triggered the login are "controlled" and only in regards to making them remain active for your input
- Until Windows Hello app is triggered the Hellofy app does nothing but sleep
- Antivirus unlikely to have issues, feel to run it through VirusTotal. When I did the only reported false alerts where from random AVs. Block it from accessing the internet if your concerned 😊

What's the performance cost:
- Even in the highest performance mode it uses less than 1% CPU and 4 MB RAM
- You can pause or close it at any time from the system tray

![image](https://github.com/ados8/Hellofy/assets/49982433/24f9488f-0c04-4a2b-981d-4beab660bea1)


How do I install it:
1. Download the app
2. Place the app anywhere on your Windows drive except your startup location i.e. `C:\Program Files (x86)\Hellofy`
3. Copy the app EXE and then go to `shell:startup` and paste a shortcut
4. Now when your device starts so will the app

**Important:**

The app is like to give a Windows warning on first run and download. This is due to the app not having any reputation and not being signed which has costs for a free app.

Things to note:
- Configuring the app is simple enough, on first run the app will make a config file in the location of itself
- It wasn't possible to manage Windows Hello Fingerprint and Face unlock while also having PIN unlock managed, so you must pick using PIN setting.
- Don't change any values other than those proceeding `:`
- `Polling frequency` controls the check rate of the app, basically how often it should check if the Windows Hello app is running; default is `2` seconds. It doesn't seem to impact performance so it shouldn't be changed. When not checking the app sleeps, setting too low is wasteful, too high will mean a delay as the app might be asleep when Windows Hello tiggers.
- `PIN mode` is used to override the face and fingerprint modes.

IMPORTANT:

Only use this mode if you never use fingerprint or face to login. Setting `Yes` will enable PIN mode and disables fingerprint and face mode. This was again due to limitations in testing with PIN mode negatively impacted by the mitigations to get fingerprint and face unlock working. It won't disable any of the methods to unlock but refines the behavior of the app to suite the most used unlock types.
