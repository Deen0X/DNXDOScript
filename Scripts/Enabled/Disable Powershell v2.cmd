@echo off
echo Windows PowerShell V2 (Security Risk. you can enable again from Windows 10 features). Windows 10 come with PowerShell V5 or above
DISM /online /disable-feature /featurename:MicrosoftWindowsPowerShellV2Root /NoRestart
DISM /online /disable-feature /featurename:MicrosoftWindowsPowerShellV2 /NoRestart
