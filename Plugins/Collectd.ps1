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

function Get-OPNsenseCollectd {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [Switch]$Plugin
    )
    $collectd = $(Invoke-OPNsenseCommand collectd general get).general
    if ([bool]::Parse($Plugin)) {
        $Plugins = Get-Member -InputObject $collectd -MemberType NoteProperty | Where-Object { $_.Name -like 'p_*_enable' } | Select-Object -ExpandProperty Name
        $results = @()
        foreach ($objPlugin in $plugins) {
            $objPlugin -match "p_(.*)_enable" | Out-Null
            $result = New-Object -TypeName PSObject -Property @{ 'Plugin' = $Matches[1] ; 'Enabled' = $collectd.$($objPlugin) }
            $results += $result
        }
        Return $results | Add-ObjectDetail -TypeName 'OPNsense.Service.Collectd.Plugin'
    } else {
        Return $(Invoke-OPNsenseCommand collectd general get).general | Add-ObjectDetail -TypeName 'OPNsense.Service.Collectd.Option'
    }
}

Function Set-OPNsenseCollectd {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
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
