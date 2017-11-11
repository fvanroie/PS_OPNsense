Function Get-OPNsenseCronJob {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
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
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
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
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
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
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true,position=1)][String]$uuid
    )
    return Set-OPNsenseCronJob -uuid $uuid 1
}

Function Disable-OPNsenseCronJob {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true,position=1)][String]$uuid
    )
    return Set-OPNsenseCronJob -uuid $uuid 0
}