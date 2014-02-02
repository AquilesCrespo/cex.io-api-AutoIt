; *** Start added by AutoIt3Wrapper ***
#include <MsgBoxConstants.au3>
; *** End added by AutoIt3Wrapper ***
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=25 Utilities.ico
#AutoIt3Wrapper_Outfile=config(x86).exe
#AutoIt3Wrapper_Outfile_x64=config(x64).exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Comment=User API conf
#AutoIt3Wrapper_Res_Description=For Configuring the API Data
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_LegalCopyright=Aquiles Crespo @ 2014
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         Aquiles dos Santos Crespo

 Script Function:
	Save configurations to File ini.

#ce ----------------------------------------------------------------------------

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#include <Constants.au3>

$apiUserName = IniRead(@ScriptDir & "\User-API-ACC.ini", "UserAPIDetails", "UserName", "NULL")
$apiKey = IniRead(@ScriptDir & "\User-API-ACC.ini", "UserAPIDetails", "Key", "NULL")
$apiSecret = IniRead(@ScriptDir & "\User-API-ACC.ini", "UserAPIDetails", "Secret", "NULL")

#Region ### START Koda GUI section ### Form=C:\Users\Aquiles\Documents\GitHub\cex.io-api-AutoIt\sandbox\Base-Files-For APP-Development\config.exe-source\Form1.kxf
$Form1 = GUICreate("Config.exe", 250, 181, 192, 124)
GUISetIcon("C:\Users\Aquiles\Documents\GitHub\cex.io-api-AutoIt\sandbox\Base-Files-For APP-Development\config.exe-source\25 Utilities.ico", -1)
$Label1 = GUICtrlCreateLabel("User Name : ", 24, 16, 66, 17)
$Input1 = GUICtrlCreateInput($apiUserName, 104, 16, 121, 21)
$Label2 = GUICtrlCreateLabel("API Key : ", 24, 46, 51, 17)
$Input2 = GUICtrlCreateInput($apiKey, 104, 46, 121, 21)
$Label3 = GUICtrlCreateLabel("API Secret : ", 24, 80, 64, 17)
$Input3 = GUICtrlCreateInput($apiSecret, 104, 80, 121, 21)
$Button1 = GUICtrlCreateButton("Save to File", 88, 112, 75, 25)
$StatusBar1 = _GUICtrlStatusBar_Create($Form1)
Dim $StatusBar1_PartsWidth[1] = [-1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, @TAB & "By : Aquiles dos Santos Crespo", 0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $Button1
			IniWrite(@ScriptDir & "\User-API-ACC.ini", "UserAPIDetails", "UserName", GUICtrlRead($Input1))
			IniWrite(@ScriptDir & "\User-API-ACC.ini", "UserAPIDetails", "Key", GUICtrlRead($Input2))
			IniWrite(@ScriptDir & "\User-API-ACC.ini", "UserAPIDetails", "Secret", GUICtrlRead($Input3))
			MsgBox($MB_SYSTEMMODAL, "Saved...", "Saved to File.....", 2)
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd


