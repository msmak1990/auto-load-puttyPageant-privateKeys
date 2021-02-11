# Load-puttyPageant-privateKeys
Date | Modified by | Remarks
:----: | :----: | :----
2021-02-07 | Sukri Kadir | Created
---

## Description:
> * This is the PowerShell script to load **automatically** the private key(s) using Putty Pageant application. 
> * All done by automated way!.

Windows Version | OS Architecture | PowerShell Version | Result
:----: | :----: | :----: | :----
Windows 10 | 64-bit and 32-bit | 5.1.x | Tested. `OK`
---

### Below are steps on what script does:

No. | Steps
:----: | :----
1 | Get a few configuration values from `PuttyPageant.cfg.ini` i.e. the Putty Pageant binary directory, the private key base directory, and the private key file name(s)
2 | Pre-validate to check the existence of the Putty Pageant binary executable file i.e. `pageant.exe`
3 | Pre-validate to test the existence of the base private key path
4 | Get recursively the private key(s) from the base private key path and store its file names into the dynamic array
5 | Throw an warning exception if the private key file name(s) is not available
6 | Load the private key(s) automatically after an user enters its pass-phrase key
---  

### How to run this script.

1. After cloning the repository, navigate into the base directory e.g. `..\auto-load-puttyPageant-privateKeys\`
2. Double-click on `Load-puttyPageant-privateKeys.cmd` file
---

### There are some functions involved as follows:

No. | Function Name | Description
:----: | :---- | :----
1 | `Get-IniConfiguration` | This function is used to get the contents of the .ini configuration file
2 | `Get-ConfigurationValue` | This function is used to get the configuration value(s) from `Get-IniConfiguration` function
3 | `Load-puttyPageant-privateKeys` | This function is used to load **automatically** the private key(s) from the specific path
4 | `PuttyPageant.cfg.ini` | This is the configuration file to customize a few configuration values

---
Example for the configuration file i.e. `PuttyPageant.cfg.ini`

```ini
[Load-puttyPageant-privateKeys.ps1]
PUTTY_PAGEANT_PATH = C:\Program Files\TortoiseGit\bin
PUTTY_PAGEANT_FILE_NAME = pageant.exe
PRIVATE_KEY_PATH = "$($env:USERPROFILE)\Desktop\Installers\.ssh"

; * to load for all the private key file names in the same directory.
; specify a private key file name to load a specified private key file name.
PRIVATE_KEY_FILE_NAME = *.ppk
```
