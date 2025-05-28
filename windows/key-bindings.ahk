#Requires AutoHotkey v2.0

edge := "C:\path\to\msedge.exe"
teams := "C:\path\to\ms-teams.exe"
outlook := "C:\path\to\outlook.exe"

; #<number> will map the function to WindowKey+<number>
#1::SwitchOrRunSSH("<user_id>", "server_name")
#9::SwitchOrRunSSH("<user_id>", "server_name")

#2::SwitchOrRunApp(edge)
#3::SwitchOrRunApp(teams)
#4::SwitchOrRunApp(outlook)
#5::SwitchOrRunTerminal()

return

; open or run a terminal locally
SwitchOrRunTerminal() {
    termName := "lcterm"
    for hwnd in WinGetList("ahk_exe WindowsTerminal.exe") {
        winT := WinGetTitle(hwnd)
        If InStr(winT, termName) {
            WinActivate(hwnd)
            return
        }
    }
    Run('wt.exe --maximized --focus --title lcterm')
}

; open or urn a terminal and ssh into the passed username@serverName
SwitchOrRunSSH(username, serverName) {
    title := serverName
    target := username . "@" . serverName
    ; even though we spawn the process with wt.exe, it will appear as WindowsTerminal.exe
    ; it is possible that wt.exe is an alias, but I am far to lazy to figure it out
    for hwnd in WinGetList("ahk_exe WindowsTerminal.exe") {
        winT := WinGetTitle(hwnd)
        If InStr(winT, termName) {
            WinActivate(hwnd)
            return
        }
    }
    Run('wt.exe --maximized --focus --title "' . title . '" ssh ' .target)
}

; if app is runnig, move it to focus
; if not running open it
SwitchOrRunApp(exe_path) {
    SplitPath exe_path, &exe_name
    wgl := WinGetList()
    for hwnd in wgl {
        pid := WinGetPid(hwnd)
        procId := ProcessExist(exe_name)
        if (pid == procId) {
            WinActivate(hwnd)
            return
        }
    }
    Run(exe_path)
}




