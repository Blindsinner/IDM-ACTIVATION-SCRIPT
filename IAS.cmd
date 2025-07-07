@set iasver=1.4-Final
@setlocal DisableDelayedExpansion
@echo off

::============================================================================
::
::   IDM Activation Script (IAS) - Final Verified Version
::
::   Features: Activation, Trial Freeze, and Update/Firewall Block.
::
::   Original Homepages: https://github.com/lstprjct/IDM-Activation-Script
::                       https://t.me/ModByPiash/5
::
::============================================================================

::  To activate, run the script with "/act" parameter or change 0 to 1 in below line
set _activate=0

::  To Freeze the 30-day trial period, run the script with "/frz" parameter or change 0 to 1 in below line
set _freeze=0

::  To reset activation and trial, run the script with "/res" parameter or change 0 to 1 in below line
set _reset=0

::  Unattended mode if any of the above is set to 1 or parameter is used

::========================================================================================================================================
::  Correct PATH setup
set "PATH=%SystemRoot%\System32;%SystemRoot%\System32\wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\;%PATH%"
if exist "%SystemRoot%\Sysnative\reg.exe" (
  set "PATH=%SystemRoot%\Sysnative;%SystemRoot%\Sysnative\wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%PATH%"
)
::========================================================================================================================================

::  Re-launch logic for 64-bit/ARM
set "_cmdf=%~f0"
for %%# in (%*) do (
  if /i "%%#"=="r1" set r1=1
)
if exist %SystemRoot%\Sysnative\cmd.exe if not defined r1 (
  setlocal EnableDelayedExpansion
  start %SystemRoot%\Sysnative\cmd.exe /c ""!_cmdf!" %* r1"
  exit /b
)

::  Null service check
sc query Null | find /i "RUNNING" >nul 2>&1 || (
  echo.
  echo Null service is not running, script may crash...
  echo Help - https://github.com/lstprjct/IDM-Activation-Script/wiki/IAS-Help#troubleshoot
  ping 127.0.0.1 -n 6 >nul
)
cls

::========================================================================================================================================
cls
color 07
title  IDM Activation Script %iasver%

set _args=%*
if defined _args set _args=%_args:"=%
if defined _args (
  for %%A in (%_args%) do (
    if /i "%%A"=="/res" set _reset=1
    if /i "%%A"=="/frz" set _freeze=1
    if /i "%%A"=="/act" set _activate=1
  )
)
for %%A in (%_activate% %_freeze% %_reset%) do if "%%A"=="1" set _unattended=1

::========================================================================================================================================
set "nul1=1>nul"
set "nul2=2>nul"
set "nul=>nul 2>&1"
set psc=powershell.exe
setlocal EnableDelayedExpansion

::  Elevate script as admin
%nul1% fltmc || (
  if not defined _elev %psc% "start cmd.exe -arg '/c "!_PSarg!"' -verb runas" && exit /b
  echo This script requires admin privileges. Right click and 'Run as administrator'.
  pause
  exit /b
)

::  Find IDM executable path in registry or default install dirs
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Wow6432Node\Internet Download Manager" /v ExePath 2^>nul') do set "IDMan=%%b"
if not exist "!IDMan!" (
    for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Internet Download Manager" /v ExePath 2^>nul') do set "IDMan=%%b"
)
if not exist "!IDMan!" (
    if exist "%ProgramFiles(x86)%\Internet Download Manager\IDMan.exe" set "IDMan=%ProgramFiles(x86)%\Internet Download Manager\IDMan.exe"
    if exist "%ProgramFiles%\Internet Download Manager\IDMan.exe"     set "IDMan=%ProgramFiles%\Internet Download Manager\IDMan.exe"
)

::  Flow control based on action flags
if %_reset%==1 goto _reset
if %_activate%==1 (set frz=0 & goto _activate)
if %_freeze%==1  (set frz=1 & goto _activate)

