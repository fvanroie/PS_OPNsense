<#  MIT License

    Copyright (c) 2017 fvanroie

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

Function New-OPNsenseCaptivePortalZone {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $true)][String]$Description,
        [Parameter(Mandatory = $true)][String]$Interface = '',
        [Parameter(Mandatory = $false)][Boolean]$Enabled = $true,
        [Parameter(Mandatory = $false)][Boolean]$ConcurrentLogins = $true,
        [Parameter(Mandatory = $false)][Boolean]$TransparentHTTPProxy = $false,
        [Parameter(Mandatory = $false)][Boolean]$TransparentHTTPSProxy = $false,
        [Parameter(Mandatory = $false)][int]$IdleTimeout = 0,
        [Parameter(Mandatory = $false)][int]$HardTimeout = 0,
        [Parameter(Mandatory = $false)][int]$authEnforceGroup = 1999,
        [Parameter(Mandatory = $false)][String]$AuthServers = '',
        [Parameter(Mandatory = $false)][String]$allowedAddress = '',
        [Parameter(Mandatory = $false)][String]$allowedMACAddress = '',
        [Parameter(Mandatory = $false)][String]$Hostname = '',
        [Parameter(Mandatory = $false)][String]$CertificateId, #uuid
        [Parameter(Mandatory = $false)][String]$TemplateId       #uuid
    )

    if ($Enabled) { $isEnabled = 1 } else { $isEnabled = 0 }
    if ($ConcurrentLogins) { $isConcurrentLogins = 1 } else { $isConcurrentLogins = 0 }
    if ($TransparentHTTPProxy) { $isTransparentHTTPProxy = 1 } else { $isTransparentHTTPProxy = 0 }
    if ($TransparentHTTPSProxy) { $isTransparentHTTPSProxy = 1 } else { $isTransparentHTTPSProxy = 0 }

    $obj = @{
        zone = @{
            enabled               = $isEnabled;
            interfaces            = $Interface;
            authservers           = $AuthServers;
            authEnforceGroup      = $authEnforceGroup;
            idletimeout           = $IdleTimeout;
            hardtimeout           = $HardTimeout;
            concurrentlogins      = $isConcurrentLogins;
            certificate           = $CertificateId;
            servername            = $Hostname;
            allowedAddresses      = $allowedAddress;
            allowedMACAddresses   = $allowedMACAddress;
            transparentHTTPProxy  = $isTransparentHTTPProxy;
            transparentHTTPSProxy = $isTransparentHTTPSProxy;
            template              = $TemplateId;
            description           = $Description
        }
    };

    return Invoke-OPNsenseCommand captiveportal settings addzone -Json $obj
}


Function Get-OPNsenseCaptivePortalTemplate {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = 'GetTemplate')]
    Param (
        [Parameter(Mandatory = $false)][String]$Name,
        [Parameter(Mandatory = $false)][String]$Uuid,
        [Parameter(Mandatory = $false)][String]$FileId
    )
    $result = Invoke-OPNsenseCommand captiveportal service searchTemplates | Select-Object -ExpandProperty Rows

    if ($Name) {
        $result = $result | where-object { $_.Name -like $Name }
    }
    if ($Uuid) {
        $result = $result | where-object { $_.Uuid -like $Uuid }
    }
    if ($FileId) {
        $result = $result | where-object { $_.FileId -like $FileId }
    }
    Return $result
}

Function New-OPNsenseCaptivePortalTemplate {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $true)][String]$Name,
        [System.IO.FileInfo]$Path
    )
    $Path = Convert-Path $Path
    if (Test-Path -PathType Leaf -Path $Path) {
        $filecontent = [IO.File]::ReadAllBytes($Path)
        $obj = @{'name' = $Name; 'content' = [System.Convert]::ToBase64String($filecontent)}

        return Invoke-OPNsenseCommand captiveportal service saveTemplate -Json $obj
    }
    else {
        Write-Error "Could not load template file $File"
    }
}

Function Save-OPNsenseCaptivePortalTemplate {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $true)][String]$FileId,
        [Parameter(Mandatory = $true)][System.IO.FileInfo]$Path,
        [Parameter(Mandatory = $false)][Switch]$Force       
    )

    if (Test-Path -PathType Leaf -Path $Path) {
        if (-Not [bool]::Parse($Force)) {
            Write-Error "The file $Path already exists."
            return
        }
    }

    try {
        $result = Invoke-OPNsenseCommand captiveportal service getTemplate -Form "fileid=$fileid" -OutFile $path
        return $result
    }
    catch {
        Write-Error "Could not save template file $File"
    }
}

Function Remove-OPNsenseCaptivePortalTemplate {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = 'GetTemplate')]
    Param (
        [Parameter(Mandatory = $false)][String]$Name,
        [Parameter(Mandatory = $false)][String]$Uuid,
        [Parameter(Mandatory = $false)][String]$FileId
    )
    $results = {}
    
    $result = Invoke-OPNsenseCommand captiveportal service searchTemplates | Select-Object -ExpandProperty Rows

    if ($Name) {
        $result = $result | where-object { $_.Name -like $Name }
    }
    if ($Uuid) {
        $result = $result | where-object { $_.Uuid -like $Uuid }
    }
    if ($FileId) {
        $result = $result | where-object { $_.FileId -like $FileId }
    }

    foreach ($templ in $result) {
        Write-Verbose "Deleting Template $($templ.uuid)"
        $result = Invoke-OPNsenseCommand captiveportal service "delTemplate/$($templ.uuid)" -Form delTemplate -AddProperty @{ 'uuid' = $templ.uuid }
        $results += $result
    }

    Return $results
}

Function Get-OPNsenseCaptivePortal {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = 'GetTemplate')]
    Param (
        [Parameter(ParameterSetName = 'ListProviders')][switch]$Provider,

        [Parameter(ParameterSetName = 'GetTemplate')]
        [Parameter(ParameterSetName = 'ListTemplates')][switch]$Template,

        [Parameter(ParameterSetName = 'GetZone')]
        [Parameter(ParameterSetName = 'ListZones')][switch]$Zone,

        [Parameter(Mandatory = $false, ParameterSetName = 'GetTemplate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'GetZone')]
        [string]$Id
    )

    If ([bool]::Parse($Provider)) {
        $arr = Invoke-OPNsenseCommand captiveportal voucher listproviders
        $results = @()
        foreach ($a in $arr) {
            $results += New-Object -TypeName psobject -Property @{ Provider = $a }

        }
        return $results
    }

    If ([bool]::Parse($Template)) {
        $result = Invoke-OPNsenseCommand captiveportal service searchtemplates
        return $($result).rows
    }

    If ([bool]::Parse($Zone)) {
        $result = Invoke-OPNsenseCommand captiveportal settings searchzones
        return $($result).rows
    }
}
