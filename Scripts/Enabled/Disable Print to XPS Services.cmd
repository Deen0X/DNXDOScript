@echo off
echo Print to XPS services
DISM /online /disable-feature /featurename:Printing-XPSServices-Features /NoRestart
