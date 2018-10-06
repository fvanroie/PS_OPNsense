
Function Start-OPNsenseService {
    # .EXTERNALHELP ../../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $false, position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String[]]$Name
    )
    BEGIN {
        if (-NOT $PSBoundParameters.ContainsKey('name')) {
            $name = Get-Services 'start'
        }
        $results = @()
    }
    PROCESS {
        foreach ($service in $name) {
            try {
                switch ($service) {
                    'netflow'
                    {     $results += Invoke-OPNsenseCommand diagnostics netflow start -AddProperty @{ name = $service.tolower()}
                    }
                    Default
                    {     $results += Invoke-OPNsenseCommand $service.tolower() service start -Json @{} -AddProperty @{ name = $service.tolower()}
                    }
                } # switch
            } catch {
                Write-Error "$service failed to start"
            }
            #$result

        } #foreach
    } # PROCESS
    END {
        return $results
    }
}
