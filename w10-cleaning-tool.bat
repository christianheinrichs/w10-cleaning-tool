@echo off

rem w10-cleaning-tool.bat
rem Last modified on 1 February 2023

rem Clean prefetch section

title w10-cleaning-tool: Clean prefetch section active

rem Delete Windows prefetch files. Needs administrator rights.
echo Deleting Windows prefetch files
del "%windir%\Prefetch\*.pf"
echo.

echo Windows prefetch files should now be gone.
echo.

pause

rem General cleanup section

title w10-cleaning-tool: General cleanup section active

echo Flushing DNS cache via ipconfig...
ipconfig /flushdns
echo.

echo NVIDIA general cleanup running...
del /q "%programdata%\NVIDIA Corporation\DisplayDriverRAS\NvTelemetry\*"
del /q "%programdata%\NVIDIA Corporation\Drs\*"
del /q "%programdata%\NVIDIA Corporation\nvtopps\*"
echo.

pause

rem Logwipe section

title w10-cleaning-tool: w10-logwipe in progress

set "egllogdir=%localappdata%\EpicGamesLauncher\Saved\Logs"
set "gg2logdir=%programdata%\GOG.com\Galaxy\logs"
set "msclogdir=%programdata%\Microsoft\Microsoft Security Client\Support"
set "msedgelogdir=%programdata%\Microsoft\EdgeUpdate\Log"
set "nvidiadir1=%programdata%\NVIDIA"
set "nvidiadir2=%programdata%\NVIDIA Corporation"
set "rgldir=%programdata%\Rockstar Games\Launcher"
set "rgldocdir=%userprofile%\Documents\Rockstar Games"
set "steamdir=C:\Program Files (x86)\Steam"
set "wndlogdir=%programdata%\Microsoft\Network\Downloader"
set "wsrmslogdir=%programdata%\Microsoft\SmsRouter\MessageStore"

rem Epic Games Launcher
if exist "%egllogdir%\*" (
	echo Epic Games Launcher: Deleting logs
	del /q "%egllogdir%\*"
	echo.
) else (
	echo Epic Games Launcher: Logs not found. Skipping...
	echo.
)

rem GOG Galaxy 2.0
if exist "%gg2logdir%\*" (
	echo GOG Galaxy 2.0: Deleting logs
	echo.
	del /q "%gg2logdir%\*"
) else (
	echo GOG Galaxy 2.0: Logs not found. Skipping...
	echo.
)

rem NVIDIA control panel
if exist "%nvidiadir1%" (
	if exist "%nvidiadir2%" (
		echo NVIDIA control panel: Deleting logs
		del /q "%nvidiadir1%\*"
		del "%nvidiadir2%\nvtopps\*.log"
		del "%nvidiadir2%\DisplayDriverRAS\NvTelemetry\*.log"
		del "%nvidiadir2%\DisplayDriverRAS\NvTelemetry\*.log.bak"
		del "%nvidiadir2%\NvProfileUpdaterPlugin\*.log"
		del "%nvidiadir2%\NvProfileUpdaterPlugin\*.log.bak"
		echo.
	)
) else (
	echo NVIDIA control panel: Log folders not found. Skipping...
	echo.
)

rem Rockstar Games Launcher
if exist "%rgldir%" (
	if exist "%rgldocdir%" (
		echo Rockstar Games Launcher: Deleting logs
		del "%rgldir%\*.txt"
		del "%rgldocdir%\Launcher\*.log"
		del "%rgldocdir%\Social Club\*.log"
		echo.
	)
) else (
	echo Rockstar Games Launcher: Log folders not found. Skipping...
	echo.
)

rem Steam
if exist "%steamdir%" (
	echo Steam: Deleting logs
	del "%steamdir%\*.log"
	del "%steamdir%\*.log.last"
	del "%steamdir%\bin\cef\cef.win7x64\*.log"
	del /q "%steamdir%\logs\*"
	echo.
) else (
	echo Steam: Steam installation not found. Skipping...
	echo.
)

