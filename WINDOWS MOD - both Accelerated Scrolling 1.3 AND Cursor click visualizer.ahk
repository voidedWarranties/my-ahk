

; Accelerated Scrolling
; V1.3
; By BoffinbraiN
; https://www.youtube.com/watch?v=OobKVPojFmg
; ORIGINAL:  https://autohotkey.com/board/topic/48426-accelerated-scrolling-script/

/*
PLUS cursor click visualization 1.0, By Taran Van Hemert.
PROBLEMS WITH THE CURSOR VISUALIZER:
Background color behind the green text is not completely transparent on the edges --- there is no anti aliasing, so it looks jagged
Would be nice to use customizable pictures, instead of a dumb font (lucida console) that not everyone will have anyway.
The click visualizations do not linger at all -- I don't know how to do this if I wanted to.
Also, You'll have to modify the positioning of the GUI to suit your own computer and its UI scaling in Windows.
*/

;Use this script only if you want cursor visualization, AND accelrated scrolling.
;SOURCE: https://github.com/TaranVH/2nd-keyboard

Menu, Tray, Icon, shell32.dll, 44 ; changes the icon to a star -- makes it easy to see which one it is.


SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoEnv
;#NoTrayIcon
#SingleInstance
#MaxHotkeysPerInterval 2000
Process, Priority, , H
SendMode Input
#SingleInstance force
CoordMode, mouse, screen

;below is a bunch of GUI stuff that I need for cursor click visualization.
;Use WIN KEY and scroll down to turn it on or off.

size := 200
kolor := 11FF99
kolor2 := 008833
showClicks = 1






Gui, -Caption +ToolWindow +AlwaysOnTop +LastFound
;Gui, Color, %kolor2%
Gui, Color, 008833
GuiHwnd := WinExist()
DetectHiddenWindows, On
WinSet, Region, % "0-0 W" Size " H" Size, ahk_id %GuiHwnd%
WinSet, ExStyle, +0x20, ahk_id %GuiHwnd% ; set click through style
;WinSet, Transparent, 0, ahk_id %GuiHwnd% ;didn't work...
;WinSet, TransColor, %kolor2% 100
WinSet, TransColor, 008833 100
;WinSet, TransColor, %kolor% 100
Gui, Show, w%Size% h%Size% ;hide
Gui, Font, s32, lucida console ;This font has nearly perfect ()v^ characters. I also tried these: ;Estrangelo Edessa ;century gothic
Gui, Add, Text, vMyText cLime,  ; xx  auto-sizes the window.

If showClicks = 1
{
	settimer, looper, -2
}
nokill = 1
delay = 200


; Show scroll velocity as a tooltip while scrolling. 1 or 0.
tooltips := 0

; The length of a scrolling session.
; Keep scrolling within this time to accumulate boost.
; Default: 500. Recommended between 400 and 1000.
timeout := 600

; If you scroll a long distance in one session, apply additional boost factor.
; The higher the value, the longer it takes to activate, and the slower it accumulates.
; Set to zero to disable completely. Default: 30.
boost := 40

; Spamming applications with hundreds of individual scroll events can slow them down.
; This sets the maximum number of scrolls sent per click, i.e. max velocity. Default: 60.
limit := 60

; Runtime variables. Do not modify.
distance := 0
vmax := 1




; Key bindings

;These allow for the visualizer to work with modifier keys, but do NOT affect any sort of clicking at all.
; ^ is CTRL
; + is SHIFT
; ! is ALT
; ~ allows the key to also pass through normally
~^WheelUp::
~+WheelUp::
~^+WheelUp::
~!WheelUp::
Wup = 1
return

~^WheelDown::
~+WheelDown::
~^+WheelDown::
~!WheelDown::
Wdown = 1
return


WheelUp:: ;notice the deliberate lack of a ~
Gui, hide
Wup = 1
Goto Scroll ;this is what does the acceleration
return

WheelDown::
Gui, hide
Wdown = 1
Goto Scroll
return

;remember, in this case the # means the WIN KEY.
#WheelUp::   Suspend

#WheelDown:: ; this turns the click visualizer and fast scroll :( on or off.
If showClicks = 1
{	
	tooltip, changing visualization
	showClicks = 0
	settimer, looper, -20
	sleep 555
	tooltip,
	Return
}
else if showClicks = 0
{
	showClicks = 1
	settimer, looper, off
}
Return

