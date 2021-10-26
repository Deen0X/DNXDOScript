@echo off
echo Internet Printing Services
DISM /online /disable-feature /featurename:Printing-Foundation-InternetPrinting-Client /NoRestart
