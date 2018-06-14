# PS_OPNsense

## About
This is a PowerShell module that uses the OPNsense REST api to manage [OPNsense](https://opnsense.org/) firewall appliances.
The development of the OPNsense REST api and this PowerShell module is still ongoing, so additional functionality will be added in the future.

## Supported Modules
Currently there are basic api hooks for these OPNsense modules:
- Firmware
- CaptivePortal
- Cron
- Diagnostics
- IDS
- Packages
- Proxy
- Services

Not all functionality is implemented yet and this is an *early development alpha release*. All testing and [feedback](https://github.com/fvanroie/PS_OPNsense/issues) is appreciated.

## Supported Objects

### Items
All CRUD items are supported using Get-OPNsenseItem, Remove-OPNsenseItem and Switch-OPNsenseItem.
Creating and updating CRUD items is being worked on and not yet fully supported.

### Packages
Full support to install, re-install, remove, lock and unlock OPNsense Packages and Plugins.

### Settings
You can get the Settings for all API modules. Changing the Settings is not supported yet.

### Services
Currently only Start, Stop, Update and Restart services are implemented for the other plugins. More work is needed to support all available REST api commands.

### Firmware
Updating firmware via PowerShell is implemented.

### Legacy Commands
There is legacy WebUI support for these commands:
- Backup Config
- Restore Config
- Reset Factory Defaults

A minimal set of legacy commands are also available in this PowerShell module. Only crucial functionality that is not yet available via the REST api yet will be exposed using the WebUI.
These cmdlets will be ported over to use the REST api functions when they are ported to the REST api when they are made available in future OPNsense firmware versions.

## Getting Started

### Install PS_OPNsense Module
To find out the location of the Modules directory, check the PSModulePath environment variable:
```powershell
$Env:PSModulePath -split ";"    # On Windows
$Env:PSModulePath -split ":"    # On Linux
```
Change into the PowerShell Module directory located in your profile folder.

You can download and unzip the module into the PowerShell Modules folder or clone the repository directly:
```git
git clone https://github.com/fvanroie/PS_OPNsense.git
```

Depending on your ExecutionPolicy, you might need to unblock the downloaded module files:
```powershell
Get-ChildItem PS_OPNsense -Recurse | Unblock-File -Verbose
```

To load this module in PowerShell type:
```powershell
Import-Module -Name PS_OPNsense -PassThru
```
Get all the commands in the PS_OPNsense module type:
```powershell
Get-Command -Module PS_OPNsense
```

### Create an API key in OPNsense
From the OPNsense GUI, create an API key for a user that will run PowerShell scripts:
- Open System > Access > Users.
- Click on a user that will be used for accessing the REST api.
- Under the section API keys, click on the Add [+] button to generate a key/secret pair.
- Download the txt file.
- Use the key and secret values to connect to OPNsense REST api using Connect-OPNsense cmdlet below.

## Examples
Connecting to an OPNsense server:
```powershell
Connect-OPNsense -Uri 'http://opnsense.local:8080' -Key <api_key> -Secret <api_secret>
Connect-OPNsense -Uri 'https://opnsense.local' -Key <api_key> -Secret <api_secret> -Verbose -Debug
Connect-OPNsense 'https://opnsense.local' <api_key> <api_secret> -SkipCertificateCheck
```
Run some commands:
```powershell
Get-OPNsenseItem -Cron Job
Get-OPNsensePackage -Plugin
```
Disconnect from the server:
```powershell
Disconnect-OPNsense
```

Use the -Verbose and/or -Debug switches to see what is going on behind the scenes. You can use the output to learn more about the OPNsense REST api.

The project contains an Examples directory with more example scripts. For the full documentation of all the cmdlets and parameters, please visit the [PS_OPNsense wiki](https://github.com/fvanroie/PS_OPNsense//wiki/).

## Compatibility
This module is tested on:

Platform          | Edition            | Version
------------------|--------------------|--------
Windows 10        | PowerShell Desktop | 5.1
Windows 10        | PowerShell Core    | 6.0
[Ubuntu 18.04](https://github.com/fvanroie/PS_OPNsense/wiki/Install-PowerShell-on-Ubuntu-18.04-beta) | PowerShell Core    | 6.0

PS_OPNsense aims to be cross-platform on PowerShell Core 6.0 and up, however it has not been extensively tested on MacOS yet. Let me know what works and what doesn't.
Feel free to use it on these platforms and report back any [issues](https://github.com/fvanroie/PS_OPNsense/issues) you encouter. The goal is to make PS_OPNsense crossplatform with PowerShell Core.