#Persistent
#SingleInstance, force
#include, %A_ScriptDir%\AHKhttp.ahk
#include %A_ScriptDir%\AHKsock.ahk
SetBatchLines, -1
SendMode Input
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
Menu, Tray, Icon, shell32.dll, 69

SendLevel, 1

paths := {}
paths["/"] := Func("HandleIncoming")

;(\__/) ||
;(•ㅅ•) ||
;/ 　 づ

;; MODIFIER ;;
isCtrlDown := 0
isAltDown := 0
isShiftDown := 0
;;;;;

;; MACRO ;;
currentChromeProfile := "Default"
nextChromeProfile := 2
chromeProfiles := ["Default", "Profile 1"]
;;;;;

server := new HttpServer()
server.LoadMimes(A_ScriptDir . "/mime.types")
server.SetPaths(paths)
server.Serve(80)
return

HandleIncoming(ByRef req, ByRef res) {
	global isCtrlDown
	global isAltDown
	global isShiftDown
	
    res.SetBodyText("Hello World")
    res.status := 200
	device := req.queries["device"]
	scancode := req.queries["scancode"]
	state := req.queries["state"]
	device := StrReplace(device, "/dev/Macros", "")
	
	f = %device%_%scancode%
	; Not LCtrl, LShift, LAlt, RCtrl, RShift, RAlt
	If((scancode <> "1d") and (scancode <> "2a") and (scancode <> "38") and (scancode <> "61") and (scancode <> "36") and (scancode <> "64")) {
		If(isAltDown = 1)
			f = a%f%
		If(isShiftDown = 1)
			f = s%f%
		If(isCtrlDown = 1)
			f = c%f%
	}
	If (state = 1) {
		switch(f)
	}
	If (state = 0) {
		f = %device%_%scancode%_u
		switchup(f)
	}
	
	final := req.queries["final"]
	If (final = 1 and state = 3) {
	    taps := req.queries["taps"]
		f = %device%_%scancode%_t
		tapswitch(f, taps)
	}
	
	If (state = 4) {
		hotstring := req.queries["hotstring"]
		StringTrimRight, hotstring, hotstring, 7
		hotswitch(device, hotstring)
	}
}

TempTooltip(text) {
	tooltip, %text%
	SetTimer, RemoveTooltip, -5000
}

RemoveTooltip:
tooltip
return

;;;;;;;;;;


ChromeOpen(url) {
	global currentChromeProfile
	Run, "C:\Users\Wong Zhao\AppData\Local\Google\Chrome SxS\Application\chrome.exe" --profile-directory="%currentChromeProfile%" %url%
}

SwitchChromeProfiles() {
	global currentChromeProfile
	global nextChromeProfile
	global chromeProfiles
	nextProfile := chromeProfiles[nextChromeProfile]
	
	If (nextProfile <> "") {
		currentChromeProfile := nextProfile
		nextChromeProfile := nextChromeProfile + 1
	}
	Else {
		currentChromeProfile := chromeProfiles[1]
		nextChromeProfile := 2
	}
	
	tooltip, Now: %currentChromeProfile%
	SetTimer, RemoveTooltip, -2000
}

tapswitch(case, taps) {
	GoTo % IsLabel(case) ? case : "default_t"
	
	1_6c_t:
	msgbox, %taps%
	return
	
	default_t:
	return
}

hotswitch(device, case) {
	GoTo % IsLabel(device) ? device : "default_h"
	
	1:
	return
	
	2:
	If (case = "P/I/N/G") {
		msgbox, Pong!
	}
	If (case = "I/3") {
		SendRaw, ǐ
	}
	return
	
	default_h:
	return
}

