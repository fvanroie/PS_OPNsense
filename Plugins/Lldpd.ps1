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

function Get-OPNsenseLldp {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [Switch]$Neighbor
    )
    if ([bool]::Parse($Neighbor)) {
        Return $(Invoke-OPNsenseCommand lldpd service neighbor).response #| Add-ObjectDetail -TypeName 'OPNsense.Service.Lldpd.Neighbor'
    } else {
        Return $(Invoke-OPNsenseCommand lldpd general get).general | Add-ObjectDetail -TypeName 'OPNsense.Service.Lldpd.Option'
    }
}

Function Set-OPNsenseLldp {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)][Switch]$Enable,
        [parameter(Mandatory = $false)][Switch]$EnableCdp,
        [parameter(Mandatory = $false)][Switch]$EnableFdp,
        [parameter(Mandatory = $false)][Switch]$EnableEdp,
        [parameter(Mandatory = $false)][Switch]$EnableSonmp
    )

    $args = Invoke-OPNsenseCommand lldpd general get

    if ($PSBoundParameters.ContainsKey('Enable')) {
        $args.general.enabled = $( if ([bool]::Parse($Enable)) {'1'} else {'0'} ) 
    }
    if ($PSBoundParameters.ContainsKey('EnableCdp')) {
        $args.general.cdp = $( if ([bool]::Parse($EnableCdp)) {'1'} else {'0'} ) 
    }
    if ($PSBoundParameters.ContainsKey('EnableEdp')) {
        $args.general.edp = $( if ([bool]::Parse($EnableEdp)) {'1'} else {'0'} ) 
    }
    if ($PSBoundParameters.ContainsKey('EnableFdp')) {
        $args.general.fdp = $( if ([bool]::Parse($EnableFdp)) {'1'} else {'0'} )
    }
    if ($PSBoundParameters.ContainsKey('EnableSonmp')) {
        $args.general.sonmp = $( if ([bool]::Parse($EnableSonmp)) {'1'} else {'0'} )
    }

    $result = Invoke-OPNsenseCommand lldpd general set -Json $args
    Update-OPNsenseService lldpd | Out-Null

    return $result
}