rem Removable Windows logs
echo Deleting removable Windows logs
echo.
del "%windir%\*.log"
del "%windir%\INF\*.log"
del "%windir%\Logs\*.log"
del "%windir%\Logs\CBS\*.cab"
del "%windir%\Logs\CBS\*.log"
del "%windir%\Logs\DISM\*.log"
del "%windir%\Logs\MoSetup\*.log"
del "%windir%\Logs\NetSetup\*.etl"
rem Throws an ‘Access is denied’ error; therefore omitted
rem del "%windir%\Logs\waasmedic\*.etl"
del "%windir%\Logs\WindowsUpdate\*.etl"
del "%windir%\Logs\SIH\*.etl"
del "%windir%\System32\*.log"
del "%windir%\System32\LogFiles\setupcln\*.log"
del "%windir%\SysWOW64\*.log"
echo.

rem Microsoft Edge Update
if exist "%msedgelogdir%\*" (
	echo Microsoft Edge Update: Ending task
	taskkill /f /im MicrosoftEdgeUpdate.exe
	echo Microsoft Edge Update: Deleting logs
	del /q "%msedgelogdir%\*"
	echo.
) else (
	echo Microsoft Edge Update: Logs not found. Skipping...
	echo.
)

rem Microsoft Security Client
if exist "%msclogdir%\*.log" (
	echo Microsoft Security Client: Deleting logs
	del "%msclogdir%\*.log"
	echo.
) else (
	echo Microsoft Security Client: Logs not found. Skipping...
	echo.
)

rem Windows Defender

rem Without temporarily disabling Windows Defender, this probably won’t work
rem Obviously NOT recommended!
echo Windows Defender: Trying to delete logs
echo.
del "%programdata%\Microsoft\Windows Defender\Support\*.log"

rem Windows network downloader
if exist "%wndlogdir%\*.log" (
	echo Windows network downloader: Deleting logs
	del "%wndlogdir%\*.log"
	echo.
) else (
	echo Windows network downloader: Logs not found. Skipping...
	echo.
)

rem Windows SmsRouter MessageStore
if exist "%wsrmslogdir%\*.log" (
	echo Windows SmsRouter MessageStore: Deleting logs
	del "%wsrmslogdir%\*.log"
	echo.
) else (
	echo Windows SmsRouter MessageStore: Logs not found. Skipping...
	echo.
)

rem Requires administrator rights

rem Empty Windows log files via wevtutil
echo Emptying Windows log files via wevtutil
echo.

rem Use a ‘for loop’ to iterate through Windows log files with ‘wevtutil’
rem Unfortunately, I have not found a method which filters out logfile
rem names with spaces in them. One possible approach would be to pipe the
rem data through a command like `findstr /v " "`
rem
rem The following command leads to a lot of occurences of the error message:
rem ‘The specified channel could not be found.’
for /f %%a in ('wevtutil el') do wevtutil cl "%%a"

