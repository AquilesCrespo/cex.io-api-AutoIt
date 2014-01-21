#include-once
#cs ----------------------------------------------------------------------------

 Title :
 AutoIt Version: 3.3.8.1 ++
 Author : Aquiles dos Santos Crespo <aquilescrespo@gmail.com>

 BTC   :	1H1WzmtLcXQvJqX79AwF3SqXfXmVSRs194 (Donate Free)

 Script Function:
	Base Function script for using with the web api from cex.io server.

	Main Functions from this script:
		=> Ticker GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
		=> Order Book GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
		=> Trade history GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC (Still in Progress)
		=> Account balance GHS, BTC, NMC, LTC, IXC, DVC (Still in Progress)
		=> Open orders (Still in Progress)
		=> Cancel order (Still in Progress)
		=> Place order (Still in Progress)
		=> Hash Rate (Still in Progress)
		=> Workers' Hash Rate (Still in Progress)

#ce ----------------------------------------------------------------------------

; #includes# ===================================================================

#include <MsgBoxConstants.au3>

; #includes END# ===============================================================

; #CURRENT# ====================================================================
;
; Variables :
;
; => No Variables to Use as API suport
;
; Functions :
;
; =========================  Public Data Functions =============================
;
; Tickers :
;
; 	=> _GetTickerGHS_BTC() : GHS/BTC Ticker data, Returns JSON dictionary
; 	=> _GetTickerLTC_BTC() : LTC/BTC Ticker data, Returns JSON dictionary
; 	=> _GetTickerNMC_BTC() : NMC/BTC Ticker data, Returns JSON dictionary
; 	=> _GetTickerGHS_NMC() : GHS/NMC Ticker data, Returns JSON dictionary
; 	=> _GetTickerBF1_BTC() : BF1/BTC Ticker data, Returns JSON dictionary
;
; Order Books :
;
; 	=> _GetOrdersBookGHS_BTC() : GHS/BTC Order Book data, Returns JSON dictionary
; 	=> _GetOrdersBookLTC_BTC() : LTC/BTC Order Book data, Returns JSON dictionary
; 	=> _GetOrdersBookNMC_BTC() : NMC/BTC Order Book data, Returns JSON dictionary
; 	=> _GetOrdersBookGHS_NMC() : GHS/NMC Order Book data, Returns JSON dictionary
; 	=> _GetOrdersBookBF1_BTC() : BF1/BTC Order Book data, Returns JSON dictionary
;
; Trade history :
; 	=>
;
; #CURRENT END# ================================================================

; ==============================================================================
; ================================ Tickers =====================================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _GetTickerGHS_BTC()
 Description : GET https://cex.io/api/ticker/GHS/BTC
 				Returns JSON dictionary:
					last - last BTC price
 					high - last 24 hours price high
 					low - last 24 hours price low
					volume - last 24 hours volume
 					bid - highest buy order
 					ask - lowest sell order
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetTickerGHS_BTC()
	Return _HTTP_Request("https://cex.io/api/ticker/GHS/BTC")
EndFunc ; =======> _GetTickerGHS_BTC() END

#cs ----------------------------------------------------------------------------

 Name : _GetTickerLTC_BTC()
 Description : GET https://cex.io/api/ticker/LTC/BTC
 				Returns JSON dictionary:
					last - last BTC price
 					high - last 24 hours price high
 					low - last 24 hours price low
					volume - last 24 hours volume
 					bid - highest buy order
 					ask - lowest sell order
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetTickerLTC_BTC()
	Return _HTTP_Request("https://cex.io/api/ticker/LTC/BTC")
EndFunc ; =======> _GetTickerLTC_BTC() END

#cs ----------------------------------------------------------------------------

 Name : _GetTickerNMC_BTC()
 Description : GET https://cex.io/api/ticker/NMC/BTC
 				Returns JSON dictionary:
					last - last BTC price
 					high - last 24 hours price high
 					low - last 24 hours price low
					volume - last 24 hours volume
 					bid - highest buy order
 					ask - lowest sell order
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetTickerNMC_BTC()
	Return _HTTP_Request("https://cex.io/api/ticker/NMC/BTC")
EndFunc ; =======> _GetTicker_GetTickerNMC_BTC() END

#cs ----------------------------------------------------------------------------

 Name : _GetTickerGHS_NMC()
 Description : GET https://cex.io/api/ticker/GHS/NMC
 				Returns JSON dictionary:
					last - last BTC price
 					high - last 24 hours price high
 					low - last 24 hours price low
					volume - last 24 hours volume
 					bid - highest buy order
 					ask - lowest sell order
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetTickerGHS_NMC()
	Return _HTTP_Request("https://cex.io/api/ticker/GHS/NMC")
EndFunc ; =======> _GetTickerGHS_NMC() END

