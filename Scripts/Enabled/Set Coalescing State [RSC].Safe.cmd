@echo off
echo Disabling Receive Segment Coalescing State (RSC) - For lan/online gaming
netsh int tcp set global rsc=disabled
