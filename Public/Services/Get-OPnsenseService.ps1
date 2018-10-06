
function Get-OPNsenseService {
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
                    'mdnsrepeater'
                    {   $result = Invoke-OPNsenseCommand mdnsrepeater service status -AddProperty @{ name = $service.tolower()}
                        $result = New-Object -TypeName psobject -AddProperty @{'status' = $result.result; 'name' = $service.tolower() }
                        $results += $result
                    }
                    'netflow'
                    {     $results += Invoke-OPNsenseCommand diagnostics netflow status -AddProperty @{ name = $service.tolower()}
                        #$result | Add-Member 'name' $service.tolower()
                        #$results += $result
                    }
                    'zerotier'
                    {     $results += Invoke-OPNsenseCommand $service.tolower() settings status -AddProperty @{ name = $service.tolower()}
                    }
                    Default
                    {     $results += Invoke-OPNsenseCommand $service.tolower() service status -AddProperty @{ name = $service.tolower()}
                        #$result | Add-Member 'name' $service.tolower()
                        #$results += $result
                        # return $result | Select-Object -Property Name,Status
                    }
                } # switch
            } catch {
                Write-Warning "$service failed to report its status."
                Write-Verbose ($_.Exception.Message)
                $result = New-Object -TypeName psobject -Property @{'status' = 'not installed'; 'name' = $service.tolower() }
                $results += $result
            }
            #$result
        } #foreach
    } # PROCESS
    END {
        return $results | Add-ObjectDetail -TypeName 'OPNsense.Service'
    }
}
