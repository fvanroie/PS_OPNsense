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
    <#
        .SYNOPSIS

        Retieves the settings for LLDP.
        .DESCRIPTION

        Use the Get-OPNsenseLldp cmdlet to list the options of the the Link Layer Discovery Protocol (LLDP) plugin.
        
        .PARAMETER Neighbor
        If this switch parameter is specified, a list of the neighboring devices is returned.
        Without this switch parameter, the configuration options of the LLDP plugin are shown.

        .EXAMPLE
        Get-OPNsenseLldp
        .EXAMPLE
        Get-OPNsenseLldp -Neighbor
    #>

    [CmdletBinding()]
    param (
        [Switch]$Neighbor
    )
    if ([bool]::Parse($Neighbor)) {
        Return $(Invoke-OPNsenseCommand lldpd service neighbor).response | Add-ObjectDetail -TypeName 'OPNsense.Service.Lldpd.Neighbor'
    } else {
        Return $(Invoke-OPNsenseCommand lldpd general get).general | Add-ObjectDetail -TypeName 'OPNsense.Service.Lldpd.Option'
    }
}

Function Set-OPNsenseLldp {
    <#
        .SYNOPSIS

        Sets the options for LLDP on one or more interfaces.
        .DESCRIPTION

        Use the Set-OPNsenseLldp cmdlet to configure the Link Layer Discovery Protocol (LLDP) on one or more physical interfaces.
        Set the name of the hardware interface instead of the logical OPNsense interface names as the protocol runs on the physical port(s).

        .PARAMETER Enable
        Enable the LLDP plugin.
        .PARAMETER Interface
        The name(s) of the physical interface(s). Multiple names seperated by a comma are allowed and you can use wildcards.
        If the interface is empty, all interfaces are used for LLDP.
        
        Preceed the interface with an exclamation mark (!) to excluded it from LLDP.
        Preceed the interface with a double exclamation mark (!!) to include the interface, even if it maches on exclusion wildcard.
        .EXAMPLE

        Set-OPNsenseLldp -Interface em*,!em0 -Enable -EnableCdp -EnableFdp -EnableEdp -EnableSonmp
        .EXAMPLE
        Set-OPNsenseLldp -Interface em*,!igp*,!!igp1 -Enable -EnableCdp -EnableFdp:$false -EnableEdp -EnableSonmp:$false
    #>
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)][Switch]$Enable,
        [parameter(Mandatory = $false)][Switch]$EnableCdp,
        [parameter(Mandatory = $false)][Switch]$EnableFdp,
        [parameter(Mandatory = $false)][Switch]$EnableEdp,
        [parameter(Mandatory = $false)][Switch]$EnableSonmp,
        [parameter(Mandatory = $false)][String]$Interface
    )

    $args = Invoke-OPNsenseCommand lldpd general get

    if ($PSBoundParameters.ContainsKey('Enable')) {
        $args.general.enabled = ConvertTo-Boolean $Enable
    }
    if ($PSBoundParameters.ContainsKey('EnableCdp')) {
        $args.general.cdp = ConvertTo-Boolean $EnableCdp 
    }
    if ($PSBoundParameters.ContainsKey('EnableEdp')) {
        $args.general.edp = ConvertTo-Boolean $EnableEdp
    }
    if ($PSBoundParameters.ContainsKey('EnableFdp')) {
        $args.general.fdp = ConvertTo-Boolean $EnableFdp
    }
    if ($PSBoundParameters.ContainsKey('EnableSonmp')) {
        $args.general.sonmp = ConvertTo-Boolean $EnableSonmp
    }
    if ($PSBoundParameters.ContainsKey('Interface')) {
        $args.general.interface = $Interface
    }

    $result = Invoke-OPNsenseCommand lldpd general set -Json $args
    Update-OPNsenseService lldpd | Out-Null

    if (Test-OPNsenseApiResult $result) {
        Get-OPNsenseLldp
    } else {
        Write-Error $result
    }
}
