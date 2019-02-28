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

Launch_Mail:: ; Toggle Pinyin Input
ToggleVar("pinyin", pinyin)
onoff := (pinyin = 1) ? "ON" : "OFF"
Tippy("Pinyin " + onoff)
return

Browser_Back::Tippy("back")
Browser_Forward::Tippy("forward")
Browser_Refresh::Tippy("refresh")
Browser_Stop::Tippy("stop")
Browser_Search::Tippy("search")
Browser_Favorites::Tippy("favorites")
Browser_Home::Tippy("browser")
Launch_App2::Tippy("calc")

~^Numpad7::SwitchVar(currentChromeProfile, nextChromeProfile, chromeProfiles, "currentChromeProfile", "nextChromeProfile")
~#Numpad7::ChromeOpen("")
NumLock::return

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
#If

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;     Config     ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

firstName := "Johnny"
lastName := "Appleseed"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;     Functions     ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DriveHelp(function) {
	WinGetTitle, drivetitle, A
	Send, !{/}%function%
	Sleep, 300
	ControlSend, Chrome_RenderWidgetHostHWND1, {Enter}, %drivetitle%
}


#If GetKeyState("F24")
F24::return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;     Program Toggling     ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

P:: ; Explorer
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, explorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, explorers, r
else
	WinActivate ahk_class CabinetWClass
return
+P::
Run, explorer.exe
return
^P::WinClose, ahk_group explorers

I:: ; Task Manager
IfWinNotExist, ahk_class TaskManagerWindow
	Run, taskmgr.exe
else
	WinActivate ahk_class TaskManagerWindow
return

O:: ; Window Spy
IfWinNotExist, ahk_exe AU3_Reveal.exe
	Run, AU3_Reveal.exe
Else
	WinActivate, ahk_exe AU3_Reveal.exe
return
^O::WinClose, ahk_exe AU3_Reveal.exe

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;     Google Drive     ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Q::DriveHelp("editing mode")
+Q::DriveHelp("suggesting mode")
^Q::DriveHelp("viewing mode")

C::DriveHelp("comic sans ms") ; Dedicated Comic Sans button

Z:: ; Have you ever needed to quickly convert your blank paper to MLA format?
DriveHelp("line spacing double")
DriveHelp("times new roman")
DriveHelp("font size 12")
SendRaw, %firstName% %lastName%`n
SendRaw, Teacher`n
SendRaw, Class`n
SendRaw, 1 January 2019`n
Sleep, 300
Send, ^+{e} ; Center Align
SendRaw, Title
Sleep, 300
Send, ^!{o}^!{h} ; Move to header
DriveHelp("times new roman")
DriveHelp("font size 12")
Send, ^+{r} ; Right Align
Send, %lastName%{Space} ; Send user's last name with a space
DriveHelp("insert page number in header starting on the first page")
return
#If

#If GetKeyState("F23")
F23::return

A::Tippy("F23 A")
B::Tippy("F23 B")
C::Tippy("F23 C")
D::Tippy("F23 D")
E::Tippy("F23 E")
F::Tippy("F23 F")
G::Tippy("F23 G")
H::Tippy("F23 H")
I::Tippy("F23 I")
J::Tippy("F23 J")
K::Tippy("F23 K")
L::Tippy("F23 L")
M::Tippy("F23 M")
N::Tippy("F23 N")
O::Tippy("F23 O")
P::Tippy("F23 P")
Q::Tippy("F23 Q")
R::Tippy("F23 R")
S::Tippy("F23 S")
T::Tippy("F23 T")
U::Tippy("F23 U")
V::Tippy("F23 V")
W::Tippy("F23 W")
X::Tippy("F23 X")
Y::Tippy("F23 Y")
Z::Tippy("F23 Z")

^A::Tippy("F23 CtrlA")
^+A::Tippy("F23 CtrlShiftA")
^+!#A::Tippy("F23 CtrlShiftAltWinA")

1::Tippy("F23 1")
2::Tippy("F23 2")
3::Tippy("F23 3")
4::Tippy("F23 4")
5::Tippy("F23 5")
6::Tippy("F23 6")
7::Tippy("F23 7")
8::Tippy("F23 8")
9::Tippy("F23 9")
0::Tippy("F23 0")

Space::Tippy("F23 Space")
#If