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

function Get-OPNsenseArpScanner {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [String]$Interface
    )
    #    $arpscanner = $(Invoke-OPNsenseCommand arpscanner settings get).arpscanner
    $arpscanner = Invoke-OPNsenseCommand arpscanner service status -Form @{ interface = $Interface }
    foreach ($peer in $arpscanner.peers) {

    }
    Return $arpscanner.general | Add-ObjectDetail -TypeName 'OPNsense.Plugin.ArpScanner.Peer'
}

Function Start-OPNsenseArpScanner {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true)][String]$Interface,
        [parameter(Mandatory = $false)][String]$Network        
    )
    return Invoke-OPNsenseCommand arpscanner service start -Form @{ interface = $Interface; networks = $Network }

}
Function Wait-OPNsenseArpScanner {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true)][String]$Interface,
        [parameter(Mandatory = $false)][String]$Network        
    )
    $status = Invoke-OPNsenseCommand arpscanner service check -Form @{ interface = $Interface }
    While ($status -ne '') {
        Start-Sleep -Seconds 1
        $status = Invoke-OPNsenseCommand arpscanner service check -Form @{ interface = $Interface }
    }
}
Function Stop-OPNsenseArpScanner {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true)][String]$Interface
    )
    return Invoke-OPNsenseCommand arpscanner service stop -Form @{ interface = $Interface }
}
Function Update-OPNsenseArp {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true)][String]$Interface,
        [parameter(Mandatory = $false)][String]$Network        
    )
    try {
        Start-OPNsenseArpScanner @PSBoundParameters   -ErrorAction SilentlyContinue | Out-Null
        Wait-OPNsenseArpScanner  @PSBoundParameters   -ErrorAction SilentlyContinue | Out-Null
        Stop-OPNsenseArpScanner -Interface $Interface -ErrorAction SilentlyContinue | Out-Null

        $result = Invoke-OPNsenseCommand arpscanner service status -Form @{ interface = $Interface }
        $results = @()
        foreach ($peer in $result.peers) {
            $results += New-Object -TypeName psobject -Property @{ 'IP' = $peer[0]; 'MAC' = $peer[1]; 'Vendor' = $peer[2]; 'Interface' = $result.interface; 'Network' = $result.network }
        }
        return $results  | Add-ObjectDetail -TypeName 'OPNsense.Plugin.ArpScanner.Peer'
    } catch [System.SystemException] {
        Throw "Unable to update the ARP table. Make sure the os-arp-scan plugin is installed!"
    } catch {
        Throw 'API returned an UNKNOWN error: ' + $_.Exception.Message
    }
}
