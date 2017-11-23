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

# Function that takes care of ALL the different REST api calls
Function Invoke-OPNsenseApiRestCommand {
    [CmdletBinding()]
    Param (
        [ValidateNotNullOrEmpty()]
        [String]$Uri,
        [ValidateNotNullOrEmpty()]
        [PSCredential]$Credential,
        $Json,
        $Form,
        [switch]$SkipCertificateCheck = $false
    )
    # Check if running PowerShell Core CLR or Windows PowerShell
    $PSCore = IsPSCoreEdition

    # Copy the parameters for splatting
    $ParamSplat = $PSBoundParameters
    $ParamSplat.Remove("Json") | Out-Null
    $ParamSplat.Remove("Form") | Out-Null

    # Our Custom Http Headers
    $Headers = @{}

    # Check PowerShell Edition
    if ($PSCore) {
        # PS Core knows the Basic Authentication and handles SkipCertificateCheck
        $ParamSplat.Add("Authentication","Basic") | Out-Null
    } else {
        # On Windows PowerShell only, Add Basic Authentication Header
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($Credential.Username + ":" + $credential.GetNetworkCredential().Password)
        $Headers = @{ 'Authorization' = ("Basic {0}" -f [System.Convert]::ToBase64String($bytes))}

        # We must handle SkipCertificateCheck in .NET as this Switch doesn't exist in PS Desktop
        # Workaround: Temporarily disable the built-in .NET certificate policy
        if ([bool]::Parse($SkipCertificateCheck)) {
            $CertPolicy = Get-CertificatePolicy -Verbose:$VerbosePreference
            Disable-CertificateValidation -Verbose:$VerbosePreference
        }
        [System.Net.ServicePointManager]::Expect100Continue = $false
        $ParamSplat.Remove("SkipCertificateCheck") | Out-Null
    }

    if ($Json) {
        # Convert HashTable to JSON object
        if ($Json.GetType().Name -eq "HashTable") {
            $Json = $Json | ConvertTo-Json -Depth 15   # Default Depth is 2!
            Write-Verbose "JSON Arguments: $Json"
            # Set correct Content-Type for JSON data
            $Headers.Add('Content-Type', 'application/json')
            $ParamSplat.Add('Method', 'POST')
            $ParamSplat.Add('Body', $json)
        } else {
            Throw 'JSON object should be a HashTable'
        }
    }
    else {
        # Post a web Form
        if ($Form) {
            # Output Verbose object in JSON notation, if -Verbose is specified
            $Json = $Form | ConvertTo-Json -Depth 15
            Write-Verbose "Form Arguments: $Json"
 
            $ParamSplat.Add('Method', 'POST')
            $ParamSplat.Add('Body', $form)
        }
        else {
            # Neither Json nor Post, so its a plain request
            $ParamSplat.Add('Method', 'GET') 
        }
    }

    # Write Parameters to Debug channel
    Write-Debug "Invoke-RestMethod"
    # Write Custom Headers to Debug channel
    if ($Headers.Count -gt 0) {
        $temp = $Headers | ConvertTo-Json -Compress
        Write-Debug "   -Headers : $temp"
    }
    foreach ($key in $ParamSplat.keys) {
        $val = $ParamSplat.Item($key)
        Write-Debug "   -$key : $val"
    }

    # Add Custom Headers to the custom Splat
    $ParamSplat.Add("Headers",$Headers) | Out-Null

    # Call the OPNsense Rest API using the Splatted Parameters
    Try {
        $result = Invoke-RestMethod @ParamSplat
    }
    Catch {
        $ErrorMessage = $_.Exception.Message
        Write-Error "An error Occured while contacting the OPNsense server: $ErrorMessage"
    }
    Finally {
        # Always restore the built-in .NET certificate policy on Windows PS Desktop only
        if (-Not $PSCore -And [bool]::Parse($SkipCertificateCheck)) {
            Set-CertificatePolicy $CertPolicy -Verbose:$VerbosePreference
        }
    }
    Return $Result
}

Function Invoke-OPNsenseCommand {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $true, position = 1, ParameterSetName = "Get")]
        [parameter(Mandatory = $true, position = 1, ParameterSetName = "Json")]
        [parameter(Mandatory = $true, position = 1, ParameterSetName = "Form")]
        [String]$Module,

        [parameter(Mandatory = $true, position = 2)][String]$Controller,
        [parameter(Mandatory = $true, position = 3)][String]$Command,

        [parameter(Mandatory = $true, ParameterSetName = "Json")]
        $Json,

        [parameter(Mandatory = $true, ParameterSetName = "Form")]
        $Form,

        [parameter(Mandatory = $false)]$AddProperty
    )

    if ($DebugPreference -eq "Inquire") { $DebugPreference = "Continue" }

    $timer = [Diagnostics.Stopwatch]::StartNew()
    $Credentials = $MyInvocation.MyCommand.Module.PrivateData['ApiCredentials']
    $OPNsenseApi = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi']
    $SkipCertificateCheck = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert']

    if ($OPNsenseApi) {
        $Uri = ($OPNsenseApi + '/' + $Module + '/' + $Controller + '/' + $Command)
    }
    else {
        throw "ERROR : Not connected to an OPNsense instance"
    }

    if ($Json) {
        $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -credential $Credentials -Json $Json `
            -SkipCertificateCheck:$SkipCertificateCheck -Verbose:$VerbosePreference
    } else {
        if ($Form) {
            $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -credential $Credentials -Form $Form `
                -SkipCertificateCheck:$SkipCertificateCheck -Verbose:$VerbosePreference
        } else {
            $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -credential $Credentials `
                -SkipCertificateCheck:$SkipCertificateCheck -Verbose:$VerbosePreference
        }
    }

    # The result return should be a JSON object, which is automatically parsed into an object
    # If the result is a String: Find empty labels and mark them as a space (#bug in ConvertFrom-JSON)
    if ($Result.GetType().Name -eq "String") {
        $result = $result.Replace('"":"', '" ":"')
        #$result = $result.Replace('"":(','" ":(')
        $result = $result.Replace('"":{', '" ":{')
        try {
            $result = ConvertFrom-Json $result -ErrorAction Stop
        }
        catch {
            # If ConvertTo-Json still fails return the string
        }
    }

    # Add a custom property to the output, if specified
    if ($AddProperty) {
        Write-Verbose "Adding Property:"
        if ($addProperty.GetType().Name -eq "HashTable") {
            $addProperty.keys | ForEach-Object {
                Write-Verbose ("* $_ : " + $addProperty.Item($_))
                $result |  Add-Member $_ $addProperty.Item($_)
            }
        }
    }

    $timer.stop()
    Write-Debug ($timer.elapsed.ToString() + " passed.")
    # Return the object
    return $result
}

function IsPSCoreEdition {
    Return ($PSVersionTable.PSEdition -eq 'Core')
}