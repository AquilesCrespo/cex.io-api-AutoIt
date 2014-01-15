#include-once
#cs ----------------------------------------------------------------------------

 Title :
 AutoIt Version: 3.3.8.1 ++
 Author : Aquiles dos Santos Crespo <aquilescrespo@gmail.com>
 Company: DjinnSoftWorks (DSW) <djinnsoftworks@gmail.com>

 BTC   :	1H1WzmtLcXQvJqX79AwF3SqXfXmVSRs194

Donate Free

 Script Function:
	Base Function script for using with the web api from cex.io server.

	Main Functions from this script:
		=> Ticker GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
		=> Availiable Balance

#ce ----------------------------------------------------------------------------

; #includes# ===================================================================

; #includes END# ===============================================================

; #VARIABLES# ==================================================================

; Globals
;
; Global array $Ticker_Data[][] : for storing the base values retrived from the
; 								  GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC cex.io api
;
; Parameters :
;	=> $Ticker_Data[0][] : GHS/BTC
;			=> $Ticker_Data[0][0] : last - last BTC price
;			=> $Ticker_Data[0][1] : high - last 24 hours BTC price high
;			=> $Ticker_Data[0][2] : low - last 24 hours BTC price low
;			=> $Ticker_Data[0][3] : volume - last 24 hours volume
;			=> $Ticker_Data[0][4] : ask - lowest BTC sell order
;			=> $Ticker_Data[0][5] : timestamp - Time stamp of this info
;
;	=> $Ticker_Data[1][] : LTC/BTC
;			=> $Ticker_Data[1][0] : last - last BTC price
;			=> $Ticker_Data[1][1] : high - last 24 hours BTC price high
;			=> $Ticker_Data[1][2] : low - last 24 hours BTC price low
;			=> $Ticker_Data[1][3] : volume - last 24 hours volume
;			=> $Ticker_Data[1][4] : ask - lowest BTC sell order
;			=> $Ticker_Data[1][5] : timestamp - Time stamp of this info
;
;	=> $Ticker_Data[2][] : NMC/BTC
;			=> $Ticker_Data[2][0] : last - last BTC price
;			=> $Ticker_Data[2][1] : high - last 24 hours BTC price high
;			=> $Ticker_Data[2][2] : low - last 24 hours BTC price low
;			=> $Ticker_Data[2][3] : volume - last 24 hours volume
;			=> $Ticker_Data[2][4] : ask - lowest BTC sell order
;			=> $Ticker_Data[2][5] : timestamp - Time stamp of this info
;
;	=> $Ticker_Data[3][] : GHS/NMC
;			=> $Ticker_Data[3][0] : last - last NMC price
;			=> $Ticker_Data[3][1] : high - last 24 hours NMC price high
;			=> $Ticker_Data[3][2] : low - last 24 hours NMC price low
;			=> $Ticker_Data[3][3] : volume - last 24 hours volume
;			=> $Ticker_Data[3][4] : ask - lowest NMC sell order
;			=> $Ticker_Data[3][5] : timestamp - Time stamp of this info
;
;	=> $Ticker_Data[4][] : BF1/BTC
;			=> $Ticker_Data[4][0] : last - last BTC price
;			=> $Ticker_Data[4][1] : high - last 24 hours BTC price high
;			=> $Ticker_Data[4][2] : low - last 24 hours BTC price low
;			=> $Ticker_Data[4][3] : volume - last 24 hours volume
;			=> $Ticker_Data[4][4] : ask - lowest BTC sell order
;			=> $Ticker_Data[4][5] : timestamp - Time stamp of this info
;
Global $Ticker_Data[5][6]
;
; Global array  $Availiable_Balance_info[] , $Availiable_Balance[] , $Availiable_Amount_in_Orders[5] :
;
;	For storing the base values retrived from the  availiable balance cex.io api
;
; Parameters :
;	=> $Availiable_Balance_info[0] : Timestamp
;	=> $Availiable_Balance_info[1] : Username
;
;	=> $Availiable_Balance[0] : Availiable BTC Ballance
;	=> $Availiable_Balance[1] : Availiable GHS Ballance
;	=> $Availiable_Balance[2] : Availiable ICX Ballance
;	=> $Availiable_Balance[3] : Availiable NMC Ballance
;	=> $Availiable_Balance[4] : Availiable DVC Ballance
;
;	=> $Availiable_Amount_in_Orders[0] : BTC Order Ballance
;	=> $Availiable_Amount_in_Orders[1] : GHS Order Ballance
;	=> $Availiable_Amount_in_Orders[2] : ICX Order Ballance (Do Not Use , Not inserted yet)
;	=> $Availiable_Amount_in_Orders[3] : NMC Order Ballance
;	=> $Availiable_Amount_in_Orders[4] : DVC Order Ballance (Do Not Use , Not inserted yet)
;
Global $Availiable_Balance_info[2]
Global $Availiable_Balance[5]
Global $Availiable_Amount_in_Orders[5]
;
; #VARIABLES END# ==============================================================

