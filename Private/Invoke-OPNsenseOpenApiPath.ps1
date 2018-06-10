<#  MIT License

    Copyright (c) 2018 fvanroie, NetwiZe.be

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

# Invoke an API call based on the OpenAPI specification file
Function Invoke-OPNsenseOpenApiPath {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $true, position = 0)]
        [ValidateSet("AcmeClient", "ArpScanner", "C-ICAP", "CaptivePortal", "ClamAV", "Collectd", "Cron", "FreeRadius", "FtpProxy", "HAProxy", "HelloWorld",
            "IDS", "Iperf", "LLDPd", "MDNSrepeater", "Monit", "Netflow", "NodeExporter", "Nut", "OpenConnect", "Postfix", "Proxy", "ProxySSO", "ProxyUserACl",
            "Quagga", "Redis", "Relayd", "Routes", "Rspamd", "ShadowSocks", "Siproxd", "Telegraf", "Tinc", "Tor", "TrafficShaper",
            "ZabbixAgent", "ZabbixProxy", "ZeroTier")]
        [String]$Module,

        [parameter(Mandatory = $true, position = 1)]
        [ValidateSet("Get", "Set", "Search", "Toggle", "Add", "Delete",
            "Status", "Start", "Restart", "Stop", "Reconfigure", "Test")]
        [String]$Action,

        [parameter(Mandatory = $true, position = 2)][String]$Object,

        [parameter(Mandatory = $false, ParameterSetName = "Json")]   
        $Body,

        #        [parameter(Mandatory = $false)][HashTable]$AddProperty,
        [parameter(Mandatory = $false)][String]$Uuid,
        [parameter(Mandatory = $false)][String]$Filter,
        [parameter(Mandatory = $false)][Switch]$Enabled
    )

    # Search the Appropriate API Call for this Action
    $call = $OPNsenseOpenApi.$Module.$Action.$Object
    if (!$Call) {
        Write-Error ("{0} {2} does not implement the {1} action. (#17)" -f $Module, $Action, $Object)
        return $null
    }

    $null, $Module, $Controller, $CmdParams = $Call.Path.Split('/', 4)
   
    # Replace Path parameters with values
    foreach ($parameter in $call.parameters) {
        if ($parameter.Value.in -eq 'Path') {
            $key = '{{{0}}}' -f $parameter.Value.Name
            switch ($key) {
                '{uuid}' { $value = $uuid }
                '{enabled}' { $value = If ($PSBoundParameters.ContainsKey('Enabled')) { ConvertTo-Boolean $Enabled } else { '' } }
                '{disabled}' { $value = If ($PSBoundParameters.ContainsKey('Enabled')) { ConvertTo-Boolean (-Not $Enabled) } else { '' } }
                default { $value = '' }
            }
            $CmdParams = $CmdParams.replace($key, $value)
        }
    }

    # Build Parameters Splat
    $Splat = @{
        'Module'     = $Module
        'Controller' = $Controller
        'Command'    = $CmdParams
        'Method'     = $Call.Method
        'Verbose'    = $VerbosePreference
        'Debug'      = $DebugPreference
        'Property'   = $call.LevelsOut
    }

    if ($Action -eq 'search') {
        $splat.Property = 'rows'
        if ($Filter) {
            $splat.Form = @{ 'searchPhrase' = $Filter}
        }
    }

    if ($Body) {
        $Splat.Add('Json', $Body)
    }
    # Add UUID, except for OPNsense.CaptivePortal.Template already as it already has a UUID
    if ($Action -eq 'get' -and $returntype -ne 'OPNsense.CaptivePortal.Template') {
        $splat.Add("AddProperty", @{ 'uuid' = $Uuid} )
    }
  
    # Run this command thru the Api
    $result = Invoke-OPNsenseCommand @Splat   

    # for OPNsense.CaptivePortal.Template all Templates are returned, select the one with the correct UUID
    if ($Action -eq 'get' -and $returntype -eq 'OPNsense.CaptivePortal.Template') {
        $result = $result | Where-Object { $_.UUID -eq $Uuid }
    }

    # Can we cast this into our own object?
    if ($call.ResponseType) {
        Write-Verbose ("Converting object to {0}" -f $call.ResponseType)
        return ConvertTo-OPNsenseObject -TypeName $call.ResponseType -InputObject $result
    }

    # Return PSCustomObject instead
    return $result
}