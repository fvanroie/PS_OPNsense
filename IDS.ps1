function Get-OPNsenseIdsUserRule {
    param (
        [Parameter(ParameterSetName='UUID',Mandatory=$false,position=1)][String]$uuid,
        [Parameter(ParameterSetName='Filter',Mandatory=$false,position=1)][String]$Filter
    )
    if ($uuid) {
        $result = Invoke-OPNsenseCommand ids settings "getuserrule/$uuid"
        if ($result.rule) {
            $result = $result.rule | Add-Member 'uuid' $uuid
        } else {
            return $result
        }

    } else {
        $result = $(Invoke-OPNsenseCommand ids settings searchUserRule -Form @{searchPhrase=$Filter}).rows
    }
    return $result
}

Function New-OPNsenseIdsUserRule {
    param (
        [Parameter(Mandatory=$true)][String]$Description,
        [Parameter(Mandatory=$false)][Boolean]$Enabled=$true,
        [Parameter(Mandatory=$false)][String]$Fingerprint,
        [Parameter(Mandatory=$false)][String]$GeoIP,
        [Parameter(Mandatory=$false)][ValidateSet('Both','Source','Destination')][String]$GeoIPdirection='Both',
        [Parameter(Mandatory=$false)][ValidateSet('Alert','Drop')][String]$Action='Alert'
    )

    switch ($GeoIPDirection) {
        'Source' { $GeoIP_Direction='src' }
        'Destination' { $GeoIP_Direction='dst' }
         Default { $GeoIP_Direction = ''}
    }
    switch ($action) {
        'Alert' { $action='alert' }
         Default { $action = 'drop'}
    }

    $argHash = @{ rule = @{ description=$Description; action=$Action; geoip=$GeoIP; geoip_direction=$GeoIP_Direction; fingerprint=$Fingerprint }  }

    if ($Enabled) {
        $argHash.rule.Add('enabled','1')
    } else {
        $argHash.rule.Add('enabled','0')
    }


    return Invoke-OPNsenseCommand ids settings adduserrule -Json $argHash
}

Function Get-OPNsenseIdsAlert {
    return $(Invoke-OPNsenseCommand ids service queryalerts -Form fileid=none).rows
}
