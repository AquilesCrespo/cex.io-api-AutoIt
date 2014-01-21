#Cex.io Autoit API - Still in Construction
Autoit source files and examples for the Cex.io API.

##How to use:
1. Download and Install AutoIt (scripting language) and Scite(most used Editor)...
2. Download and install Python , for the Editor you can choose your self (personally 
   I use Komodo Edit)...
3. Download API Functions source ( cex.io-Autoit-Functions folder )...
4. Place the UDF's Here Supplied inside you AutoIt Include Folder...
5. Create your AutoIt project script...
6. Include the API Functions to your script:

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
; Tickers :
_GetTickerGHS_BTC() : GHS/BTC Ticker data, Returns JSON dictionary
_GetTickerLTC_BTC() : LTC/BTC Ticker data, Returns JSON dictionary
_GetTickerNMC_BTC() : NMC/BTC Ticker data, Returns JSON dictionary
_GetTickerGHS_NMC() : GHS/NMC Ticker data, Returns JSON dictionary
_GetTickerBF1_BTC() : BF1/BTC Ticker data, Returns JSON dictionary

; Order Books :
_GetOrdersBookGHS_BTC() : GHS/BTC Order Book data, Returns JSON dictionary
_GetOrdersBookLTC_BTC() : LTC/BTC Order Book data, Returns JSON dictionary
_GetOrdersBookNMC_BTC() : NMC/BTC Order Book data, Returns JSON dictionary
_GetOrdersBookGHS_NMC() : GHS/NMC Order Book data, Returns JSON dictionary
_GetOrdersBookBF1_BTC() : BF1/BTC Order Book data, Returns JSON dictionary


other Functions Being developed.....
```

Calling Function and Output his Parameters

```autoit
; example of how to call a Function Storing in a Variable
$ReturnText = _GetTickerGHS_BTC()
; Write into console the GHS/BTC obtained in the web ticker API Outputting the Variable were was stored
ConsoleWrite(@CRLF & "GHS/BTC" & @CRLF & @CRLF & "JSON : " & @CRLF & @CRLF & $ReturnText & @CRLF) ; Run this from sciTE
; Or Even Write down in a msg Box Outputting the Variable were was stored
MsgBox(0, "GHS/BTC", "JSON : " & @CRLF & @CRLF & $ReturnText & @CRLF)
```


You can Find Some more usage Example in the Application-Example folder
