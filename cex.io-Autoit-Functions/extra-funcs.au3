#include-once

Func _ProcessReduceMemory($iPID) ; Once again, not made by me, but it makes it so the script takes up less memory. :3
        Local $iProcExists = ProcessExists($iPID)
        If Not $iProcExists Then Return SetError(1, 0, 0)
        If IsString($iPID) Then $iPID = $iProcExists
        Local $hOpenProc, $aResult
        $hOpenProc = DllCall("Kernel32.dll", "int", "OpenProcess", "int", 0x1F0FFF, "int", False, "int", $iPID)
        $aResult = DllCall("Kernel32.dll", "int", "SetProcessWorkingSetSize", "hwnd", $hOpenProc[0], "int", -1, "int", -1)
        DllCall("Kernel32.dll", "int", "CloseHandle", "int", $hOpenProc[0])
        If Not IsArray($aResult) Or $aResult[0] = 0 Then Return SetError(2, 0, 0)
        Return $aResult[0]
EndFunc   ;==>_ProcessReduceMemory

Func _Error() ; If there's any error, it'll just say there's an error, rather than crashing. Isn't really needed in this script, but you never know when something might happen.
        ConsoleWrite("Errored" & @CRLF)
EndFunc   ;==>_Error

#cs ----------------------------------------------------------------------------
 Function Name : _RunCMD($sTitle, $sCommand)

 Author : Unknown (Don't remember the Web Site were i taked out)

 Function : Run program in CMD.exe window with changed title. It will Exit
 			 After Execution

 Parameters :
		=> $sTitle : CMD window Title
		=> $sCommand : Command to run

 How to Use:
	=> _RunCMD('Conect To VPN....', 'rasdial "My VPN" username password')
	=> _RunCMD('Disconect From VPN....', 'rasdial "My VPN" /disconect')
	=> _RunCMD('IP Checker....', 'START /max /d "C:\Program Files\Mozilla Firefox" firefox.exe "http://www.whatismyipaddress.com/"' )
#ce ----------------------------------------------------------------------------
Func _RunCMD($sTitle, $sCommand) ; Returns PID of Run.
	Return Run(@ComSpec & " /C title " & $sTitle & "|" & $sCommand)
EndFunc