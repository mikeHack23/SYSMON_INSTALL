@echo off
Color 9F
@echo    *************************************
@echo    **             MIKE                **
@echo    *************************************


SET rutaxml="%~d0%~p0sysmonconfig-export.xml"
SET rutalogs="%~d0%~p0SYSMON_%computername%.log"
SET rutaexe="%~d0%~p0Sysmon.exe"
SET sysmonConfig="%~d0%~p0SYSMON.config"


echo ==================================================================================== >>%rutalogs%
echo ================================================================================= >>%rutalogs%
echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Lista Variables >>%rutalogs%
echo %rutaxml% >>%rutalogs%
echo %rutalogs% >>%rutalogs%
echo %rutaexe% >>%rutalogs% 


echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Desinstalando Sysmon >>%rutalogs% 
sysmon.exe -u
sysmon64.exe -u
del /f /q %SystemRoot%\System32\Winevt\Logs\Microsoft-Windows-Sysmon%4Operational.evtx

echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Instalando Sysmon %rutaexe% -accepteula -i %rutaxml% >>%rutalogs% 
%rutaexe% -accepteula -i %rutaxml%


echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Extendiendo Tamaño eventos >>%rutalogs% 
wevtutil sl Microsoft-Windows-Sysmon/Operational /ms:1048576000


echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Save Logs IP >>%rutalogs% 

@for /F "tokens=* delims= " %%i in ('ipconfig^|FINDSTR "Dirección IPv4" ') do set mip=%%i 
@set mip=%mip:~44,-1%
@echo %mip%


echo "%computername%";"%mip%";"%username%";"%date% %time%" >>%rutalogs% 

echo ==================================================================================== >>%sysmonConfig%
echo %date% %time% CONFIG XML SYSMON >>%sysmonConfig%
echo ==================================================================================== >>%sysmonConfig%

sysmon -s >> %sysmonConfig%
echo ==================================================================================== >>%sysmonConfig%
echo %date% %time% CONFIG SYSMON >>%sysmonConfig%
echo ==================================================================================== >>%sysmonConfig%

sysmon -c >> %sysmonConfig%
