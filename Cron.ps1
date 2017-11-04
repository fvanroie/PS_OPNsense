Function Get-OPNsenseCronJob {
  <#
    .SYNOPSIS

    Executes an OPNsense command against the REST api of a connected server.

    .DESCRIPTION

    The Out-OpnSenseXMLConfig function writes an an OPNsense configuration
    file to disk.

    .EXAMPLE
    Invoke-OPNsenseCommand core firmware info
    .EXAMPLE
    Invoke-OPNsenseCommand ids settings test -Json @{ key1 = value1; key2 = value2 }
  #>
    param (
        [Parameter(Mandatory=$false,position=1)][String]$uuid
    )
    if ($uuid) {
        $result = Invoke-OPNsenseCommand cron settings "getjob/$uuid"
        if ($result.job) {
            $result = $result.job | Add-Member 'uuid' $uuid
        } else {
            return $result
        }

    } else {
        $result = $(Invoke-OPNsenseCommand cron settings searchjobs).rows
    }
    return $result
}

# Private, unapproved Verb
Function Toggle-OPNsenseCronJob {
    param (
        [Parameter(Mandatory=$true,position=1)][String]$uuid
    )
    $result = Invoke-OPNsenseCommand cron settings "togglejob/$uuid" toggle
    return $result
}

Function New-OPNsenseCronJob {
    param (
        [Parameter(Mandatory=$true,position=1)][String]$uuid,
        [Parameter(Mandatory=$true,position=2)][int]$enabled
    )

    $job = Get-OPNsenseCronJob -Id $uuid
    if ($job.enabled -ne $enabled) {
        $result = Toggle-OPNsenseCronJob -id $uuid
    }
    return Get-OPNsenseCronJob -uuid $uuid
}

Function Set-OPNsenseCronJob {
    param (
        [Parameter(Mandatory=$true,position=1)][String]$uuid,
        [Parameter(Mandatory=$true,position=2)][int]$enabled
    )

    $job = Get-OPNsenseCronJob -uuid $uuid
    if ($job.enabled -ne $enabled) {
        $result = Toggle-OPNsenseCronJob -uuid $uuid
    }
    return Get-OPNsenseCronJob -uuid $uuid
}

Function Enable-OPNsenseCronJob {
    param (
        [Parameter(Mandatory=$true,position=1)][String]$uuid
    )
    return Set-OPNsenseCronJob -uuid $uuid 1
}

Function Disable-OPNsenseCronJob {
    param (
        [Parameter(Mandatory=$true,position=1)][String]$uuid
    )
    return Set-OPNsenseCronJob -uuid $uuid 0
}
