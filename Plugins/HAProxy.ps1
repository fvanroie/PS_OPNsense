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


function ConvertTo-InputObject {
    [CmdletBinding()]
    Param(
        [String]$paramset,
        [HashTable]$psbounds,
        [PSObject]$InputObject
    )
    Write-Verbose "Parameterset : $paramset"
    Write-Verbose (ConvertTo-Json $psbounds)
    if ($InputObject) { Write-Verbose (ConvertTo-Json $InputObject) }
    if ($paramSet -eq "AsParam") {
        $obj = New-Object PsObject;
        foreach ($key in $PSBounds.keys) {
            if ($key -notin [System.Management.Automation.PSCmdlet]::CommonParameters -and
                $key -notin [System.Management.Automation.PSCmdlet]::OptionalCommonParameters) {
                if ($key -in 'enabled') {
                    $obj | Add-Member -MemberType NoteProperty -Name $key -Value $PSBounds[$key] -Force
                } elseif ($key -in 'bind', 'linkedErrorFiles', 'linkedServers') {
                    $obj | Add-Member -MemberType NoteProperty -Name $key -Value ($PSBounds[$key] -Join ',') -Force
                } else {
                    $obj | Add-Member -MemberType NoteProperty -Name $key -Value $PSBounds[$key] -Force
                }
            }
        }        
    } else {
        $obj = $InputObject
    }
    Write-Debug ("Parameters : {0}" -f (ConvertTo-Json -InputObject $obj))
    return $obj
}


function Get-NoteProperty {
    [CmdletBinding()]
    param (
        [psobject]$obj
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


##### GET Functions #####
function Get-OPNsenseHAProxyDetail {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [ValidateSet('Server', 'Backend', 'Frontend', 'Healthcheck', 'Errorfile', 'Lua', 'Acl', 'Action', 'Healthcheck')]
        [String]$ObjectType,
        [parameter(Mandatory = $true)][string]$Uuid
    )
    Switch ($ObjectType) {
        'Server' { Get-OPNsenseHAProxyServer -Uuid $Uuid }    
        'Backend' { Get-OPNsenseHAProxyBackend -Uuid $Uuid }    
        'Frontend' { Get-OPNsenseHAProxyFrontend -Uuid $Uuid }    
        'Healthcheck' { Get-OPNsenseHAProxyHealthCheck -Uuid $Uuid }    
        'Errorfile' { Get-OPNsenseHAProxyErrorfile -Uuid $Uuid }    
        'Lua' { Get-OPNsenseHAProxyLuaScript -Uuid $Uuid }    
        'Acl' { Get-OPNsenseHAProxyAcl -Uuid $Uuid }    
        'Action' { Get-OPNsenseHAProxyAction -Uuid $Uuid }    
        default { }
    }
}

function Select-OPNsenseHAProxyObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [AllowNull()]$InputObject,

        [parameter(Mandatory = $false)]
        [AllowEmptyCollection()][string[]]$Uuid,

        [parameter(Mandatory = $false)]
        [AllowEmptyCollection()][string[]]$Name,

        [parameter(Mandatory = $false)]
        [AllowEmptyCollection()][string[]]$Description 
    )
    
    Write-Verbose "- UUID : $Uuid`n`t - Name : $Name`n`t - Description : $Description"
    $result = @()

    # Test if the InputObject is defined
    if (-Not $InputObject) {
        return $resul
    }

    # UUID filter
    If ($Uuid) {
        $ids = $Uuid
    } else {
        $ids = Get-NoteProperty $InputObject
    }

    ForEach ($id in $ids) {
        # Skip objects that do not satisfy the filters passed
        If (Skip-OPNsenseObject -Value $InputObject.$id.Name -Like $Name) { continue }
        If (Skip-OPNsenseObject -Value $InputObject.$id.Description -Like $Description) { continue }

        # PassThru is needed to capture the object
        $result += $InputObject.$id | Add-Member -MemberType NoteProperty -Name 'Uuid' -Value $id -PassThru
    }

    return $result
}