; #CURRENT# ====================================================================
; $Ticker_Data[5][6] : For Data Output
; $Availiable_Balance_info[2] : For Data Output
; $Availiable_Balance[5] : For Data Output
; $Availiable_Amount_in_Orders[5] : For Data Output
; _GetTickerGHS_BTC() : Function for the GHS/BTC Ticker
; _GetTickerLTC_BTC() : Function for the LTC/BTC Ticker
; _GetTickerNMC_BTC() : Function for the NMC/BTC Ticker
; _GetTickerGHS_NMC() : Function for the GHS/NMC Ticker
; _GetTickerBF1_BTC() : Function for the BF1/BTC Ticker
; #CURRENT END# ================================================================

; #INTERNAL_USE_ONLY# ==========================================================
; List of Variables and Functions Used Internaly Only
; #INTERNAL_USE_ONLY END# ======================================================

Func _HTTP_Request($url,$methode="GET")
	Local $HTTP = ObjCreate("winhttp.winhttprequest.5.1") ; Creates the HTTP requests variable. I name it relevent to what the variable does
	$HTTP.Open($methode, $url, False) ; Opens a GET request to the IP address site, basically it's viewing the page source
	$HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5") ; Sets the User Agent
	Switch $methode
		Case "GET"
			$HTTP.Send() ; Not sure what this does, really. I guess it just tells it to send with the desired credentials
		Case "POST"
			_RunCMD('Firefox Loader....', 'START /max /d "' & @ScriptDir & '" api-sig-Gen.py' )
			$apiKey = IniRead(@ScriptDir & "\User-API-Conf.ini", "UserAPIDetails", "Key", "NULL")
			$apinonce = IniRead(@ScriptDir & "\User-API-Conf.ini", "GeneratedDetails", "nonce", "NULL")
			$apisig = IniRead(@ScriptDir & "\User-API-Conf.ini", "GeneratedDetails", "signature", "NULL")
			$POST_info = "key=" & $apiKey & "&signature=" & $apisig & "&nonce=" & $apinonce
			$HTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			$HTTP.Send($POST_info) ; Not sure what this does, really. I guess it just tells it to send with the desired credentials
	EndSwitch
	Return $HTTP.ResponseText ; The response of what it just sent
EndFunc

Func _GetTickerGHS_BTC()
	Local $HTTP = ObjCreate("winhttp.winhttprequest.5.1") ; Creates the HTTP requests variable. I name it relevent to what the variable does
	$HTTP.Open("GET", "https://cex.io/api/ticker/GHS/BTC", False) ; Opens a GET request to the IP address site, basically it's viewing the page source
	$HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5") ; Sets the User Agent
	$HTTP.Send() ; Not sure what this does, really. I guess it just tells it to send with the desired credentials
	$HTTP.ResponseText ; The response of what it just sent
	$Ticker_Data[0][0] = _StrBetween($HTTP.ResponseText, '"last":"', '"')
	$Ticker_Data[0][1] = _StrBetween($HTTP.ResponseText, '"high":"', '"')
	$Ticker_Data[0][2] = _StrBetween($HTTP.ResponseText, '"low":"', '"')
	$Ticker_Data[0][3] = _StrBetween($HTTP.ResponseText, '"volume":"', '"')
	$Ticker_Data[0][4] = _StrBetween($HTTP.ResponseText, '"ask":"', '"')
	$Ticker_Data[0][5] = _StrBetween($HTTP.ResponseText, '"timestamp":"', '"')
EndFunc

