#include-once
; #SCRIPT INFO# ================================================================
;
; Title : cex-io_api.au3
; Script Version : 2.1
; AutoIt Version: 3.3.12.2
; Author : Aquiles dos Santos Crespo <aquilescrespo@gmail.com>
; Developers Group : ---
; Date : 06-05-2014
;
; to be used with the https://cex.io/ web site
; Base Info and Idea in this UDF Development can Be Founded in :
;			-	https://cex.io/api	-
;
;	==================================================
;	= 				(Donate Free)					 =
;	==================================================
;	=   BTC  :	1H1WzmtLcXQvJqX79AwF3SqXfXmVSRs194   =
;	=   LTC	 :	LR8WYvYA2yYs4bYCnpXJnTiu6F3ZqKN5dk   =
;	=   NMC  :	MzuyBeHeea9fa7L9yDqDdZQ5BGR3TZEVkV   =
;	==================================================
;
; Script Function:
;
;	UDF script for using with CEX.IO
;	application programming interface (API), that allows the clients to access
;	and control their accounts, using custom written scripts in AutoIt.
;
;	Main Functions from this script:
;		=> Ticker GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, IXC/BTC
;		=> Order Book GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, IXC/BTC
;		=> Trade history GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, IXC/BTC
;		=> Account balance GHS, BTC, NMC, LTC, IXC, DVC, IXC, DODGE, FTC, AUR
;		=> Open orders GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, IXC/BTC
;		=> Cancel order GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, IXC/BTC
;		=> Place order GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, IXC/BTC
;		=> Hash Rate
;		=> Workers' Hash Rate
;
; Change log:
;		=> Code Remodelation with remake of Comment areas
;		=> Especial Function to Store the Authentication Info
;		=> error handler (still a bit poor but i am working on it)
;		=> functions for reduction of memory consuption by the process (in progress)
;
; #SCRIPT INFO END# ============================================================

; #includes# ===================================================================

#include <MsgBoxConstants.au3>
#include <Crypt.au3>
#include <Date.au3>
#include <String.au3>

; #includes END# ===============================================================

; #Variables# ==================================================================

; for External use
; no variables to declare for external use


;	- Do not touch this Variables Bellow -
; 			-for internal use-

; Login credencials for the Cex.io api
Global $UserName ; For storing the Web Login from Cex.io
Global $api_key ; For Storing the Cex.io API Key
Global $api_secret ; For storing the Cex.io API Secret

; #Variables END# ==============================================================

; ==============================================================================
; ========================== Base API Function Script ==========================
; ==============================================================================

; #CURRENT# ====================================================================
;
;	Cex.io API
; 		========= Public Data Functions ==========
;		_CexIO_Authentication() : For Save the user Autentication from your API
; 		_CexIO_API() : base Function that call the API... all the output data will
;					   be in JSON dictionary
; 		_CexIO_Place_data() : Create the String to be interpretated in Place
;							 	   order API...
; #CURRENT END# ================================================================

; #FUNCTION COMMENT# ===========================================================
;
; Name : _CexIO_Authentication()
; Description : stores the user api credencials
; Parameters :
; 	=> $login : Web Login from the user
; 	=> $key : Key From your API
; 	=> $secret : Secret from your API
; Author : Aquiles dos Santos Crespo
;
; #FUNCTION COMMENT END# =======================================================
Func _CexIO_Authentication($login,$key,$secret)
	$UserName = $login
	$api_key = $key
	$api_secret = $secret
EndFunc ; =======> FUNCTION _CexIO_Authentication END

; #FUNCTION COMMENT# ===========================================================
;
; Name : _CexIO_API()
; Description : Call the API to Be used
; Parameters :
;	=> $api_type : Obligatory field , api function to be called
;				   Info of data to be used:
;						=> "ticker" : Used  to get the ticker data
;									  Have to use with it the $api_xtra_URL_data
;									  variable with the Currency pair Values
;									  Availiable by cex.io api
;									  GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, IXC/BTC
;						=> "order_book" : used to get teh Order book data
;										  Have to use with it the $api_xtra_URL_data
;										  variable with the Currency pair Values
;										  Availiable by cex.io api
;										  GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, IXC/BTC
;						=> "trade_history" : used to take the trade history data
;											 Have to use with it the $api_xtra_URL_data
;											 variable with the Currency pair Values
;											 Availiable by cex.io api
;											 GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, IXC/BTC
;						=> "balance" : Get your Account Ballance
;						=> "open_orders" : Get your open orders
;						=> "cancel_order" : cancel order from your open orders
;											use $data for passing the order ID to
;											cancel
;						=> "place_order" : place an order based on your availiable balance
;										   Use the Function _CexIO_PlaceOrder_data() to send the
;										   data for the $data from this Function
;						=> "ghash.io" : to access the ghash.io API Use
;										Have to use with it the $api_xtra_URL_data
;										variable with the "hashrate" for check your global
;										hash rate , or the " for check the hash rate
;										from each worker that you have....
;	=> $api_xtra_URL_data : Use only if you have to insert the Currency pair availiable by
;							Cex.io API that are GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, IXC/BTC
;							or if you want to check the Ghash hashing rate with "hashrate"
;							to verify global hasshing rate , or "workers" to verify the
;							hash rate from each worker....
;	=> $methode : GET or POST ... Pre-defined to GET .
;				  POST is More used when you have to pass info to the server like Autentication
;				  info...
;	=> $data : extra data to be sende to the server if needed
; Author : Aquiles dos Santos Crespo
;
; #FUNCTION COMMENT END# =======================================================
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
EndFunc ; =======> FUNCTION _CexIO_API() END

