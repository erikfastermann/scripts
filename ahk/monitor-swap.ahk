; AutoHotkey script - Swap a Window between Monitors
; BUG: doesn't work for all programs e.g.: CMD, Teamspeak


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, On
SetTitleMatchMode, 2





; Monitor upper left corner, check Window Spy Active Window Position for a maximized Window for each monitor
; If you don't have a third monitor, set a high value for Mon3CornerX
Mon1CornerX = -1610
Mon2CornerX = -9
Mon3CornerX = 3190
Mon1CornerY = -2
Mon2CornerY = -9
Mon3CornerY = -10


; Press F16 to swap active window in this order Mon1 > Mon2 > Mon3 > Mon1 ...
F16::
WinGetActiveTitle, ActWin

WinGetActiveStats, ActTitle, ActWidth, ActHeight, ActX, ActY

; if-Function checks if active Window Monitor is 1
if (ActX >= Mon1CornerX and ActX < Mon2CornerX)
{
	; sets new position and maximizes the window
	WinRestore, %ActWin%
	WinMove, %ActWin%, , Mon2CornerX, Mon2CornerY, ActWidth, ActHeight
	WinRestore, %ActWin%
	WinMaximize, %ActWin%
}

; repeated for monitor 2
else if (ActX >= Mon2CornerX and ActX < Mon3CornerX)
{
	WinRestore, %ActWin%
	WinMove, %ActWin%, , Mon3CornerX, Mon3CornerY, ActWidth, ActHeight
	WinRestore, %ActWin%
	WinMaximize, %ActWin%
}

; repeated for monitor 3
else if (ActX >= Mon3CornerX)
{
	WinRestore, %ActWin%
	WinMove, %ActWin%, , Mon1CornerX, Mon1CornerY, ActWidth, ActHeight
	WinRestore, %ActWin%
	WinMaximize, %ActWin%
}

Return