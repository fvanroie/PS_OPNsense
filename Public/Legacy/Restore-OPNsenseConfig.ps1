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
Function Restore-OPNsenseConfig {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]
    Param (
        [parameter(Mandatory = $true, position = 1, ParameterSetName = "XML")]
        [ValidateNotNullOrEmpty()]
        [String]$Xml,

        [parameter(Mandatory = $true, position = 1, ParameterSetName = "File")]
        [ValidateScript( {
                if (-Not ($_ | Test-Path) ) {
                    throw "File does not exist"
                }
                if (-Not ($_ | Test-Path -PathType Leaf) ) {
                    throw "The Path argument must be a file. Folders are not allowed."
                }
                if ($_ -notmatch "(\.xml)") {
                    throw "The file specified in the path argument must be of type xml."
                }
                return $true
            })]
        [System.IO.FileInfo]$Path,

        [ValidateNotNullOrEmpty()]
        [parameter(Mandatory = $false)]
        [SecureString]$Password
    )

    if ($DebugPreference -eq "Inquire") { $DebugPreference = "Continue" }

    # Check Parameters
    $decrypt = if ($PSBoundParameters.ContainsKey('Password')) { $true } else { $false }
    if ($PSBoundParameters.ContainsKey('Path')) {
        $xml = Get-Content -Path $Path -ErrorAction Stop -Raw
    }

    #Content validation

    $SkipCertificateCheck = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert']
    $Credential = $MyInvocation.MyCommand.Module.PrivateData['WebCredentials']
    $Uri = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseUri']

    $boundary = [guid]::NewGuid().ToString()
    $bodyXML = @'
--{0}
Content-Disposition: form-data; name="{1}"; filename="{2}"
Content-Type: text/xml

{3}
--{0}--
'@
    $bodytempl = @'
--{0}
Content-Disposition: form-data; name="{1}"

{2}

'@

    $SkipCertificateCheck = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseSkipCert']
    $Credential = $MyInvocation.MyCommand.Module.PrivateData['WebCredentials']
    $Uri = $MyInvocation.MyCommand.Module.PrivateData['OPNsenseUri']

    if (-not $Credential) {
        Throw "No web password has been set."
    }

    if (-Not $PSCmdlet.ShouldProcess($Uri, "Restore OPNsense configuration")) {
        Write-Warning 'Aborting Restore-OPNsenseConfig'
        Return
    }

    if ($PSVersionTable.PSEdition -ne 'Core' -And [bool]::Parse($SkipCertificateCheck)) {
        $CertPolicy = Get-CertificatePolicy -Verbose:$VerbosePreference
        Disable-CertificateValidation -Verbose:$VerbosePreference
    }

    Try {
        $webpage = Invoke-WebRequest -Uri $Uri -SessionVariable cookieJar
        $xssToken = $webpage.InputFields | Where-Object { $_.type -eq 'hidden'}

        $form = @{
            $xssToken.name = $xssToken.value;
            usernamefld = $Credential.Username;
            passwordfld = $Credential.GetNetworkCredential().Password;
            login = 1
        }
        $webpage = Invoke-WebRequest -Uri "$Uri/index.php" -WebSession $cookieJar -Method POST -Body $form
        # check logged in
        if ($webpage.ParsedHtml.title -eq 'Login') {
            Throw 'Unable to login to the OPNsense server'
        }

        $webpage = Invoke-WebRequest -Uri "$Uri/diag_backup.php" -WebSession $cookieJar
        $xssToken = $webpage.InputFields | Where-Object { $_.type -eq 'hidden'}

        $form = @{
            $xssToken[0].name = $xssToken[0].value ;
            restorearea = '' ;
            rebootafterrestore = 'checked';
            decrypt = if ($decrypt) { 'on' } else { '' };
            decrypt_password = if ($decrypt) { $Password.GetNetworkCredential().Password } else { '' };
            decrypt_passconf = if ($decrypt) { $Password.GetNetworkCredential().Password } else { '' };
            restore = "Restore configuration"
        }

        $body = ""
        $form.Keys | ForEach-Object {
            $body += $bodytempl -f $boundary, $_, $form.Item($_)
        }
        $body += $bodyXML -f $boundary, 'conffile', 'config.xml', $xml
        Write-Verbose $body
        $restorexml = Invoke-WebRequest "$Uri/diag_backup.php" -WebSession $cookieJar -Method POST -Body $body -ContentType "multipart/form-data; boundary=$boundary"
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

    try {
        if ($restorexml.parsedhtml.body.getElementsbyclassname('alert-danger').length -gt 0) {
            $err = $restorexml.parsedhtml.body.getElementsbyclassname('alert-danger')[0].innerText
            $err = ($err.split("`n") | Select-Object -Skip 1) -join "`n+ "
            Write-Error $err
            Return
        }
        if ($restorexml.parsedhtml.body.getElementsbyclassname('alert-info').length -gt 0) {
            $result = $restorexml.parsedhtml.body.getElementsbyclassname('alert-info')[0].innerText
        } else {
            $Result = $restorexml.parsedhtml.body.getElementsbyclassname('alert')[0].innerText
        }
    } catch {
        $result = $restorexml
    }
    Return $Result
}