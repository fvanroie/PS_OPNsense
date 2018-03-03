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

function Get-OPNsenseIdsUserRule {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(ParameterSetName = 'UUID', Mandatory = $false, position = 1)][String]$uuid,
        [Parameter(ParameterSetName = 'Filter', Mandatory = $false, position = 1)][String]$Filter
    )
    if ($uuid) {
        $result = Invoke-OPNsenseCommand ids settings "getuserrule/$uuid"
        if ($result.rule) {
            $result = $result.rule | Add-Member 'uuid' $uuid
        } else {
            return $result
        }

    } else {
        $result = $(Invoke-OPNsenseCommand ids settings searchUserRule -Form @{searchPhrase = $Filter}).rows
    }
    return $result
}

Function New-OPNsenseIdsUserRule {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $true)][String]$Description,
        [Parameter(Mandatory = $false)][Boolean]$Enabled = $true,
        [Parameter(Mandatory = $false)][String]$Fingerprint,
        [Parameter(Mandatory = $false)][String]$GeoIP,
        [Parameter(Mandatory = $false)][ValidateSet('Both', 'Source', 'Destination')][String]$GeoIPdirection = 'Both',
        [Parameter(Mandatory = $false)][ValidateSet('Alert', 'Drop')][String]$Action = 'Alert'
    )

    switch ($GeoIPDirection) {
        'Source' { $GeoIP_Direction = 'src' }
        'Destination' { $GeoIP_Direction = 'dst' }
        Default { $GeoIP_Direction = ''}
    }
    switch ($action) {
        'Alert' { $action = 'alert' }
        Default { $action = 'drop'}
    }

    $argHash = @{ rule = @{ description = $Description; action = $Action; geoip = $GeoIP; geoip_direction = $GeoIP_Direction; fingerprint = $Fingerprint }  }

    if ($Enabled) {
        $argHash.rule.Add('enabled', '1')
    } else {
        $argHash.rule.Add('enabled', '0')
    }


    return Invoke-OPNsenseCommand ids settings adduserrule -Json $argHash
}

Function Get-OPNsenseIdsAlert {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    return $(Invoke-OPNsenseCommand ids service queryalerts -Form fileid=none).rows
}

Function Update-OPNsenseIdsRule {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml

}