rem While it gets most of the log files, it doesn’t get the log files with
rem spaces in them, so those are still explicitly deleted
rem
rem Note: There could be something missing here
wevtutil cl "Internet Explorer"
wevtutil cl "Key Management Service"
wevtutil cl "Microsoft-Windows-Application Server-Applications/Admin"
wevtutil cl "Microsoft-Windows-Application Server-Applications/Analytic"
wevtutil cl "Microsoft-Windows-Application Server-Applications/Debug"
wevtutil cl "Microsoft-Windows-Application Server-Applications/Operational"
wevtutil cl "Microsoft-Windows-AppLocker/EXE and DLL"
wevtutil cl "Microsoft-Windows-AppLocker/MSI and Script"
wevtutil cl "Microsoft-Windows-AppLocker/Packaged app-Deployment"
wevtutil cl "Microsoft-Windows-AppLocker/Packaged app-Execution"
wevtutil cl "Microsoft-Windows-CAPI2/Catalog Database Debug"
wevtutil cl "Microsoft-Windows-Folder Redirection/Operational"
wevtutil cl "Microsoft-Windows-HomeGroup Control Panel Performance/Diagnostic"
wevtutil cl "Microsoft-Windows-HomeGroup Control Panel/Operational"
wevtutil cl "Microsoft-Windows-HomeGroup Listener Service/Operational"
wevtutil cl "Microsoft-Windows-HomeGroup Provider Service Performance/Diagnostic"
wevtutil cl "Microsoft-Windows-HomeGroup Provider Service/Operational"
wevtutil cl "Microsoft-Windows-Kernel-PnP/Boot Diagnostic"
wevtutil cl "Microsoft-Windows-Kernel-PnP/Configuration Diagnostic"
wevtutil cl "Microsoft-Windows-Kernel-PnP/Device Enumeration Diagnostic"
wevtutil cl "Microsoft-Windows-Kernel-PnP/Driver Diagnostic"
wevtutil cl "Microsoft-Windows-Kernel-PnP/Driver Watchdog"
wevtutil cl "Microsoft-Windows-Known Folders API Service"
rem Throws an ‘Access is denied’ message
rem wevtutil cl "Microsoft-Windows-LiveId/Analytic"
rem wevtutil cl "Microsoft-Windows-LiveId/Operational"
wevtutil cl "Microsoft-Windows-User Control Panel Performance/Diagnostic"
wevtutil cl "Microsoft-Windows-User Control Panel Usage/Diagnostic"
wevtutil cl "Microsoft-Windows-User Control Panel/Diagnostic"
wevtutil cl "Microsoft-Windows-User Control Panel/Operational"
wevtutil cl "Microsoft-Windows-User Device Registration/Admin"
wevtutil cl "Microsoft-Windows-User Device Registration/Debug"
wevtutil cl "Microsoft-Windows-User Profile Service/Diagnostic"
wevtutil cl "Microsoft-Windows-User Profile Service/Operational"
wevtutil cl "Microsoft-Windows-Windows Defender/Operational"
wevtutil cl "Microsoft-Windows-Windows Defender/WHC"
wevtutil cl "Microsoft-Windows-Windows Firewall With Advanced Security/ConnectionSecurity"
wevtutil cl "Microsoft-Windows-Windows Firewall With Advanced Security/ConnectionSecurityVerbose"
wevtutil cl "Microsoft-Windows-Windows Firewall With Advanced Security/Firewall"
wevtutil cl "Microsoft-Windows-Windows Firewall With Advanced Security/FirewallDiagnostics"
wevtutil cl "Microsoft-Windows-Windows Firewall With Advanced Security/FirewallVerbose"
wevtutil cl "Microsoft-Windows-Workplace Join/Admin"
wevtutil cl "Network Isolation Operational"
wevtutil cl "Windows PowerShell"

echo.

echo The following logs were deleted: Epic Games Launcher, GOG Galaxy 2.0,
echo NVIDIA control panel, Rockstar Games Launcher, Steam, WFC
echo Windows logs have been emptied...
echo.

pause

rem Registry clean section

title w10-cleaning-tool: Registry cleanup active...

set "heapleakregpath=HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection"
set "hkcrmuishellpath=HKCR\Local Settings\Software\Microsoft\Windows\Shell"
set "hkcuwinntcvregpath=HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
set "hkcuw64=HKCU\SOFTWARE\Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node"
set "hkcuwincurrentrkeypath=HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion"
set "hklmw64rkeypath=HKLM\SOFTWARE\WOW6432Node\Microsoft"

echo Doing registry cleanup

rem Full registry key path:
rem HKCR\Local Settings\Software\Microsoft\Windows\Shell\MuiCache
echo Cleaning HKCR\Local Settings\Software\Microsoft\Windows\Shell\MuiCache
reg delete "%hkcrmuishellpath%\MuiCache" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\Direct3D\MostRecentApplication
echo Cleaning HKCU\SOFTWARE\Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\Direct3D\MostRecentApplication
reg delete "%hkcuw64%\Microsoft\Direct3D\MostRecentApplication" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\DirectDraw\MostRecentApplication
echo Cleaning HKCU\SOFTWARE\Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\DirectDraw\MostRecentApplication
reg delete "%hkcuw64%\Microsoft\DirectDraw\MostRecentApplication" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\DirectPlay\Applications
echo Cleaning HKCU\SOFTWARE\Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\DirectPlay\Applications
rem Problematic with applications containing space characters
for /f %%a in ('reg query HKCU\SOFTWARE\Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\DirectPlay\Applications') do reg delete "%%a" /f
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\DirectInput
rem
rem echo Cleaning HKCU\SOFTWARE\Microsoft\DirectInput
rem
rem Throws an ‘Access is denied’ message
rem for /f %%a in ('reg query "HKCU\SOFTWARE\Microsoft\DirectInput"') do reg delete "%%a" /f
rem echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\DirectInput\MostRecentApplication
echo Cleaning HKCU\SOFTWARE\Microsoft\DirectInput\MostRecentApplication
reg delete "HKCU\SOFTWARE\Microsoft\DirectInput\MostRecentApplication" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\DirectPlay8\Applications
echo Cleaning HKCU\SOFTWARE\Microsoft\DirectPlay8\Applications
reg delete "HKCU\SOFTWARE\Microsoft\DirectPlay8\Applications" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppBadgeUpdated
echo Cleaning HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppBadgeUpdated
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppBadgeUpdated" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppLaunch
echo Cleaning HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppLaunch
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppLaunch" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched
echo Cleaning HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched
reg delete "%hkcuwincurrentrkeypath%\Explorer\FeatureUsage\AppSwitched" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\ShowJumpView
echo Cleaning HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\ShowJumpView
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\ShowJumpView" /f /va
echo.

