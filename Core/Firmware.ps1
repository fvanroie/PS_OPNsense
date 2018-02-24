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


Function Get-OPNsenseUpdateStatus {
    [CmdletBinding()]
    Param(
        [String]$Message = 'Busy',
        [double]$Seconds = 2
    )
    $start = 0
    Write-Verbose ''
    Write-Verbose 'This can take a while...'
    Write-Verbose ''
    Do {
        Write-Progress -Activity $Message
        Start-Sleep -Seconds $Seconds
        $result = Invoke-OPNsenseCommand core firmware upgradestatus -Verbose:$false

        # Write-Verbose buffer, starting where we left off the previous itteration
        $log = $result.log.substring($start)
        $lines = $log.Split("`n")

        # Write-Verbose buffer, except last line as it can be incomplete
        for ($i = 1; $i -lt $lines.length; $i++) {
            Write-Verbose ('   ' + $lines[$i - 1])
            $start += $lines[$i - 1].length + 1
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
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]
    Param()
    if ($pscmdlet.ShouldProcess($MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'])) {
        $result = Invoke-OPNsenseCommand core firmware upgrade -Form 'upgrade' -Verbose:$VerbosePreference
        if ($result.status -eq 'ok') {
            return Get-OPNsenseUpdateStatus -Message "Updating OPNsense:" -Verbose:$VerbosePreference
        }
        return $result
    }
}


Function Get-OPNsenseUpdate {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [SupportsWildcards()]    
        [Parameter(Mandatory = $false, position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String[]]$Name,
        [String]$Reason
    )
    BEGIN {
        # Get all packages
        $opn = Get-OPNsense
        $updpkgnames = Get-Member -InputObject $opn.all_packages -MemberType NoteProperty | Select-Object -ExpandProperty name
        
        # No Name was passed
        if (-Not $PSBoundParameters.ContainsKey('Name')) { $Name = '*' }

        $allupdates = @()
    }
    PROCESS {
        # Multiple Names can be passed
        foreach ($updname in $updpkgnames) {
            $allupdates += $opn.all_packages.$updname
        }
    }
    END {
        return $allupdates | Add-ObjectDetail -TypeName 'OPNsense.Firmware.Update' | Sort-Object Reason, Name
    }
}

Function Get-OPNsense {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = 'Mirror')]
    Param(
        [Alias("Mirrors")]
        [Parameter(Mandatory = $false, ParameterSetName = 'Mirror')]
        [Switch]$Mirror = $false,

        [Parameter(Mandatory = $true, ParameterSetName = 'Changelog')]
        [Switch]$Changelog = $false,
        [Parameter(Mandatory = $true, ParameterSetName = 'Changelog')]
        [String]$Version        
    )

    if ([bool]::Parse($Mirror)) {
        $allMirrors = @()
        $result = Invoke-OPNsenseCommand core firmware getfirmwareoptions -Verbose:$VerbosePreference
        $result.mirrors | get-member -type NoteProperty | foreach-object {
            $url = $_.Name ;
            $name = $result.mirrors."$($_.Name)";

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
        return $allMirrors | Add-ObjectDetail -TypeName 'OPNsense.Firmware.Mirror'
    }

    if ([bool]::Parse($Changelog)) {
        $result = Invoke-OPNsenseCommand core firmware "changelog/$Version" -Form changelog
        return $result | Add-ObjectDetail -TypeName 'OPNsense.Firmware.Changelog'
    }

    # No Switches
    return Invoke-OPNsenseCommand core firmware status
}


Function Set-OPNsense {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false, ParameterSetName = "FirmwareOptions")]
        [String]$Mirror,
        [parameter(Mandatory = $false, ParameterSetName = "FirmwareOptions")]
        [String]$Flavour,
        [parameter(Mandatory = $false, ParameterSetName = "FirmwareOptions")]
        [String]$Subscription
    )

    $changed = 0
    $FirmwareOptions = Invoke-OPNsenseCommand core firmware getFirmwareConfig -AddProperty @{ Subscription = '' }
    if ($PSBoundParameters.ContainsKey('Mirror')) {
        $changed++
        $FirmwareOptions.Mirror = $Mirror
    }
    if ($PSBoundParameters.ContainsKey('Flavour')) {
        $changed++
        $FirmwareOptions.Flavour = $Flavour
    }
    if ($PSBoundParameters.ContainsKey('Subscription')) {
        $changed++
        $FirmwareOptions.Subscription = $Subscription
    }

    if ($changed -gt 0) {
        Write-Verbose "$changed setting(s) have changed"
        $result = Invoke-OPNsenseCommand core firmware setFirmwareConfig `
            -Json @{ mirror = $FirmwareOptions.Mirror; flavour = $FirmwareOptions.Flavour; subscription = $FirmwareOptions.Subscription }
        if ($Result.status -eq 'ok') {
            return $FirmwareOptions | Add-ObjectDetail -TypeName 'OPNsense.Firmware.Options'
        } else {
            Throw 'Failed to set the firmware options.'
        }
    } else {
        Write-Warning 'No settings have changed, skipping.'
        return $FirmwareOptions | Add-ObjectDetail -TypeName 'OPNsense.Firmware.Options'
    }
}
