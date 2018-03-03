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

Function New-OPNsenseProxyRemoteBlacklist {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Filename,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Url,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Description,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('True', 'False', '0', '1', $true, $false)]
        $Enabled,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Username,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Password,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Filter,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('True', 'False', '0', '1', $true, $false)]
        $SslNoVerify
    )
    BEGIN {
        $blacklists = $()
    }
    PROCESS {
        $blacklist = @{ filename = $Filename ; url = $Url ; description = $Description; enabled = '0' ;
            username = $Username ; password = $Password ; SslNoVerify = '0'
        }

        if ([System.Convert]::ToBoolean($Enabled)) {
            $blacklist['enabled'] = '1'
        }
        if ([System.Convert]::ToBoolean($SslNoVerify)) {
            $blacklist['SslNoVerify'] = '1'
        }
        $result = Invoke-OPNsenseCommand proxy settings addremoteblacklist -Json @{ 'blacklist' = $blacklist }
        $blacklists += $result
    }
    END {
        return $blacklists | Add-ObjectDetail -TypeName 'OPNsense.Proxy.RemoteBlacklist'
    }
}

Function Get-OPNsenseProxyRemoteBlacklist {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [SupportsWildcards()]    
        [Parameter(Mandatory = $false, position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String[]]$Uuid
    )
    BEGIN {
        $blacklists = @()
    }
    PROCESS {
        if ($PSBoundParameters.ContainsKey('Uuid')) {
            foreach ($Id in $uuid) {
                $Blacklist = Invoke-OPNsenseCommand proxy settings "getremoteblacklist/$Id" |
                    Select-Object -ExpandProperty blacklist
                $Blacklist.enabled = $Blacklist.enabled -eq 1
                $Blacklist.sslNoVerify = $Blacklist.sslNoVerify -eq 1
                $Blacklist | Add-Member 'uuid' $Id
                $blacklists += $Blacklist
            }
        } else {
            $Blacklist = Invoke-OPNsenseCommand proxy settings searchremoteblacklists | Select-Object -ExpandProperty rows
            foreach ($Item in $blacklist) {
                $Item.enabled = $Item.enabled -eq 1
            }
            $blacklists += $Blacklist
        }
    }
    END {
        return $blacklists
    }
}


Function Sync-OPNsenseProxyRemoteBlacklist {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $false, position = 0)]
        [Switch]$Apply
    )

    if ([bool]::Parse($Apply)) {
        $result = Invoke-OPNsenseCommand proxy service fetchacls -Form fetchacls
    } else {
        $result = Invoke-OPNsenseCommand proxy service downloadacls -Form downloadacls
    }

    Return $result
}