function Get-OPNsenseHAProxyObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [ValidateSet('Server', 'Backend', 'Frontend', 'Healthcheck', 'Errorfile', 'Lua', 'Acl', 'Action')]
        [String]$ObjectType
    )
    
    Invoke-OPNsenseCommand haproxy settings get |
        Select-Object -ExpandProperty haproxy |
        Select-Object -ExpandProperty ('{0}s' -f $ObjectType.ToLower()) |
        Select-Object -ExpandProperty $ObjectType.ToLower()
}

##### NEW Functions #####
<#
function New-OPNsenseHAProxyObject {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [ValidateSet('Server', 'Backend', 'Frontend', 'Healthcheck', 'Errorfile', 'Lua', 'Acl', 'Action', 'Healthcheck')]
        [String]$ObjectType,
        [PsObject[]]$InputObject
    )
    PROCESS {
        foreach ($Item in $InputObject) {
            #    return Invoke-OPNsenseCommand haproxy settings get | Select-Object -ExpandProperty haproxy | Select-Object -ExpandProperty $("{0}s" -f $ObjectType) | Select-Object -ExpandProperty $("{0}s" -f $ObjectType)
            $result = Invoke-OPNsenseCommand haproxy settings $("add{0}" -f $ObjectType.ToLower()) -Json @{ $ObjectType.ToLower() = $Item }
            if (Test-Result $result) {
                return $result
            }
        }
    }    
}
#>
function New-OPNsenseHAProxyObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [ValidateSet('Server', 'Backend', 'Frontend', 'Healthcheck', 'Errorfile', 'Lua', 'Acl', 'Action')]
        [String]$ObjectType,
        [PsObject[]]$InputObject,
        [Switch]$PassThru
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        $PassThru = $true
        foreach ($Item in $InputObject) {
            #$Uuid = $Item.Uuid
            #if ($Uuid) {
            # Mode needs lowercase
            $Properties = Get-NoteProperty $Item
            if ($Item.Mode) { $Item.Mode = $Item.Mode.tolower() }
            if ($Item.Code) { $Item.Code = ( 'x{0}' -f $Item.Code) }
            foreach ($prop in 'Enabled', 'Negate') {
                if ($prop -in $Properties) {
                    $Item.$prop = ConvertTo-Boolean $Item.$prop
                }
            }
            
            $snapBefore = $(Invoke-OPNsenseCommand haproxy settings $("search{0}s" -f $ObjectType.ToLower()) -Form @{ searchPhrase = $Item.Name} ).rows
            $result = Invoke-OPNsenseCommand haproxy settings $("add{0}" -f $ObjectType.ToLower()) -Json @{ $ObjectType.ToLower() = $Item }
            
            if (Test-OPNsenseApiResult $result) {
                $snapAfter = $(Invoke-OPNsenseCommand haproxy settings $("search{0}s" -f $ObjectType.ToLower()) -Form @{ searchPhrase = $Item.Name} ).rows
                $uuid = Compare-Object -ReferenceObject $snapBefore -DifferenceObject $snapAfter -Property Uuid | Select-Object -ExpandProperty Uuid

                $result = Get-OPNsenseHAProxyDetail -ObjectType $ObjectType -Uuid $Uuid
                #if ($PassThru) {
                $results += $result
                #}
            }
            #} else {
            #    Write-Error $("Invalid UUID for {0} object!" -f $ObjectType)
            #}
        }
    }
    END {
        return $results | Add-ObjectDetail -TypeName ('OPNsense.HAProxy.{0}.Detail' -f $ObjectType)
    }
}
Function New-OPNsenseHAProxyServer {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "AsParam")]  
    Param(
        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsObject")]
        [PSObject[]]$InputObject,

        [parameter(ValueFromPipelineByPropertyname = $true)][String]$address,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$advanced,
        [parameter(ValueFromPipelineByPropertyname = $true)][int]$checkDownInterval,
        [parameter(ValueFromPipelineByPropertyname = $true)][int]$checkInterval,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateRange(0, 65535)][int]$checkPort,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$description,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet("Active", "Backup", "Disabled")][String]$mode,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$name,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateRange(0, 65535)][int]$port,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$source,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$ssl,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$sslCA,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$sslClientCertificate,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$sslCRL,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$sslVerify,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateRange(0, 256)][int]$weight
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        # Convert parameters to InputObject
        $obj = ConvertTo-InputObject -paramset $PSCmdlet.ParameterSetName -psbounds $PSBoundParameters -InputObject $InputObject
        # Create new Object
        $result = New-OPNsenseHAProxyObject -ObjectType Server -InputObject $obj
        $results += $result
    }   
    END {
        return $results
    } 
}