switch(case) {
	GoTo % IsLabel(case) ? case : "default"
	
	;; MODIFIER VARIABLE DECLARATION ;;
	global isCtrlDown
	global isAltDown
	global isShiftDown
	;;;;;
	
	;; MACRO VARIABLE DECLARATION ;;
	global currentChromeProfile
	global nextChromeProfile
	global chromeProfiles
	;;;;;
	
	; LCTRL
	1_1d:
		isCtrlDown := 1
	return
	; RCTRL
	1_61:
		isCtrlDown := 1
	return
	
	; LALT
	1_38:
		isAltDown := 1
	return
	; RALT
	1_64:
		isAltDown := 1
	return
	
	; LSHIFT
	1_2a:
		isShiftDown := 1
	return
	; RSHIFT
	1_36:
		isShiftDown := 1
	return
	
	; Switch Chrome Profiles / Open Chrome
	1_19:
		SwitchChromeProfiles()
	return
	c1_19:
		ChromeOpen("about:blank")
	return
	
	; Chrome Canary
	1_2e:
		IfWinNotExist, ahk_class Chrome_WidgetWin_1 
			ChromeOpen("")
		GroupAdd, chromes, ahk_class Chrome_WidgetWin_1
		if WinActive("ahk_class Chrome_WidgetWin_1")
			Send ^{tab}
		else
			WinActivate ahk_class Chrome_WidgetWin_1
	return
	c1_2e:
		If WinActive("ahk_class Chrome_WidgetWin_1")
			Send ^+{tab}
	return
	a1_2e:
		If WinActive("ahk_class Chrome_WidgetWin_1")
			GroupActivate, chromes, r
	return
	
	; School
	1_1f:
		ChromeOpen("https://wrms.schoolloop.com")
	return
	c1_1f:
		ChromeOpen("https://portal.srvusd.net")
	return
	a1_1f:
		ChromeOpen("https://campus.srvusd.net")
	return
	
	; Back
	1_30:
		if WinActive("ahk_class Chrome_WidgetWin_1")
			Send !{Left}
		if WinActive("ahk_exe explorer.exe")
			Send !{Left}
	return
	c1_30:
		if WinActive("ahk_class Chrome_WidgetWin_1")
			Send !{Right}
		if WinActive("ahk_exe explorer.exe")
			Send !{Right}
	return
	
	; Desktop
	1_20:
		WinMinimizeAll
	return
	c1_20:
		WinMinimizeAllUndo
	return
	
	; ImageSearch Testing
	1_29:
		WinActivate, ahk_exe Discord.exe
		ImageSearch, FoundX, FoundY, 0, 100, 9999, 9999, %A_WorkingDir%\assets\discord_profile.png
		If(ErrorLevel = 0) {
			MouseGetPos, OrigX, OrigY
			MouseClick, Left, FoundX + 20, FoundY + 30
			Sleep, 100
			MouseClick, Left, FoundX + 20, FoundY - 150
			MouseMove, OrigX, OrigY
		}
		WinMinimize, ahk_exe Discord.exe
	return
	c1_29:
		WinActivate, ahk_exe Discord.exe
		ImageSearch, FoundX, FoundY, 0, 100, 9999, 9999, %A_WorkingDir%\assets\discord_already_dnd.png
		If(ErrorLevel = 0) {
			MouseGetPos, OrigX, OrigY
			MouseClick, Left, FoundX + 20, FoundY + 30
			Sleep, 100
			MouseClick, Left, FoundX + 20, FoundY - 250
			MouseMove, OrigX, OrigY
		}
		WinMinimize, ahk_exe Discord.exe
	return
	
	1_25:
		WinActivate, Google Hangouts
		ImageSearch, FoundX, FoundY, 0, 0, 9999, 9999, %A_WorkingDir%\assets\hangouts_msg.png
		If(ErrorLevel = 0) {
			MouseGetPos, OrigX, OrigY
			MouseClick, Left, FoundX + 30, FoundY
			Sleep, 100
			Send, k{Enter}
		}
		Else {
			ImageSearch, FoundX, FoundY, 0, 0, 9999, 9999, %A_WorkingDir%\assets\hangouts_msg_2.png
			If(ErrorLevel = 0) {
				Send, k{Enter}
			}
		}
		WinMinimize, Google Hangouts
	return
	
	1_1c:
		TempTooltip("test")
	return
	
	1_2c:
		key = A
		Send, {F24 down}
		Send, {%key%}
		Send, {F24 up}
	return
	
	default:
		message = Not Mapped - %case%
		TempTooltip(message)
	return
}

switchup(case) {
	GoTo % IsLabel(case) ? case : "default_u"
	
	;; MODIFIER VARIABLE DECLARATION ;;
	global isCtrlDown
	global isAltDown
	global isShiftDown
	;;;;;
	
	; LCTRL
	1_1d_u:
		isCtrlDown := 0
	return
	; RCTRL
	1_61_u:
		isCtrlDown := 0
	return
	
	; LALT
	1_38_u:
		isAltDown := 0
	return
	; RALT
	1_64_u:
		isAltDown := 0
	return
	
	; LSHIFT
	1_2a_u:
		isShiftDown := 0
	return
	; RSHIFT
	1_36_u:
		isShiftDown := 0
	return
	
	default_u:
	return
}