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
        [Parameter(Mandatory=$true)]$CertPolicy
    )
    #[System.Net.ServicePointManager]::ServerCertificateValidationCallback = $CertPolicy.ServerCertificateValidationCallback
    [System.Net.ServicePointManager]::CertificatePolicy = $CertPolicy.CertificatePolicy
    [System.Net.ServicePointManager]::Expect100Continue = $CertPolicy.Expect100Continue
    #Write-Verbose [System.Net.ServicePointManager]::ServerCertificateValidationCallback
    Write-Debug $([System.Net.ServicePointManager]::CertificatePolicy.GetType()).Name
    Write-Debug ("Expect100Continue: " + $([System.Net.ServicePointManager]::Expect100Continue))
}

# Temporariy Disable certificate validation
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
