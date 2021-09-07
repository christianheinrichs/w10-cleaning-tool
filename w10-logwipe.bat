@echo off

title Windows 10 log wipe script running

rem Epic Games Launcher
echo Epic Games Launcher: Deleting logs
echo.
del /q %localappdata%\EpicGamesLauncher\Saved\Logs\*

rem GOG Galaxy 2.0
echo GOG Galaxy 2.0: Deleting logs
echo.
del /q %programdata%\GOG.com\Galaxy\logs\*

rem NVIDIA control panel
echo NVIDIA control panel: Deleting logs
echo.
del /q %programdata%\NVIDIA\*
del "%programdata%\NVIDIA Corporation\nvtopps\*.log"
del "%programdata%\NVIDIA Corporation\DisplayDriverRAS\NvTelemetry\*.log"
del "%programdata%\NVIDIA Corporation\DisplayDriverRAS\NvTelemetry\*.log.bak"
del "%programdata%\NVIDIA Corporation\NvProfileUpdaterPlugin\*.log"
del "%programdata%\NVIDIA Corporation\NvProfileUpdaterPlugin\*.log.bak"
echo.

rem Rockstar Games Launcher
echo Rockstar Games Launcher: Deleting logs
echo.
del "%programdata%\Rockstar Games\Launcher\*.txt"
del "%userprofile%\Documents\Rockstar Games\Launcher\*.log"
del "%userprofile%\Documents\Rockstar Games\Social Club\*.log"

rem Steam
echo Steam: Deleting logs
echo.
del "C:\Program Files (x86)\Steam\*.log"
del "C:\Program Files (x86)\Steam\*.log.last"
del /q "C:\Program Files (x86)\Steam\logs\*"


rem Removable Windows logs
echo Deleting removable Windows logs
echo.
del %systemroot%\*.log
del %systemroot%\INF\*.log
del %systemroot%\Logs\*.log
del %systemroot%\Logs\CBS\*.log
del %systemroot%\Logs\DISM\*.log
del %systemroot%\System32\*.log
del %systemroot%\System32\LogFiles\setupcln\*.log
del %systemroot%\SysWOW64\*.log
echo.

rem Microsoft Edge Update
echo Microsoft Edge Update: Ending task
echo.
taskkill /f /im MicrosoftEdgeUpdate.exe
echo Microsoft Edge Update: Deleting logs
echo.
del /q %programdata%\Microsoft\EdgeUpdate\Log\*
echo.

rem Microsoft Security Client
echo Microsoft Security Client: Deleting logs
echo.
del "%programdata%\Microsoft\Microsoft Security Client\Support\*.log"
echo.

rem Windows Defender

rem Without temporarily disabling Windows Defender, this probably won’t work
rem Obviously NOT recommended!
echo Windows Defender: Trying to delete logs
echo.
del "C:\ProgramData\Microsoft\Windows Defender\Support\*.log"

rem Windows network downloader
echo Windows network downloader: Deleting logs
echo.
del %programdata%\Microsoft\Network\Downloader\*.log

rem Windows SmsRouter MessageStore
echo Windows SmsRouter MessageStore: Deleting logs
echo.
del %programdata%\Microsoft\SmsRouter\MessageStore\*.log

rem Requires administration privileges
rem TODO: Iterate through all logs without writing out logfile names explicitly

rem Empty Windows log files via wevtutil
echo Emptying Windows log files via wevtutil
echo.
wevtutil cl Application
wevtutil cl Microsoft-Client-Licensing-Platform/Admin
wevtutil cl Microsoft-Windows-AAD/Operational
wevtutil cl Microsoft-Windows-Application-Experience/Program-Compatibility-Assistant
wevtutil cl Microsoft-Windows-Application-Experience/Program-Compatibility-Troubleshooter
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
wevtutil cl Microsoft-Windows-CertificateServicesClient-Lifecycle-System/Operational
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
wevtutil cl Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin
wevtutil cl Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Debug
wevtutil cl Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Operational
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
rem Throws an ‘Access denied’ message
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
wevtutil cl Microsoft-Windows-Provisioning-Diagnostics-Provider/Admin
wevtutil cl Microsoft-Windows-Provisioning-Diagnostics-Provider/AutoPilot
wevtutil cl Microsoft-Windows-Provisioning-Diagnostics-Provider/ManagementService
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
wevtutil cl "Microsoft-Windows-Windows Firewall With Advanced Security/ConnectionSecurity"
wevtutil cl "Microsoft-Windows-Windows Firewall With Advanced Security/Firewall"
wevtutil cl "Microsoft-Windows-Windows Firewall With Advanced Security/FirewallDiagnostics"
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
echo The following logs were deleted: Epic Games Launcher, GOG Galaxy, NVIDIA control panel, Rockstar Games Launcher, Steam
echo Windows logs have been emptied...
echo.

pause