Func _GetTickerLTC_BTC()
	Local $HTTP = ObjCreate("winhttp.winhttprequest.5.1") ; Creates the HTTP requests variable. I name it relevent to what the variable does
	$HTTP.Open("GET", "https://cex.io/api/ticker/LTC/BTC", False) ; Opens a GET request to the IP address site, basically it's viewing the page source
	$HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5") ; Sets the User Agent
	$HTTP.Send() ; Not sure what this does, really. I guess it just tells it to send with the desired credentials
	$HTTP.ResponseText ; The response of what it just sent
	$Ticker_Data[1][0] = _StrBetween($HTTP.ResponseText, '"last":"', '"')
	$Ticker_Data[1][1] = _StrBetween($HTTP.ResponseText, '"high":"', '"')
	$Ticker_Data[1][2] = _StrBetween($HTTP.ResponseText, '"low":"', '"')
	$Ticker_Data[1][3] = _StrBetween($HTTP.ResponseText, '"volume":"', '"')
	$Ticker_Data[1][4] = _StrBetween($HTTP.ResponseText, '"ask":"', '"')
	$Ticker_Data[1][5] = _StrBetween($HTTP.ResponseText, '"timestamp":"', '"')
EndFunc

Func _GetTickerNMC_BTC()
	Local $HTTP = ObjCreate("winhttp.winhttprequest.5.1") ; Creates the HTTP requests variable. I name it relevent to what the variable does
	$HTTP.Open("GET", "https://cex.io/api/ticker/NMC/BTC", False) ; Opens a GET request to the IP address site, basically it's viewing the page source
	$HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5") ; Sets the User Agent
	$HTTP.Send() ; Not sure what this does, really. I guess it just tells it to send with the desired credentials
	$HTTP.ResponseText ; The response of what it just sent
	$Ticker_Data[2][0] = _StrBetween($HTTP.ResponseText, '"last":"', '"')
	$Ticker_Data[2][1] = _StrBetween($HTTP.ResponseText, '"high":"', '"')
	$Ticker_Data[2][2] = _StrBetween($HTTP.ResponseText, '"low":"', '"')
	$Ticker_Data[2][3] = _StrBetween($HTTP.ResponseText, '"volume":"', '"')
	$Ticker_Data[2][4] = _StrBetween($HTTP.ResponseText, '"ask":"', '"')
	$Ticker_Data[2][5] = _StrBetween($HTTP.ResponseText, '"timestamp":"', '"')
EndFunc

Func _GetTickerGHS_NMC()
	Local $HTTP = ObjCreate("winhttp.winhttprequest.5.1") ; Creates the HTTP requests variable. I name it relevent to what the variable does
	$HTTP.Open("GET", "https://cex.io/api/ticker/GHS/NMC", False) ; Opens a GET request to the IP address site, basically it's viewing the page source
	$HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5") ; Sets the User Agent
	$HTTP.Send() ; Not sure what this does, really. I guess it just tells it to send with the desired credentials
	$HTTP.ResponseText ; The response of what it just sent
	$Ticker_Data[3][0] = _StrBetween($HTTP.ResponseText, '"last":"', '"')
	$Ticker_Data[3][1] = _StrBetween($HTTP.ResponseText, '"high":"', '"')
	$Ticker_Data[3][2] = _StrBetween($HTTP.ResponseText, '"low":"', '"')
	$Ticker_Data[3][3] = _StrBetween($HTTP.ResponseText, '"volume":"', '"')
	$Ticker_Data[3][4] = _StrBetween($HTTP.ResponseText, '"ask":"', '"')
	$Ticker_Data[3][5] = _StrBetween($HTTP.ResponseText, '"timestamp":"', '"')
EndFunc

Func _GetTickerBF1_BTC()
	Local $HTTP = ObjCreate("winhttp.winhttprequest.5.1") ; Creates the HTTP requests variable. I name it relevent to what the variable does
	$HTTP.Open("GET", "https://cex.io/api/ticker/BF1/BTC", False) ; Opens a GET request to the IP address site, basically it's viewing the page source
	$HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5") ; Sets the User Agent
	$HTTP.Send() ; Not sure what this does, really. I guess it just tells it to send with the desired credentials
	$HTTP.ResponseText ; The response of what it just sent
	$Ticker_Data[4][0] = _StrBetween($HTTP.ResponseText, '"last":"', '"')
	$Ticker_Data[4][1] = _StrBetween($HTTP.ResponseText, '"high":"', '"')
	$Ticker_Data[4][2] = _StrBetween($HTTP.ResponseText, '"low":"', '"')
	$Ticker_Data[4][3] = _StrBetween($HTTP.ResponseText, '"volume":"', '"')
	$Ticker_Data[4][4] = _StrBetween($HTTP.ResponseText, '"ask":"', '"')
	$Ticker_Data[4][5] = _StrBetween($HTTP.ResponseText, '"timestamp":"', '"')
EndFunc
