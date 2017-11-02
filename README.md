# PS_OPNsense

## About
This is a PowerShell module that leverages the OPNsense api to manage an [OPNsense](https://opnsense.org/) open source firewall appliances. The development of both OPNsense and this PowerShell module is still very much ongoing, so additional functionality will be added as these projects mature.

To load this module in PowerShell type:
```powershell
Import-Module -Name PS_OPNsense
```

## Supported Modules
Currently there are api hooks for these OPNsense modules:
- *CaptivePortal*
- *Core (Firmware and Packages)*
- *Cron*
- *Diagnostics*
- *IDS*
- *Proxy*
- *Routes*
- *TrafficShaper*
- *Unbound*

Modules in **bold** have been implemented in the current version of the PS_OPNsense module.
Currently only the raw API commands are available. See the examples below.

## Examples
```powershell
Connect-OPNsense -Uri 'http://fw01.local/api' -Key <my_api_key> -Secret <my_api_secret>
Connect-OPNsense -Uri 'https://fw01.local/api' -Key <my_api_key> -Secret <my_api_secret> -Verbose
Connect-OPNsense -Uri 'https://fw01.local/api' -Key <my_api_key> -Secret <my_api_secret> -AcceptCertificate -Verbose
Invoke-OPNsenseCommand core firmware status -Verbose
$(Invoke-OPNsenseCommand core firmware info).changelog
Disconnect-OPNsense
```
