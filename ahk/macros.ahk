; My Hotkeys with AutoHotkey - use and adjust to your needs


; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases. Commented out to use %userprofile% etc.
#Warn All, Off  ; Warnings disabled
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.





; currently I only use the writing features, everything after this is commented out
/*

; Some often written words in german messages, Usage: only type the letters between the colons and then press space or enter
::mfg::Mit freundlichen Grüßen,{Enter}Erik Fastermann

::sgf::Sehr geehrte Frau

::sgh::Sehr geehrter Herr

::sgdh::Sehr geehrte Damen und Herren,{Enter}





; I'm using the F13 to F24 Hotkeys configured through the Logitech Gaming Software using this script: https://autohotkey.com/boards/viewtopic.php?t=40286&p=183796

; Run / Switch between applications and multiple windows of these applications with the following hotkeys
; inspired by Taran van Hemert (https://github.com/TaranVH/2nd-keyboard/blob/7c9131937b0e2d72b28301566588db26e0f8d87b/Almost%20All%20Windows%20Functions.ahk#L476)


; My Keyboard Layout (^: Ctrl, !: Alt)

;	M1: Standard										|	M2: Programming							|	M3: Gaming (!F19: TeamSpeak Mute Mic, !F20: TeamSpeak Mute Speaker -> configured through TeamSpeak)
	
;	F13: Firefox			F14: Windows Explorer					|									|
;	F15: Firefox New Tab		F16: Firefox YT-Subs + Twitch-Follows			|									|
;	F17: Spotify			F18: VLC						|				^F18: Notepad++				|
;	F19: LibreOffice		F20: Adobe Acrobat Reader				|	^F19: CMD		^F20: PowerShell			|
;	F21: IrfanView			F22: VirtualBox						|	^F21: PuTTY		^F22: FileZilla				|	!F21: TeamSpeak
;	F23: Gimp 2.8			F24: HitFilm 4 Express					|	^F23: GitHub Desktop	^F24: HitFilm 4 Express			|	!F23: League of Legends - Client	!F24: League of Legends - Game


; Standard

; Firefox
F13::
IfWinNotExist, ahk_exe firefox.exe
	Run, firefox.exe
	
if WinActive("ahk_exe firefox.exe")
	Send ^{PgDn}
else
	WinActivate ahk_exe firefox.exe
Return


; Windows Explorer
F14::
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, explorerwindows, ahk_class CabinetWClass

if WinActive("ahk_class CabinetWClass")
	GroupActivate, explorerwindows, r
else
	WinActivate ahk_class CabinetWClass
Return


; Firefox - New Tab
F15::
IfWinNotExist, ahk_exe firefox.exe
	Run, firefox.exe
	
WinActivate ahk_exe firefox.exe
Send ^{t}
Return


; Firefox - YT-Subs + Twitch-Follows
F16::
IfWinNotExist, ahk_exe firefox.exe
	Run, firefox.exe
	
Sleep 750 ; set higher if your system is slow
WinActivate ahk_exe firefox.exe

Send ^{t}
Send yt  ; set as keyword in Firefox for https://www.youtube.com/feed/subscriptions
Send {Enter}
Sleep 200  ; set higher if your system is slow

Send ^{t}
Send tw ; set as keyword in Firefox for https://www.twitch.tv/directory/following
Send {Enter}
Return


; Spotify
F17::
IfWinNotExist, ahk_exe Spotify.exe
	Run, %userprofile%\AppData\Roaming\Spotify\Spotify.exe
WinActivate ahk_exe Spotify.exe
Return


; VLC
F18::
IfWinNotExist, ahk_exe vlc.exe
	Run, C:\Program Files\VideoLAN\VLC\vlc.exe
GroupAdd, vlcwindows, ahk_exe vlc.exe

if WinActive("ahk_exe vlc.exe")
	GroupActivate, vlcwindows, r
else
	WinActivate ahk_exe vlc.exe
Return



; M1

; LibreOffice
F19::
IfWinNotExist, ahk_exe soffice.bin
	Run, soffice.exe
GroupAdd, librewindows, ahk_exe soffice.bin

if WinActive("ahk_exe soffice.bin")
	GroupActivate, librewindows, r
else
	WinActivate ahk_exe soffice.bin
Return


; Adobe Acrobat 32-Bit
F20::
IfWinNotExist, ahk_exe AcroRd32.exe
	Run, AcroRd32.exe

if WinActive("ahk_exe AcroRd32.exe")
	Send ^{tab}
else
	WinActivate ahk_exe AcroRd32.exe
Return


; IrfanView 32-Bit
F21::
IfWinNotExist, ahk_exe i_view32.exe
	Run, C:\Program Files (x86)\IrfanView\i_view32.exe
GroupAdd, irfanwindows, ahk_exe i_view32.exe

if WinActive("ahk_exe i_view32.exe")
	GroupActivate, irfanwindows, r
else
	WinActivate ahk_exe i_view32.exe
Return


; Virtual Box
F22::
IfWinNotExist, ahk_exe VirtualBox.exe
	Run, C:\Program Files\Oracle\VirtualBox\VirtualBox.exe
GroupAdd, virtwindows, ahk_exe VirtualBox.exe

if WinActive("ahk_exe VirtualBox.exe")
	GroupActivate, virtwindows, r
else
	WinActivate ahk_exe VirtualBox.exe
Return


; Gimp 2.8
F23::
IfWinNotExist, ahk_exe gimp-2.8.exe
	Run, C:\Program Files\GIMP 2\bin\gimp-2.8.exe
GroupAdd, gimpwindows, ahk_exe gimp-2.8.exe

if WinActive("ahk_exe gimp-2.8.exe")
	GroupActivate, gimpwindows, r
else
	WinActivate ahk_exe gimp-2.8.exe
Return


; HitFilm 4 Express
F24::
IfWinNotExist, ahk_exe HitFilmExpress.exe
	Run, C:\Program Files\FXHOME\HitFilm 4 Express\HitFilmExpress.exe
WinActivate ahk_exe HitFilmExpress.exe
Return



; M2

; Notepad++
^F18::
IfWinNotExist, ahk_exe notepad++.exe
	Run, notepad++.exe

if WinActive("ahk_exe notepad++.exe")
	Send ^{PgDn}
else
	WinActivate ahk_exe notepad++.exe
Return

; CMD - Admin
^F19::
IfWinNotExist, ahk_exe cmd.exe
	Run, *RunAs "cmd.exe"
GroupAdd, cmdwindows, ahk_exe cmd.exe

if WinActive("ahk_exe cmd.exe")
	GroupActivate, cmdwindows, r
else
	WinActivate ahk_exe cmd.exe
Return


; PowerShell - Admin
^F20::
IfWinNotExist, ahk_exe powershell.exe
	Run, *RunAs "powershell.exe"
GroupAdd, pswindows, ahk_exe powershell.exe

if WinActive("ahk_exe powershell.exe")
	GroupActivate, pswindows, r
else
	WinActivate ahk_exe powershell.exe
Return


; Putty
^F21::
IfWinNotExist, ahk_exe putty.exe
	Run, C:\Program Files (x86)\PuTTY\putty.exe  ; your PuTTY path
GroupAdd, puttywindows, ahk_exe putty.exe

if WinActive("ahk_exe putty.exe")
	GroupActivate, puttywindows, r
else
	WinActivate ahk_exe putty.exe
Return


; FileZilla
^F22::
IfWinNotExist, ahk_exe filezilla.exe
	Run, filezilla.exe
WinActivate ahk_exe filezilla.exe
Return


; GitHub Desktop
^F23::
IfWinNotExist, ahk_exe GitHubDesktop.exe
	Run, %userprofile%\AppData\Local\GitHubDesktop\GitHubDesktop.exe
WinActivate ahk_exe GitHubDesktop.exe
Return


; Atom
^F24::
IfWinNotExist, ahk_exe atom.exe
	Run, %userprofile%\AppData\Local\atom\atom.exe

if WinActive("ahk_exe atom.exe")
	Send ^{PgDn}
else
	WinActivate ahk_exe atom.exe
Return



; M3

; TeamSpeak - 64-Bit
!F21::
IfWinNotExist, ahk_exe ts3client_win64.exe
	Run, C:\Program Files\TeamSpeak 3 Client\ts3client_win64.exe
WinActivate ahk_exe ts3client_win64.exe
Return


; League of Legends - Client
!F23::
IfWinNotExist, ahk_exe LeagueClientUx.exe
	Run, C:\Riot Games\League of Legends\LeagueClient.exe
GroupAdd, lolwindows, ahk_exe LeagueClientUx.exe

if WinActive("ahk_exe LeagueClientUx.exe")
	GroupActivate, lolwindows, r
else
	WinActivate ahk_exe LeagueClientUx.exe
Return


; League of Legends - Game
!F24::WinActivate ahk_exe League of Legends.exe


*/














; older Functions - not used anymore

; The following Hotkeys are used to toggle playback and volume for Firefox on YouTube or Twitch while using another application (The last click you did in Firefox had to be on the player for this to work properly!)

; Space - Pause / Start
; F13::
; ControlSend,ahk_parent,{Space down}, ahk_exe firefox.exe
; Sleep 20
; ControlSend,ahk_parent,{Space up}, ahk_exe firefox.exe
; Return


; Arrow down - Volume down
; F15::
; ControlSend,ahk_parent,{Down down}, ahk_exe firefox.exe
; Sleep 20
; ControlSend,ahk_parent,{Down up}, ahk_exe firefox.exe
; Return


; Arrow up - Volume up
; F16::
; ControlSend,ahk_parent,{Up down}, ahk_exe firefox.exe
; Sleep 20
; ControlSend,ahk_parent,{Up up}, ahk_exe firefox.exe
; Return



; Control the Volume of Spotify over the mixer using nircmd (https://www.nirsoft.net/utils/nircmd.html) with the following hotkeys

; Volume down
; F17::Run, nircmd changeappvolume spotify.exe -0.1

; Volume up
; F18::Run, nircmd changeappvolume spotify.exe +0.1