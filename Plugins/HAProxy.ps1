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

function New-OPNsenseHAProxyObject {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [ValidateSet('Server', 'Backend', 'Frontend', 'Healthcheck', 'Errorfile', 'Lua', 'Acl', 'Action', 'Healthcheck')]
        [String]$ObjectType,
        [PsObject]$InputObject
    )
    #    return Invoke-OPNsenseCommand haproxy settings get | Select-Object -ExpandProperty haproxy | Select-Object -ExpandProperty $("{0}s" -f $ObjectType) | Select-Object -ExpandProperty $("{0}s" -f $ObjectType)
    return Invoke-OPNsenseCommand haproxy settings $("add{0}" -f $ObjectType.ToLower()) -Json @{ $ObjectType.ToLower() = $InputObject }
}

function Get-NoteProperty {
    [CmdletBinding()]
    param (
        $obj
    )
    return Get-Member -InputObject $obj -MemberType NoteProperty | Select-Object -ExpandProperty Name
}

function Format-OPNsenseProperty {
    [CmdletBinding()]
    param (
        $obj
    )
    $props = Get-NoteProperty $obj
    foreach ($prop in $props) {
        switch ($obj.($prop).GetType().Name) {
            'PSCustomObject' {
                $obj.($prop) = Get-MultiOption $obj.($prop)
            }
            default {}
        }
    }
    return $obj
}

function Get-MultiOption {
    [CmdletBinding()]
    param (
        $obj
    )
    $props = Get-NoteProperty $obj
    $result = @()
    foreach ($prop in $props) {
        if ($obj.($prop).selected -gt 0) {
            $result += $obj.($prop).value -replace ' \[default\]', ''
            #$result += $prop

            #$val = $obj.($prop).value -replace ' \[default\]', ''
            #$result += @{ $val = $prop}
        }
    }
    return $result
}

function Get-OPNsenseHAProxyDetail {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [ValidateSet('Server', 'Backend', 'Frontend', 'Healthcheck', 'Errorfile', 'Lua', 'Acl', 'Action', 'Healthcheck')]
        [String]$ObjectType,
        [parameter(Mandatory = $true)][string]$Uuid
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        $result = Invoke-OPNsenseCommand haproxy settings $("get{0}/{1}" -f $ObjectType.ToLower(), $Uuid) | Select-Object -ExpandProperty $ObjectType
        $result | Add-Member -MemberType NoteProperty -Name 'uuid' -Value $Item.uuid
        $result = Format-OPNsenseProperty $result
        $results += $result
    }
    END {
        return $results | Add-ObjectDetail -TypeName ('OPNsense.HAProxy.{0}.Detail' -f $ObjectType)
    }
}

function Get-OPNsenseHAProxyObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [ValidateSet('Server', 'Backend', 'Frontend', 'Healthcheck', 'Errorfile', 'Lua', 'Acl', 'Action', 'Healthcheck')]
        [String]$ObjectType,
        [parameter(Mandatory = $false)][string[]]$Name,
        [parameter(Mandatory = $false)][Switch]$Enabled        
    )
    #    return Invoke-OPNsenseCommand haproxy settings get | Select-Object -ExpandProperty haproxy | Select-Object -ExpandProperty $("{0}s" -f $ObjectType) | Select-Object -ExpandProperty $("{0}s" -f $ObjectType)
    $items = Invoke-OPNsenseCommand haproxy settings $("search{0}s" -f $ObjectType.ToLower()) | Select-Object -ExpandProperty rows

    # Get Object details based on the UUID
    $results = @()
    foreach ($item in $items) {
        $result = Get-OPNsenseHAProxyDetail -ObjectType $ObjectType -Uuid $item.Uuid
        $results += $result
    }

    return $results
}

Function Get-OPNsenseHAProxyServer {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)][string[]]$Name,
        [parameter(Mandatory = $false)][Switch]$Enabled        
    )
    return Get-OPNsenseHAProxyObject -ObjectType "Server" @PSBoundParameters
}

Function Get-OPNsenseHAProxyBackend {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)][string[]]$Name,
        [parameter(Mandatory = $false)][Switch]$Enabled        
    )
    return Get-OPNsenseHAProxyObject "Backend" @PSBoundParameters
}

