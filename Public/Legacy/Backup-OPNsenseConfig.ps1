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

Function Backup-OPNsenseConfig {
    # .EXTERNALHELP ../../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param (
        [switch]$RRDdata = $false,

        [ValidateNotNullOrEmpty()]
        [parameter(Mandatory = $false)]
        [SecureString]$Password
    )

    if ($DebugPreference -eq "Inquire") { $DebugPreference = "Continue" }

    $SkipCertificateCheck = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert']
    $Credential = $MyInvocation.MyCommand.Module.PrivateData['WebCredentials']
    $Uri = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseUri']

    if (-not $Credential) {
        Throw "No web password has been set."
    }

    if ($PSBoundParameters.ContainsKey('Password')) {
        $encrypt = $true
    } else {
        $encrypt = $false
    }

    if ($PSVersionTable.PSEdition -ne 'Core' -And [bool]::Parse($SkipCertificateCheck)) {
        $CertPolicy = Get-CertificatePolicy -Verbose:$VerbosePreference
        Disable-CertificateValidation -Verbose:$VerbosePreference
    }

    Try {
        if ($PSVersionTable.PSEdition -eq 'Core') {
            $webpage = Invoke-WebRequest -Uri $Uri -SessionVariable cookieJar -SkipCertificateCheck:$SkipCertificateCheck
        } else {
            $webpage = Invoke-WebRequest -Uri $Uri -SessionVariable cookieJar
        }

        $xssToken = $webpage.InputFields | Where-Object { $_.type -eq 'hidden'}
        $form = @{
            $xssToken.name = $xssToken.value;
            usernamefld = $Credential.Username;
            passwordfld = $Credential.GetNetworkCredential().Password;
            login = 1
        }
        if ($PSVersionTable.PSEdition -eq 'Core') {
            $webpage = Invoke-WebRequest -Uri "$Uri/index.php" -WebSession $cookieJar -Method POST -Body $form -SkipCertificateCheck:$SkipCertificateCheck
        } else {
            $webpage = Invoke-WebRequest -Uri "$Uri/index.php" -WebSession $cookieJar -Method POST -Body $form
        }

        # check logged in
        if ($webpage.ParsedHtml.title -eq 'Login') {
            Throw 'Unable to login to the OPNsense Web GUI. Make sure the WebCredential parameter is set and correct.'
        }

        if ($PSVersionTable.PSEdition -eq 'Core') {
            $webpage = Invoke-WebRequest -Uri "$Uri/diag_backup.php" -WebSession $cookieJar -Method POST -Body $form -SkipCertificateCheck:$SkipCertificateCheck
        } else {
            $webpage = Invoke-WebRequest -Uri "$Uri/diag_backup.php" -WebSession $cookieJar -Method POST -Body $form
        }
        $xssToken = $webpage.InputFields | Where-Object { $_.type -eq 'hidden'}

        $form = @{
            $xssToken[0].name = $xssToken[0].value ;
            donotbackuprrd = if ([bool]::Parse($RRDdata)) { '' } else { 'on' } ;
            encrypt = if ($encrypt) { 'on' } else { '' };
            encrypt_password = if ($encrypt) { $Password.GetNetworkCredential().Password } else { '' };
            encrypt_passconf = if ($encrypt) { $Password.GetNetworkCredential().Password } else { '' };
            download = "Download configuration"
        }
        if ($PSVersionTable.PSEdition -eq 'Core') {
            $backupxml = Invoke-WebRequest "$Uri/diag_backup.php" -WebSession $cookieJar -Method POST -Body $form -SkipCertificateCheck:$SkipCertificateCheck
        } else {
            $backupxml = Invoke-WebRequest "$Uri/diag_backup.php" -WebSession $cookieJar -Method POST -Body $form
        }
        $Result = $backupxml.RawContent.Substring($backupxml.RawContent.Length - $backupxml.RawContentLength, $backupxml.RawContentLength)
    } Catch {
        $ErrorMessage = $_.Exception.Message
        Write-Error "An error Occured while connecting to the OPNsense server: $ErrorMessage"
    }
    # Always restore the built-in .NET certificate policy
    Finally {
        if ($PSVersionTable.PSEdition -ne 'Core' -And [bool]::Parse($SkipCertificateCheck)) {
            Set-CertificatePolicy $CertPolicy -Verbose:$VerbosePreference
        }
    }
    Return $Result
}