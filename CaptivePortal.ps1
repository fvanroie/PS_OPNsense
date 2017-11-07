
Function New-OPNsenseCaptivePortalZone {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true)][String]$Description,
        [Parameter(Mandatory=$true)][String]$Interface='',
        [Parameter(Mandatory=$false)][Boolean]$Enabled=$true,
        [Parameter(Mandatory=$false)][Boolean]$ConcurrentLogins=$true,
        [Parameter(Mandatory=$false)][Boolean]$TransparentHTTPProxy=$false,
        [Parameter(Mandatory=$false)][Boolean]$TransparentHTTPSProxy=$false,
        [Parameter(Mandatory=$false)][int]$IdleTimeout=0,
        [Parameter(Mandatory=$false)][int]$HardTimeout=0,
        [Parameter(Mandatory=$false)][int]$authEnforceGroup=1999,
        [Parameter(Mandatory=$false)][String]$AuthServers='',
        [Parameter(Mandatory=$false)][String]$allowedAddress='',
        [Parameter(Mandatory=$false)][String]$allowedMACAddress='',
        [Parameter(Mandatory=$false)][String]$Hostname='',
        [Parameter(Mandatory=$false)][String]$CertificateId,   #uuid
        [Parameter(Mandatory=$false)][String]$TemplateId       #uuid
    )

    if ($Enabled) { $isEnabled=1 } else { $isEnabled=0 }
    if ($ConcurrentLogins) { $isConcurrentLogins=1 } else { $isConcurrentLogins=0 }
    if ($TransparentHTTPProxy) { $isTransparentHTTPProxy=1 } else { $isTransparentHTTPProxy=0 }
    if ($TransparentHTTPSProxy) { $isTransparentHTTPSProxy=1 } else { $isTransparentHTTPSProxy=0 }

    $obj = @{
        zone = @{
            enabled=$isEnabled;
            interfaces=$Interface;
            authservers=$AuthServers;
            authEnforceGroup=$authEnforceGroup;
            idletimeout=$IdleTimeout;
            hardtimeout=$HardTimeout;
            concurrentlogins=$isConcurrentLogins;
            certificate=$CertificateId;
            servername=$Hostname;
            allowedAddresses=$allowedAddress;
            allowedMACAddresses=$allowedMACAddress;
            transparentHTTPProxy=$isTransparentHTTPProxy;
            transparentHTTPSProxy=$isTransparentHTTPSProxy;
            template=$TemplateId;
            description=$Description
        }
    };

    return Invoke-OPNsenseCommand captiveportal settings addzone -Json $obj
}

Function New-OPNsenseCaptivePortalTemplate {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true)][String]$Name,
        [Parameter(Mandatory=$true)][String]$File
    )
    if (Test-Path -PathType Leaf -Path $File) {
        $filecontent = [IO.File]::ReadAllBytes($File)
        $obj = @{'name'=$Name;'content'=[System.Convert]::ToBase64String($filecontent)};

        return Invoke-OPNsenseCommand captiveportal service saveTemplate -Json $obj
    } else {
        Write-Error "Could not load file $File"
    }
}

Function Get-OPNsenseCaptivePortal {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName='GetTemplate')]
    Param (
        [Parameter(ParameterSetName='ListProviders')][switch]$Provider,

        [Parameter(ParameterSetName='GetTemplate')]
        [Parameter(ParameterSetName='ListTemplates')][switch]$Template,

        [Parameter(ParameterSetName='GetZone')]
        [Parameter(ParameterSetName='ListZones')][switch]$Zone,

        [Parameter(Mandatory=$false,ParameterSetName='GetTemplate')]
        [Parameter(Mandatory=$false,ParameterSetName='GetZone')]
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
