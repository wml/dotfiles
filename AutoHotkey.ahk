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

#z::Run www.autohotkey.com

;^!n::
;IfWinExist Untitled - Notepad
;	WinActivate
;else
;	Run Notepad
;return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.
LCtrl & `;::AltTab   ; cycle windows with C-L

^F1::
IfWinExist Inbox - will.leszczuk@zocdoc.com - Microsoft Outlook
	WinActivate
return

^F2::
IfWinExist Calendar - will.leszczuk@zocdoc.com - Microsoft Outlook
	WinActivate
return

^F3::
If WinExist("ahk_class ApolloRuntimeContentWindow")
	WinActivate
return

^F5::
IfWinExist ZocDoc.vs2010 - Microsoft Visual Studio (Administrator)
	WinActivate
return

^F6::
IfWinExist -bash
	WinActivate
return

^F7::
IfWinExist Microsoft SQL Server Management Studio
	WinActivate
return

^F8::
IfWinExist SQL Server Profiler - [Untitled - 1 (WLESZCZUK)]
	WinActivate
return

^F9::
if WinExist("ahk_class Chrome_WidgetWin_0")
    WinActivate
else 
    if WinExist("ahk_class Chrome_WidgetWin_1")
        WinActivate
    return
return

^F10::
IfWinExist Administrator: C:\Windows\system32\cmd.exe
	WinActivate
return
