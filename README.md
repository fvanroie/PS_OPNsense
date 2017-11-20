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

Not all functionality is implemented yet and this is an early development alpha release. All testing and feedback is appreciated.

## Supported Plugins
Currently there are basic api hooks for these optional OPNsense pluginss:
- ClamAV

Currently only Start, Stop, Update and Restart services are implemented for the plugins. More work is needed to support all available REST api commands.

## Legacy Commands
Currently there is legacy WebUI support for these commands:
- Backup Config
- Restore Config
- Reset Factory Defaults

Only a minimal set of legacy commands will be made available. Only crucial functionality that is not yet available via the REST api yet will be addressed using the WebUI. In the future these cmdlets will be ported over to REST api functions when possible.

## Getting Started
You can download and unzip the module into the PowerShell Modules folder or clone the repository directly:
```git
git clone https://github.com/fvanroie/PS_OPNsense.git .\PS_OPNsense
```

To load this module in PowerShell type:
```powershell
Import-Module -Name PS_OPNsense
```

## Examples
Connecting to an OPNsense server:
```powershell
Connect-OPNsense -Uri 'http://opnsense.local:8080' -Key <api_key> -Secret <api_secret>
Connect-OPNsense -Uri 'https://opnsense.local' -Key <api_key> -Secret <api_secret> -Verbose -Debug
Connect-OPNsense 'https://opnsense.local' <api_key> <api_secret> -SkipCertificateCheck
```
Run some commands:
```powershell
Invoke-OPNsenseCommand core firmware status -Verbose
$(Invoke-OPNsenseCommand core firmware info).changelog
```
Disconnect from the server:
```powershell
Disconnect-OPNsense
```

Use the -Verbose and/or -Debug switches to see what is going on behind the scenes. You can use the output to learn more about the OPNsense REST api.

For the full documentation on all the different cmdlets and parameters, please visit the [PS_OPNsense wiki](https://github.com/fvanroie/PS_OPNsense//wiki/).

## Compatibility
This module is tested on:

Platform   | Edition            | Version
-----------|--------------------|--------
Windows 10 | PowerShell Desktop | 5.1
Windows 10 | PowerShell Core    | RC 6.0

PS_OPNsense aims to be cross-platform on PowerShell Core RC 6.0 and up, however it has not been tested on Linux and MacOS yet.
Feel free to use it on these platforms and report back any issues you encouter.