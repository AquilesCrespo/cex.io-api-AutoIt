#include-once
#cs ----------------------------------------------------------------------------

 Title :
 AutoIt Version: 3.3.8.1 ++
 Author : Aquiles dos Santos Crespo <aquilescrespo@gmail.com>

 BTC   :	1H1WzmtLcXQvJqX79AwF3SqXfXmVSRs194 (Donate Free)

 Script Function:

	UDF script for using with the web api from cex.io server.

	Main Functions from this script:
		=> Ticker GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
		=> Order Book GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
		=> Trade history GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
		=> Account balance GHS, BTC, NMC, LTC, IXC, DVC
		=> Open orders
		=> Cancel order
		=> Place order
		=> Hash Rate
		=> Workers' Hash Rate

#ce ----------------------------------------------------------------------------

; #includes# ===================================================================

#include <MsgBoxConstants.au3>
#include <Crypt.au3>
#include <Date.au3>
#include <String.au3>

; #includes END# ===============================================================

; #Variables# ==================================================================

; for External use
Global $UserName
Global $api_key
Global $api_secret

; for internal use
;  no variable to declare

; #Variables END# ==============================================================

; #CURRENT# ====================================================================
;
; Variables :
;
;  		==============  Globals ==================
;		=> $UserName : Web Login From the Account
;		=> $api_key : Key From your API
;		=> $api_secret : Secret from your API
;
; Functions :
;
;	Cex.io API
; 		========= Public Data Functions ==========
; 		_CexIO_API() : base Function that call the API... all the output data will
;					   be in JSON dictionary
; 		_CexIO_PlaceOrder_data() : Create the String to be interpretated in Place
;							 	   order API...
; #CURRENT END# ================================================================

; ==============================================================================
; ========================== Base API Function Script ==========================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _CexIO_API()
 Description : Call the API to Be used
 Parameters :
	=> $api_type : Obligatory field , api function to be called
				   Info of data to be used:
						=> "ticker" : Used  to get the ticker data
									  Have to use with it the $api_xtra_URL_data
									  variable with the Currency pair Values
									  Availiable by cex.io api
									  GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
						=> "order_book" : used to get teh Order book data
										  Have to use with it the $api_xtra_URL_data
										  variable with the Currency pair Values
										  Availiable by cex.io api
										  GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
						=> "trade_history" : used to take the trade history data
											 Have to use with it the $api_xtra_URL_data
											 variable with the Currency pair Values
											 Availiable by cex.io api
											 GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
						=> "balance" : Get your Account Ballance
						=> "open_orders" : Get your open orders
						=> "cancel_order" :


 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _CexIO_API($api_type,$api_xtra_URL_data=False,$methode="GET",$data="")
	Local $HTTP = ObjCreate("winhttp.winhttprequest.5.1") ; Creates the HTTP requests variable.
	; check if $api_xtra_URL_data=False or not to Open a GET/POST request to the IP address or site url
	if $api_xtra_URL_data = False Then $HTTP.Open($methode, "https://cex.io/api/" &  $api_type, False)
	if $api_xtra_URL_data <> False Then  $HTTP.Open($methode, "https://cex.io/api/" &  $api_type & "/" & $api_xtra_URL_data, False)
	; Sets the User Agent
	$HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5")
	Switch $methode
		Case "GET"
			$HTTP.Send() ; Send Request in case of GET methode
		Case "POST"
			; Sets the Content Type to "application/x-www-form-urlencoded" and send request with the
			; desired credentials in Case of POST Methode
			$HTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			$HTTP.Send(_Post_Data($api_type,$data))
	EndSwitch
	Return $HTTP.ResponseText ; Return's The response of what it just sent
EndFunc ; =======> _CexIO_API() END

#cs ----------------------------------------------------------------------------

 Name : _CexIO_PlaceOrder_data()
 Description :
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _CexIO_PlaceOrder_data($type,$ammount,$price)
	Return $type & ";" & $ammount & ";" & $price
