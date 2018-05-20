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
    Retrieve the settings data from the OPNsense api.
    The Module/Command/Object define which api to call based on the settings.json file.
#>


Function Get-OPNsenseSetting {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [OutputType([Object[]])]
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $true, position = 0)]
        [ValidateSet("AcmeClient", "ArpScanner", "C-ICAP", "ClamAV", "Collectd", "FreeRadius", "HAProxy", "HelloWorld", "IDS", "Iperf", "LLDPd", "MDNSrepeater", "Monit", "Netflow", "NodeExporter", "Nut", "OpenConnect", 
            "Postfix", "Proxy", "ProxySSO", "Quagga", "Redis", "Relayd", "Rspamd", "ShadowSocks", "Siproxd", "Telegraf", "Tor", "ZabbixAgent", "ZabbixProxy", "ZeroTier")]
        [String]$Module,
        [parameter(Mandatory = $true, position = 1)]
        [String]$Setting
    )
    BEGIN {
        $Command = "get"
    }
    PROCESS {
        Write-Verbose "Getting settings for $Module $Setting"

        # TODO : Check if the appropriate plugin is installed

        # Get the Invoke Arguments List
        $arglist = $OPNsenseSettingMap.settings.$Module.$Setting.$Command.command
        $returntype = $OPNsenseSettingMap.settings.$Module.$Setting.$Command.returntype

        # Build Invoke Arguments Splat
        $splat = @{};
        if ($arglist) {
            $arglist | Get-Member -MemberType NoteProperty | ForEach-Object { $splat.add($_.name, $arglist.($_.name))}
        } else {
            Throw "Undefined api call for $command $Module $Setting"
        }

        # Invoke splat
        $result = Invoke-OPNsenseCommand @splat

        # TODO : Cast returntype
        #if ($returntype) {
        #    Write-Verbose "Converting object to $returntype"
        #    return ConvertTo-OPNsenseObject -TypeName $returntype -InputObject $result
        #}
        return $result

    }
    END {
    }
}