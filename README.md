# OPNsense

## About
This is a PowerShell module that leverages the OPNsense api to manage an [OPNsense](https://opnsense.org/) open source firewall appliances. The development of both OPNsense and this PowerShell module is still very much ongoing, so additional functionality will be added as these projects evolve.

## Supported Modules
Currently there are basic api hooks for these OPNsense modules:
- Backup
- CaptivePortal
- ClamAV
- Firmware
- Packages
- Cron
- Diagnostics
- IDS
- Proxy
- Services

Not all fucntionality is implemented yet and this is an early development alpha release. All testing and feedback
is appreciated.

## Getting Started
Clone the repository to your PowerShell Modules folder:
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
Connect-OPNsense -Uri 'https://fw01.local/api' -Key <api_key> -Secret <api_secret>
Connect-OPNsense -Uri 'https://fw01.local/api' -Key <api_key> -Secret <api_secret> -Verbose
Connect-OPNsense 'https://fw01.local/api' <api_key> <api_secret> -AcceptCertificate
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
