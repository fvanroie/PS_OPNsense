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

Function Convert-UnixSecondstoLocal {
    param(
        [parameter(Mandatory = $true)][decimal] $unixSeconds
    )
    return [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($unixSeconds))

    #$origin = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
    #return $origin.AddSeconds($unixSeconds).toLocalTime()
}

Function Convert-DateTimetoUnix {
    param (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$dt
    )
    $origin = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
    [Math]::Round($($dt - $origin).TotalSeconds)
}

Function Format-SystemHealthData {
    Param (
        [ValidateNotNullOrEmpty()]
        $data
    )
    $rawdata = $data | Select-Object -ExpandProperty d3 | Select-Object -ExpandProperty data
    $table = @()
    $rows = $rawdata[0].values.Count
    for ($i = 0; $i -lt $rows; $i++) {
        $unixdt = Convert-UnixSecondstoLocal ($rawdata.values[$i][0] / 1000)
        $row = New-Object PSObject -Property @{ timestamp = $Unixdt }
        foreach ($column in $rawdata) {
            $row | Add-Member -NotePropertyName $column.key -NotePropertyValue $column.values[$i][1]
        }
        $table += $row
    }

    return $table
}

Function ValidateSystemHealthOptions {
    Param (
        [ValidateSet("packets", "system", "traffic")]
        [String]$type,
        [String]$data,
        [String]$collection
    )

    $result = Invoke-OPNsenseCommand diagnostics systemhealth getRRDlist
    switch ($type) {
        'packets' { $options = $result.data.packets }
        'system' { $options = $result.data.system }
        'traffic' { $options = $result.data.traffic }
        default { Throw "Invalid SystemHealthOptions type: $type" }
    }
    if ($options -NotContains $data) {
        $choices = $options | ConvertTo-Json -compress
        Throw """$data"" is not a valid $type $collection option. ""$data"" needs to be in $choices"
    }
}

Function Get-OPNsenseSystemHealth {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, ParameterSetName = "Packets")]
        [ValidateNotNullOrEmpty()]
        [Switch]$Packets,

        [parameter(Mandatory = $true, ParameterSetName = "Traffic")]
        [ValidateNotNullOrEmpty()]
        [Switch]$Traffic,

        [parameter(Mandatory = $true, ParameterSetName = "Packets")]
        [parameter(Mandatory = $true, ParameterSetName = "Traffic")]
        [ValidateNotNullOrEmpty()]
        [String]$Interface,

        [parameter(Mandatory = $true, ParameterSetName = "System")]
        [ValidateNotNullOrEmpty()]
        [Switch]$System,

        [parameter(Mandatory = $true, ParameterSetName = "System")]
        [ValidateNotNullOrEmpty()]
        [String]$Resource,

        [DateTime]$From,
        [DateTime]$To,

        [ValidateSet("Standard", "Medium", "High")]
        [String]$Resolution,

        [ValidateSet("20 Hours", "60 Hours", "9 Days", "10 Days")]
        [String]$Zoomlevel,

        [Switch]$Inverse = $false
    )

    if ([bool]::Parse($Packets)) {
        $type = 'packets'
        $data = $Interface.ToLower()
        ValidateSystemHealthOptions $type $data interface
    }

    if ([bool]::Parse($Traffic)) {
        $type = 'traffic'
        $data = $Interface.ToLower()
        ValidateSystemHealthOptions $type $data interface
    }

    if ([bool]::Parse($System)) {
        $type = 'system'
        $data = $Resource.ToLower()
        ValidateSystemHealthOptions $type $data resource
    }
    Write-Verbose "DataType: $data-$type"

    if ([bool]($MyInvocation.BoundParameters.Keys -match 'From')) {
        $start = Convert-DateTimetoUnix $From
    } else {
        $start = 0
    }
    if ([bool]($MyInvocation.BoundParameters.Keys -match 'To')) {
        $end = Convert-DateTimetoUnix $To
    } else {
        $end = 0
    }
    Write-Verbose "From: $start"
    Write-Verbose "To: $end"

    switch ($Resolution) {
        'Medium' { $res = 240 }
        'High' { $res = 600 }
        default { $res = 120 }
    }
    Write-Verbose "Resolution: $res"
    switch ($ZoomLevel) {
        '60 Hours' { $zoom = 1 }
        '9 Days' { $zoom = 2 }
        '10 Days' { $zoom = 3 }
        default { $zoom = 0 }
    }
    Write-Verbose "ZoomLevel: $zoom"
    $inv = if ([boolean]::Parse($Inverse)) { 'true' } else { 'false' }
    Write-Verbose "Inverse: $inv"

    $result = Invoke-OPNsenseCommand diagnostics systemhealth "getsystemhealth/$data-$type/$start/$end/$res/$inv/$zoom" -Verbose:$VerbosePreference

    if ($result.title -eq 'error') {
        Write-Error "Could not get the system health for $type"
        Return
    }

    return Format-SystemHealthData $result
}

Function Get-OPNsenseInterface {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param()
    $result = $(Invoke-OPNsenseCommand diagnostics systemhealth getRRDlist).data.traffic |
        Select-Object -Property @{"N" = "Interface"; "E" = {$_}}
    return $result
}

Function Get-OPNsenseResource {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param()
    $result = $(Invoke-OPNsenseCommand diagnostics systemhealth getRRDlist).data.system |
        Select-Object -Property @{"N" = "Resource"; "E" = {$_}}
    return $result
}

Function Get-OPNsenseRoute {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
    )
    $result = Invoke-OPNsenseCommand diagnostics interface getroutes
    return $result
}

Function Get-OPNsenseARP {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
    )
    $result = Invoke-OPNsenseCommand diagnostics interface getarp
    return $result  | Add-ObjectDetail -TypeName 'OPNsense.Diagnostics.Interface.Arp' | Sort-Object -Property Interface, { [System.Version]$_.IP } 
}

Function Clear-OPNsenseARP {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]
    Param (
    )
    if ($pscmdlet.ShouldProcess($MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'])) {
        $result = Invoke-OPNsenseCommand diagnostics interface flusharp -Form flusharp
        return $result.Split("`n") | Where-Object { $_ -ne '' }
    }
}