Function New-OPNsenseHAProxyBackend {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "AsParam")]  
    Param(
        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsObject")]
        [PSObject[]]$InputObject,

        [parameter(Mandatory = $true, ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$enabled,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$name,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$description,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet("HTTP", "TCP")][String]$mode = "HTTP",
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet("source", "roundrobin", "static-rr", "leastconn", "uri")][String]$algorithm = "http",
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$source,
        [parameter(ValueFromPipelineByPropertyname = $true)][String[]]$linkedServers,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$healthCheckEnabled,
        [parameter(ValueFromPipelineByPropertyname = $true)][String[]]$healthCheck,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$healthCheckLogStatus,
        [parameter(ValueFromPipelineByPropertyname = $true)][String[]]$linkedActions,
        [parameter(ValueFromPipelineByPropertyname = $true)][String[]]$linkedErrorfiles      
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        # Convert parameters to InputObject
        $obj = ConvertTo-InputObject -paramset $PSCmdlet.ParameterSetName -psbounds $PSBoundParameters -InputObject $InputObject
        # Create new Object
        $result = New-OPNsenseHAProxyObject -ObjectType Backend -InputObject $obj
        $results += $result
    }   
    END {
        return $results
    } 
}
Function New-OPNsenseHAProxyFrontend {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "AsParam")]  
    Param(
        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsObject")]
        [PSObject[]]$InputObject,

        [parameter(Mandatory = $true, ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$enabled,
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyname = $true)][String]$name,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$description,
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyname = $true)][String[]]$bind,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$bindOptions,
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyname = $true)]
        [ValidateSet("http", "ssl", "tcp")][String]$mode = "http",
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$defaultBackend,
        [parameter( ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$sslEnabled,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$ssl_customOptions,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$ssl_advancedEnabled,

        [parameter(ValueFromPipelineByPropertyname = $true)][String]$customOptions,

        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet("http-keep-alive", "http-tunnel", "httpclose", "http-server-close", "foreclose")][String]$connectionBehaviour = "http-keep-alive",
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$ssl_default_certificate,
        [parameter(ValueFromPipelineByPropertyname = $true)][String[]]$linkedServers,

        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$logging_dontLogNull,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$logging_dontLogNormal,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$logging_logSeparateErrors,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$logging_detailedLog,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$logging_socketStats,

        [parameter(ValueFromPipelineByPropertyname = $true)][String[]]$linkedActions,
        [parameter(ValueFromPipelineByPropertyname = $true)][String[]]$linkedErrorfiles      
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        # Convert parameters to InputObject
        $obj = ConvertTo-InputObject -paramset $PSCmdlet.ParameterSetName -psbounds $PSBoundParameters -InputObject $InputObject
        # Create new Object
        $result = New-OPNsenseHAProxyObject -ObjectType Frontend -InputObject $obj
        $results += $result
    }   
    END {
        return $results
    } 
}
Function New-OPNsenseHAProxyErrorfile {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "AsParam")]  
    Param(
        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsObject")]
        [PSObject[]]$InputObject,

        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsParam")][String]$name,
        [parameter(Position = 1, ValueFromPipelineByPropertyname = $true)][String]$description,
        [parameter(Position = 2, Mandatory = $true, ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(200, 400, 403, 405, 408, 429, 500, 502, 503, 504)][int]$code,
        [parameter(Position = 3, Mandatory = $true, ValueFromPipelineByPropertyname = $true)][String]$content
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        # Convert parameters to InputObject
        $obj = ConvertTo-InputObject -paramset $PSCmdlet.ParameterSetName -psbounds $PSBoundParameters -InputObject $InputObject
        # Create new Object
        $result = New-OPNsenseHAProxyObject -ObjectType Errorfile -InputObject $obj
        $results += $result
    }   
    END {
        return $results
    } 
}
Function New-OPNsenseHAProxyLuaScript {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "AsParam")]  
    Param(
        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsObject")]
        [PSObject[]]$InputObject,

        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsParam")][String]$name,
        [parameter(Position = 1, ValueFromPipelineByPropertyname = $true)][String]$description,
        [parameter(Position = 2, Mandatory = $true, ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$enabled,
        [parameter(Position = 3, Mandatory = $true, ValueFromPipelineByPropertyname = $true)][String]$content
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        # Convert parameters to InputObject
        $obj = ConvertTo-InputObject -paramset $PSCmdlet.ParameterSetName -psbounds $PSBoundParameters -InputObject $InputObject
        # Create new Object
        $result = New-OPNsenseHAProxyObject -ObjectType "Lua" -InputObject $obj
        $results += $result
    }   
    END {
        return $results
    } 
}
Function New-OPNsenseHAProxyHealthCheck {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "AsParam")]  
    Param(
        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsObject")]
        [PSObject[]]$InputObject,

        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsParam")][String]$name,
        [parameter(Position = 1, ValueFromPipelineByPropertyname = $true)][String]$description,
        [parameter(Position = 2, Mandatory = $true, ValueFromPipelineByPropertyname = $true)]
        [ValidateSet('tcp', 'http', 'agent', 'ldap', 'mysql', 'pgsql', 'redis', 'smtp', 'esmtp', 'ssl')][String]$type,
        [parameter(Position = 3, Mandatory = $true, ValueFromPipelineByPropertyname = $true)][String]$interval,
        [parameter(Position = 4, Mandatory = $true, ValueFromPipelineByPropertyname = $true)][Int]$checkPort

        ## Additional options need to be implemented using Dynamic Parameters
        ## Currently they can be set using $InputObject
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        # Convert parameters to InputObject
        $obj = ConvertTo-InputObject -paramset $PSCmdlet.ParameterSetName -psbounds $PSBoundParameters -InputObject $InputObject
        # Create new Object
        $result = New-OPNsenseHAProxyObject -ObjectType "Healthcheck" -InputObject $obj
        $results += $result
    }   
    END {
        return $results
    } 
}
Function New-OPNsenseHAProxyAcl {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "AsParam")]  
    Param(
        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsObject")]
        [PSObject[]]$InputObject,

        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsParam")][String]$name,
        [parameter(Position = 1, ValueFromPipelineByPropertyname = $true)][String]$description,
        [parameter(Position = 2, Mandatory = $true, ValueFromPipelineByPropertyname = $true)]
        [ValidateSet('hdr_end', 'hdr_reg', 'path_beg', 'path', 'path_dir', 'url_param', 'ssl_c_verify', 'ssl_c_ca_commonname',
            'src_is_local', 'src_bytes_in_rate', 'src_kbytes_in', 'src_conn_cnt', 'src_conn_rate', 'src_http_err_rate', 'src_http_req_rate', 'src_sess_rate',
            'traffic_is_http', 'ssl_sni', 'ssl_sni_beg', 'ssl_sni_reg', 'custom_acl')][String]$expression,
        [parameter(Position = 3, Mandatory = $true, ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$negate

        ## Additional options need to be implemented using Dynamic Parameters
        ## Currently they can be set using $InputObject
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        # Convert parameters to InputObject
        $obj = ConvertTo-InputObject -paramset $PSCmdlet.ParameterSetName -psbounds $PSBoundParameters -InputObject $InputObject
        # Create new Object
        $result = New-OPNsenseHAProxyObject -ObjectType "Acl" -InputObject $obj
        $results += $result
    }   
    END {
        return $results
    } 
}


##### SET Functions #####
function Set-OPNsenseHAProxyObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [ValidateSet('Server', 'Backend', 'Frontend', 'Healthcheck', 'Errorfile', 'Lua', 'Acl', 'Action', 'Healthcheck')]
        [String]$ObjectType,
        [PsObject[]]$InputObject,
        [Switch]$PassThru
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        $PassThru = $true
        foreach ($Item in $InputObject) {
            Write-Debug ("Parameters : {0}" -f (ConvertTo-Json -InputObject $Item))
            $Uuid = $Item.Uuid
            if ($Uuid) {
                # Mode needs lowercase
                $Properties = Get-NoteProperty $Item
                if ($Item.Mode) { $Item.Mode = $Item.Mode.tolower() }
                if ($Item.Code) { $Item.Code = ( 'x{0}' -f $Item.Code) }
                foreach ($prop in 'Enabled', 'Negate') {
                    if ($prop -in $Properties) {
                        $Item.$prop = ConvertTo-Boolean $Item.$prop
                    }
                }

                #    return Invoke-OPNsenseCommand haproxy settings get | Select-Object -ExpandProperty haproxy | Select-Object -ExpandProperty $("{0}s" -f $ObjectType) | Select-Object -ExpandProperty $("{0}s" -f $ObjectType)
                $result = Invoke-OPNsenseCommand haproxy settings $("set{0}/{1}" -f $ObjectType.ToLower(), $Uuid) -Json @{ $ObjectType.ToLower() = $Item }
                if (Test-OPNsenseApiResult $result) {
                    $result = Get-OPNsenseHAProxyDetail -ObjectType $ObjectType -Uuid $Uuid
                    if ($PassThru) {
                        $results += $result
                    }
                }
            } else {
                Write-Error $("Invalid UUID for {0} object!" -f $ObjectType)
            }
        }
    }
    END {
        return $results | Add-ObjectDetail -TypeName ('OPNsense.HAProxy. {0}.Detail' -f $ObjectType)
    }
}
Function Set-OPNsenseHAProxyServer {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "AsParam")]  
    Param(
        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsParam")]
        [String]$Uuid,

        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsObject")]
        [PSObject[]]$InputObject,

        [parameter(ValueFromPipelineByPropertyname = $true)][String]$Address,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$Advanced,
        [parameter(ValueFromPipelineByPropertyname = $true)][int]$CheckDownInterval,
        [parameter(ValueFromPipelineByPropertyname = $true)][int]$CheckInterval,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateRange(0, 65535)][int]$CheckPort,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$Description,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet("Active", "Backup", "Disabled")][String]$Mode,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$Name,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateRange(0, 65535)][int]$Port,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$Source,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$Ssl,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$sslCA,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$sslClientCertificate,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$sslCRL,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$SslVerify,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateRange(0, 256)][int]$Weight
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        # Convert parameters to InputObject
        $paramset = $PSCmdlet.ParameterSetName
        Write-Verbose $paramSet
        if ($paramSet -eq "AsParam") {
            $InputObject = New-Object PsObject;
            foreach ($key in $PSBoundParameters.keys) {
                if ($key -notin [System.Management.Automation.PSCmdlet]::CommonParameters -and
                    $key -notin [System.Management.Automation.PSCmdlet]::OptionalCommonParameters) {
                    $InputObject | Add-Member -MemberType NoteProperty -Name $key.tolower() -Value $PSBoundParameters[$key] -Force
                }
            }        
        }

        $result = Set-OPNsenseHAProxyObject -ObjectType Server -InputObject $InputObject
        $results += $result
    }   
    END {
        return $results
    } 
}
Function Set-OPNsenseHAProxyLuaScript {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "AsParam")]  
    Param(
        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsParam")]
        [String]$Uuid,

        [parameter(Position = 0, Mandatory = $true, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsObject")]
        [PSObject[]]$InputObject,

        [parameter(ValueFromPipelineByPropertyname = $true)][String]$Description,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$Name,
        [parameter(ValueFromPipelineByPropertyname = $true)][String]$Content,
        [parameter(ValueFromPipelineByPropertyname = $true)]
        [ValidateSet(0, 1, '0', '1', $False, $True)]$Enabled
    )
    BEGIN {
        $results = @()
    }
    PROCESS {
        # Convert parameters to InputObject
        $paramset = $PSCmdlet.ParameterSetName
        Write-Verbose $paramSet
        if ($paramSet -eq "AsParam") {
            $InputObject = New-Object PsObject;
            foreach ($key in $PSBoundParameters.keys) {
                if ($key -notin [System.Management.Automation.PSCmdlet]::CommonParameters -and
                    $key -notin [System.Management.Automation.PSCmdlet]::OptionalCommonParameters) {
                    $InputObject | Add-Member -MemberType NoteProperty -Name $key.tolower() -Value $PSBoundParameters[$key] -Force
                }
            }        
        }

        $result = Set-OPNsenseHAProxyObject -ObjectType Lua -InputObject $InputObject
        $results += $result
    }   
    END {
        return $results
    } 
}