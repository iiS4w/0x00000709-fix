@ECHO OFF
TITLE 0x00000709 FIX [iS4w]
COLOR 2

 goto check_Permissions
 :check_Permissions
 echo Administrative permissions required. Detecting permissions...
 echo.
 echo.
 net session >nul 2>&1
 if [%errorLevel%] == [0] (
 	goto start
 ) else (
 	echo 			Failure: PLEASE RUN AS ADMINISTRATOR.
 )
 pause>nul
exit

:start
cls
ECHO 			--------------------------------------
ECHO 			   0x00000709 ERROR FIX (WINDOWS 11)
ECHO 			--------------------------------------
ECHO                                      [iS4w]
ECHO.
ECHO PRESS ANY KEY TO START.
PAUSE>nul
ECHO ------------------------------------
ECHO ENABLING LPD and LPR FEATURES.
ECHO ------------------------------------
Dism /online /Enable-Feature /FeatureName:Printing-Foundation-LPDPrintService /All -norestart 
Dism /online /Enable-Feature /FeatureName:Printing-Foundation-LPRPortMonitor /All -norestart 
timeout 3 > nul

ECHO ------------------------------------
ECHO RPC CONFIGURATIONS ON GROUP POLICY.
ECHO ------------------------------------

(
echo Computer
echo Software\Policies\Microsoft\Windows NT\Printers\RPC
echo RpcUseNamedPipeProtocol
echo DWORD:1
echo Computer
echo Software\Policies\Microsoft\Windows NT\Printers\RPC
echo RpcAuthentication
echo DWORD:0
echo Computer
echo Software\Policies\Microsoft\Windows NT\Printers\RPC
echo RpcProtocols
echo DWORD:7
echo Computer
echo Software\Policies\Microsoft\Windows NT\Printers\RPC
echo ForceKerberosForRpc
echo DWORD:0
echo Computer
echo Software\Policies\Microsoft\Windows NT\Printers\RPC
echo RpcTcpPort
echo DWORD:0
) > "%temp%\RPC.txt"

"%~dp0\LGPO.exe" /t "%temp%\RPC.txt"
del /f /q "%temp%\RPC.txt"

GPUPDATE /force
timeout 3 > nul

ECHO --------------------------------------
ECHO RPC CONFIGURATIONS ON REGISTRY EDITOR.
ECHO --------------------------------------
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcOverTcp /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcOverNamedPipes /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f
timeout 3 > nul

ECHO ----------------------------------------
ECHO Windows PERMISSIONS ON REGISTRY EDITOR.
ECHO ----------------------------------------
echo HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows [7]>"%temp%\winper.txt"
"%~dp0\regini.exe" "%temp%\winper.txt"
DEL /q /f "%temp%\winper.txt"
timeout 3 > nul

ECHO -------------------------------------
ECHO RESTARTING PRINTER SPOOLER SERVICE.
ECHO -------------------------------------
net stop Spooler /y
net start Spooler
timeout 3 > nul
echo.
echo.
ECHO ---------------------------------------
ECHO PRESS ANY KEY TO RESTART YOUR COMPUTER NOW.
ECHO ---------------------------------------
pause>nul
SHUTDOWN /r /t 0