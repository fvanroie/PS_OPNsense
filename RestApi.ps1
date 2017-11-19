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
      [switch]$SkipCertificateCheck=$false
  )
  $Headers = @{}

  # Check if running PowerShell Core CLR or Windows PowerShell
  $PSCore = Is-PSCoreEdition

  # Windows PowerShell only
  if (-Not $PSCore) {
      $bytes = [System.Text.Encoding]::UTF8.GetBytes($Credential.Username + ":" + $credential.GetNetworkCredential().Password)
      $Headers = @{ 'Authorization' = ("Basic {0}" -f [System.Convert]::ToBase64String($bytes))}

      # Temporarily disable the built-in .NET certificate policy
      if ([bool]::Parse($SkipCertificateCheck)) {
          $CertPolicy = Get-CertificatePolicy -Verbose:$VerbosePreference
          Disable-CertificateValidation -Verbose:$VerbosePreference
      }
  }

  # Call the OPNsense Rest API
  Try {
      # Post a JSON object
      if ($Json) {
          # Convert HashTable to JSON object
          if ($Json.GetType().Name -eq "HashTable") {
              $Json = $Json | ConvertTo-Json -Depth 15   # Default Depth is 2
              Write-Verbose "JSON Arguments: $Json"
              # Set correct Content-Type for JSON data
              $Headers.Add('Content-Type','application/json')
              if ($PSCore) {
                  $result = Invoke-RestMethod -Uri $uri -Method 'Post' -Body $Json `
                                      -Authentication 'Basic' -Credential $Credential -Headers $Headers `
                                      -SkipCertificateCheck:$SkipCertificateCheck
              } else {
                  [System.Net.ServicePointManager]::Expect100Continue = $false
                  $result = Invoke-RestMethod -Uri $uri -Method Post -Body $Json -Headers $Headers
              }
          } else {
              Throw 'JSON object should be a HashTable'
              #$result = Invoke-RestMethod -Uri $uri -Method Post -Body $Json `
              #             -Headers $BasicAuthHeader -Verbose:$VerbosePreference
          }
      } else {
          # Post a web Form
          if ($Form) {
              # Output Verbose object in JSON notation, if -Verbose is specified
              $Json = $Form | ConvertTo-Json -Depth 15
              Write-Verbose "Form Arguments: $Json"
              if ($PSCore) {
                  $result = Invoke-RestMethod -Uri $uri -Method 'Post' -Body $Form `
                                      -Authentication 'Basic' -Credential $Credential -Headers $Headers `
                                      -SkipCertificateCheck:$SkipCertificateCheck
              } else {
                  [System.Net.ServicePointManager]::Expect100Continue = $false
                  $result = Invoke-RestMethod -Uri $uri -Method Post -Body $Form -Headers $Headers
              }
          # Neither Json nor Post, so its a plain request
          } else {
              if ($PSCore) {
                  $result = Invoke-RestMethod -Uri $uri -Method 'Get' `
                                    -Authentication 'Basic' -Credential $Credential -Headers $Headers `
                                    -SkipCertificateCheck:$SkipCertificateCheck
              } else {
                  # This needs to be POST for SkipCertificateCheck to work properly in PS Desktop
                  # Use a POST with empty body instead of a GET, to work around bug
                  # that prevents GET from working when used with -SkipCertificateCheck

                  # Reverted back to GET method, seems OK
                  [System.Net.ServicePointManager]::Expect100Continue = $false
                  $result = Invoke-RestMethod -Uri $uri -Method Get -Headers $Headers
              }
          }
      }
  }
  Catch {
      $ErrorMessage = $_.Exception.Message
      Write-Error "An error Occured while connecting to the OPNsense server: $ErrorMessage"
  }
  Finally {
      # Always restore the built-in .NET certificate policy on Windows PowerShell only
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
        [parameter(Mandatory=$true,position=1,ParameterSetName = "Get")]
        [parameter(Mandatory=$true,position=1,ParameterSetName = "Json")]
        [parameter(Mandatory=$true,position=1,ParameterSetName = "Form")]
        [String]$Module,

        [parameter(Mandatory=$true,position=2)][String]$Controller,
        [parameter(Mandatory=$true,position=3)][String]$Command,

        [parameter(Mandatory=$true,ParameterSetName = "Json")]
        $Json,

        [parameter(Mandatory=$true,ParameterSetName = "Form")]
        $Form,

        [parameter(Mandatory=$false)]$AddProperty
    )

    if ($DebugPreference -eq "Inquire") { $DebugPreference = "Continue" }

    $timer = [Diagnostics.Stopwatch]::StartNew()
    $Credentials = $MyInvocation.MyCommand.Module.PrivateData['ApiCredentials']
    $OPNsenseApi = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi']
    $SkipCertificateCheck = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert']

    if ($OPNsenseApi) {
        $Uri = ($OPNsenseApi + '/' + $Module + '/' + $Controller + '/' + $Command)
    } else {
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
        $result = $result.Replace('"":"','" ":"')
        #$result = $result.Replace('"":(','" ":(')
        $result = $result.Replace('"":{','" ":{')
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

Function Connect-OPNsense() {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true,position=1,ParameterSetName = "Modern")]
        [parameter(Mandatory=$true,position=1,ParameterSetName = "Legacy")]
        [ValidateNotNullOrEmpty()]
        [String]$Url,

        [parameter(Mandatory=$true,position=2,ParameterSetName = "Modern")]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty,

        [parameter(Mandatory=$true,position=2,ParameterSetName = "Legacy")]
        [ValidateNotNullOrEmpty()]
        [String]$Key,

        [parameter(Mandatory=$true,position=3,ParameterSetName = "Legacy")]
        [ValidateNotNullOrEmpty()]
        [String]$Secret,

        [parameter(Mandatory=$false,position=3,ParameterSetName = "Modern")]
        [parameter(Mandatory=$false,position=4,ParameterSetName = "Legacy")]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $WebCredential = [System.Management.Automation.PSCredential]::Empty,

        [parameter(Mandatory=$false,position=4,ParameterSetName = "Modern")]
        [parameter(Mandatory=$false,position=5,ParameterSetName = "Legacy")]
        [switch]$SkipCertificateCheck=$false
    )

    $OPNsenseApi = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi']
    if ($OPNsenseApi) {
        Throw "ERROR : Already connected to $OPNsenseApi. Please use Disconnect-OPNsense first."
    }

    #$bytes = [System.Text.Encoding]::UTF8.GetBytes($Key + ":" + $Secret)
    #$Credentials = [System.Convert]::ToBase64String($bytes)
    if ($PSBoundParameters.ContainsKey('Secret')) {
        $SecurePassword = $Secret | ConvertTo-SecureString -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $Key, $SecurePassword
    }
    if ($PSBoundParameters.ContainsKey('Password')) {
        $SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
        $WebCredential = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $SecurePassword
    } else {
        if (-Not $PSBoundParameters.ContainsKey('WebCredential')) {
            $WebCredential = $null
        }
    }
    $Uri = ($Url + '/api/core/firmware/info')
    $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -Credential $Credential `
                  -SkipCertificateCheck:$SkipCertificateCheck -Verbose:$VerbosePreference

    if ($Result) {
      # Validate the connection result
      if ($Result.product_version) {
          Write-Verbose ("OPNsense version : " + $Result.product_version )
          $MyInvocation.MyCommand.Module.PrivateData['ApiCredentials'] = $Credential
          $MyInvocation.MyCommand.Module.PrivateData['WebCredentials'] = $WebCredential
          $MyInvocation.MyCommand.Module.PrivateData['OPNsenseUri'] = $Url
          $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'] = "$Url/api"
          $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert'] = [bool]::Parse($SkipCertificateCheck)
          return $Result | Select-Object -Property product_name,product_version
      } else {
        Throw "ERROR : Failed to get the OPNsense version of server '$Url'."
      }
  } else {
      Throw "ERROR : Could not connect to the OPNsense server '$Url' using the credentials supplied."
  }
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

function Is-PSCoreEdition {
    Return ($PSVersionTable.PSEdition -eq 'Core')
}
