#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

#include Tippy.ahk

ToggleVar(name, value) {
	%name% := not value
}

SwitchVar(current, next, arr, currentname, nextname) {
	nextProfile := arr[next]
	If (nextProfile <> "") {
		%currentname% := nextProfile
		%nextname% := next + 1
		
		Tippy("Now: " + nextProfile)
	}
	Else {
		%currentname% := arr[1]
		%nextname% = 2
		
		Tippy("Now: " + arr[1])
	}
}

ChromeOpen(url) {
	global
	;C:\Users\USERNAME\AppData\Local\Google\Chrome SxS\Application\chrome.exe
	RegRead, localdir, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, Local AppData
	path = %localdir%\Google\Chrome SxS\Application\chrome.exe --profile-directory="%currentChromeProfile%" %url%
	Run, %path%
}

currentChromeProfile := "Default"
nextChromeProfile := 2
chromeProfiles := ["Default", "Profile 1"]

pinyin := false

Launch_Mail::
ToggleVar("pinyin", pinyin)
onoff := (pinyin = 1) ? "ON" : "OFF"
Tippy("Pinyin " + onoff)
return
Launch_App2::Tippy("test", 5000)

~^Numpad7::SwitchVar(currentChromeProfile, nextChromeProfile, chromeProfiles, "currentChromeProfile", "nextChromeProfile")
~#Numpad7::ChromeOpen("")
NumLock::
return

#If pinyin = 1
:*:v0::ü

:*:a`1::ā
:*:o`1::ō
:*:e`1::ē
:*:i`1::ī
:*:u`1::ū
:*:v`1::ǖ

:*:a2::á
:*:o2::ó
:*:e2::é
:*:i2::í
:*:u2::ú
:*:v2::ǘ

:*:a3::ă
:*:o3::ŏ
:*:e3::ě
:*:i3::ǐ
:*:u3::ǔ
:*:v3::ǚ

:*:a4::à
:*:o4::ò
:*:e4::è
:*:i4::ì
:*:u4::ù
:*:v4::ǜ