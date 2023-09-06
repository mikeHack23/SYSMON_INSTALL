@echo off
Color 9F
@echo    ***************************
@echo    **        mike           **
@echo    ***************************

SET rutabat1Origen="%~d0%~p0Ejecutables\uninstall_SYSMON.bat"
SET rutabat2Origen="%~d0%~p0Ejecutables\install_SYSMON.bat"

SET rutabat1="C:\ProgramData\SYSMON\uninstall_SYSMON.bat"
SET rutabat2="C:\ProgramData\SYSMON\install_SYSMON.bat"

SET rutaxmlOrigen="%~d0%~p0Ejecutables\sysmonconfig-export.xml"
SET rutaxml="C:\ProgramData\SYSMON\sysmonconfig-export.xml"

SET rutalogsOrigen="%~d0%~p0Logs_Programas\"
SET rutalogs="C:\ProgramData\SYSMON\SYSMON_%computername%.log"

SET rutaexeOrigen="%~d0%~p0Ejecutables\Sysmon.exe"
SET rutaexe="C:\ProgramData\SYSMON\Sysmon.exe"

SET rutaexeOrigen64="%~d0%~p0Ejecutables\Sysmon64.exe"
SET rutaexe64="C:\ProgramData\SYSMON\Sysmon64.exe"

SET sysmonConfig="C:\ProgramData\SYSMON\SYSMON.config"


md "C:\ProgramData\SYSMON"
CACLS "C:\ProgramData\SYSMON" /E /G everyone:F
CACLS "C:\ProgramData\SYSMON" /E /G todos:F
echo ==================================================================================== >>%rutalogs%  
echo %date% %time% Creando Carpeta  >>%rutalogs%  


echo ==================================================================================== >>%rutalogs%
echo ================================================================================= >>%rutalogs%
echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Lista Variables >>%rutalogs%
echo %rutaxmlOrigen% >>%rutalogs%
echo %rutaxml% >>%rutalogs%

echo %rutalogsOrigen% >>%rutalogs%
echo %rutalogs% >>%rutalogs%

echo %rutaexeOrigen% >>%rutalogs%
echo %rutaexe% >>%rutalogs% 
echo %rutaexeOrigen64% >>%rutalogs%
echo %rutaexe64% >>%rutalogs% 

echo %rutabat1Origen% >>%rutalogs%
echo %rutabat2Origen% >>%rutalogs% 
echo %rutabat1% >>%rutalogs%
echo %rutabat2% >>%rutalogs% 


echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Desinstalando Sysmon >>%rutalogs% 
sysmon.exe -u
sysmon64.exe -u

del /f /q %SystemRoot%\System32\Winevt\Logs\Microsoft-Windows-Sysmon%4Operational.evtx

echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Eliminando Archivos >>%rutalogs% 
DEL %rutaxml%
DEL %rutaexe%
DEL %rutaexe64%
DEL %rutabat1%
DEL %rutabat2%


echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Copiando Archivos >>%rutalogs% 
xcopy %rutaxmlOrigen% "C:\ProgramData\SYSMON\" /R /Y /S >>%rutalogs% 
xcopy %rutaexeOrigen% "C:\ProgramData\SYSMON\" /R /Y /S >>%rutalogs% 
xcopy %rutaexeOrigen64% "C:\ProgramData\SYSMON\" /R /Y /S >>%rutalogs%
xcopy %rutabat1Origen% "C:\ProgramData\SYSMON\" /R /Y /S >>%rutalogs% 
xcopy %rutabat2Origen% "C:\ProgramData\SYSMON\" /R /Y /S >>%rutalogs% 



echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Instalando Sysmon %rutaexe% -accepteula -i %rutaxml% >>%rutalogs% 
%rutaexe% -accepteula -i %rutaxml%


echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Extendiendo Tamaño eventos >>%rutalogs% 
wevtutil sl Microsoft-Windows-Sysmon/Operational /ms:1048576000


echo ==================================================================================== >>%rutalogs% 
echo %date% %time% Guardando Logs IP >>%rutalogs% 

@for /F "tokens=* delims= " %%i in ('ipconfig^|FINDSTR "Dirección IPv4" ') do set mip=%%i 
@set mip=%mip:~44,-1%
@echo %mip%


echo "%computername%";"%mip%";"%username%";"%date% %time%" >>%rutalogs% 

xcopy %rutalogs% %rutalogsOrigen% /R /Y /S 

echo ==================================================================================== >>%sysmonConfig%
echo %date% %time% CONFIG XML SYSMON >>%sysmonConfig%
echo ==================================================================================== >>%sysmonConfig%

sysmon -s >> %sysmonConfig%
echo ==================================================================================== >>%sysmonConfig%
echo %date% %time% CONFIG SYSMON >>%sysmonConfig%
echo ==================================================================================== >>%sysmonConfig%

sysmon -c >> %sysmonConfig%








