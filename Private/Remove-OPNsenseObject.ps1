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


Function Remove-OPNsenseObject {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]
    Param(
        [parameter(Mandatory = $true, position = 0)][String]$Module,
        [parameter(Mandatory = $true, position = 1)][String]$Controller,
        [parameter(Mandatory = $true, position = 2)][String]$Command,

        [Parameter(Mandatory = $true, position = 3)]
        [AllowEmptyString()][String]$ObjectType,

        [Parameter(Mandatory = $true, position = 4)]
        [AllowEmptyCollection()][String[]]$Uuid
    )
    BEGIN {
        $results = @()
        # Get object list to match uuid to object name
        #Some Plugins implement search commands in singular, default is plural
        switch ($Module) {
            { @("AcmeClient", "Freeradius", "IDS", "Monit", "Postfix", "ProxyUserACL", "Quagga", "Routes", "Siproxd", "Tinc", "Tor", "Zerotier") -Contains $_ } {           
                $metadata = $(Invoke-OPNsenseCommand $Module $Controller $("search{0}" -f $Command.ToLower())).rows
            }
            default {           
                $metadata = $(Invoke-OPNsenseCommand $Module $Controller $("search{0}s" -f $Command.ToLower())).rows
            }
        }
    }
    PROCESS {
        foreach ($id in $Uuid) {
            $item = $metadata | Where-Object { $_.Uuid -eq $id }
            if ($PSCmdlet.ShouldProcess(("{0} {{{1}}}" -f $item.name, $id), "Remove $ObjectType")) {
                $result = Invoke-OPNsenseCommand $Module $Controller $("del{0}/{1}" -f $Command.ToLower(), $id) -Json $ObjectType.ToLower() -AddProperty @{ 'Uuid' = "$id"; 'Name' = "{0}" -f $item.Name }
                #Test-Result $result | Out-Null
                $results += $result
            }    
        }
    }    
    END {
        return $results
    }
}
