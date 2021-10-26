@echo off
echo Print to PDF services
DISM /online /disable-feature /featurename:Printing-PrintToPDFServices-Features /NoRestart
