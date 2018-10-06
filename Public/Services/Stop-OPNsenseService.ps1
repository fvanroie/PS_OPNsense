
function Stop-OPNsenseService {
    # .EXTERNALHELP ../../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $false, position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String[]]$Name
    )
    BEGIN {
        if (-NOT $PSBoundParameters.ContainsKey('name')) {
            $name = Get-Services 'stop'
        }
        $results = @()
    }
    PROCESS {
        foreach ($service in $name) {
            try {
                switch ($service) {
                    'netflow'
                    {     $results += Invoke-OPNsenseCommand diagnostics netflow stop -AddProperty @{ name = $service.tolower()}
                    }
                    Default
                    {     $results += Invoke-OPNsenseCommand $service.tolower() service stop -Json @{} -AddProperty @{ name = $service.tolower()}
                    }
                } # switch
            } catch {
                Write-Error "$service failed to stop"
            }
            #$result

        } #foreach
    } # PROCESS
    END {
        return $results
    }
}

function Invoke-OPNsenseService {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false)]
        [Switch]$FreshClam
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        if ([bool]::Parse($FreshClam)) {
            $result = Invoke-OPNsenseCommand clamav service freshclam -AddProperty @{ name = 'clamav' }
            $results += $result
        }
    } # PROCESS
    END {
        return $results
    }
}