rem Full registry path:
rem HKCU\SOFTWARE\Microsoft\Notepad
echo Cleaning HKCU\SOFTWARE\Microsoft\Notepad
reg delete "HKCU\SOFTWARE\Microsoft\Notepad" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\JumplistData
echo Cleaning HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\JumplistData
reg delete "%hkcuwincurrentrkeypath%\Search\JumplistData" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UFH\SHC
echo Cleaning HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UFH\SHC
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UFH\SHC" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store
echo Cleaning HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store
reg delete "%hkcuwinntcvregpath%\AppCompatFlags\Compatibility Assistant\Store" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers
echo Cleaning HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers
reg delete "%hkcuwinntcvregpath%\AppCompatFlags\Layers" /f /va
echo.

rem Full registry key paths:
rem HKCU\System\GameConfigStore\Children
rem HKCU\System\GameConfigStore\Parents
rem
rem Some video games make Windows 10 create keys with possibly random or
rem pseudo-random alphanumerical key names divided by four dashes/minuses under
rem the full key HKCU\System\GameConfigStore\Children and
rem HKCU\System\GameConfigStore\Parents
echo Cleaning HKCU\System\GameConfigStore\Children
for /f %%a in ('reg query HKCU\System\GameConfigStore\Children') do reg delete %%a /f
echo.

echo Cleaning HKCU\System\GameConfigStore\Parents
for /f %%a in ('reg query HKCU\System\GameConfigStore\Parents') do reg delete %%a /f
echo.

rem Full registry key path:
rem HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications
echo Cleaning HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications
reg delete "%heapleakregpath%\DiagnosedApplications" /f /va

rem Causes problems with applications containing a space character
for /f %%a in ('reg query %heapleakregpath%\DiagnosedApplications') do reg delete %%a /f
echo.

rem Full registry key path:
rem HKLM\SOFTWARE\WOW6432Node\Microsoft\Direct3D\MostRecentApplication
echo Cleaning HKLM\SOFTWARE\WOW6432Node\Microsoft\Direct3D\MostRecentApplication
reg delete "%hklmw64rkeypath%\Direct3D\MostRecentApplication" /f /va
echo.

rem Full registry key path:
rem HKLM\SOFTWARE\WOW6432Node\Microsoft\DirectDraw\MostRecentApplication
echo Cleaning HKLM\SOFTWARE\WOW6432Node\Microsoft\DirectDraw\MostRecentApplication
reg delete "%hklmw64rkeypath%\DirectDraw\MostRecentApplication" /f /va
echo.

rem Full registry key path:
rem HKLM\SYSTEM\ControlSet001\Services\bam\State\UserSettings\*
rem
rem The following contains registry values of recently used programs. I have
rem not yet found a method to actually delete them. Via registry editor you’ll
rem just get the error ‘Unable to delete all specified values.’
rem
rem When using ‘reg delete’, even as administrator you’ll receive the
rem ‘ERROR: Access is denied.’ message. The asterisk is a placeholder for user
rem IDs; this is for example purposes only and non-functional
rem
rem reg delete HKLM\SYSTEM\ControlSet001\Services\bam\State\UserSettings\* /f /va

echo Registry cleanup partially done.

echo Some keys and values could not be removed. Consider cleaning the following
echo manually with the registry editor:
echo.

echo HKCU\SOFTWARE\Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\DirectPlay\Applications
echo HKCU\SOFTWARE\Microsoft\DirectInput
echo HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications
echo.

pause