; #FUNCTION COMMENT# ===========================================================
;
; Name : _CexIO_PlaceOrder_data()
; Description : use this function when you need to pass info for place an order
; Parameters :
;	=> $type : type "buy" or "sell"
;	=> $ammount : ammount availiable to sell in your account
;	=> $price : Price to sell
; Author: Aquiles dos Santos Crespo
;
; #FUNCTION COMMENT END# =======================================================
Func _CexIO_Place_data($type,$ammount,$price)
	Return $type & ";" & $ammount & ";" & $price
EndFunc ; =======> _CexIO_PlaceOrder_data() END

; #FUNCTION COMMENT# ===========================================================
;
; Name : _ProcessReduceMemory()
; Description : use this function when you need to pass info for place an order
; Parameters :
;	=> $iPID : process id
; Author: Unknown
;
; #FUNCTION COMMENT END# =======================================================
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

; #FUNCTION COMMENT# ===========================================================
;
; Name : _ProcessReduceMemory()
; Description : just some thing to handle errors without autoit errors
; Author: Aquiles Crespo
;
; #FUNCTION COMMENT END# =======================================================
Func _Error() ; If there's any error, it'll just say there's an error, rather than crashing. Isn't really needed in this script, but you never know when something might happen.
        ConsoleWrite("Errored" & @CRLF)
		MsgBox(1,"Error","An error Ocurred...." , 5)
EndFunc   ;==>_Error

; ========================= Base API Function Script END =======================

; ==============================================================================
; ========================= Internal Functions Script ==========================
; ==============================================================================

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

; #FUNCTION COMMENT# ===========================================================
;
; Name : _Post_Data()
; Description : Generates the POST Method
; Parameters :
; Author : Aquiles dos Santos Crespo
;
; #FUNCTION COMMENT END# =======================================================
Func _Post_Data($api,$data="")
	Switch $api
		Case "trade_history"
			$POST_info = "since=" & $data
		Case "balance" or "ghash.io"
			$POST_info = _GenCexIOAPIData()
		Case "cancel_order"
			$POST_info = _GenCexIOAPIData() & "&id=" & $data
		Case "place_order"
			local $info = StringSplit($data, ";")
			$POST_info = _GenCexIOAPIData() & "&type=" & $info[1] & "&amount=" & $info[2] & "&price=" & $info[3]
	EndSwitch
	Return $POST_info ; Returns The response of the Post Data
EndFunc ; =======> _Post_Data() END

; #FUNCTION COMMENT# ===========================================================
;
; Name : _GenCexIOAPIData()
; Description : Returns the Base API POST info ...
;				This info is the API keys and User name from your Cex.io
;				Accout API.....
; Parameters :
; Author: Aquiles dos Santos Crespo
;
; #FUNCTION COMMENT END# =======================================================
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

; #FUNCTION COMMENT# ===========================================================
;
; Name : _timestamp()
; Description : Generates a Unix Time Stamp for the API Authentication
; Parameters :
;	=> $date : staart Date . Standart date 1970/01/01
; Author: Aquiles dos Santos Crespo
;
; #FUNCTION COMMENT END# =======================================================
Func _timestamp($date="1970/01/01")
	; generates a timestamp
	Return _DateDiff("s", $date & " 00:00:00", _NowCalc()) & @MSEC
EndFunc ; =======> _timestamp() END

; #FUNCTION COMMENT# ===========================================================
;
; Name : _hmac_sha256()
; Description :  keyed-Hash Message Authentication Code with based hash sha256
; Parameters : => $key : is the API Secret($api_secret)
; 			   => $message : the junction from api nonce + $User Name + api key
; Author: Unknown (Founded parts and solutions somewhere over the internet)
;
; #FUNCTION COMMENT END# =======================================================
Func _hmac_sha256($key, $message)
    Local Const $oconst = 0x5C, $iconst = 0x36  ; 92 / 54 DEC
	Local $blocksize = 64 ; Block size 64 bits
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
EndFunc   ; =======> _hmac_sha256()

; ======================= END Internal Functions Script ========================