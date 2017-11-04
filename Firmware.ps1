Function Invoke-OPNsenseCoreCommand {
    [CmdletBinding()]
    Param (
      [Parameter(Mandatory=$true,position=1)][String]$Module,
      [parameter(Mandatory=$true,position=2)][String]$Controller,
      [parameter(Mandatory=$true,position=3)][String]$Command
    )
    $result = Invoke-OPNsenseCommand $Module $Controller $Command -Form $Command -Verbose:$VerbosePreference
    if ($result.status -eq "failure") {
        Write-Error "Failed to execute $Module/$Controller/$Command command"
        return $false
    }
    if ($result.status -eq "ok") {
        return $true
    }
    return $result
}

Function Stop-OPNsense {
    [CmdletBinding()]
    Param()
    return Invoke-OPNsenseCoreCommand core firmware poweroff -Verbose:$VerbosePreference
}

Function Restart-OPNsense {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding(
       SupportsShouldProcess=$true,
       ConfirmImpact="High"
    )]
    Param()
    if ($pscmdlet.ShouldProcess($MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'])) {
        return Invoke-OPNsenseCoreCommand core firmware reboot -Verbose:$VerbosePreference
    }  else  {
        return $false
    }
}

Function Update-OPNsense {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param()
    return Invoke-OPNsenseCoreCommand core firmware upgrade -Verbose:$VerbosePreference
}

# pkg audit -F
# FreeBSD registers vulnerabilities for its packages and we though that made a
# nice addition to a security project to create visibility and awareness.
Function Invoke-OPNsenseAudit {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param()
    return Invoke-OPNsenseCoreCommand core firmware audit -Verbose:$VerbosePreference
}

Function Get-OPNsense {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param()
    return Invoke-OPNsenseCoreCommand core firmware status -Verbose:$VerbosePreference
}
