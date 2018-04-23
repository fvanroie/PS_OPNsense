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
    The Module/Command/Object define which api to call based on the functionmap.json file.
#>


Function Get-OPNsenseObject {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [OutputType([Object[]])]
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $true, position = 0)][String]$Module,
        [parameter(Mandatory = $true, position = 1)][String]$Object,
        [parameter(Mandatory = $false)][String[]]$Uuid,
        [parameter(Mandatory = $false)][Boolean]$Enable
    )
    BEGIN {
        $uuids = @()
    }
    PROCESS {
        if (-Not $UUID) {
            Write-Verbose "Gathering all the UUIDs..."
            $uuids += $(Invoke-OPNsenseFunction $Module search $Object).UUID
        } else {
            $uuids += $UUID
        }
    }
    END {
        foreach ($id in $uuids) {
            Write-Verbose ""
            Write-Verbose ("Retrieving Object {0}" -f $id)
            Invoke-OPNsenseFunction $Module get $Object -Uuid $id
        }
    }
}

<#
function Get-OPNsenseObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [ValidateSet('AcmeClient', 'ARPscanner', 'CaptivePortal', 'CICAP', 'ClamAV', 'Collectd', 'Core', 'Cron', 'Diagnostics', 'Freeradius', 'HAProxy', 'HelloWorld',
            'IDS', 'iperf', 'Lldpd', 'MDNSRepeater', 'Monit', 'Nut', 'Postfix', 'Proxy', 'ProxySSO', 'ProxyUserACL', 'Quagga', 'Relayd', 'Routes', 'Siproxd',
            'Telegraf', 'Tinc', 'Tor', 'TrafficShaper', 'Unbound', 'Wol', 'ZabbixAgent', 'Zabbixproxy', 'Zerotier'
        )]
        [String]$Module,

        [Parameter(Mandatory = $true, position = 1)]
        [ValidateSet('Access', 'Accounts', 'Actions', 'Activity', 'Bgp', 'Certificates', 'Client', 'Diagnostics', 'Dns', 'Domain', 'Eap', 'Exitacl', 'Firewall', 'Firmware',
            'General', 'Hiddenservice', 'Hiddenserviceacl', 'Input', 'Instance', 'Interface', 'Menu', 'Netflow', 'Network', 'Networkinsight', 'Ospf6settings', 'Ospfsettings', 'Output',
            'Recipient', 'Routes', 'Sender', 'Service', 'Session', 'Settings', 'Socksacl', 'Statistics', 'Status', 'Systemhealth', 'User', 'Validations', 'Voucher', 'Wol'
        )]
        [String]$Controller,

        [Parameter(Mandatory = $true, position = 2)]
        [String]$Command,

        [Parameter(Mandatory = $false)]
        [String[]]$Property
    )
    
    # Get Parent object
    $result = Invoke-OPNsenseCommand $Module.ToLower() $Controller.ToLower() $Command.ToLower()

    # Drill down to the requested property level
    foreach ($prop in $Property) {
        if ($prop -in (Get-NoteProperty $result)) {
            $result = Select-Object -InputObject $result -ExpandProperty $prop       
        } else {
            Throw "$prop is an invalid property for object $Module/$Controller/$Command"
        }
    }

    # Convert $result into Object

    return $result
#>