:MainMenu
cls
echo.
echo    =================================================
echo      IDM Activation & Firewall Block Script %iasver%
echo    =================================================
echo.
echo      [1] Activate IDM
echo      [2] Freeze IDM Trial
echo      [3] Reset IDM Activation / Trial
echo.
echo      [0] Exit
echo.
echo    =================================================
choice /C:1230 /N /M "   Please enter your choice: "
set _erl=%errorlevel%
if %_erl%==4 exit /b
if %_erl%==3 goto _reset
if %_erl%==2 (set frz=1 & goto _activate)
if %_erl%==1 (set frz=0 & goto _activate)
goto MainMenu

::========================================================================================================================================
:_reset
cls
echo.
echo  Resetting IDM Activation and Trial Status...
taskkill /f /im idman.exe %nul%
:: Remove firewall rules
call :unblock_firewall

echo.
echo  Deleting registration keys...
reg delete "HKCU\Software\DownloadManager" /v FName /f %nul%
reg delete "HKCU\Software\DownloadManager" /v LName /f %nul%
reg delete "HKCU\Software\DownloadManager" /v Email /f %nul%
reg delete "HKCU\Software\DownloadManager" /v Serial /f %nul%
echo  Reset complete.
goto done

::========================================================================================================================================
:_activate
cls
echo.
if %frz%==0 (echo  Activating IDM...) else (echo  Freezing IDM Trial...)
echo.
if not exist "!IDMan!" (
    echo  ERROR: IDM is not installed or could not be found.
    goto done
)
taskkill /f /im idman.exe %nul%
:: Block firewall and disable updates
call :block_updates_and_firewall
if %frz%==0 (
    echo.
    echo  Applying registration details...
    set /a fname=%random% %% 9000 + 1000
    set /a lname=%random% %% 9000 + 1000
    reg add "HKCU\Software\DownloadManager" /v FName /t REG_SZ /d "!fname!" /f >nul
    reg add "HKCU\Software\DownloadManager" /v LName /t REG_SZ /d "!lname!" /f >nul
    reg add "HKCU\Software\DownloadManager" /v Email /t REG_SZ /d "!fname!.!lname!@idm.com" /f >nul
    reg add "HKCU\Software\DownloadManager" /v Serial /t REG_SZ /d "XXXXX-XXXXX-XXXXX-XXXXX" /f >nul
    echo  Activation process complete.
) else (
    echo  Trial freeze process complete.
)
goto done

::========================================================================================================================================
:done
echo.
echo  =================================================
if %_unattended%==0 (
  pause
  goto MainMenu
)
exit /b

::========================================================================================================================================
:: Firewall & Update Blocking Functions
::========================================================================================================================================
:unblock_firewall
echo:
echo  Removing IDM Firewall rules...
netsh advfirewall firewall delete rule name="IDM Block Outbound" >nul 2>&1 && echo    - Removed Outbound Firewall Rule
netsh advfirewall firewall delete rule name="IDM Block Inbound"  >nul 2>&1 && echo    - Removed Inbound Firewall Rule
exit /b

:block_updates_and_firewall
echo:
echo  Blocking IDM via Firewall to prevent online checks...
:: Delete old rules
netsh advfirewall firewall delete rule name="IDM Block Outbound" >nul 2>&1
netsh advfirewall firewall delete rule name="IDM Block Inbound"  >nul 2>&1
:: Add new rules
set "fw_rule_out=netsh advfirewall firewall add rule name="IDM Block Outbound" dir=out action=block program="!IDMan!" enable=yes"
set "fw_rule_in=netsh advfirewall firewall add rule name="IDM Block Inbound" dir=in action=block program="!IDMan!" enable=yes"
!fw_rule_out! >nul && echo    + Added Outbound Firewall Rule
!fw_rule_in!  >nul && echo    + Added Inbound Firewall Rule
echo:
echo  Disabling automatic update checks via registry...
reg add "HKCU\Software\DownloadManager" /v LastCheckQU /t REG_SZ /d "9999-99-99" /f >nul && echo    - Set LastCheckQU to year 9999
exit /b

::========================================================================================================================================
