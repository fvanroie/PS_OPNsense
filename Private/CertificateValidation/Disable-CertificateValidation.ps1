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

# Temporarily Disable certificate validation
Function Disable-CertificateValidation() {
    [CmdletBinding()]
    Param()
    #[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
    Try {
        [System.Net.ServicePointManager]::CertificatePolicy = New-Object -TypeName 'OPNsense.Policy.TrustAllCerts'
    } Catch {
        Add-Type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    namespace OPNsense.Policy {
        public class TrustAllCerts : ICertificatePolicy {
            public bool CheckValidationResult(
                ServicePoint srvPoint, X509Certificate certificate,
                WebRequest request, int certificateProblem) {
                return true;
            }
        }
    }
"@
        [System.Net.ServicePointManager]::CertificatePolicy = New-Object -TypeName 'OPNsense.Policy.TrustAllCerts'
    }
    #Write-Verbose [System.Net.ServicePointManager]::ServerCertificateValidationCallback
    Write-Debug $([System.Net.ServicePointManager]::CertificatePolicy.GetType()).Name
    [System.Net.ServicePointManager]::Expect100Continue = $false
}
