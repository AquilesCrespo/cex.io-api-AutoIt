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
		=> Cancel order
		=> Place order
		=> Hash Rate
		=> Workers' Hash Rate

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
;			Cex.io API
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
; Cancel order :
; 	=> _CexIOCancelOrder() : Cancel order From User Cex.io API,
;							 Returns 'true' if order has been found and canceled.
;
; Place order :
; 	=> _CexIOPlaceOrder() : Place order From User Cex.io API,
;							Returns JSON dictionary with Placed Order Data.
;
;			Ghash.io API
;
; Hash Rate :
; 	=> _GetGhashIOHashRate() : Get Hash Rate From User Cex.io API,
;							   Returns JSON dictionary.
;
; Worker's Hash Rate :
; 	=> _GetGhashIOWorkersHashRate() : Get Worker's Hash Rate From User Cex.io API,
;							   		  Returns JSON dictionary.
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
; ============================= Cancel order ===================================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _CexIOCancelOrder()
 Description : POST https://cex.io/api/cancel_order/
			   Params:
					key - API key
					signature - signature
					nonce - nonce
					id - order ID
			   Returns 'true' if order has been found and canceled.
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _CexIOCancelOrder($OrderID)
	Return _HTTP_Request("https://cex.io/api/cancel_order/","POST","CancelOrder",$OrderID)
EndFunc ; =======> _CexIOCancelOrder() END

; =========================== Cancel order END =================================

; ==============================================================================
; ============================= Place order ====================================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _CexIOPlaceOrder()
 Description : POST https://cex.io/api/place_order/$CurrecyPair
			   Params:
					key - API key
					signature - signature
					nonce - nonce
					type - 'buy' or 'sell'
					amount - amount
					price - price
			   Returns JSON dictionary representing order:
					id - order id
					time - timestamp
					type - buy or sell
					price - price
					amount - amount
					pending - pending amount (if partially executed)
 Parameters :
	=> $CurrecyPair : Currency Pairs Availiable GHS/BTC, LTC/BTC, NMC/BTC, GHS/NMC, BF1/BTC
	=> $type : 'buy' or 'sell'
	=> $amount : amount
	=> $price : price
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _CexIOPlaceOrder($type,$amount,$price,$CurrecyPair="GHS/BTC")
	$data = $type & ";" & $amount & ";" & $price
	Return _HTTP_Request("https://cex.io/api/open_orders/" & $CurrecyPair,"POST","PlaceOrder",$data)
EndFunc ; =======> _CexIOPlaceOrder() END

; =========================== Place order END ==================================

; ==============================================================================
; ======================== GHash.IO API Hash Rate ==============================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _GetGhashIOHashRate()
 Description : POST https://cex.io/api/ghash.io/hashrate
			   Params:
					key - API key
					signature - signature
					nonce - nonce
			   Returns overall hash rate in MH/s. Check the example below:
					{
						last5m: 8653712.064777328,
						last15m: 7352634.332939788,
						last1h: 7561176.160135326,
						last1d: 7311813.730181709,
						prev5m: 6421196.8,
						prev15m: 6782816.711111112,
						prev1h: 7388774.4,
						prev1d: 7477957.688888889
					}
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetGhashIOHashRate()
	Return _HTTP_Request("https://cex.io/api/ghash.io/hashrate","POST","UserAuth")
EndFunc ; =======> _GetGhashIOHashRate() END

; ====================== GHash.IO API Hash Rate END ============================

; ==============================================================================
; ==================== GHash.IO API Workers' Hash Rate =========================
; ==============================================================================

#cs ----------------------------------------------------------------------------

 Name : _GetGhashIOWorkersHashRate()
 Description : POST https://cex.io/api/ghash.io/hashrate
			   Params:
					key - API key
					signature - signature
					nonce - nonce
			   Returns workers' hash rate and rejected shares.
					{
						'user.worker1': {
							last5m: 4313825.593869732,
							last15m: 2451891.2891986063,
							last1h: 2489898.702611626,
							last1d: 2402110.182142402,
							prev5m: 2345642.6666666665,
							prev15m: 2736583.111111111,
							prev1h: 2169719.466666667,
							prev1d: 2308126.637037037,
							rejected: {
								stale: '1042944', duplicate: 0, lowdiff: 0
							}
						},
						'user.worker2': {
							last5m: 2156912.796934866,
							last15m: 1593729.3379790941,
							last1h: 2035393.3838809323,
							last1d: 2278052.761779044,
							prev5m: 1407385.6,
							prev15m: 2306548.6222222224,
							prev1h: 2169719.466666667,
							prev1d: 2367047.6740740743,
							rejected: {
								stale: '932352', duplicate: 0, lowdiff: '81920'
							}
						}
					}
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _GetGhashIOWorkersHashRate()
	Return _HTTP_Request("https://cex.io/api/ghash.io/workers","POST","UserAuth")
EndFunc ; =======> _GetGhashIOWorkersHashRate() END

; ================== GHash.IO API Workers' Hash Rate END =======================

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
			$HTTP.Send() ; Send Request
		Case "POST"
			$HTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded"); Sets the Content Type
			$HTTP.Send(_Post_Data($type,$data)) ; send request with the desired credentials
	EndSwitch
	Return $HTTP.ResponseText ; The response of what it just sent
EndFunc ; =======> _HTTP_Request() END

#cs ----------------------------------------------------------------------------

 Name : _Post_Data()
 Description : Generates the POST Method
 Parameters :
 Author: Aquiles dos Santos Crespo

#ce ----------------------------------------------------------------------------
Func _Post_Data($methode,$data="")
	Switch $methode
		Case "TradeHistory"
			$POST_info = "since=" & $data
		Case "UserAuth"
			$POST_info = _GenCexIOAPIData()
		Case "CancelOrder"
			$POST_info = _GenCexIOAPIData() & "&id=" & $data
		Case "PlaceOrder"
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
	_RunCMD('Cex.io Credencial API Generator....', 'START /max /d "' & @ScriptDir & '" api-sig-Gen.py' )
	$apiKey = IniRead(@ScriptDir & "\User-API-ACC.ini", "UserAPIDetails", "Key", "NULL")
	$apinonce = IniRead(@ScriptDir & "\User-API-ACC.ini", "GeneratedDetails", "nonce", "NULL")
	$apisig = IniRead(@ScriptDir & "\User-API-ACC.ini", "GeneratedDetails", "signature", "NULL")
	$POST_info = "key=" & $apiKey & "&signature=" & $apisig & "&nonce=" & $apinonce
	Return $POST_info
EndFunc ; =======> _GenCexIOAPIData() END

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
