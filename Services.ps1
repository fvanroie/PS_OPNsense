function Get-OPNsenseService {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$false,position=1)][String]$Name=''
    )
    switch ($name)
    {
        'proxy'
            {     $result = Invoke-OPNsenseCommand proxy service status
                  $result | Add-Member 'name' $name.tolower()
                  return $result | Select-Object -Property Name,Status
            }
        'ids'
            {     $result = Invoke-OPNsenseCommand ids service status
                  $result | Add-Member 'name' $name.tolower()
                  return $result | Select-Object -Property Name,Status
            }
        'netflow'
            {     $result = Invoke-OPNsenseCommand diagnostics netflow status
                  $result | Add-Member 'name' $name.tolower()
                  return $result | Select-Object -Property Name,Status
            }
        ''
            {
                  $results = @()
                  $result = Invoke-OPNsenseCommand proxy service status
                  $result | Add-Member 'name' 'proxy'
                  $results += $result
                  $result = Invoke-OPNsenseCommand ids service status
                  $result | Add-Member 'name' 'ids'
                  $results += $result
                  $result = Invoke-OPNsenseCommand diagnostics netflow status
                  $result | Add-Member 'name' 'netflow'
                  $results += $result
                  return $results | Select-Object -Property Name,Status
            }
        Default
            {     return }
    }
}

function Update-OPNsenseService {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true,position=1)][String]$Name
    )
    switch ($name)
    {
        'cron'
            {     return Invoke-OPNsenseCommand cron service reconfigure reconfigure }
        'trafficshaper'
            {     return Invoke-OPNsenseCommand trafficshaper service reconfigure reconfigure }
        'netflow'
            {     return Invoke-OPNsenseCommand diagnostics netflow reconfigure reconfigure }
        'captiveportal'
            {     return Invoke-OPNsenseCommand captiveportal service reconfigure reconfigure }
        Default {}
    }
    return $result
}

Function Start-OPNsenseService {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true,position=1)]
        [ValidateSet("ids","proxy")]
        [String]$Name
    )
    switch ($name)
    {
        'ids'
            {     return Invoke-OPNsenseCommand ids service start start   }
        'proxy'
            {     return Invoke-OPNsenseCommand proxy service start start }
        Default {}
    }
    return $result
}

function Restart-OPNsenseService {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true,position=1)]
        [ValidateSet("ids","proxy")]
        [String]$Name
    )
    switch ($name)
    {
        'ids'
            {     return Invoke-OPNsenseCommand ids service restart restart   }
        'proxy'
            {     return Invoke-OPNsenseCommand proxy service restart restart }
        Default {}
    }
    return $result
}

function Stop-OPNsenseService {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true,position=1)]
        [ValidateSet("ids","proxy")]
        [String]$Name
    )
    switch ($name)
    {
        'ids'
              {     return Invoke-OPNsenseCommand ids service stop stop   }
        'proxy'
              {     return Invoke-OPNsenseCommand proxy service stop stop }
        Default {}
    }
    return $result
}
