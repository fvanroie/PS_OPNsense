# OPNsense

## 
This is a PowerShell module that leverages the OPNsense api to manage an [OPNsense](https://opnsense.org/) open source firewall appliances. The development of both OPNsense and this PowerShell module is still very much ongoing, so additional functionality will be added as these projects mature.

Currently there are api hooks for these OPNsense modules:
- **CaptivePortal**
- **Core (Firmware and Packages)**
- **Cron**
- **Diagnostics**
- **IDS**
- **Proxy**
- Routes
- TrafficShaper
- Unbound

Modules in **bold** have mostly been implemented in the current version of the PS_OPNsense module.

## Examples
```powershell
Connect-OPNsense -Uri 'https://fw01.local/api' -Key <my_api_key> -Secret <my_api_secret>
Get-OPNsense
Restart-OPNsense
Disconnect-OPNsense
```