Scroll:
	t := A_TimeSincePriorHotkey
	if (A_PriorHotkey = A_ThisHotkey && t < timeout)
	{
		; Remember how many times we've scrolled in the current direction
		distance++

		; Calculate acceleration factor using a 1/x curve
		v := (t < 80 && t > 1) ? (250.0 / t) - 1 : 1

		; Apply boost
		if (boost > 1 && distance > boost)
		{
			; Hold onto the highest speed we've achieved during this boost
			if (v > vmax)
				vmax := v
			else
				v := vmax

			v *= distance / boost
		}

		; Validate
		v := (v > 1) ? ((v > limit) ? limit : Floor(v)) : 1

		if (v > 1 && tooltips)
			QuickToolTip(v, timeout)
		
		

		MouseClick, %A_ThisHotkey%, , , v
	}
	else
	{
		; Combo broken, so reset session variables
		distance := 0
		vmax := 1

		MouseClick %A_ThisHotkey%
	}
	return

Quit:
	QuickToolTip("Exiting Accelerated Scrolling...", 1000)
	Sleep 1000
	ExitApp

QuickToolTip(text, delay)
{
	ToolTip, %text%
	SetTimer ToolTipOff, %delay%
	return

	ToolTipOff:
	SetTimer ToolTipOff, Off
	ToolTip
	return
}



; pgup::send {wheelup 50}
; pgdn::send {wheeldown 50}




;Begin cursor click visualization stuff:

~*$LButton::
Lbuttondown = 1
Return
~*$LButton up::
Lbuttondown = -1
Return

~*$RButton::
Rbuttondown = 1
Return
~*$RButton up::
Rbuttondown = -1
Return

~*$MButton::
Mbuttondown = 1
Return
~*$MButton up::
Mbuttondown = -1
Return

wheelkiller:
;msgbox, wheelkiller
if Wup = -1
{
Wup = 0
Gui, hide
}
if Wdown = -1
{
Wdown = 0
Gui, hide
}
Return


looper:
MouseGetPos, realposX, realposY
posX := realposX - Size/2.8, posY := realposY - Size/3.2 + 0 ; puts the gui in the middle rather than the corner. You'll have to change these variables if you have UI scaling set to 100% rather than 150% like I do.

posY := posY+17

If(Mbuttondown = 1 and not Lbuttondown = 1 and not Rbuttondown = 1)
{
	GuiControl,, MyText, |
	posXX := posX+19
	Gui, Show, x%posXX% y%posY% NA
}
If Mbuttondown = -1
{
	Mbuttondown = 0
	Gui, hide
}

If(Lbuttondown = 1 and Rbuttondown = 1)
{
	GuiControl,, MyText, -
	posXX := posX+19
	Gui, Show, x%posXX% y%posY% NA
	settimer, looper, -20
	return
}

If(Lbuttondown = 1 and Mbuttondown = 1)
{
	GuiControl,, MyText, <
	posXX := posX+13
	Gui, Show, x%posXX% y%posY% NA
}

If(Rbuttondown = 1 and Mbuttondown = 1)
{
	GuiControl,, MyText, >
	posXX := posX+27
	Gui, Show, x%posXX% y%posY% NA
}

If(Lbuttondown = 1 and not Mbuttondown = 1)
{
	GuiControl,, MyText, (
	posXX := posX+13
	Gui, Show, x%posXX% y%posY% NA
}
If Lbuttondown = -1
{
	Lbuttondown = 0
	Gui, hide
}


If(Rbuttondown = 1 and not Mbuttondown = 1)
{
	posXX := posX+28
	GuiControl,, MyText, )
	Gui, Show, x%posXX% y%posY% NA
}
If Rbuttondown = -1
{
	Rbuttondown = 0
	Gui, hide
}

If Wup = 1
{
	posYu := posY-10
	posxu := posX+19
	GuiControl,, MyText, ^
	Gui, Show, x%posXu% y%posYu% NA
	settimer, wheelkiller, -200
	Wup = -1
}
If Wdown = 1
{
	posYd := posY+15
	posXd := posX+19
	Gui, Font, s20 cBlue, Verdana
	GuiControl,, MyText, v
	Gui, Show, x%posXd% y%posYd% NA
	
	
	settimer, wheelkiller, -200
	Wdown = -1
}


settimer, looper, -1
Return