#cs ----------------------------------------------------------------------------

 Name : _GetTickerBF1_BTC()
 Description : GET https://cex.io/api/ticker/BF1/BTC
 				Returns JSON dictionary:
					last - last BTC price
 					high - last 24 hours price high
 					low - last 24 hours price low
					volume - last 24 hours volume
 					bid - highest buy order
 					ask - lowest sell order
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetTickerBF1_BTC()
	Return  _HTTP_Request("https://cex.io/api/ticker/BF1/BTC")
EndFunc ; =======> _GetTickerBF1_BTC() END

; ============================== Tickers END ===================================

; ==============================================================================
; ============================= Order Books ====================================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _GetOrdersBookGHS_BTC()
 Description : GET https://cex.io/api/order_book/GHS/BTC , and, Returns JSON dictionary
				with "bids" and "asks". Each is a list of open orders and each order
				is represented as a list of price and amount.
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetOrdersBookGHS_BTC()
	Return  _HTTP_Request("https://cex.io/api/order_book/GHS/BTC")
EndFunc ; =======> _GetTickerBF1_BTC() END

#cs ----------------------------------------------------------------------------

 Name : _GetOrdersBookLTC_BTC()
 Description : GET https://cex.io/api/order_book/LTC/BTC , and, Returns JSON dictionary
				with "bids" and "asks". Each is a list of open orders and each order
				is represented as a list of price and amount.
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetOrdersBookLTC_BTC()
	Return  _HTTP_Request("https://cex.io/api/order_book/LTC/BTC")
EndFunc ; =======> _GetTickerBF1_BTC() END

#cs ----------------------------------------------------------------------------

 Name : _GetOrdersBookNMC_BTC()
 Description : GET https://cex.io/api/order_book/NMC/BTC , and, Returns JSON dictionary
				with "bids" and "asks". Each is a list of open orders and each order
				is represented as a list of price and amount.
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetOrdersBookNMC_BTC()
	Return  _HTTP_Request("https://cex.io/api/order_book/NMC/BTC")
EndFunc ; =======> _GetTickerBF1_BTC() END

#cs ----------------------------------------------------------------------------

 Name : _GetOrdersBookGHS_NMC()
 Description : GET https://cex.io/api/order_book/GHS/NMC , and, Returns JSON dictionary
				with "bids" and "asks". Each is a list of open orders and each order
				is represented as a list of price and amount.
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetOrdersBookGHS_NMC()
	Return  _HTTP_Request("https://cex.io/api/order_book/GHS/NMC")
EndFunc ; =======> _GetTickerBF1_BTC() END

#cs ----------------------------------------------------------------------------

 Name : _GetOrdersBookBF1_BTC()
 Description : GET https://cex.io/api/order_book/BF1/BTC , and, Returns JSON dictionary
				with "bids" and "asks". Each is a list of open orders and each order
				is represented as a list of price and amount..
 Parameters : -----
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetOrdersBookBF1_BTC()
	Return  _HTTP_Request("https://cex.io/api/order_book/BF1/BTC")
EndFunc ; =======> _GetTickerBF1_BTC() END

; =========================== Order Books END ==================================

; ==============================================================================
; ============================ Trade history ===================================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _GetTradeHistoryGHS_BTC()
 Description : GET https://cex.io/api/trade_history/GHS/BTC ,
				Params:
					=> since - return trades with tid >= since

					Returns a list of recent trades, where each
					trade is a JSON dictionary:
						=> tid - trade id
						=> amount - trade amount
						=> price - price
						=> date - UNIX timestamp

 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetTradeHistoryGHS_BTC($advanced=FALSE,$since="")
	If $advanced = FALSE Then $Return = _HTTP_Request("https://cex.io/api/trade_history/GHS/BTC")
	If $advanced = TRUE Then $Return = _HTTP_Request("https://cex.io/api/trade_history/GHS/BTC","POST","TradeHistory",$since)
	Return  $Return
EndFunc ; =======> __GetTradeHistoryGHS_BTC END

; ========================== Trade history END =================================

; ==============================================================================
; ============================= Extra Funcs ====================================
; ==============================================================================
; Comments : Some Functions Bellow Founded on the Internet
;

