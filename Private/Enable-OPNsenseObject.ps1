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


Function Enable-OPNsenseObject {
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
        [AllowEmptyString()]
        [String]$ObjectType,

        [Parameter(Mandatory = $true, position = 4)]
        [AllowEmptyCollection()]
        [String[]]$Uuid,

        [Parameter(Mandatory = $true, position = 5)]
        [Boolean]$Enable
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

        if ($Enable -eq $true) {
            $Toggle = 'Enable'
            $newStatus = '1'
        } else {
            $Toggle = 'Disable'
            $newStatus = '0'
        }

    }
    PROCESS {
        foreach ($id in $Uuid) {
            $item = $metadata | Where-Object { $_.Uuid -eq $id }
            if (-not $item) {
                Write-Warning ('{2} "{{{0}}}" can not be {1}d because it cannot be found.' -f $id, $Toggle.ToLower(), $ObjectType)
            }

            # Get the current state of the object
            if ($item.enabled) {
                $currentStatus = $item.enabled
            } elseif ($item.disabled) {
                $currentStatus = 1 - $item.disabled
            } else {
                $currentStatus = $null  # Unknown
            }

            # Is Change needed?
            if ($newStatus -ne $CurrentStatus) {
                # Request confirmation if needed
                if ($PSCmdlet.ShouldProcess(("{0} {{{1}}}" -f $item.name, $id), "$Toggle $ObjectType")) {
                    $result = Invoke-OPNsenseCommand $Module $Controller $("toggle{0}/{1}/{2}" -f $Command.ToLower(), $id, $newStatus) -Form $Command.ToLower() -AddProperty @{ 'Uuid' = "$id"; 'Name' = "{0}" -f $item.Name }
                    #Test-Result $result | Out-Null
                    $results += $result
                }    
            } else {
                # Already in the Requested State
                Write-Verbose ('{3} "{0} {{{1}}}" is already {2}d.' -f $item.name, $id, $Toggle.ToLower(), $ObjectType)
            }

        }
    }    
    END {
        return $results
    }
}
