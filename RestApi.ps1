# Function that takes care of ALL the different REST api calls
Function Invoke-OPNsenseApiRestCommand {
  [CmdletBinding()]
  param (
      [String]$Uri,
      [String]$Credentials,
      $Json,
      $Form,
      [switch]$AcceptCertificate=$false
  )
  Write-Verbose "OPNsense Uri: $uri"
  $BasicAuthHeader = @{ Authorization = ("Basic {0}" -f $Credentials) }

  # Temporarily disable the built-in .NET certificate policy
  if ([bool]::Parse($AcceptCertificate)) {
      $CertPolicy = Get-CertificatePolicy -Verbose:$VerbosePreference
      Disable-CertificateValidation -Verbose:$VerbosePreference
  }

  Try {
      # Post a JSON object
      if ($Json) {
          # Convert HashTable to JSON object
          if ($Json.GetType().Name -eq "HashTable") {
              $Json = $Json | ConvertTo-Json -Depth 15   # Default Depth is 2
              Write-Verbose "Api JSON Arguments: $Json"
              # Set correct Content-Type for JSON data
              $BasicAuthHeader.Add('Content-Type','application/json')
              $result = Invoke-RestMethod -Uri $uri -Method Post -Body $Json `
                            -Headers $BasicAuthHeader -Verbose:$VerbosePreference
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
              Write-Verbose "Api Form Arguments: $Json"
              $result = Invoke-RestMethod -Uri $uri -Method Post -Body $Form `
                            -Headers $BasicAuthHeader -Verbose:$VerbosePreference
          # Neither Json nor Post, so its a plain request
          } else {
              # This needs to be POST for AcceptCertificate to work properly
              # Use a POST with empty body instead of a GET, to work around bug
              # that prevents GET from working when used with -AcceptCertificate
              $result = Invoke-RestMethod -Uri $uri -Method Post -Body '' `
                            -Headers $BasicAuthHeader -Verbose:$VerbosePreference
          }
      }
  }
  Catch {
      $ErrorMessage = $_.Exception.Message
      Write-Error "An error Occured while connecting to the OPNsense server: $ErrorMessage"
  }
  # Always restore the built-in .NET certificate policy
  Finally {
      if ([bool]::Parse($AcceptCertificate)) {
          Set-CertificatePolicy $CertPolicy -Verbose:$VerbosePreference
      }
  }
  Return $Result
}

Function Invoke-OPNsenseCommand {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
        Param (
            [Parameter(Mandatory=$true,position=1)][String]$Module,
            [parameter(Mandatory=$true,position=2)][String]$Controller,
            [parameter(Mandatory=$true,position=3)][String]$Command,
            [parameter(Mandatory=$false)]$Json,
            [parameter(Mandatory=$false)]$Form,
            [parameter(Mandatory=$false)]$AddProperty
        )

    $timer = [Diagnostics.Stopwatch]::StartNew()
    $Credentials = $MyInvocation.MyCommand.Module.PrivateData['Credentials']
    $OPNsenseApi = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi']
    $AcceptCertificate = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert']

    if ($OPNsenseApi) {
        $Uri = ($OPNsenseApi + '/' + $Module + '/' + $Controller + '/' + $Command)
    } else {
        throw "ERROR : Not connected to an OPNsense instance"
    }

    if ($Json) {
        $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -credentials $Credentials -Json $Json `
                      -AcceptCertificate:$AcceptCertificate -Verbose:$VerbosePreference
    } else {
        if ($Form) {
            $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -credentials $Credentials -Form $Form `
                          -AcceptCertificate:$AcceptCertificate -Verbose:$VerbosePreference
        } else {
            $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -credentials $Credentials `
                          -AcceptCertificate:$AcceptCertificate -Verbose:$VerbosePreference
        }
    }

    # The result return should be a JSON object, which is automatically parsed into an object
    # If the result is a String: Find empty labels and mark them as a space (#bug in ConvertFrom-JSON)
    if ($Result.GetType().Name -eq "String") {
        $result = $result.Replace('"":{','" ":{') | ConvertFrom-Json
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
    Write-Verbose ($timer.elapsed.ToString() + " passed.")
    # Return the object
    return $result
}

Function Connect-OPNsense() {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    param (
        [String]$Url,
        [String]$Key,
        [String]$Secret,
        [switch]$AcceptCertificate=$false
    )

    $OPNsenseApi = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi']
    if ($OPNsenseApi) {
        Throw "ERROR : Already connected to $OPNsenseApi. Please use Disconnect-OPNsense first."
    }

    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Key + ":" + $Secret)
    $Credentials = [System.Convert]::ToBase64String($bytes)
    $uri = ($Url + '/core/firmware/info')
    $Result = Invoke-OPNsenseApiRestCommand -Uri $uri -credentials $Credentials `
                  -AcceptCertificate:$AcceptCertificate -Verbose:$VerbosePreference

    if ($Result) {
      # Validate the connection result
      if ($Result.product_version) {
          Write-Verbose ("OPNsense version : " + $Result.product_version )
          $MyInvocation.MyCommand.Module.PrivateData['Credentials'] = $Credentials
          $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'] = $Url
          $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert'] = [bool]::Parse($AcceptCertificate)
          return $Result | Select-Object -Property product_name,product_version
      } else {
        Throw 'ERROR : Failed to get the OPNsense version.'
      }
  } else {
      Throw 'ERROR : Could not connect to the OPNsense server using the credentials supplied.'
  }
}

Function Disconnect-OPNsense() {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param()
    If ($MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'] ) {
        Write-Verbose ('Disconnecting from ' + $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'])
        $MyInvocation.MyCommand.Module.PrivateData['Credentials'] = $null
        $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi'] = $null
        $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert'] = $null
    } else {
        Throw 'ERROR : You are not connected to an OPNsense server. Please use Connect-OPNsense first.'
    }
}
