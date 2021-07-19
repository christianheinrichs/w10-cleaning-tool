w10-logwipe
===========

###### Rationale
Are you sick of log files clogging up your Windows machine? Well, look no
further. This script empties almost all Windows log files. Unfortunately, I am
not aware of any way of removing logs which are handled by the `wevtutil`
command. Log files which can be deleted are done so by utilising the OS’
internal `del` command. It can also wipe logs of third-party programs.

The currently supported ones are:

- Epic Games Launcher
- GOG Galaxy 2.0
- NVIDIA control panel
- Steam

###### Usage
In this section, there will be two methods described of executing this script.
Feel free to do this any way you want to.

*Method 1*
1. First and foremost, this script requires admin privileges.
2. Create a shortcut to this script and set it to run with admin privileges in
   the ‘Advanced’ section of the shortcut tab.
3. Simply doubleclick the shortcut.

*Method 2*
1. Run the Windows command prompt as administrator
2. Navigate to the script’s location via `cd`
3. Type in `w10-logwipe.bat` or `start w10-logwipe.bat` to start it in a new
   window

###### Closing note
Please take into consideration that one or more log files might not get emptied.
The reason for this is the explicit selection of logs which are emptied as per
`wevtutil`. A fix is currently on the to do list.

This script assumes that you’re using Windows 10. It might or might not work on
earlier versions like Windows 7 or Windows 8. This script also assumes a default
installation path for the EGL, GOG Galaxy 2.0, the NVIDIA control panel and
Steam, so you might need to tweak it if your installation path is different.

What this script cannot is delete log files which are currently in use. For
example, trying to empty the operational log of Windows Live ID will cause an
‘Access denied’ message. Logs which are currently used by the NVIDIA control
panel for example can’t be simply deleted either, because they are currently in
use, so this requires an approach which closes the program, then deletes the log
file and restarts the process or leaves it closed.
