@echo off
echo Remote Differential Compression
DISM /online /disable-feature /featurename:MSRDC-Infrastructure /NoRestart
