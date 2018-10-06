
function Test-OPNsenseService {
    # .EXTERNALHELP ../../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $false, position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String[]]$Name
    )
    BEGIN {
        if (-NOT $PSBoundParameters.ContainsKey('name')) {
            $name = Get-Services 'testconfig'
        }
        $results = @()
    }
    PROCESS {
        foreach ($service in $name) {
            try {
                switch ($service) {
                    Default
                    {     $results += Invoke-OPNsenseCommand $service.tolower() service configtest -Json @{} -AddProperty @{ name = $service.tolower()}
                    }
                } # switch
            } catch {
                Write-Error "$service config failed to test"
            }
            #$result

        } #foreach
    } # PROCESS
    END {
        return $results
    }
}
