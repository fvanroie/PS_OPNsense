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

# Private Function that takes care of ALL the different REST api calls
Function Invoke-OPNsenseApiRestCommand {
    [CmdletBinding()]
    Param (
        [ValidateNotNullOrEmpty()]
        [String]$Uri,
        [ValidateNotNullOrEmpty()]
        [PSCredential]$Credential,
        $Json,
        $Form,
        [System.IO.FileInfo]$OutFile,
        [Switch]$SkipCertificateCheck = $false
    )

    # Copy the parameters for splatting
    $ParamSplat = $PSBoundParameters
    $ParamSplat.Remove("Json") | Out-Null
    $ParamSplat.Remove("Form") | Out-Null

    # Our Custom Http Headers
    $Headers = @{}

    # Check PowerShell Edition
    if ($IsPSCoreEdition) {
        # PS Core knows the Basic Authentication and handles SkipCertificateCheck
        $ParamSplat.Add("Authentication", "Basic") | Out-Null
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
        } elseif ($Json.GetType().Name -eq "PSCustomObject") {
            $Json = $Json | ConvertTo-Json -Depth 15   # Default Depth is 2!
        } elseif ($Json.GetType().Name -eq "String") {
            # ALready a String
        } else {
            Throw 'JSON object should be a HashTable'
        }

        # OK, we have a $JSON string now
        Write-Verbose "JSON Arguments: $Json"
        $ParamSplat.Add('Body', $json)
        $ParamSplat.Add('ContentType', 'application/json')
        $ParamSplat.Add('Method', 'POST')
    } else {
        # Post a web Form
        if ($Form) {
            # Output object in JSON notation, if -Verbose is specified
            $Json = $Form | ConvertTo-Json -Depth 15
            Write-Verbose "Form Arguments: $Json"
 
            $ParamSplat.Add('Method', 'POST')
            $ParamSplat.Add('Body', $form)
        } else {
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
    $ParamSplat.Add("Headers", $Headers) | Out-Null

    # Call the OPNsense Rest API using the Splatted Parameters
    Try {
        $result = Invoke-RestMethod @ParamSplat
    } Catch {
        $ErrorMessage = $_.Exception.Message
        Write-Error "An error Occured while contacting the OPNsense server: $ErrorMessage"
    } Finally {
        # Always restore the built-in .NET certificate policy on Windows PS Desktop only
        if (-Not $IsPSCoreEdition -And [bool]::Parse($SkipCertificateCheck)) {
            Set-CertificatePolicy $CertPolicy -Verbose:$VerbosePreference
        }
    }
    Return $Result
}