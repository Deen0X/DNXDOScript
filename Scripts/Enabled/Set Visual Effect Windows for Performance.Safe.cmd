@echo off
echo Setting visual effects on windows for best performance, but with custom config.
echo This setting really will not impact on gaming, but improve your usage on windows interface.
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects /v VisualFXSetting /t REG_DWORD /d 2 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\CursorShadow /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DragFullWindows /v DefaultApplied /t REG_DWORD /d 1 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DropShadow /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMAeroPeekEnabled /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMEnabled /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DWMSaveThumbnailEnabled /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\FontSmoothing /v DefaultApplied /t REG_DWORD /d 1 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListBoxSmoothScrolling /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewAlphaSelect /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ListviewShadow /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\SelectionFade /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimations /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\Themes /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ThumbnailsOrIcon /v DefaultApplied /t REG_DWORD /d 1 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation /v DefaultApplied /t REG_DWORD /d 0 /f
reg ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TransparentGlass /v DefaultApplied /t REG_DWORD /d 0 /f
