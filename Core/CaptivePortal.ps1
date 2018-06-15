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

Function New-OPNsenseCaptivePortalZone {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)][String]$Description,
        [Parameter(Mandatory = $false)][Boolean]$Enabled = $true,
        [Parameter(Mandatory = $false)][Boolean]$ConcurrentLogins = $true,
        [Parameter(Mandatory = $false)][Boolean]$TransparentHTTPProxy = $false,
        [Parameter(Mandatory = $false)][Boolean]$TransparentHTTPSProxy = $false,
        [Parameter(Mandatory = $false)][int]$IdleTimeout = 0,
        [Parameter(Mandatory = $false)][int]$HardTimeout = 0,
        [Parameter(Mandatory = $false)][int]$authEnforceGroup = 1999,
        [Parameter(Mandatory = $false)][String]$allowedAddress = '',
        [Parameter(Mandatory = $false)][String]$allowedMACAddress = '',
        [Parameter(Mandatory = $false)][String]$Hostname = ''
    )

    DynamicParam {
        # Get all the dynamic parameter values
        $newzone = Invoke-OPNsenseCommand captiveportal settings getzone | Select-Object -ExpandProperty zone
        # Create the dictionary 
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        # Interface
        $options = $newzone | Select-Object -ExpandProperty interfaces | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty name
        $dynParam = New-ValidationDynamicParam -Name Interface -Type '[String[]]' -Mandatory -ValidateSetOptions $options
        $RuntimeParameterDictionary.Add('Interface', $dynParam)

        # AuthServers
        $options = $newzone | Select-Object -ExpandProperty authservers | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty name
        $dynParam = New-ValidationDynamicParam -Name AuthServers -Type '[String[]]' -ValidateSetOptions $options
        $RuntimeParameterDictionary.Add('AuthServers', $dynParam)

        # Template
        $options = $newzone | Select-Object -ExpandProperty template | Get-Member -MemberType NoteProperty | Where-Object { $_.Name -notin ('', ' ') } |  Select-Object -ExpandProperty name
        $arrList = @()
        foreach ($option in $options) {
            $arrList += $newzone.template."$option".value
            $arrList += $option
        }
        $dynParam = New-ValidationDynamicParam -Name Template -Type '[String]' -ValidateSetOptions $arrList
        $RuntimeParameterDictionary.Add('Template', $dynParam)

        # Certificate
        $options = $newzone | Select-Object -ExpandProperty certificate | Get-Member -MemberType NoteProperty | Where-Object { $_.Name -notin ('', ' ') } |  Select-Object -ExpandProperty name
        $arrList = @()
        foreach ($option in $options) {
            $arrList += $newzone.certificate."$option".value
            $arrList += $option
        }
        $dynParam = New-ValidationDynamicParam -Name Certificate -Type '[String]' -ValidateSetOptions $arrList
        $RuntimeParameterDictionary.Add('Certificate', $dynParam)

        # Add the parameters
        return $RuntimeParameterDictionary
    }

    BEGIN {
        $myInterface = $PSBoundParameters.Interface -join ','
        $myAuthServers = $PSBoundParameters.AuthServers -join ','      
        $myCertificate = $PSBoundParameters.Certificate
        $myTemplate = $PSBoundParameters.Template

        if ($myTemplate -or $myCertificate) {
            $newzone = Invoke-OPNsenseCommand captiveportal settings getzone | Select-Object -ExpandProperty zone

            # Resolve Name to UUID
            if ($myCertificate) {
                $options = $newzone | Select-Object -ExpandProperty certificate | Get-Member -MemberType NoteProperty | Where-Object { $_.Name -notin ('', ' ') } |  Select-Object -ExpandProperty name
                if ($myCertificate -notin $options) {
                    $found = 0
                    foreach ($option in $options) {
                        if ($myCertificate -eq $newzone.certificate."$option".value) {
                            $myCertificate = $option
                            $found++
                        }
                    }
                    if ($found -ne 1) {
                        Throw "Unable to find the UUID of the certificate"
                    }
                }
            }

            # Resolve Name to UUID
            if ($myTemplate) {
                $options = $newzone | Select-Object -ExpandProperty template | Get-Member -MemberType NoteProperty | Where-Object { $_.Name -notin ('', ' ') } |  Select-Object -ExpandProperty name
                if ($myTemplate -notin $options) {
                    $found = 0
                    foreach ($option in $options) {
                        if ($myTemplate -eq $newzone.template."$option".value) {
                            $myTemplate = $option
                            $found++
                        }
                    }
                    if ($found -ne 1) {
                        Throw "Unable to find the UUID of the template"
                    }
                }
            }

        }
    }
    PROCESS {}

    END {
        if ($Enabled) { $isEnabled = 1 } else { $isEnabled = 0 }
        if ($ConcurrentLogins) { $isConcurrentLogins = 1 } else { $isConcurrentLogins = 0 }
        if ($TransparentHTTPProxy) { $isTransparentHTTPProxy = 1 } else { $isTransparentHTTPProxy = 0 }
        if ($TransparentHTTPSProxy) { $isTransparentHTTPSProxy = 1 } else { $isTransparentHTTPSProxy = 0 }

        $obj = @{
            zone = @{
                enabled               = [String]$isEnabled;
                interfaces            = [String]$myInterface;
                authservers           = [String]$myAuthServers;
                authEnforceGroup      = $authEnforceGroup;
                idletimeout           = [String]$IdleTimeout;
                hardtimeout           = [String]$HardTimeout;
                concurrentlogins      = $isConcurrentLogins;
                certificate           = [String]$myCertificate;
                servername            = $Hostname;
                allowedAddresses      = $allowedAddress;
                allowedMACAddresses   = $allowedMACAddress;
                transparentHTTPProxy  = [String]$isTransparentHTTPProxy;
                transparentHTTPSProxy = [String]$isTransparentHTTPSProxy;
                template              = [String]$myTemplate;
                description           = $Description
            }
        };

        $result = Invoke-OPNsenseCommand captiveportal settings addzone -Json $obj
        if ($result) {
            if ($result.validations) {
                $count = $($result.validations | Get-Member -MemberType NoteProperty).count
                $keys = $result.validations | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty  Name
                Write-Verbose "$count validations failed:"
                foreach ($key in $keys) {
                    Write-Verbose ("   - $key : " + $result.validations."$key")
                }
            }
        } else {
            Throw "Failed to add the CaptivePortal zone..."
        }

        return $result
    }
}


