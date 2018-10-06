
function Update-OPNsenseService {
    # .EXTERNALHELP ../../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $false, position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String[]]$Name
    )
    BEGIN {
        if (-NOT $PSBoundParameters.ContainsKey('name')) {
            $name = Get-Services 'status'
        }
        $results = @()
    }
    PROCESS {
        foreach ($service in $name) {
            try {
                switch ($service) {
                    'netflow'
                    {     $results += Invoke-OPNsenseCommand diagnostics netflow reconfigure -AddProperty @{ name = $service.tolower()}
                    }
                    'monit'
                    {     $results += Invoke-OPNsenseCommand $service.tolower() service reload -Json @{} -AddProperty @{ name = $service.tolower()}
                    }
                    Default
                    {     $results += Invoke-OPNsenseCommand $service.tolower() service reconfigure -Json @{} -AddProperty @{ name = $service.tolower()}
                    }
                } # switch
            } catch {
                Write-Error "$service failed to reconfigure"
            }
            #$result

        } #foreach
    } # PROCESS
    END {
        return $results
    }
}
