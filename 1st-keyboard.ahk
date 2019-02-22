#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

#include Tippy.ahk

pinyin := false

Launch_Mail::
pinyin := not pinyin
return
Launch_App2::Tippy("test", 5000)

#If pinyin = 1
:*:i3::ǐ
::btw::by the way