<#Function Get-OPNsenseCaptivePortalTemplate {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = 'GetTemplate')]
    Param (
        [Parameter(Mandatory = $false)][String]$Name,
        [Parameter(Mandatory = $false)][String]$Uuid,
        [Parameter(Mandatory = $false)][String]$FileId
    )
    $result = Invoke-OPNsenseCommand captiveportal service searchTemplates | Select-Object -ExpandProperty Rows

    if ($Name) {
        $result = $result | where-object { $_.Name -like $Name }
    }
    if ($Uuid) {
        $result = $result | where-object { $_.Uuid -like $Uuid }
    }
    if ($FileId) {
        $result = $result | where-object { $_.FileId -like $FileId }
    }
    Return $result
}#>

Function New-OPNsenseCaptivePortalTemplate {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $true)][String]$Name,
        [System.IO.FileInfo]$Path
    )
    $Path = Convert-Path $Path
    if (Test-Path -PathType Leaf -Path $Path) {
        $filecontent = [IO.File]::ReadAllBytes($Path)
        $obj = @{'name' = $Name; 'content' = [System.Convert]::ToBase64String($filecontent)}

        return Invoke-OPNsenseCommand captiveportal service saveTemplate -Json $obj
    } else {
        Write-Error "Could not load template file $File"
    }
}

Function Save-OPNsenseCaptivePortalTemplate {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $true)][String]$FileId,
        [Parameter(Mandatory = $true)][System.IO.FileInfo]$Path,
        [Parameter(Mandatory = $false)][Switch]$Force       
    )

    if (Test-Path -PathType Leaf -Path $Path) {
        if (-Not [bool]::Parse($Force)) {
            Write-Error "The file $Path already exists."
            return
        }
    }

    try {
        $result = Invoke-OPNsenseCommand captiveportal service getTemplate -Form "fileid=$fileid" -OutFile $path
        return $result
    } catch {
        Write-Error "Could not save template file $File"
    }
}


<#Function Get-OPNsenseCaptivePortal {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = 'GetTemplate')]
    Param (
        [Parameter(ParameterSetName = 'GetTemplate')]
        [switch]$Template,

        [Parameter(ParameterSetName = 'GetZone')]
        [switch]$Zone,

        [Parameter(ParameterSetName = 'ListProviders')]
        [switch]$Provider,

        [Parameter(Mandatory = $false, ParameterSetName = 'GetTemplate')]
        [Parameter(Mandatory = $false, ParameterSetName = 'GetZone')]
        [ValidateNotNullOrEmpty()]
        [string]$Uuid
    )

    If ([bool]::Parse($Provider)) {
        $arr = Invoke-OPNsenseCommand captiveportal voucher listproviders
        $results = @()
        foreach ($a in $arr) {
            $results += New-Object -TypeName psobject -Property @{ Provider = $a }

        }
        return $results
    }

    If ([bool]::Parse($Template)) {
        $result = Invoke-OPNsenseCommand captiveportal service searchtemplates
        return $($result).rows
    }

    If ([bool]::Parse($Zone)) {
        $result = Invoke-OPNsenseCommand captiveportal settings searchzones
        return $($result).rows
    }
}#>