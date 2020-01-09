@echo off

SET netcard1=Ethernet
SET netcard2=Wi-Fi

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

netsh int show int | find "%netcard1%"
IF errorlevel 1 (
	echo Does not exists a netcard named '%netcard1%'
	pause
	exit 0
)

netsh int show int | find "%netcard2%"
IF errorlevel 1 (
	echo Does not exists a netcard named '%netcard2%'
	pause 
	exit 0
)

netsh int show int "%netcard2%" | find "Conectado"
IF errorlevel 1 (
	netsh interface set interface name="%netcard1%" admin=DISABLED
	netsh interface set interface name="%netcard2%" admin=ENABLED
) ELSE (
	netsh interface set interface name="%netcard1%" admin=ENABLED
	netsh interface set interface name="%netcard2%" admin=DISABLED
)