Function Get-OPNsenseHAProxyFrontend {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)][string[]]$Name,
        [parameter(Mandatory = $false)][Switch]$Enabled        
    )
    return Get-OPNsenseHAProxyObject "Frontend" @PSBoundParameters
}
Function Get-OPNsenseHAProxyErrorfile {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)][string[]]$Name,
        [parameter(Mandatory = $false)][Switch]$Enabled        
    )
    return Get-OPNsenseHAProxyObject "Errorfile" @PSBoundParameters
}

Function Get-OPNsenseHAProxyHealthCheck {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)][string[]]$Name,
        [parameter(Mandatory = $false)][Switch]$Enabled        
    )
    return Get-OPNsenseHAProxyObject "HealthCheck" @PSBoundParameters
}

Function Get-OPNsenseHAProxyAcl {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)][string[]]$Name,
        [parameter(Mandatory = $false)][Switch]$Enabled        
    )
    return Get-OPNsenseHAProxyObject "Acl" @PSBoundParameters
}

Function Get-OPNsenseHAProxyAction {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)][string[]]$Name,
        [parameter(Mandatory = $false)][Switch]$Enabled        
    )
    return Get-OPNsenseHAProxyObject "Action" @PSBoundParameters
}

Function Get-OPNsenseHAProxyLuaScript {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)][string[]]$Name,
        [parameter(Mandatory = $false)][Switch]$Enabled        
    )
    return Get-OPNsenseHAProxyObject "Lua" @PSBoundParameters
}

Function New-OPNsenseHAProxyServer {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [PsObject]$Parameters
    )
    return New-OPNsenseHAProxyObject Server -InputObject $Parameters
}

Function New-OPNsenseHAProxyBackend {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [PsObject]$Parameters
    )
    return New-OPNsenseHAProxyObject Backend -InputObject $Parameters
}

Function New-OPNsenseHAProxyFrontend {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [PsObject]$Parameters
    )
    return New-OPNsenseHAProxyObject Frontend -InputObject $Parameters
}

Function New-OPNsenseHAProxyErrorfile {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0, ParameterSetName = "Object")]
        [PsObject]$InputObject,

        [Parameter(Mandatory = $true, position = 0, ParameterSetName = "Normal")]
        [String]$Name,
        [Parameter(Mandatory = $false, ParameterSetName = "Normal")]
        [String]$Description,
        [Parameter(Mandatory = $true, position = 1, ParameterSetName = "Normal")]
        [ValidateSet(200, 400, 403, 405, 408, 429, 500, 502, 503, 504)]
        [int]$ErrorCode,
        [Parameter(Mandatory = $true, position = 2, ParameterSetName = "Normal")]
        [String]$Content
    )

    if ($InputObject) {
        $Params = $InputObject
        $ValidCodes = @(200, 400, 403, 405, 408, 429, 500, 502, 503, 504)
        if ($ValidCodes -contains $Params.code) {
            $Params.code = "x{0}" -f $Params.code
            return New-OPNsenseHAProxyObject -ObjectType "Errorfile" -InputObject $Params
        } else {
            Write-Error $("{0} is an invalid code." -f $Params.code)
        }
    } else {
        $Params = @{
            'name' = $Name;
            'description' = "{0}" -f $Description;
            'code' = "x$errorcode";
            'content' = $Content;
            
        }
        return New-OPNsenseHAProxyObject -ObjectType "Errorfile" -InputObject $Params
    }
}

Function New-OPNsenseHAProxyLuaScript {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0, ParameterSetName = "Object")]
        [PsObject]$InputObject,

        [Parameter(Mandatory = $true, position = 0, ParameterSetName = "Normal")]
        [String]$Name,
        [Parameter(Mandatory = $false, ParameterSetName = "Normal")]
        [String]$Description,
        [Parameter(Mandatory = $true, position = 1, ParameterSetName = "Normal")]
        [String]$Content
    )

    if ($InputObject) {
        return New-OPNsenseHAProxyObject -ObjectType "Lua" -InputObject $InputObject
    } else {
        $Params = @{
            'name' = $Name;
            'description' = "{0}" -f $Description;
            'content' = $Content;
        }
        return New-OPNsenseHAProxyObject -ObjectType "Lua" -InputObject $Params
    }
}
