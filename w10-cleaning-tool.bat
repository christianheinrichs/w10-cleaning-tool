@echo off

rem w10-cleaning-tool.bat
rem Last modified on 11 February 2022

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
del "%systemroot%\*.log"
del "%systemroot%\INF\*.log"
del "%systemroot%\Logs\*.log"
del "%systemroot%\Logs\CBS\*.log"
del "%systemroot%\Logs\DISM\*.log"
del "%systemroot%\System32\*.log"
del "%systemroot%\System32\LogFiles\setupcln\*.log"
del "%systemroot%\SysWOW64\*.log"
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

set "mwaexp=Microsoft-Windows-Application-Experience"
set "mwcscls=Microsoft-Windows-CertificateServicesClient-Lifecycle-System"
set "mwdmedp=Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider"
set "mwpdp=Microsoft-Windows-Provisioning-Diagnostics-Provider"
set "mwwfwas=Microsoft-Windows-Windows Firewall With Advanced Security"

rem Empty Windows log files via wevtutil
echo Emptying Windows log files via wevtutil
echo.
wevtutil cl Application
wevtutil cl Microsoft-Client-Licensing-Platform/Admin
wevtutil cl Microsoft-Windows-AAD/Operational
wevtutil cl "%mwaexp%/Program-Compatibility-Assistant"
wevtutil cl "%mwaexp%/Program-Compatibility-Troubleshooter"
wevtutil cl Microsoft-Windows-Application-Experience/Program-Telemetry
wevtutil cl Microsoft-Windows-AppModel-Runtime/Admin
wevtutil cl Microsoft-Windows-AppReadiness/Admin
wevtutil cl Microsoft-Windows-AppReadiness/Operational
wevtutil cl Microsoft-Windows-AppXDeployment/Operational
wevtutil cl Microsoft-Windows-AppXDeploymentServer/Operational
wevtutil cl Microsoft-Windows-AppxPackaging/Operational
wevtutil cl Microsoft-Windows-Audio/Operational
wevtutil cl Microsoft-Windows-Audio/PlaybackManager
wevtutil cl Microsoft-Windows-BackgroundTaskInfrastructure/Operational
wevtutil cl Microsoft-Windows-Biometrics/Operational
wevtutil cl "Microsoft-Windows-BitLocker/BitLocker Management"
wevtutil cl Microsoft-Windows-Bits-Client/Operational
wevtutil cl "%mwcscls%/Operational"
wevtutil cl Microsoft-Windows-Cleanmgr/Diagnostic
wevtutil cl Microsoft-Windows-CloudStore/Operational
wevtutil cl Microsoft-Windows-CodeIntegrity/Operational
wevtutil cl Microsoft-Windows-Containers-BindFlt/Operational
wevtutil cl Microsoft-Windows-Containers-Wcifs/Debug
wevtutil cl Microsoft-Windows-Containers-Wcifs/Operational
wevtutil cl Microsoft-Windows-CoreSystem-SmsRouter-Events/Debug
wevtutil cl Microsoft-Windows-CoreSystem-SmsRouter-Events/Operational
wevtutil cl Microsoft-Windows-Crypto-DPAPI/Operational
wevtutil cl Microsoft-Windows-Crypto-NCrypt/Operational
wevtutil cl "%mwdmedp%/Admin"
wevtutil cl "%mwdmedp%/Debug"
wevtutil cl "%mwdmedp%/Operational"
wevtutil cl Microsoft-Windows-DxgKrnl-Admin
wevtutil cl Microsoft-Windows-DeviceSetupManager/Admin
wevtutil cl Microsoft-Windows-DeviceSetupManager/Operational
wevtutil cl Microsoft-Windows-Diagnosis-DPS/Analytic
wevtutil cl Microsoft-Windows-Diagnosis-DPS/Debug
wevtutil cl Microsoft-Windows-Diagnosis-DPS/Operational
wevtutil cl Microsoft-Windows-Diagnosis-PCW/Operational
wevtutil cl Microsoft-Windows-Diagnosis-Scheduled/Operational
wevtutil cl Microsoft-Windows-Diagnosis-Scripted/Admin
wevtutil cl Microsoft-Windows-Diagnosis-Scripted/Operational
wevtutil cl Microsoft-Windows-Diagnosis-ScriptedDiagnosticsProvider/Operational
wevtutil cl Microsoft-Windows-Diagnostics-Performance/Operational
wevtutil cl Microsoft-Windows-Fault-Tolerant-Heap/Operational
wevtutil cl Microsoft-Windows-GroupPolicy/Operational
wevtutil cl Microsoft-Windows-HelloForBusiness/Operational
wevtutil cl "Microsoft-Windows-HomeGroup Control Panel/Operational"
wevtutil cl Microsoft-Windows-IKE/Operational
wevtutil cl Microsoft-Windows-International/Operational
wevtutil cl Microsoft-Windows-Kernel-Boot/Operational
wevtutil cl Microsoft-Windows-Kernel-PnP/Configuration
wevtutil cl Microsoft-Windows-Kernel-ShimEngine/Operational
wevtutil cl Microsoft-Windows-Kernel-WHEA/Errors
wevtutil cl Microsoft-Windows-Kernel-WHEA/Operational
wevtutil cl Microsoft-Windows-Kernel-EventTracing/Admin
wevtutil cl Microsoft-Windows-Kernel-EventTracing/Analytic
wevtutil cl "Microsoft-Windows-Known Folders API Service"
wevtutil cl Microsoft-Windows-LanguagePackSetup/Operational
rem Throws an ‘Access is denied’ message
rem wevtutil cl Microsoft-Windows-LiveId/Operational
wevtutil cl Microsoft-Windows-MemoryDiagnostics-Results/Debug
wevtutil cl Microsoft-Windows-MUI/Admin
wevtutil cl Microsoft-Windows-MUI/Operational
wevtutil cl Microsoft-Windows-NCSI/Operational
wevtutil cl Microsoft-Windows-NetworkProfile/Operational
wevtutil cl Microsoft-Windows-NlaSvc/Operational
wevtutil cl Microsoft-Windows-Ntfs/Operational
wevtutil cl Microsoft-Windows-Ntfs/WHC
wevtutil cl Microsoft-Windows-OneBackup/Debug
wevtutil cl Microsoft-Windows-Partition/Diagnostic
wevtutil cl Microsoft-Windows-PowerShell/Admin
wevtutil cl Microsoft-Windows-PowerShell/Operational
wevtutil cl Microsoft-Windows-Privacy-Auditing/Operational
wevtutil cl "%mwpdp%/Admin"
wevtutil cl "%mwpdp%/AutoPilot"
wevtutil cl "%mwpdp%/ManagementService"
wevtutil cl Microsoft-Windows-PushNotification-Platform/Admin
wevtutil cl Microsoft-Windows-PushNotification-Platform/Operational
wevtutil cl Microsoft-Windows-ReadyBoost/Operational
wevtutil cl Microsoft-Windows-RemoteAssistance/Admin
wevtutil cl Microsoft-Windows-RemoteAssistance/Operational
wevtutil cl Microsoft-Windows-Resource-Exhaustion-Detector/Operational
wevtutil cl Microsoft-Windows-Resource-Exhaustion-Resolver/Operational
wevtutil cl Microsoft-Windows-Security-LessPrivilegedAppContainer/Operational
wevtutil cl Microsoft-Windows-Security-Mitigations/KernelMode
wevtutil cl Microsoft-Windows-Security-Mitigations/UserMode
wevtutil cl Microsoft-Windows-Security-SPP-UX-Notifications/ActionCenter
wevtutil cl Microsoft-Windows-SettingSync/Debug
wevtutil cl Microsoft-Windows-SettingSync/Operational
wevtutil cl Microsoft-Windows-Shell-Core/ActionCenter
wevtutil cl Microsoft-Windows-Shell-Core/AppDefaults
wevtutil cl Microsoft-Windows-Shell-Core/Diagnostic
wevtutil cl Microsoft-Windows-Shell-Core/LogonTasksChannel
wevtutil cl Microsoft-Windows-Shell-Core/Operational
wevtutil cl Microsoft-Windows-ShellCommon-StartLayoutPopulation/Operational
wevtutil cl Microsoft-Windows-SmbClient/Connectivity
wevtutil cl Microsoft-Windows-SmbClient/Security
wevtutil cl Microsoft-Windows-SMBServer/Operational
wevtutil cl Microsoft-Windows-StateRepository/Operational
wevtutil cl Microsoft-Windows-Storage-ClassPnP/Operational
wevtutil cl Microsoft-Windows-StorageSettings/Diagnostic
wevtutil cl Microsoft-Windows-StorageSpaces-Driver/Operational
wevtutil cl Microsoft-Windows-Storage-Storport/Health
wevtutil cl Microsoft-Windows-Storage-Storport/Operational
wevtutil cl Microsoft-Windows-Store/Operational
wevtutil cl Microsoft-Windows-Storsvc/Diagnostic
wevtutil cl Microsoft-Windows-TaskScheduler/Maintenance
wevtutil cl Microsoft-Windows-TerminalServices-LocalSessionManager/Operational
wevtutil cl Microsoft-Windows-Time-Service/Operational
wevtutil cl Microsoft-Windows-TWinUI/Operational
wevtutil cl Microsoft-Windows-TZSync/Operational
wevtutil cl Microsoft-Windows-UAC/Operational
wevtutil cl Microsoft-Windows-UAC-FileVirtualization/Operational
wevtutil cl Microsoft-Windows-UniversalTelemetryClient/Operational
wevtutil cl "Microsoft-Windows-User Device Registration/Admin"
wevtutil cl "Microsoft-Windows-User Profile Service/Operational"
wevtutil cl Microsoft-Windows-UserPnp/DeviceInstall
wevtutil cl Microsoft-Windows-VHDMP-Operational
wevtutil cl Microsoft-Windows-VolumeSnapshot-Driver/Operational
wevtutil cl Microsoft-Windows-Wcmsvc/Operational
wevtutil cl Microsoft-Windows-WebAuthN/Operational
wevtutil cl Microsoft-Windows-WER-Diag/Operational
wevtutil cl Microsoft-Windows-WER-PayloadHealth/Operational
wevtutil cl Microsoft-Windows-WFP/Operational
wevtutil cl "Microsoft-Windows-Windows Defender/Operational"
wevtutil cl "%mwwfwas%/ConnectionSecurity"
wevtutil cl "%mwwfwas%/Firewall"
wevtutil cl "%mwwfwas%/FirewallDiagnostics"
wevtutil cl Microsoft-Windows-WindowsSystemAssessmentTool/Operational
wevtutil cl Microsoft-Windows-WindowsUpdateClient/Operational
wevtutil cl Microsoft-Windows-WinINet-Config/ProxyConfigChanged
wevtutil cl Microsoft-Windows-Winlogon/Operational
wevtutil cl Microsoft-Windows-WinRM/Operational
wevtutil cl Microsoft-Windows-WMI-Activity/Operational
wevtutil cl Security
wevtutil cl Setup
wevtutil cl System
wevtutil cl WFC
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

