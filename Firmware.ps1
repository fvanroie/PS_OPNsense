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
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding(
       SupportsShouldProcess=$true,
       ConfirmImpact="High"
    )]
    Param()
    if ($pscmdlet.ShouldProcess($MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'])) {
        return Invoke-OPNsenseCoreCommand core firmware poweroff -Verbose:$VerbosePreference
    }
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

Function Get-UpdateStatus {
    [CmdletBinding()]
    Param(
        [String]$Message
    )
    $start = 0
    Write-Verbose ''
    Write-Verbose 'This can take a while...'
    Write-Verbose ''
    Do {
        Write-Progress -Activity $Message
        Start-Sleep -s 2
        $result = Invoke-OPNsenseCommand core firmware upgradestatus -Verbose:$false

        # Write-Verbose buffer, starting where we left off the previous itteration
        $log = $result.log.substring($start)
        $lines = $log.Split("`n")

        # Write-Verbose buffer, except last line as it can be incomplete
        for ($i = 1; $i -lt $lines.length; $i++) {
          Write-Verbose ('   ' + $lines[$i-1])
            $start += $lines[$i-1].length + 1
        }
    } Until ($result.status -ne 'running')

    # Write-Verbose remaining Buffer
    $log = $result.log.substring($start)
    $lines = $log.Split("`n")

    # Write-Verbose buffer, including last line as it is complete
    for ($i = 0; $i -lt $lines.length; $i++) {
        Write-Verbose ('   ' + $lines[$i])
        $start += $lines[$i].length + 1
    }
    return $Result
}

Function Update-OPNsense {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding(
       SupportsShouldProcess=$true,
       ConfirmImpact="High"
    )]
    Param()
    if ($pscmdlet.ShouldProcess($MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'])) {
        $result = Invoke-OPNsenseCommand core firmware upgrade -Form 'upgrade' -Verbose:$VerbosePreference
        if ($result.status -eq 'ok') {
            return Get-UpdateStatus -Message "Updating OPNsense:" -Verbose:$VerbosePreference
        }
        return $result
    }
}

# Performs pkg audit -F
# FreeBSD registers vulnerabilities for its packages and this command visualizes the security issues found.
Function Invoke-OPNsenseAudit {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param(
        [Switch]$Raw
    )
    $result = Invoke-OPNsenseCommand core firmware audit -Form audit -Verbose:$VerbosePreference

    if ($result.status -eq 'ok') {
        $log = Get-UpdateStatus -Message "Running Audit in OPNsense:" -Verbose:$VerbosePreference
        if ([bool]::Parse($Raw)) { Return $log }

        $AuditPattern = '(.*):\n(.*)\nCVE: (.*)\nWWW: (.*)'
        $cves = Select-String -InputObject $log -Pattern $AuditPattern -AllMatches
        $result = @()
        foreach ($cve in $cves.matches) {
            $argHash = @{
                CVE = $cve.groups[3].value;
                Issue = $cve.groups[1].value;
                Title = $cve.groups[2].value;
                Url = $cve.groups[4].value
            }
            $result += New-Object PSObject -Property $argHash
        }
    } else {
        Write-Error "Failed to audit OPNsense"
    }
    return $result
}

Function Get-OPNsense {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param(
        [Alias("Mirrors")]
        [parameter(Mandatory=$false)]
        [Switch]$Mirror=$false
    )

    if ([bool]::Parse($Mirror)) {
      $allMirrors = @()
      $result = Invoke-OPNsenseCommand core firmware getfirmwareoptions -Verbose:$VerbosePreference
      $result.mirrors | get-member -type NoteProperty | foreach-object {
          $url=$_.Name ;
          $name=$result.mirrors."$($_.Name)";

          if ($name -match "(.*) \((.*)\)") {
              $hosting = $Matches[1]
              $location = $Matches[2]
          } else {
              $hosting = ''
              $location = ''
          }
          $commercial = $Url -in $result.has_subscription

          $thisMirror = New-Object PSObject -Property @{ Url = $url ; Description = $name ; Hosting = $hosting ; Location = $location ; Commercial = $commercial }
          $allMirrors += $thisMirror
      }
      return $allMirrors
    }

    # No Switches
    return Invoke-OPNsenseCommand core firmware status -Verbose:$VerbosePreference
}


Function Set-OPNsense {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param(
      [parameter(Mandatory=$false,ParameterSetName = "FirmwareSettings")]
        [String]$Mirror,
        [parameter(Mandatory=$false,ParameterSetName = "FirmwareSettings")]
        [String]$Flavour,
        [parameter(Mandatory=$false,ParameterSetName = "FirmwareSettings")]
        [String]$Subscription
    )

    $changed = 0
    $FirmwareSettings = Invoke-OPNsenseCommand core firmware getFirmwareConfig -AddProperty @{ Subscription='' }
    if ($PSBoundParameters.ContainsKey('Mirror')) {
        $changed++
        $FirmwareSettings.Mirror = $Mirror
    }
    if ($PSBoundParameters.ContainsKey('Flavour')) {
        $changed++
        $FirmwareSettings.Flavour = $Flavour
    }
    if ($PSBoundParameters.ContainsKey('Subscription')) {
        $changed++
        $FirmwareSettings.Subscription = $Subscription
    }

    if ($changed -gt 0) {
        Write-Verbose "$changed setting(s) have changed"
        $result = Invoke-OPNsenseCommand core firmware setFirmwareConfig `
                          -Json @{ mirror = $FirmwareSettings.Mirror; flavour = $FirmwareSettings.Flavour; subscription = $FirmwareSettings.Subscription }
        if ($Result.status -eq 'ok') {
            return $FirmwareSettings
        } else {
            Throw 'Failed to set FirmwareSettings.'
        }
    } else {
        Write-Warning 'No settings have changed, skipping.'
        return $FirmwareSettings
    }
}
