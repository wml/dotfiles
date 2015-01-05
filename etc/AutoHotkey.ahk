; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.

LCtrl & `;::AltTab   ; cycle windows with C-L

^V::+INS

$^a:: Send {HOME}
$^e:: Send {END}
$^p:: Send {UP}
$^n:: Send {DOWN}
$^f:: Send {RIGHT}
$!f:: Send {Ctrl Down}{RIGHT}{Ctrl Up}
$^b:: Send {LEFT}
$!b:: Send {Ctrl Down}{LEFT}{Ctrl Up}
$^h:: Send {Backspace}
$^d:: Send {DEL}
$^j:: Send {Enter}
$^_:: Send ^z
$^v:: Send {PGDN}
$!v:: Send {PGUP}
$^k:: Send {Shift down}{END}{DEL}{shift up}
$!>:: Send {Ctrl Down}{END}{Ctrl Up}
$!<:: Send {Ctrl Down}{HOME}{Ctrl Up}

#n:: Send ^n
#d:: Send ^d
#c:: Send ^c
#v:: Send ^v
#f:: Send ^f
#s:: Send ^s
#w:: Send ^w
#j:: Send ^j
#k:: Send ^k
#a:: Send ^a
#x:: Send ^x
#b:: Send ^b

^0:: Suspend

^.::^V ; outlook "move to folder"

#include %A_ScriptDir%\local.ahk
