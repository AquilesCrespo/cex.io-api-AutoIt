#include-once
; #FUNCTION# ====================================================================================================================
; Name...........: _StrBetween
; Description ...: Search Text Between Strings
; Syntax.........: _StrBetween($sArg_01, $sArg_02, $sArg_03)
; Parameters ....: $sArg_01  - Text or String Containing Data to make the search.
;				   $sArg_02  - First Marker
;				   $sArg_03  - Second Marker
; Return values .: Success      - True
;                  Failure      - False
; Author ........: UNKNOWNN (Founded on Autoit Foruns don't remember thread)
; Modified.......:
; Remarks .......: Requires Windows XP Minimum
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _StrBetween($sArg_01, $sArg_02, $sArg_03)
        Local $sStr_X, $sStr_Y
        $sStr_X = StringInStr($sArg_01, $sArg_02) + StringLen($sArg_02)
        $sStr_Y = StringInStr(StringTrimLeft($sArg_01, $sStr_X), $sArg_03)
        Return StringMid($sArg_01, $sStr_X, $sStr_Y)
	EndFunc   ;==>_StrBetween

; #FUNCTION in research# ========================================================================================================
; Description ...: Search Text Between Strings
; 				   Still Researching this Functions
; Author ........: UNKNOWNN (Founded on Autoit Foruns don't remember thread)
; Modified.......:
; Remarks .......: Requires Windows XP Minimum
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================

Func stringbetween($str, $start, $end)
    $pos = StringInStr($str, $start)
    If Not @error Then
        $str = StringTrimLeft($str, $pos + StringLen($start) - 1)
        $pos = StringInStr($str, $end)
        If Not @error Then
            $str = StringTrimRight($str, StringLen($str) - $pos + 1)
            Return $str
        EndIf
    EndIf
EndFunc

; ALTERNATIVE 1 to the "stringbetween" function
Func _SRE_BetweenEX($s_String, $s_Start, $s_End, $iCase = 'i')
   If $iCase <> 'i' Then $iCase = ''
   $a_Array = StringRegExp ($s_String, '(?' & $iCase & _
           ':' & $s_Start & ')(.*?)(?' & $iCase & _
           ':' & $s_End & ')', 3)
   If @extended & IsArray($a_Array) Then Return $a_Array
   Return SetError(1, 0, 0)
EndFunc;==>_SRE_BetweenEX