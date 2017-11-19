# PS_OPNsense

## About
This is a PowerShell module that leverages the OPNsense api to manage [OPNsense](https://opnsense.org/) firewall appliances. The development of both OPNsense and this PowerShell module is still very much ongoing, so additional functionality will be added as these projects evolve.

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

Not all functionality is implemented yet and this is an early development alpha release. All testing and feedback
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

Use the -Verbose and/or -Debug switches to see what is going on behind the scenes. You can use the output to learn more about the OPNsense REST Api.

For the documentation on all the different cmdlets, please visit the [PS_OPNsense wiki](https://github.com/fvanroie/PS_OPNsense//wiki/).
