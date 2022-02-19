w10-cleaning-tool

Introduction

This project has now been converted. If you only want the Windows 10 log file
cleaner, please revert to version 19.1.2022-r2 to only use that functionality.
Instead of focusing only on log files, this batch file now takes care of other
tasks as well. For the sake of readability, the following is split into a
listed format.

- Prefetch cleanup

  Windows 10 and previous versions probably as well create so called prefetch
  files in the .pf format. This I assume is being done for performance reasons,
  so data of a specific executable file can be prefetched. From a privacy
  standpoint however, this is just one of many methods which can be used to
  determine previously used programs. So before you shut down your Windows
  machine, run this batch file and it should delete those .pf files.

- General cleanup

  This is just a very small routine which deletes your local DNS cache and gets
  rid of data related to NVIDIA. Data in this context consists of several
  events files in what seems to be some kind of binary format, yet another log
  file and one or more backups of it for NvTelemetry, a telemetry switch file,
  an application timestamps file containing recently used programs with
  timestamps, a log file for nvtopps and finally a database file for nvtopps.

- Log deletion section (formerly known as w10-logwipe)

  This section empties almost all Windows log files and deletes Windows log
  files which can be deleted by utilising the OS’ internal ‘del’ command. It can
  also wipe logs of third-party programs.

  The currently supported ones are:

  - Epic Games Launcher
  - GOG Galaxy 2.0
  - NVIDIA control panel
  - Rockstar Games Launcher
  - Steam
  - Windows Firewall Control

- Registry cleanup

  Although there are already many programs and scripts out there that take care
  of this, I still felt the need to include it. This is the last section and it
  uses ‘reg delete’ to get rid of certain registry entries. A big problem here
  though is that I have no idea how to get rid of multiple keys or subkeys
  located under yet another key. I guess that you somehow need to iterate
  through it. This is currently on the to-do list.

Usage

In this section, there will be two methods described of executing this script.
Feel free to do this any way you want to.

Method 1

1. First and foremost, this script requires administrator privileges
2. Create a shortcut to this script and set it to run with administrator
   privileges in the ‘Advanced’ section of the shortcut tab
3. Simply double-click the shortcut

Method 2

1. Run the Windows command prompt as administrator
2. Navigate to the script’s location via ‘cd’
3. Type in ‘w10-cleaning-tool.bat’ or ‘start w10-cleaning-tool.bat’ to start it
   in a new window

Closing note

While I tried my best to provide you a tool to gain a little bit more privacy
on a Windows 10 machine, it doesn’t give you any protection against a
determined attacker. It also does not protect you against file recovery
attacks. Use this script at your own risk.

Licensing

This project is licensed under the GNU GPL 3.0 license. To read it, please
refer to the LICENSE document.
