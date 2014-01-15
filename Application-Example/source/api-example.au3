#include <cex-io_api.au3>
#include <StrBetween.au3>

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

$Error = ObjEvent("AutoIt.Error", "_Error") ; Creates an error handler. If there's an error, the program won't crash. Isn't needed, but if your program is unstable, it keeps it going.

_ProcessReduceMemory(@AutoItPID) ; Isn't needed, but reduces memory so it hogs less resources
_ProcessReduceMemory("AutoIt3Wrapper.exe") ; Isn't needed, reduces memory so it hogs less resources

_GetTickerGHS_BTC()

; Write into console the GHS/BTC obtained in the web ticker API
ConsoleWrite(@CRLF & "GHS/BTC" & @CRLF & @CRLF & "Last : " & $Ticker_Data[0][0] & @CRLF & "High : " & $Ticker_Data[0][1] & @CRLF & "Low : " & $Ticker_Data[0][2] & @CRLF & "Volume : " & $Ticker_Data[0][3] & @CRLF & "Ask : " & $Ticker_Data[0][4] & @CRLF & "Timestamp : " & $Ticker_Data[0][5] & @CRLF) ; Run this from sciTE

; Write down in a msg Box
MsgBox(0, "GHS/BTC", "Last : " & $Ticker_Data[0][0] & @CRLF & "High : " & $Ticker_Data[0][1] & @CRLF & "Low : " & $Ticker_Data[0][2] & @CRLF & "Volume : " & $Ticker_Data[0][3] & @CRLF & "Ask : " & $Ticker_Data[0][4] & @CRLF & "Timestamp : " & $Ticker_Data[0][5] & @CRLF)

; or even make your ouwn gui

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("GHS/BTC Ticker", 242, 307, 192, 124)
$Group1 = GUICtrlCreateGroup("GHS/BTC", 8, 8, 225, 233)
$Label1 = GUICtrlCreateLabel("Last price:", 56, 40, 53, 17)
$Label2 = GUICtrlCreateLabel($Ticker_Data[0][0], 120, 40, 61, 17)
$Label3 = GUICtrlCreateLabel("High:", 56, 72, 29, 17)
$Label4 = GUICtrlCreateLabel($Ticker_Data[0][1], 120, 72, 61, 17)
$Label5 = GUICtrlCreateLabel("Low:", 56, 104, 27, 17)
$Label6 = GUICtrlCreateLabel ($Ticker_Data[0][2] ,120, 104, 61, 17)
$Label7 = GUICtrlCreateLabel("Volume:", 56, 136, 42, 17)
$Label8 = GUICtrlCreateLabel( $Ticker_Data[0][3], 120, 136, 61, 17)
$Label9 = GUICtrlCreateLabel("Ask:", 56, 168, 25, 17)
$Label10 = GUICtrlCreateLabel( $Ticker_Data[0][4], 120, 168, 61, 17)
$Label11 = GUICtrlCreateLabel("Timestamp:", 56, 200, 58, 17)
$Label12 = GUICtrlCreateLabel( $Ticker_Data[0][5], 120, 200, 64, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd


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
