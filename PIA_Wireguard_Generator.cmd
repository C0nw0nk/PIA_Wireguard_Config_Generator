@echo off & setLocal EnableDelayedExpansion
::Setup / Requirements
:: Windows PIA app needs to be installed & pre-configured to use WireGuard prior to running this batch file
:: Thats it this will grab the wireguard info used by the PIA app so you can use it in Openwrt wireguard vpns etc where you need to manually put a wireguard config file

:: Needs to use a PIA DNS server especially for dedicated IP
:: 10.0.0.242 - PIA DEFAULT DNS server
:: 10.0.0.243 - PIA DEFAULT DNS+Streaming
:: 10.0.0.244 - PIA DEFAULT DNS+MACE
:: 10.0.0.241 - PIA DEFAULT DNS+Streaming+Mace
set PIA_DNS=DNS = 10.0.0.243,10.0.0.242

set PIA_WIREGUARD_OUTPUT=pia_wireguard.conf

:: End Edit DO NOT TOUCH ANYTHING BELOW THIS POINT UNLESS YOU KNOW WHAT YOUR DOING!

TITLE C0nw0nk - Private Internet Access Wireguard Config Generator - PIA Generator

set PC="pia.conf"

set root_path="%~dp0"

:: Windows PIA app installation directory
set DIRECTORY=C:\Program Files\Private Internet Access

:: This is where PIA stores its wireguard config but it wipes the file so you can not view it.
set PIA="%DIRECTORY%\data\w*.conf"

start "PIA" "%DIRECTORY%\pia-client.exe"
timeout /t 2 /nobreak
"%DIRECTORY%\piactl.exe" disconnect
timeout /t 2 /nobreak
"%DIRECTORY%\piactl.exe" connect

if exist %PC% del %PC% > nul
if exist %PIA_WIREGUARD_OUTPUT% del %PIA_WIREGUARD_OUTPUT% > nul

:START
if exist %PIA% copy %PIA% %PC% > nul
rem if exist %PC% notepad %PC%
if exist %PC% (
	FOR /F "usebackq delims=" %%A IN ("%PC:"=%") DO (
		ECHO %%A
	)
	if exist %PC% (
		set /a count=0
		for /f "usebackq delims=" %%a in ("%PC:"=%") do (
			if !count! equ 0 (
				echo %%a>>%PIA_WIREGUARD_OUTPUT%
			)
			if !count! equ 1 (
				echo %PIA_DNS%>>%PIA_WIREGUARD_OUTPUT%
				echo %%a>>%PIA_WIREGUARD_OUTPUT%
			)
			if !count! equ 2 (
				echo %%a>>%PIA_WIREGUARD_OUTPUT%
			)
			if !count! equ 3 (
				echo %%a>>%PIA_WIREGUARD_OUTPUT%
			)
			if !count! equ 4 (
				echo %%a>>%PIA_WIREGUARD_OUTPUT%
			)
			if !count! equ 5 (
				echo %%a>>%PIA_WIREGUARD_OUTPUT%
			)
			if !count! equ 6 (
				echo %%a>>%PIA_WIREGUARD_OUTPUT%
			)
			if !count! equ 7 (
				echo %%a>>%PIA_WIREGUARD_OUTPUT%
			)
			set/a count+=1
		)
		goto END
	)
)
goto START
:END
if exist %PC% del %PC% > nul

echo wireguard config file generated check your folder %root_path%

pause
