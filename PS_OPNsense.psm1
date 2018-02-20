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


# Module Variables
$IsPSCoreEdition = ($PSVersionTable.PSEdition -eq 'Core')
if ($IsPSCoreEdition) {}

# Load individual functions from scriptfiles
ForEach ($Folder in 'Core', 'Plugins', 'Private', 'Public') {
    $Scripts = Get-ChildItem -Recurse -Filter '*.ps1' -Path ("{0}/{1}/" -f $PSScriptRoot, $Folder)
    ForEach ($Script in $Scripts) {
        . $Script.FullName
    }
}


Function Connect-OPNsense() {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "Modern")]
    param (
        [parameter(Mandatory = $true, position = 1, ParameterSetName = "Modern")]
        [parameter(Mandatory = $true, position = 1, ParameterSetName = "Legacy")]
        [ValidateNotNullOrEmpty()]
        [String]$Url,

        [parameter(Mandatory = $true, position = 2, ParameterSetName = "Modern")]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty,

        [parameter(Mandatory = $true, position = 2, ParameterSetName = "Legacy")]
        [ValidateNotNullOrEmpty()]
        [String]$Key,

        [parameter(Mandatory = $true, position = 3, ParameterSetName = "Legacy")]
        [ValidateNotNullOrEmpty()]
        [SecureString]$Secret,

        [parameter(Mandatory = $false, position = 3, ParameterSetName = "Modern")]
        [parameter(Mandatory = $false, position = 4, ParameterSetName = "Legacy")]
        [System.Management.Automation.PSCredential]
        $WebCredential = [System.Management.Automation.PSCredential]::Empty,

        [parameter(Mandatory = $false, position = 4, ParameterSetName = "Modern")]
        [parameter(Mandatory = $false, position = 5, ParameterSetName = "Legacy")]
        [switch]$SkipCertificateCheck = $false
    )

    $OPNsenseApi = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi']
    if ($OPNsenseApi) {
        Throw "ERROR : Already connected to $OPNsenseApi. Please use Disconnect-OPNsense first."
    }
    $minversion = [System.Version]'18.1.1'
    
    #$bytes = [System.Text.Encoding]::UTF8.GetBytes($Key + ":" + $Secret)
    #$Credentials = [System.Convert]::ToBase64String($bytes)
    if ($PSBoundParameters.ContainsKey('Secret')) {
        $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $Key, $Secret
    }
    if (-Not $PSBoundParameters.ContainsKey('WebCredential')) {
        $WebCredential = $null
    }

    $Uri = ($Url + '/api/core/firmware/info')
    $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -Credential $Credential `
        -SkipCertificateCheck:$SkipCertificateCheck -Verbose:$VerbosePreference

    if ($Result) {
        # Validate the connection result
        if ($Result.product_version) {
            Write-Warning @"

            THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
            IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
            FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
            AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
            LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
            OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
            SOFTWARE.

"@

            try {
                $temp = Select-String -InputObject $result.product_version -pattern '[0-9\.]*' -AllMatches
                $shortversion = [System.Version]$temp.Matches[0].Value.Trim('.')                
                Write-Verbose ("OPNsense version : " + $Result.product_version )

                if ($shortversion -lt $minversion) {
                    Write-Warning "$shortversion may not be supported by the PS_OPNsense PowerShell Module. Please use OPNsense $minversion or higher."
                }
            } catch {
                $shortversion = $null
                Write-Warning "Unsupported version of $($result.product_name) $($result.product_version) detected. Proceed with extreme care!"
            }
            Add-Member -InputObject $Result 'short_version' $shortversion

            $MyInvocation.MyCommand.Module.PrivateData['Version'] = $shortversion
            $MyInvocation.MyCommand.Module.PrivateData['ApiCredentials'] = $Credential
            $MyInvocation.MyCommand.Module.PrivateData['WebCredentials'] = $WebCredential
            $MyInvocation.MyCommand.Module.PrivateData['OPNsenseUri'] = $Url
            $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'] = "$Url/api"
            $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert'] = [bool]::Parse($SkipCertificateCheck)
        } else {
            Throw "ERROR : Failed to get the OPNsense version of server '$Url'."
        }
    } else {
        Throw "ERROR : Could not connect to the OPNsense server '$Url' using the api credentials supplied."
    }
    return $result  | Add-ObjectDetail -TypeName 'OPNsense.Core.Version'
}

Function Disconnect-OPNsense() {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param()
    If ($MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'] ) {
        Write-Verbose ('Disconnecting from ' + $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'])
        $MyInvocation.MyCommand.Module.PrivateData['ApiCredentials'] = $null
        $MyInvocation.MyCommand.Module.PrivateData['WebCredentials'] = $null
        $MyInvocation.MyCommand.Module.PrivateData['OPNsenseUri'] = $null
        $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'] = $null
        $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert'] = $null
    } else {
        Throw 'ERROR : You are not connected to an OPNsense server. Please use Connect-OPNsense first.'
    }
}


Function Enable-OPNsense {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "CaptivePortalZone")]
    Param(
        [parameter(ParameterSetName = "CaptivePortalZone")]
        [Alias('Zone')]
        [Switch]$CaptivePortalZone,
        [parameter(ParameterSetName = "CronJob")]
        [Alias('Job')]
        [Switch]$CronJob,
        [parameter(ParameterSetName = "FtpProxy")]
        [Switch]$FtpProxy,
        [parameter(ParameterSetName = "IdsRule")]
        [Alias('Rule')]
        [Switch]$IdsRule,
        [parameter(ParameterSetName = "IdsRuleSet")]
        [Alias('RuleSet')]
        [Switch]$IdsRuleSet,
        [parameter(ParameterSetName = "IdsUserRule")]
        [Alias('UserRule')]
        [Switch]$IdsUserRule,
        [parameter(ParameterSetName = "ProxyRemoteBlackList")]
        [Alias('Blacklist')]
        [Alias('RemoteBlacklist')]
        [Switch]$ProxyRemoteBlackList,
        [parameter(ParameterSetName = "Route")]
        [Switch]$Route,
        [parameter(ParameterSetName = "TrafficShaperPipe")]
        [Alias('Pipe')]
        [Switch]$TrafficShaperPipe,
        [parameter(ParameterSetName = "TrafficShaperQueue")]
        [Alias('Queue')]
        [Switch]$TrafficShaperQueue
    )

    DynamicParam {
        # Create the dictionary 
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        if ($CaptivePortalZone) {
            $options = $(Invoke-OPNsenseCommand captiveportal settings searchzones).rows
        }
        if ($CronJob) {
            $options = $(Invoke-OPNsenseCommand cron settings searchjobs).rows
        }
        if ($FtpProxy) {
            $options = $(Invoke-OPNsenseCommand ftpproxy settings searchproxy).rows
        }
        if ($ProxyRemoteBlacklist) {
            $options = $(Invoke-OPNsenseCommand proxy settings searchremoteblacklists).rows
        }
        if ($Route) {
            $options = $(Invoke-OPNsenseCommand routes routes searchroute).rows
        }
        if ($TrafficShaperPipe) {
            $options = $(Invoke-OPNsenseCommand trafficshaper settings searchpipes).rows
        }
        if ($TrafficShaperQueue) {
            $options = $(Invoke-OPNsenseCommand trafficshaper settings searchqueues).rows
        }

        if ($options) {
            $options = $options | Select-Object -ExpandProperty Uuid
            $dynParam = New-ValidationDynamicParam -Name Uuid -Type '[String[]]' -Mandatory -ValidateSetOptions $options -Position 0 -ValueFromPipelineByPropertyName -ValueFromPipeline
            $RuntimeParameterDictionary.Add('Uuid', $dynParam)
        }
        return $RuntimeParameterDictionary
    }

    BEGIN {

    }

    PROCESS {
        foreach ($myuuid in $PSBoundParameters.Uuid) {
            if ($CaptivePortalZone) {
                $result += Invoke-OPNsenseCommand captiveportal settings "togglezone/$myuuid/1" -Form 'toggle'
            }
            if ($CronJob) {
                # Warning, CronJobs can only be toggled and not set directly.
                # It is needed to check the status first and toggle only when needed !!
                $result += Enable-OPNsenseCronJob -uuid $myuuid
            }
            if ($FtpProxy) {
                # Warning, FtpProxy can only be toggled and not set directly.
                # It is needed to check the status first and toggle only when needed !!
                $result += Invoke-OPNsenseCommand ftpproxy settings "toggleproxy/$myuuid" -Form 'toggle'
            }
            if ($IdsRule) {
                $result += Invoke-OPNsenseCommand ids settings "togglerule/$myuuid/1" -Form 'toggle'
            }
            if ($IdsRuleSet) {
                $result += Invoke-OPNsenseCommand ids settings "toggleruleset/$myuuid/1" -Form 'toggle'
            }
            if ($IdsUserRule) {
                $result += Invoke-OPNsenseCommand ids settings "toggleuserrule/$myuuid/1" -Form 'toggle'
            }
            if ($ProxyRemoteBlacklist) {
                # Warning, RemoteBlackLists can only be toggled and not set directly.
                # It is needed to check the status first and toggle only when needed !!
                $result += Invoke-OPNsenseCommand proxy settings "toggleremoteblacklist/$myuuid" -Form 'toggle'
            }
            if ($Route) {
                $result += Invoke-OPNsenseCommand routes routes "toggleRoute/$myuuid/0" -Form 'toggle' # 0 = enabled
            }
            if ($TrafficShaperPipe) {
                $result += Invoke-OPNsenseCommand trafficshaper settings "togglepipe/$myuuid/1" -Form 'toggle'
            }
            if ($TrafficShaperQueue) {
                $result += Invoke-OPNsenseCommand trafficshaper settings "togglequeue/$myuuid/1" -Form 'toggle'
            }
        }
    }

    END {
        return $result
    }
}