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
		=> Trade history GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
		=> Account balance GHS, BTC, NMC, LTC, IXC, DVC
		=> Open orders
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
; 	=> _GetCexIOTicker() : Get Ticker data, Returns JSON dictionary
;
; Order Books :
;
; 	=> _GetCexIOOrdersBook() : Get Order Book data, Returns JSON dictionary
;
; Trade history :
; 	=> _GetCexIOTradeHistory() : Get Trade history data, Returns JSON dictionary
;
; Account balance :
; 	=> _GetCexIOAccountBallance() : Get Account balance data From User Cex.io API,
;									Returns JSON dictionary
;
; Open orders :
; 	=> _GetCexIOOpenOrders() : Get Open orders data From User Cex.io API,
;							   Returns JSON dictionary
;
; #CURRENT END# ================================================================

; ==============================================================================
; ================================ Tickers =====================================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _GetCexIOTicker($CurrecyPair)
 Description : GET https://cex.io/api/ticker/$CurrecyPair
 				Returns JSON dictionary:
					last - last BTC price
 					high - last 24 hours price high
 					low - last 24 hours price low
					volume - last 24 hours volume
 					bid - highest buy order
 					ask - lowest sell order
 Parameters :
	=> $CurrecyPair : Currency Pairs Availiable GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
					  Has the GHS/BTC as default...
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetCexIOTicker($CurrecyPair="GHS/BTC")
	Return _HTTP_Request("https://cex.io/api/ticker/" & $CurrecyPair)
EndFunc ; =======> _GetTicker() END

; ============================== Tickers END ===================================

; ==============================================================================
; ============================= Order Books ====================================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _GetCexIOOrdersBook()
 Description : GET https://cex.io/api/order_book/GHS/BTC , and, Returns JSON dictionary
				with "bids" and "asks". Each is a list of open orders and each order
				is represented as a list of price and amount.
 Parameters :
	=> $CurrecyPair : Currency Pairs Availiable GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetCexIOOrdersBook($CurrecyPair="GHS/BTC")
	Return  _HTTP_Request("https://cex.io/api/order_book/" & $CurrecyPair)
EndFunc ; =======> _GetCexIOOrdersBook() END

; =========================== Order Books END ==================================

; ==============================================================================
; ============================ Trade history ===================================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _GetCexIOTradeHistory()
 Description : GET https://cex.io/api/trade_history/GHS/BTC ,
				Params:
					=> since - return trades with tid >= since

					Returns a list of recent trades, where each
					trade is a JSON dictionary:
						=> tid - trade id
						=> amount - trade amount
						=> price - price
						=> date - UNIX timestamp

Parameters :
	=> $CurrecyPair : Currency Pairs Availiable GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC

 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetCexIOTradeHistory($CurrecyPair="GHS/BTC",$advanced=FALSE,$since="")
	If $advanced = FALSE Then $Return = _HTTP_Request("https://cex.io/api/trade_history/" & $CurrecyPair)
	If $advanced = TRUE Then $Return = _HTTP_Request("https://cex.io/api/trade_history/" & $CurrecyPair,"POST","TradeHistory",$since)
	Return  $Return
EndFunc ; =======> _GetCexIOTradeHistory END

; ========================== Trade history END =================================

; ==============================================================================
; =========================== Account balance ==================================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _GetCexIOAccountBallance()
 Description : POST https://cex.io/api/balance/
			   Params:
					key - API key
					signature - signature
					nonce - nonce

			   Returns JSON dictionary:
					available - available balance
					orders - balance in pending orders
					bonus - referral program bonus

 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetCexIOAccountBallance()
	Return _HTTP_Request("https://cex.io/api/balance/","POST","UserAuth")
EndFunc ; =======> _GetCexIOAccountBallance END

; ========================= Account balance END ================================

; ==============================================================================
; ============================= Open orders ====================================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _GetCexIOOpenOrders()
 Description : POST https://cex.io/api/open_orders/$CurrecyPair
			   Params:
					key - API key
					signature - signature
					nonce - nonce
			   Returns JSON list of open orders. Each order is represented as
			   dictionary:
					id - order id
					time - timestamp
					type - buy or sell
					price - price
					amount - amount
					pending - pending amount (if partially executed)

Parameters :
	=> $CurrecyPair : Currency Pairs Availiable GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC

 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetCexIOOpenOrders($CurrecyPair="GHS/BTC")
	Return _HTTP_Request("https://cex.io/api/open_orders/" & $CurrecyPair,"POST","UserAuth")
EndFunc ; =======> _GetCexIOOpenOrders() END

; =========================== Open orders END ==================================

; ==============================================================================
; ============================= Extra Funcs ====================================
; ==============================================================================
; Comments : Some Functions Bellow Founded on the Internet
;

#cs ----------------------------------------------------------------------------

 Name : _CexIOReduceProcessMemory()
 Description :
 Parameters :
 Author:

#ce ----------------------------------------------------------------------------
Func _CexIOReduceProcessMemory($iPID) ; Once again, not made by me, but it makes it so the script takes up less memory. :3
        Local $iProcExists = ProcessExists($iPID)
        If Not $iProcExists Then Return SetError(1, 0, 0)
        If IsString($iPID) Then $iPID = $iProcExists
        Local $hOpenProc, $aResult
        $hOpenProc = DllCall("Kernel32.dll", "int", "OpenProcess", "int", 0x1F0FFF, "int", False, "int", $iPID)
        $aResult = DllCall("Kernel32.dll", "int", "SetProcessWorkingSetSize", "hwnd", $hOpenProc[0], "int", -1, "int", -1)
        DllCall("Kernel32.dll", "int", "CloseHandle", "int", $hOpenProc[0])
        If Not IsArray($aResult) Or $aResult[0] = 0 Then Return SetError(2, 0, 0)
        Return $aResult[0]
EndFunc   ; =======> _CexIOReduceProcessMemory END

#cs ----------------------------------------------------------------------------

 Name : _CexIOErrorsOutput()
 Description :
 Parameters :
 Author:

#ce ----------------------------------------------------------------------------
Func _CexIOErrorsOutput() ; If there's any error, it'll just say there's an error, rather than crashing. Isn't really needed in this script, but you never know when something might happen.
		; ConsoleWrite("There was an error...." & @CRLF)
		MsgBox($MB_SYSTEMMODAL, "Error", "There was an error...." & @CRLF & @CRLF & "This message box will timeout after 10 seconds or select the OK button." & @CRLF, 10)
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
