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


Function Get-OPNsenseItem {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [OutputType([Object[]])]
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $true, position = 0)][String]$Module,
        [parameter(Mandatory = $true, position = 1)][String]$Item,
        [parameter(Mandatory = $false)][String[]]$Uuid,
        [parameter(Mandatory = $false)][Boolean]$Enable
    )
    BEGIN {
        $uuids = @()
    }
    PROCESS {
        if (-Not $UUID) {
            Write-Verbose "Gathering all the UUIDs..."
            #$uuids += $(Invoke-OPNsenseFunction $Module search $Item).UUID
            $uuids += $(Invoke-OPNsenseOpenApiPath $Module search $Item).UUID
        } else {
            $uuids += $UUID
        }
    }
    END {
        foreach ($id in $uuids) {
            Write-Verbose ""
            Write-Verbose ("Retrieving Item {0}" -f $id)
            Invoke-OPNsenseOpenApiPath $Module get $Item -Uuid $id
        }
    }
}