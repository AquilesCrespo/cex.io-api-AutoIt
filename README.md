#Cex.io Autoit API - Still in Construction
Autoit source files and examples for the Cex.io API.

##How to use:
1. Download and Install AutoIt (scripting language) and Scite(most used Editor)...
2. Download and install Python , for the Editor you can choose your self (personally 
   I use Komodo Edit)...
3. Download API Functions source ( cex.io-Autoit-Functions folder )...
4. Place the Functions inside you Autoit Include Folder...
5. Create your Autoit project script...
6. Include the API Functions to your script:

```autoit
#include <cex-io_api.au3>
#include <StrBetween.au3>
#include <Array.au3>
#include <JSON.au3>
#include <JSON_Translate.au3> ; examples of translator functions, includes JSON_pack and JSON_unpack
```

##Contents:

Folders
```Autoit
Application-Example : Files with an Application Example that use with this API Functions
	Content : 
		=> api-exemple.au3 : Example of how to use this API
		=> api-sig-Gen.py : This Generates your Nonce and Signature for send to the
							server....
		=> GHS_BTC-ticker.kxf : window form Example for this example

base-files : Base Files to Start your API . Here you wil Find an Signature and Nonce
			 Generator based on the cex.io-api-python From matveyco (GitHub)

cex.io-Autoit-Functions : all the base functions from this API and extra functions 
						  Development for Support this API and your future tools 
						  based on it...
						  Some of this Files I have founded on the internet to download 
						  other were Remodelled by what I founded on Forums with tutorials
```

API Function List

```autoit
_GetTickerGHS_BTC() : Function for the GHS/BTC Ticker
_GetTickerLTC_BTC() : Function for the LTC/BTC Ticker
_GetTickerNMC_BTC() : Function for the NMC/BTC Ticker
_GetTickerGHS_NMC() : Function for the GHS/NMC Ticker
_GetTickerBF1_BTC() : Function for the BF1/BTC Ticker
...
other Functions Being developed.....
```

Calling Function and Output his Parameters

```autoit
; example of how to call a Function
_GetTickerGHS_BTC()
; Write into console the GHS/BTC obtained in the web ticker API
ConsoleWrite(@CRLF & "GHS/BTC" & @CRLF & @CRLF & "Last : " & $Ticker_Data[0][0] & @CRLF & "High : " & $Ticker_Data[0][1] & @CRLF & "Low : " & $Ticker_Data[0][2] & @CRLF & "Volume : " & $Ticker_Data[0][3] & @CRLF & "Ask : " & $Ticker_Data[0][4] & @CRLF & "Timestamp : " & $Ticker_Data[0][5] & @CRLF) ; Run this from sciTE
```

You can Find Some more usage Example in the Application-Example folder
