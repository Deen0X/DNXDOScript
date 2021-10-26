@echo off
echo Microsoft Internet Explorer 11 (install another option such Chrome, Firefox, Opera, etc)
DISM /online /disable-feature /featurename:Internet-Explorer-Optional-amd64 /NoRestart
