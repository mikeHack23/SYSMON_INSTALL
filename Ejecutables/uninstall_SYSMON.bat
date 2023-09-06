@echo off
Color 9F
@echo    ***************************
@echo    **        mike           **
@echo    ***************************

sysmon64.exe -u force

sysmon.exe -u force

del /f /q %SystemRoot%\System32\Winevt\Logs\Microsoft-Windows-Sysmon%4Operational.evtx