#cs ----------------------------------------------------------------------------

 Name : _ProcessReduceMemory()
 Description :
 Parameters :
 Author: Unknown (Don't remember the Web Site were i taked out)

#ce ----------------------------------------------------------------------------
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
EndFunc   ; =======> _ProcessReduceMemory END

#cs ----------------------------------------------------------------------------

 Name : _Error()
 Description :
 Parameters :
 Author: Unknown (Don't remember the Web Site were i taked out)

#ce ----------------------------------------------------------------------------
Func _Error() ; If there's any error, it'll just say there's an error, rather than crashing. Isn't really needed in this script, but you never know when something might happen.
        ; ConsoleWrite("Errored" & @CRLF)
		MsgBox($MB_SYSTEMMODAL, "Error", "There was an error...." & @CRLF & "This message box will timeout after 10 seconds or select the OK button." & @CRLF, 10)
EndFunc   ; =======> _Error END

#cs ----------------------------------------------------------------------------

 Name : _RunCMD()
 Author : Unknown (Don't remember the Web Site were i taked out)
 Description : Run program in CMD.exe window with changed title. It will Exit
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
	Return RunWait(@ComSpec & " /C title " & $sTitle & "|" & $sCommand)
EndFunc ; =======> _RunCMD() END

#cs ----------------------------------------------------------------------------
 Name...........: _StrBetween
 Description ...: Search Text Between Strings
 Syntax.........: _StrBetween($sArg_01, $sArg_02, $sArg_03)
 Parameters ....: $sArg_01  - Text or String Containing Data to make the search.
				   $sArg_02  - First Marker
				   $sArg_03  - Second Marker
 Return values .: Success      - True
                  Failure      - False
 Author ........: UNKNOWNN (Founded on Autoit Foruns don't remember thread)
 Modified.......:
 Remarks .......: Requires Windows XP Minimum
 Related .......:
 Link ..........:
 Example .......:
#ce ----------------------------------------------------------------------------
Func _StrBetween($sArg_01, $sArg_02, $sArg_03)
        Local $sStr_X, $sStr_Y
        $sStr_X = StringInStr($sArg_01, $sArg_02) + StringLen($sArg_02)
        $sStr_Y = StringInStr(StringTrimLeft($sArg_01, $sStr_X), $sArg_03)
        Return StringMid($sArg_01, $sStr_X, $sStr_Y)
	EndFunc   ; =======> _StrBetween

#cs ----------------------------------------------------------------------------

			Some Extra Functions in Research

 Description ...: Search Text Between Strings
 				   Still Researching this Functions
 Author ........: UNKNOWNN (Founded on Autoit Foruns don't remember thread)
 Modified.......:
 Remarks .......: Requires Windows XP Minimum
 Related .......:
 Link ..........:
 Example .......:
#ce ----------------------------------------------------------------------------

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
EndFunc ; =======>
; ALTERNATIVE 1 to the "stringbetween" function
Func _SRE_BetweenEX($s_String, $s_Start, $s_End, $iCase = 'i')
   If $iCase <> 'i' Then $iCase = ''
   $a_Array = StringRegExp ($s_String, '(?' & $iCase & _
           ':' & $s_Start & ')(.*?)(?' & $iCase & _
           ':' & $s_End & ')', 3)
   If @extended & IsArray($a_Array) Then Return $a_Array
   Return SetError(1, 0, 0)
EndFunc; =======> _SRE_BetweenEX


; ============================ Extra Funcs END =================================

; #INTERNAL_USE_ONLY# ==========================================================
;
; Variables :
; => ....
;
; Functions:
; => _HTTP_Request() : Requests the GET or Post Method for the Functions of This API
; => _Post_Data() : Generates the post data for the API
;
; #INTERNAL_USE_ONLY END# ======================================================

#cs ----------------------------------------------------------------------------

 Name : _HTTP_Request()
 Description :
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _HTTP_Request($url,$methode="GET",$type="",$data="")
	Local $HTTP = ObjCreate("winhttp.winhttprequest.5.1") ; Creates the HTTP requests variable.
	$HTTP.Open($methode, $url, False) ; Opens a GET request to the IP address or site url
	$HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5") ; Sets the User Agent
	Switch $methode
		Case "GET"
			$HTTP.Send() ; Not sure what this does, really. I guess it just tells it to send with the desired credentials
		Case "POST"
			$HTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded"); Sets the Content Type
			$HTTP.Send(_Post_Data($type,$data)) ; Not sure what this does, really. I guess it just tells it to send with the desired credentials
	EndSwitch
	Return $HTTP.ResponseText ; The response of what it just sent
EndFunc ; =======> _HTTP_Request() END

#cs ----------------------------------------------------------------------------

 Name : _Post_Data()
 Description :
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _Post_Data($methode,$data="")
	Switch $methode
		Case "TradeHistory"
			$POST_info = "since=" & $data
		Case "UserAuth"
			_RunCMD('Firefox Loader....', 'START /max /d "' & @ScriptDir & '" api-sig-Gen.py' )
			Sleep(100)
			$apiKey = IniRead(@ScriptDir & "\User-API-Conf.ini", "UserAPIDetails", "Key", "NULL")
			$apinonce = IniRead(@ScriptDir & "\User-API-Conf.ini", "GeneratedDetails", "nonce", "NULL")
			$apisig = IniRead(@ScriptDir & "\User-API-Conf.ini", "GeneratedDetails", "signature", "NULL")
			$POST_info = "key=" & $apiKey & "&signature=" & $apisig & "&nonce=" & $apinonce
	EndSwitch
	Return $POST_info ; Returns The response of the Post Data
EndFunc ; =======> _Post_Data() END
