#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

macros2line1 =
macros2line2 =
macros1line1 =
macros1line2 =

Color1 = 60FF7D
Color2 = 60FF7E

Gui, MACROS2: New
Gui, MACROS2: +AlwaysOnTop +Owner +Disabled -SysMenu -Caption +LastFound +Disabled +E0x08000000 -ToolWindow	 +E0x20 -Border -MinimizeBox -MaximizeBox -Resize +LastFound
Gui, MACROS2: Margin, 0, 0
Gui, MACROS2: Color, %Color1% ; Set the window background color to Color1

Gui, MACROS2: Font, s25 c%Color2% bold, Segoe UI ; Set text size to 80, color to Color2 (Make sure Color2 is very similar to Color1 to make the faint outline very unnoticable), and font to Arial
Gui, MACROS2: Add, Text, vText, ========================================================================================================================================================================
Gui, MACROS2: Font, s15 c%Color2% normal italic, Segoe UI
Gui, MACROS2: Add, Text, vText2, ========================================================================================================================================================================
GuiControl, MACROS2: , Text,
GuiControl, MACROS2: , Text2,
SysGet, Monitor, MonitorWorkArea
MonitorBottom := MonitorBottom - 350
MonitorLeft := MonitorLeft + 25
Gui, MACROS2: Show, NoActivate X%MonitorLeft% Y%MonitorBottom%, MACROS
WinSet, TransColor, %Color1% 50, MACROS
Gui, MACROS2: Hide

Gui, MACROS1: New
Gui, MACROS1: +AlwaysOnTop +Owner +Disabled -SysMenu -Caption +LastFound +E0x08000000 +ToolWindow +E0x20 -Border -MinimizeBox -MaximizeBox -Resize +LastFound
Gui, MACROS1: Margin, 0, 0
Gui, MACROS1: Color, %Color1% ; Set the window background color to Color1

Gui, MACROS1: Font, s25 c%Color2% bold, Segoe UI ; Set text size to 80, color to Color2 (Make sure Color2 is very similar to Color1 to make the faint outline very unnoticable), and font to Arial
Gui, MACROS1: Add, Text, vText, ========================================================================================================================================================================
Gui, MACROS1: Font, s15 c%Color2% normal italic, Segoe UI
Gui, MACROS1: Add, Text, vText2, ========================================================================================================================================================================
GuiControl, MACROS1: , Text,
GuiControl, MACROS1: , Text2,
SysGet, Monitor, MonitorWorkArea
MonitorBottom := MonitorBottom - 250
MonitorLeft := MonitorLeft + 25
Gui, MACROS1: Show, NoActivate X%MonitorLeft% Y%MonitorBottom%, MACROS
WinSet, TransColor, %Color1% 50, MACROS
Gui, MACROS1: Hide

Gui, MACROS: New
Gui, MACROS: +AlwaysOnTop +Owner +Disabled -SysMenu -Caption +LastFound +E0x08000000 +ToolWindow +E0x20 -Border -MinimizeBox -MaximizeBox -Resize +LastFound
Gui, MACROS: Margin, 0, 0
Gui, MACROS: Color, %Color1% ; Set the window background color to Color1

Gui, MACROS: Font, s25 c%Color2% bold, Segoe UI ; Set text size to 80, color to Color2 (Make sure Color2 is very similar to Color1 to make the faint outline very unnoticable), and font to Arial
Gui, MACROS: Add, Text, vText, ========================================================================================================================================================================
Gui, MACROS: Font, s15 c%Color2% normal italic, Segoe UI
Gui, MACROS: Add, Text, vText2, ========================================================================================================================================================================
GuiControl, MACROS: , Text,
GuiControl, MACROS: , Text2,
SysGet, Monitor, MonitorWorkArea
MonitorBottom := MonitorBottom - 150
MonitorLeft := MonitorLeft + 25
Gui, MACROS: Show, NoActivate X%MonitorLeft% Y%MonitorBottom%, MACROSORIG
WinSet, TransColor, %Color1% 150, MACROSORIG
Gui, MACROS: Hide

SetTransparency(transparency) {
	global Color1
	WinSet, TransColor, %Color1% %transparency%, MACROSORIG
}

DisplayText(line1, line2) {
	
	WinGet, winid,, A
	
	global macros2line1
	global macros2line2
	global macros1line1
	global macros1line2
	
	GuiControl, MACROS: , Text, %line1%
	GuiControl, MACROS: , Text2, %line2%
	Gui, MACROS: Show
	
	GuiControl, MACROS1: , Text, %macros1line1%
	GuiControl, MACROS1: , Text2, %macros1line2%
	Gui, MACROS1: Show
	
	GuiControl, MACROS2: , Text, %macros2line1%
	GuiControl, MACROS2: , Text2, %macros2line2%
	Gui, MACROS2: Show
	
	macros2line1 := macros1line1
	macros2line2 := macros1line2
	
	macros1line1 := line1
	macros1line2 := line2
	
	WinActivate ahk_id %winid%
}

DisplayTextTop(line1) {
	
	WinGet, winid,, A
	
	global macros2line1
	global macros1line1
	
	GuiControl, MACROS: , Text, %line1%
	Gui, MACROS: Show
	
	GuiControl, MACROS1: , Text, %macros1line1%
	Gui, MACROS1: Show
	
	GuiControl, MACROS2: , Text, %macros2line1%
	Gui, MACROS2: Show
	
	macros2line1 := macros1line1
	macros1line1 := line1
	
	WinActivate ahk_id %winid%
}

DisplayTextBottom(line2) {
	
	WinGet, winid,, A
	
	global macros2line2
	global macros1line2
	
	GuiControl, MACROS: , Text2, %line2%
	Gui, MACROS: Show
	
	GuiControl, MACROS1: , Text2, %macros1line2%
	Gui, MACROS1: Show
	
	GuiControl, MACROS2: , Text2, %macros2line2%
	Gui, MACROS2: Show
	
	macros2line2 := macros1line2
	macros1line2 := line2
	
	WinActivate ahk_id %winid%
}

keyarray =
lastdown =
lastdowntime := A_Now
test = Browser_Back`nBrowser_Forward
StringSplit, keyarray, test, `n

Loop {
	Sleep, 20
	Loop, %keyarray0% {
		key := keyarray%A_Index%
		GetKeyState, state, %key%, P
		repeat := lastdown = key
		If state = D
		{
			If repeat = 0
			{
				DisplayText(key, key)
				lastdown := key
			}
			SetTransparency(255)
			lastdowntime := A_Now
		} Else {
			If repeat = 1
			{
				lastdown =
				SetTransparency(150)
			}
		}
	}
	timenow := A_Now
	EnvSub, timenow, lastdowntime, seconds
	If(timenow > 2) {
		SetTransparency(50)
	}
}

NoTransparency:
	SetTransparency(255)
return

TransparentALittle:
	SetTransparency(150)
return

Browser_Back::
return

Browser_Forward::
return