rem Some video games make Windows 10 create keys with possibly random or
rem pseudo-random alphanumerical key names divided by four dashes/minuses under
rem the full key HKCU\System\GameConfigStore\Children. Thusly, the following
rem command is unfortunately useless since it focuses on values located under a
rem key.
rem reg delete "HKCU\System\GameConfigStore\Children" /f /va

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
rem HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched
echo Cleaning HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched
reg delete "%hkcuwincurrentrkeypath%\Explorer\FeatureUsage\AppSwitched" /f /va
echo.

rem Full registry key path:
rem HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\JumplistData
echo Cleaning HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\JumplistData
reg delete "%hkcuwincurrentrkeypath%\Search\JumplistData" /f /va
echo.

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

rem The following contains registry values of recently used programs. I have
rem not yet found a method to actually delete them. Via registry editor you’ll
rem just get the error ‘Unable to delete all specified values.’
rem
rem When using ‘reg delete’, even as administrator you’ll receive the
rem ‘ERROR: Access is denied.’ message. The asterisk is a placeholder for user
rem IDs; this is for example purposes only and non-functional
rem
rem reg delete HKLM\SYSTEM\ControlSet001\Services\bam\State\UserSettings\* /f /va

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

echo Cleaning HKCU\SOFTWARE\Microsoft\DirectPlay8\Applications
reg delete "HKCU\SOFTWARE\Microsoft\DirectPlay8\Applications" /f /va
echo.

rem Deleting values does the trick, the /va argument however is useless here,
rem because it doesn’t delete keys. Again, need to find out how to delete all
rem keys under
rem HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications
rem
rem Full registry key path:
rem HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications
echo Cleaning HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications
reg delete "%heapleakregpath%\DiagnosedApplications" /f /va
echo.

echo Registry cleanup partially done.

echo Some keys and values could not be removed. Consider cleaning the following
echo manually with the registry editor:
echo.
echo HKCU\SOFTWARE\Microsoft\DirectInput
echo HKCU\SOFTWARE\Microsoft\Notepad
echo HKCU\System\GameConfigStore\Children
echo HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications
echo.

pause
