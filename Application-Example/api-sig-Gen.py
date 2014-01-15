#!/usr/bin/env python
##
## Author:	Aquiles dos Santos Crespo
## e-mail:	aquilescrespo@gmail.com
## Comments : Based on the cex.io Python API by matveyco
##
## BTC   :	1H1WzmtLcXQvJqX79AwF3SqXfXmVSRs194
##
## Donate Free...

import hmac
import hashlib
import time
import urllib
import urllib2
import ConfigParser

config = ConfigParser.ConfigParser()
config.read('User-API-Conf.ini')

nonce = '{:.10f}'.format(time.time()*1000).split('.')[0]

string = nonce + config.get('UserAPIDetails', 'UserName') + config.get('UserAPIDetails', 'Key') ##create string
signature = hmac.new(config.get('UserAPIDetails', 'Secret'), string, digestmod=hashlib.sha256).hexdigest().upper() ##create signature

config.set('GeneratedDetails', 'Nonce', nonce)
config.set('GeneratedDetails', 'Signature', signature)

with open('User-API-Conf.ini', 'w') as configfile:
    config.write(configfile)