EndFunc ; =======> _CexIO_PlaceOrder_data() END

; ========================= Base API Function Script END =======================

; #INTERNAL_USE_ONLY# ==========================================================
;
; Variables :
; => ....
;
; Functions:
; => _Post_Data() : Generates the post data for the API
; => _GenCexIOAPIData() :  Generates the API authentication
; => _timestamp() : Unix TimeStamp
; => _hmac_sha256() : output's a keyed-Hash Message Authentication Code with
;					  based hash sha256
;
; #INTERNAL_USE_ONLY END# ======================================================

#cs ----------------------------------------------------------------------------

 Name : _Post_Data()
 Description : Generates the POST Method
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _Post_Data($api,$data="")
	Switch $api
		Case "trade_history"
			$POST_info = "since=" & $data
		Case "balance"
			$POST_info = _GenCexIOAPIData()
		Case "cancel_order"
			$POST_info = _GenCexIOAPIData() & "&id=" & $data
		Case "place_order"
			local $info = StringSplit($data, ";")
			$POST_info = _GenCexIOAPIData() & "&type=" & $info[1] & "&amount=" & $info[2] & "&price=" & $info[3]
	EndSwitch
	Return $POST_info ; Returns The response of the Post Data
EndFunc ; =======> _Post_Data() END

#cs ----------------------------------------------------------------------------

 Name : _GenCexIOAPIData()
 Description : Returns the Base API POST info
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GenCexIOAPIData()
	; get Timestamp for the Nonce
	Local $apinonce = _timestamp()
	; Generate string
	Local $String = $apinonce & $UserName & $api_key
	; Generate the Signature
	Local $signature = _hmac_sha256($api_secret, $String)
	;generate post authentication Info
	Local $POST_info = "key=" & $api_key & "&signature=" & $signature & "&nonce=" & $apinonce
	Return $POST_info
EndFunc ; =======> _GenCexIOAPIData() END

#cs ----------------------------------------------------------------------------

 Name : _timestamp()
 Description : Generates a Unix Time Stamp for the API Authentication
 Parameters :
	=> $date : staart Date . Standart date 1970/01/01
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _timestamp($date="1970/01/01")
	; generates a timestamp
	Return _DateDiff("s", $date & " 00:00:00", _NowCalc()) & @MSEC
EndFunc ; =======> _timestamp() END

#cs ----------------------------------------------------------------------------

 Name : _hmac_sha256()
 Description :  keyed-Hash Message Authentication Code with based hash sha256

 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _hmac_sha256($key, $message)
	Local Const $CALG_SHA_256 = 0x0000800c ; since this comes commented on the Crypt.au3 UDF we need to Declare this constant here....
    Local $blocksize = 64
	Local Const $oconst = 0x5C, $iconst = 0x36  ; 92 / 54 DEC
	Local $a_opad[$blocksize], $a_ipad[$blocksize]
    Local $opad = Binary(''), $ipad = Binary('')
    $key = Binary($key)
    If BinaryLen($key) > $blocksize Then $key = _Crypt_HashData($key, $CALG_SHA_256)
    For $i = 1 To BinaryLen($key)
        $a_ipad[$i - 1] = Number(BinaryMid($key, $i, 1))
        $a_opad[$i - 1] = Number(BinaryMid($key, $i, 1))
    Next
    For $i = 0 To $blocksize - 1
        $a_opad[$i] = BitXOR($a_opad[$i], $oconst)
        $a_ipad[$i] = BitXOR($a_ipad[$i], $iconst)
    Next
    For $i = 0 To $blocksize - 1
        $ipad &= Binary(Hex($a_ipad[$i], 2))
        $opad &= Binary(Hex($a_opad[$i], 2))
    Next
    Return StringRegExpReplace (_Crypt_HashData($opad & _Crypt_HashData($ipad & Binary($message), $CALG_SHA_256),$CALG_SHA_256),"0x","")
EndFunc   ;==>hmac
