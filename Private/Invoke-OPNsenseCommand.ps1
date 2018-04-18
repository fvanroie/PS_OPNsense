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

# Public Function that abscracts the API calls
Function Invoke-OPNsenseCommand {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
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
        [parameter(Mandatory = $false)][System.IO.FileInfo]$OutFile,

        [parameter(Mandatory = $false)][String[]]$Property,

        [parameter(Mandatory = $false)][HashTable]$AddProperty
    )

    if ($DebugPreference -eq "Inquire") { $DebugPreference = "Continue" }

    #$timer = [Diagnostics.Stopwatch]::StartNew()
    $Credentials = $MyInvocation.MyCommand.Module.PrivateData['ApiCredentials']
    $OPNsenseApi = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseApi']
    $SkipCertificateCheck = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert']

    if ($OPNsenseApi) {
        $Uri = ($OPNsenseApi + '/' + $Module + '/' + $Controller + '/' + $Command)
    } else {
        throw "ERROR : Not connected to an OPNsense instance"
    }

    try {
        if ($Json) {
            $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -credential $Credentials -Json $Json `
                -SkipCertificateCheck:$SkipCertificateCheck -Verbose:$VerbosePreference `
                -ErrorAction Stop
        } else {
            if ($Form) {
                $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -credential $Credentials -Form $Form `
                    -SkipCertificateCheck:$SkipCertificateCheck -Verbose:$VerbosePreference `
                    -ErrorAction Stop -OutFile $OutFile
            } else {
                $Result = Invoke-OPNsenseApiRestCommand -Uri $Uri -credential $Credentials `
                    -SkipCertificateCheck:$SkipCertificateCheck -Verbose:$VerbosePreference `
                    -ErrorAction Stop
            }
        }
    } catch [Microsoft.PowerShell.Commands.WriteErrorException] {
        Throw $_.Exception.Message
    } catch {
        Throw 'API returned an UNKNOWN error: ' + $_.Exception.Message
    }

    # File was saved file to disk
    If ($OutFile) {
        return
    }

    # The result returned should be a JSON object, which is automatically parsed into an object
    # If the result is a String: Find empty labels and mark them as a space (#bug in ConvertFrom-JSON)
    if ($result) {
        if ($Result.GetType().Name -eq "String") {
            $result = $result.Replace('"":"', '" ":"')
            #$result = $result.Replace('"":(','" ":(')
            $result = $result.Replace('"":{', '" ":{')
            try {
                $result = ConvertFrom-Json $result -ErrorAction Stop
            } catch {
                # If ConvertTo-Json still fails return the String already in $result by default
            }
        }

        # Drill down to the requested property level
        foreach ($prop in $Property) {
            if ($prop -in (Get-NoteProperty $result)) {
                $result = Select-Object -InputObject $result -ExpandProperty $prop       
            } else {
                Throw "$prop is an invalid property for object $Module/$Controller/$Command"
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
    }

    #$CurrentTime = $Timer.Elapsed
    #write-Debug $([string]::Format("Time passed: {0:d2}h {1:d2}m {2:d2}.{3:d3}s",
    #        $CurrentTime.hours, 
    #        $CurrentTime.minutes, 
    #        $CurrentTime.seconds,
    #        $CurrentTime.milliseconds))
    #$Timer.stop()
    
    # Return the object
    return $result
}