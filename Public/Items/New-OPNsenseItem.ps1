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


<#
    Retrieve the data for an object from the OPNsense api.
    The Module/Action/Object define which api to call based on the opnsense.json file.
#>


Function New-OPNsenseItem {
    # .EXTERNALHELP ../../PS_OPNsense.psd1-Help.xml
    [OutputType([Object[]])]
    [CmdletBinding()]
    Param (
        <# Start ParametersetName #>
        [parameter(Mandatory = $true, ParametersetName = 'AcmeClient')]
        [ValidateSet("Account", "Action", "Certificate", "Validation")]
        [String]$AcmeClient,
        [parameter(Mandatory = $true, ParametersetName = 'CaptivePortal')]
        [ValidateSet("Template", "Voucher", "Zone")]
        [String]$CaptivePortal,
        [parameter(Mandatory = $true, ParametersetName = 'Cron')]
        [ValidateSet("Job")]
        [String]$Cron,
        [parameter(Mandatory = $true, ParametersetName = 'FreeRadius')]
        [ValidateSet("Client", "User")]
        [String]$FreeRadius,
        [parameter(Mandatory = $true, ParametersetName = 'FtpProxy')]
        [ValidateSet("Proxy")]
        [String]$FtpProxy,
        [parameter(Mandatory = $true, ParametersetName = 'HAProxy')]
        [ValidateSet("Acl", "Action", "Backend", "ErrorFile", "Frontend", "Healthcheck", "LuaScript", "Server")]
        [String]$HAProxy,
        [parameter(Mandatory = $true, ParametersetName = 'IDS')]
        [ValidateSet("UserRule")]
        [String]$IDS,
        [parameter(Mandatory = $true, ParametersetName = 'Monit')]
        [ValidateSet("Alert", "Service", "Test")]
        [String]$Monit,
        [parameter(Mandatory = $true, ParametersetName = 'Postfix')]
        [ValidateSet("Domain", "Recipient", "Sender")]
        [String]$Postfix,
        [parameter(Mandatory = $true, ParametersetName = 'Proxy')]
        [ValidateSet("RemoteBlacklist")]
        [String]$Proxy,
        [parameter(Mandatory = $true, ParametersetName = 'ProxyUserACl')]
        [ValidateSet("UserACL")]
        [String]$ProxyUserACl,
        [parameter(Mandatory = $true, ParametersetName = 'Quagga')]
        [ValidateSet("BGPAspath", "BGPNeighbor", "BGPPrefixlist", "BGPRoutemap", "Ospf6Interface", "OspfInterface", "OspfNetwork", "OspfPrefixlist")]
        [String]$Quagga,
        [parameter(Mandatory = $true, ParametersetName = 'Relayd')]
        [ValidateSet("Host", "Protocol", "Table", "TableCheck", "VirtualServer")]
        [String]$Relayd,
        [parameter(Mandatory = $true, ParametersetName = 'Routes')]
        [ValidateSet("Route")]
        [String]$Routes,
        [parameter(Mandatory = $true, ParametersetName = 'Siproxd')]
        [ValidateSet("Domain", "User")]
        [String]$Siproxd,
        [parameter(Mandatory = $true, ParametersetName = 'Tinc')]
        [ValidateSet("Host", "Network")]
        [String]$Tinc,
        [parameter(Mandatory = $true, ParametersetName = 'Tor')]
        [ValidateSet("Exitacl", "HiddenService", "HiddenServiceACL", "HiddenServiceAuth", "SocksACL")]
        [String]$Tor,
        [parameter(Mandatory = $true, ParametersetName = 'TrafficShaper')]
        [ValidateSet("Pipe", "Queue", "Rule")]
        [String]$TrafficShaper,
        [parameter(Mandatory = $true, ParametersetName = 'ZeroTier')]
        [ValidateSet("Network")]
        [String]$ZeroTier
        <# End ParametersetName #>
    )

    $Module = $PsCmdlet.ParameterSetName
    $Item = $PsBoundParameters[$Module]

    # Search the Appropriate API Call for this Action
    $call = $OPNsenseOpenApi.$Module.'get'.$Item
    if (!$Call) {
        Write-Error ("{0} {2} does not implement the {1} action. (#17)" -f $Module, 'new', $Item)
        return $null
    }
    return New-Object -TypeName $call.ResponseType
}