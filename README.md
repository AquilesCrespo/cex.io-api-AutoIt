#Cex.io Autoit API - Still in Construction
Autoit source files and examples for the Cex.io API.

##How to use:
1. Download and Install AutoIt (scripting language) and Scite(most used Editor)...
2. Download and install Python , for the Editor you can choose your self (personally 
   I use Komodo Edit)...
3. Download API UDF source ( cex.io-Autoit-Functions folder )...
4. Place the UDF's Here Supplied inside you AutoIt Include Folder...
5. Place the UDF's Supplied in extra-UDF's folder inside you AutoIt Include Folder...
6. Create your AutoIt project script...
7. Include the API Functions to your script:

```autoit
#include <cex-io_api.au3>
#include <JSON.au3>
#include <JSON_Translate.au3> ; examples of translator functions, includes JSON_pack and JSON_unpack

; And Other Includes that you may require to your own API Development

```

##Contents:

Folders
```Autoit
Application-Example : Files with an Application Example that use with this API Functions
	Base-Files : 
		=> User-API-ACC.ini : For Storing Authentication credencials...
		=> api-sig-Gen.py : Base Files to Start your API . Here you wil Find an Signature and Nonce
							Generator based on the cex.io-api-python From matveyco (GitHub)
							server....

	cex.io-Autoit-UDF's : All the base functions and extra some functions in Review and
						  Development for Support this API and your future tools 
						  based on it...
	extra-UDF's : 
		=> JSON UDF's That I founded on the internet to support this API

```

API Function List

```autoit
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

other Functions Being developed.....
```

Calling Function and Output his Parameters

```autoit
; example of how to call a Function Storing in a Variable
$ReturnText = _GetCexIOTicker()
; Write into console the GHS/BTC obtained in the web ticker API Outputting the Variable were was stored
ConsoleWrite(@CRLF & "GHS/BTC" & @CRLF & @CRLF & "JSON : " & @CRLF & @CRLF & $ReturnText & @CRLF) ; Run this from sciTE
; Or Even Write down in a msg Box Outputting the Variable were was stored
MsgBox(0, "GHS/BTC", "JSON : " & @CRLF & @CRLF & $ReturnText & @CRLF)
```


You can Find Some more usage Example in the Application-Example folder
