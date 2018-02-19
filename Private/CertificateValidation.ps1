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

# Save the current certificate policy
Function Get-CertificatePolicy() {
    [CmdletBinding()]
    Param()
    #  Write-Verbose [System.Net.ServicePointManager]::ServerCertificateValidationCallback
    Write-Debug $([System.Net.ServicePointManager]::CertificatePolicy.GetType()).Name
    Write-Debug ("Expect100Continue: " + $([System.Net.ServicePointManager]::Expect100Continue))
    return @{
        #    ServerCertificateValidationCallback = [System.Net.ServicePointManager]::ServerCertificateValidationCallback ;
        CertificatePolicy = [System.Net.ServicePointManager]::CertificatePolicy ;
        Expect100Continue = [System.Net.ServicePointManager]::Expect100Continue
    }
}

# Change the current certificate policy
Function Set-CertificatePolicy() {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]$CertPolicy
    )
    #[System.Net.ServicePointManager]::ServerCertificateValidationCallback = $CertPolicy.ServerCertificateValidationCallback
    [System.Net.ServicePointManager]::CertificatePolicy = $CertPolicy.CertificatePolicy
    [System.Net.ServicePointManager]::Expect100Continue = $CertPolicy.Expect100Continue
    #Write-Verbose [System.Net.ServicePointManager]::ServerCertificateValidationCallback
    Write-Debug $([System.Net.ServicePointManager]::CertificatePolicy.GetType()).Name
    Write-Debug ("Expect100Continue: " + $([System.Net.ServicePointManager]::Expect100Continue))
}

# Temporarily Disable certificate validation
Function Disable-CertificateValidation() {
    [CmdletBinding()]
    Param()
    #[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
    Try {
        [System.Net.ServicePointManager]::CertificatePolicy = New-Object OPNsenseTrustAllCertsPolicy
    }
    Catch {
        Add-Type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class OPNsenseTrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
        [System.Net.ServicePointManager]::CertificatePolicy = New-Object OPNsenseTrustAllCertsPolicy
    }
    #Write-Verbose [System.Net.ServicePointManager]::ServerCertificateValidationCallback
    Write-Debug $([System.Net.ServicePointManager]::CertificatePolicy.GetType()).Name
    [System.Net.ServicePointManager]::Expect100Continue = $false
}
