<#  MIT License

    Copyright (c) 2018 fvanroie, NetwiZe.be

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
#>


##### Module Variables
#$IsPSCoreEdition = ($PSVersionTable.PSEdition -eq 'Core')
$minversion = [System.Version]'18.1.7'

$debug = $true  

# Load individual functions from scriptfiles
# TODO : itterate over the objectmap and test if all Objects can be instantiated
ForEach ($Folder in 'Classes', 'Core', 'Plugins', 'Private', 'Public') {
    $FullPath = ("{0}/{1}/" -f $PSScriptRoot, $Folder)
    $Scripts = Get-ChildItem -Recurse -Filter '*.ps1' -Path $FullPath | Where-Object { $_.Name -notlike '*.Tests.ps1' }
    ForEach ($Script in $Scripts) {
        Try {
            # Dot Source each function file
            . $Script.fullname

            # Export Public Functions only
            if ($Folder -eq 'Public') {
                Export-ModuleMember $script.basename
            }

        } Catch {
            # Display error
            Write-Error -Message ("Failed to import function {0}: {1}" -f $Script.name, $_)
        }
    }
}

ForEach ($Folder in 'Classes') {
    $FullPath = ("{0}/{1}/" -f $PSScriptRoot, $Folder)
    $Files = Get-ChildItem -Recurse -Filter '*.cs' -Path $FullPath | Where-Object { $_.Name -notlike '*.Tests.ps1' }
    ForEach ($File in $Files) {
        if ($debug) {
            Write-Host -ForegroundColor Gray "Loading class file $file"
        }
        Try {
            Import-Type -Path $file

        } Catch {
            # Display error
            Write-Error -Message ("Failed to load class definition file {0}`nError : {1}" -f $file.name, $_)
        }
    }
}


# Load external data files
# TODO : convert this to a ps1 file so it can be code-signed
Try {
    if ($debug) {
        Write-Host -ForegroundColor Gray "ScriptRoot: $PSScriptRoot"
    }
    # Load objectmap of api calls
    $FullPath = ("{0}/{1}" -f $PSScriptRoot, 'Data/opnsense.json')
    $OPNsenseOpenApi = Import-OpenApiData $FullPath

    # Load objectmap of api calls
    #$FullPath = ("{0}/{1}" -f $PSScriptRoot, 'Data/items.json')
    #$OPNsenseItemMap = Get-Content $FullPath | ConvertFrom-Json

    # Load servicemap of api calls
    $FullPath = ("{0}/{1}" -f $PSScriptRoot, 'Data/services.json')
    $OPNsenseServiceMap = Get-Content $FullPath | ConvertFrom-Json

    # Load settingsmap of api calls
    $FullPath = ("{0}/{1}" -f $PSScriptRoot, 'Data/settings.json')
    $OPNsenseSettingMap = Get-Content $FullPath | ConvertFrom-Json

} Catch {
    Throw ("Unable to load the API maps :`nError : {0}" -f $_)
}

# Compare Classes in OpenApi with Classes in PowerShell Module

# Load objectmap of api calls
$FullPath = ("{0}/{1}" -f $PSScriptRoot, 'Data/opnsense.json')
$OpenApiSpec = Get-Content $FullPath | ConvertFrom-Json

$cppClasses = [AppDomain]::CurrentDomain.GetAssemblies().ExportedTypes.Fullname |
    Where-Object {$_ -like 'OPnsense.*'} | Select-Object -Unique
$apiClasses = $OpenApiSpec.components.schemas.psobject.Properties.name
$diff = Compare-Object $cppClasses $apiClasses
foreach ($Class in $diff) {
    if ($Class.SideIndicator -eq '<=') {
        Write-Warning ("{0} is not defined in the API specification." -f $Class.InputObject)
    } else {
        Write-Warning ("{0} is not defined in the Class Definitions." -f $Class.InputObject)
    }
}

##### Static Export of Module Fucntions (Temporary situation untill all function get a proper script file)
Export-ModuleMember -Function Connect-OPNsense, Disconnect-OPNsense, Invoke-OPNsenseCommand
$f = @(########## PLUGINS ##########
    # ArpScanner
    'Update-OPNsenseArp', #'Get-OPNsenseArpScanner', 'Start-OPNsenseArpScanner', 'Wait-OPNsenseArpScanner', 'Stop-OPNsenseArpScanner',
    # Lldpd
    'Get-OPNsenseLldp', 'Set-OPNsenseLldp',
    # HAProxy
    'New-OPNsenseHAProxyServer', 'New-OPNsenseHAProxyFrontend', 'New-OPNsenseHAProxyBackend', 'New-OPNsenseHAProxyErrorfile', 'New-OPNsenseHAProxyLuaScript', 'New-OPNsenseHAProxyAcl', 'New-OPNsenseHAProxyHealthCheck',
    'Set-OPNsenseHAProxyServer', 'Set-OPNsenseHAProxyLuaScript',
   

    ########## CORE ##########
    # RestApi
    'Invoke-OPNsenseCommand', 'Invoke-OPNsenseOpenApiPath',
    # Firmware
    'Get-OPNsense', 'Set-OPNsense',

    # Cron
    'Get-OPNsenseCronJob', 'Enable-OPNsenseCronJob', 'Disable-OPNsenseCronJob', 'Remove-OPNsenseCronJob',
    'New-OPNsenseCronJob', 'Set-OPNsenseCronJob',
    #IDS
    'Get-OPNsenseIdsUserRule', 'New-OPNsenseIdsUserRule'
    # Proxy
    'New-OPNsenseProxyRemoteBlacklist', 'Get-OPNsenseProxyRemoteBlacklist', 'Remove-OPNsenseProxyRemoteBlacklist',
    'Sync-OPNsenseProxyRemoteBlacklist',
    # CaptivePortal
    'New-OPNsenseCaptivePortalZone', 'Remove-OPNsenseCaptivePortalZone',
    'New-OPNsenseCaptivePortalTemplate', 'Get-OPNsenseCaptivePortalTemplate', 'Set-OPNsenseCaptivePortalTemplate', 'Remove-OPNsenseCaptivePortalTemplate', 'Save-OPNsenseCaptivePortalTemplate',
    'Get-OPNsenseCaptivePortal',
    # Diagnostics
    'Get-OPNsenseSystemHealth', 'Get-OPNsenseResource', 'Get-OPNsenseInterface', 'Get-OPNsenseRoute', 'Get-OPNsenseARP', 'Clear-OPNsenseARP',
    # Services
    'Get-OPNsenseService', 'Start-OPNsenseService', 'Update-OPNsenseService', 'Test-OPNsenseService', 'Restart-OPNsenseService', 'Stop-OPNsenseService', 'Invoke-OPNsenseService'
)
Export-ModuleMember -Function $f