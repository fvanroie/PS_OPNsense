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


Function Connect-OPNsense {
    # .EXTERNALHELP ../../../PS_OPNsense.psd1-Help.xml
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
    
    #$bytes = [System.Text.Encoding]::UTF8.GetBytes($Key + ":" + $Secret)
    #$Credentials = [System.Convert]::ToBase64String($bytes)
    if ($PSBoundParameters.ContainsKey('Secret')) {
        $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $Key, $Secret
    }
    if (-Not $PSBoundParameters.ContainsKey('WebCredential')) {
        $WebCredential = $null
    }

    # Increase Maximum connections
    $servicePoint = [System.Net.ServicePointManager]::FindServicePoint($Url)
    $servicePoint.ConnectionLimit = 4

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
                $shortversion = [System.Version]$temp.Matches[0].Value.TrimEnd('.')                
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

            [OPNsenseDrive]::Url = $Url
            [OPNsenseDrive]::Credential = $Credential
            [OPNsenseDrive]::SkipCertificateCheck = [bool]::Parse($SkipCertificateCheck)

        } else {
            Throw "ERROR : Failed to get the OPNsense version of server '$Url'."
        }
    } else {
        Throw "ERROR : Could not connect to the OPNsense server '$Url' using the api credentials supplied."
    }
    return $result  | Add-ObjectDetail -TypeName 'OPNsense.Core.Version'
}