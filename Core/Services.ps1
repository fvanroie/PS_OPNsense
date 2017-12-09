<#  MIT License

    Copyright (c) 2017 fvanroie

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

function Get-OPNsenseService {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
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
                Write-Error "$service failed to report status"
            }
            #$result
        } #foreach
    } # PROCESS
    END {
        return $results | Add-ObjectDetail -TypeName 'OPNsense.Service'
    }
}

function Update-OPNsenseService {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
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

Function Start-OPNsenseService {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
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

function Restart-OPNsenseService {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $false, position = 1, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String[]]$Name
    )
    BEGIN {
        if (-NOT $PSBoundParameters.ContainsKey('name')) {
            $name = Get-Services 'restart'
        }
        $results = @()
    }
    PROCESS {
        foreach ($service in $name) {
            try {
                switch ($service) {
                    'netflow'
                    {     $results += Invoke-OPNsenseCommand diagnostics netflow restart -AddProperty @{ name = $service.tolower()}
                    }
                    Default
                    {     $results += Invoke-OPNsenseCommand $service.tolower() service restart -Json @{} -AddProperty @{ name = $service.tolower()}
                    }
                } # switch
            } catch {
                Write-Error "$service failed to restart"
            }
            #$result

        } #foreach
    } # PROCESS
    END {
        return $results
    }
}

function Stop-OPNsenseService {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
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
        [Parameter(Mandatory = $true, position = 1, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false)]
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

Function Get-Services {
    param (
        [Parameter(Mandatory = $true, position = 1)][String]$Action
    )
    switch ($action) {
        'status' {
            Return @(
                'acmeclient',
                'collectd',
                'clamav',
                'freeradius',
                'haproxy',
                'ids',
                'monit',
                #'postfix',
                'proxy',
                'quagga',
                'siproxd',
                'telegraf',
                #'tinc',
                #'tor',
                'zabbixagent'
                #'zabbixproxy',
                #'zerotier'
            )
        }
        'reconfigure' {
            Return @(status
                'acmeclient',
                'cicap',
                'clamav',
                'collectd',
                'cron',
                'freeradius',
                'haproxy',
                'ids',
                'postfix',
                'proxy',
                'quagga',
                'siproxd',
                'telegraf',
                'tor',
                'trafficshaper',
                'zabbixagent',
                'zabbixproxy'
            )
        }
        'start' {
            Return @(
                'acmeclient',
                'arpscanner',
                'clamav',
                'collectd',
                'diagnostics',
                'freeradius',
                'ftpproxy',
                'haproxy',
                'mdnsrepeater',
                'monit',
                'proxy',
                'quagga',
                'rspamd',
                'siproxd',
                'telegraf',
                'tinc',
                'tor',
                'zabbixagent',
                'zabbixproxy'
            )
        }
        'restart' {
            Return @(
                'acmeclient',
                'arpscanner',
                'clamav',
                'collectd',
                'ftpproxy',
                'helloworld',
                'ids',
                'mdnsrepeater',
                'monit',
                'postfix',
                'proxy',
                'quagga',
                'rspamd',
                'siproxd',
                'telegraf',
                'tinc',
                'zabbixagent'
            )
        }
        'stop' {
            Return @(
                'acmeclient',
                'arpscanner',
                'captiveportal',
                'clamav',
                'collectd',
                'freeradius',
                'ftpproxy',
                'haproxy',
                'ids',
                'mdnsrepeater',
                'monit',
                'proxy',
                'quagga',
                'rspamd',
                'siproxd',
                'telegraf',
                'tinc',
                'tor',
                'zabbixagent',
                'zabbixproxy'
            )
        }
    }
}
