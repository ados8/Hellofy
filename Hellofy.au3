#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icons\security.ico
#AutoIt3Wrapper_Outfile=Compiled\Hellofy.exe
#AutoIt3Wrapper_Res_Description=Manages Windows Hello prompt
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_ProductName=Hellofy
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_LegalCopyright=GNU AFFERO GENERAL PUBLIC LICENSE
#AutoIt3Wrapper_Res_Language=3081
#AutoIt3Wrapper_Run_Tidy=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;-----------------------------------------------
;Title: Hellofy
;Purpose: Forces Windows Hello prompt to always be in focus
;Date: 05/06/23
;Version: 1.0
;Designer: ados8
;-----------------------------------------------

;Dependencies
#include <File.au3>
#include <StringConstants.au3>

;Global varibles
Global $Delay = 2 ;multiplied later by 1000
Global $DelayPIN = 0 ;Changes based on config file

;Checks for config and deploys default settings
If Not FileExists(@ScriptDir & "\settings.config") Then
	MsgBox(16, "Read Me!", "Config file has been made at the script location, please read the GitHub page.")
	_FileCreate(@ScriptDir & "\settings.config")
	$Config = FileOpen(@ScriptDir & "\settings.config", 2)
	FileWrite($Config, "Polling frequency (seconds): " & $Delay & @LF & "PIN mode : No")
	FileClose($Config)
EndIf

;Import config settings into app
$Config = FileOpen(@ScriptDir & "\settings.config", 0)
$Settings = FileRead($Config, -1)

;Set polling frequency based on config settings
$Delay = StringRegExp($Settings, '([0-9]{1,3600})', $STR_REGEXPARRAYMATCH)
$Delay = $Delay[0] * 1000 ;converts to milliseconds to bypass reg exp limitation

;Determin if PIN mode is enabled
If StringInStr($Settings, "Yes", 0, 1) = 0 Then
	$ModeSelected = "FINGER"
Else
	$ModeSelected = "PIN"
	$DelayPIN = 1000
EndIf

;Main payload
While 1
	;Wait for the existance of Windows Hello window
	While WinExists("[CLASS:Credential Dialog Xaml Host]", "") = 0
		Sleep($Delay)
	WEnd

	;Find the last active app which must have triggered the Windows Hello authentication prompt
	$ActiveWindowHandle = WinGetHandle("[ACTIVE]")
	WinActivate($ActiveWindowHandle)

	;While Windows Hello app exists force it and the app which triggered it to remain in focus.
	While WinExists("[CLASS:Credential Dialog Xaml Host]", "")
		WinActivate("[CLASS:Credential Dialog Xaml Host]")
		If $ModeSelected = "FINGER" Then
			WinSetState("[CLASS:Credential Dialog Xaml Host]", "", @SW_DISABLE)
			Sleep(1000)
			WinSetState("[CLASS:Credential Dialog Xaml Host]", "", @SW_ENABLE)
		ElseIf $ModeSelected = "PIN" Then
			Sleep($DelayPIN)
		EndIf
		If WinExists("[CLASS:Credential Dialog Xaml Host]", "") = 0 Then
			ExitLoop
		EndIf
	WEnd
WEnd
