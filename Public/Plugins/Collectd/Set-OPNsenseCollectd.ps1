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


Function Set-OPNsenseCollectd {
    # .EXTERNALHELP ../../../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [ValidateSet('network', 'graphite', 'cpu', 'df', 'interface', 'load', 'memory', 'processes', 'uptime', 'users')]
        [parameter(Mandatory = $false)][string[]]$Plugin,
        [parameter(Mandatory = $false)][Switch]$Enabled
    )

    $theObject = Get-OPNsenseCollectd
    $argHash = @{}
    $theObject.psobject.properties | ForEach-Object { $argHash[$_.Name] = $_.Value }

    if ($PSBoundParameters.ContainsKey('Plugin')) {
        foreach ($PluginName in $Plugin) {
            $argHash["p_$($PluginName)_enable"] = $( if ([bool]::Parse($Enabled)) {'1'} else {'0'} )
        }
    }

    return Invoke-OPNsenseCommand collectd general set -Json @{ 'general' = $argHash }
}