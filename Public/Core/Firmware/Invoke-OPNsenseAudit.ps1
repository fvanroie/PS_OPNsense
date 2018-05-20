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


# Performs pkg audit -F
# FreeBSD registers vulnerabilities for its packages and this command visualizes the security issues found.
Function Invoke-OPNsenseAudit {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param(
        [Switch]$Raw
    )
    $result = Invoke-OPNsenseCommand core firmware audit -Form audit -Verbose:$VerbosePreference

    if ($result.status -eq 'ok') {
        $log = Get-OPNsenseUpdateStatus -Title "Running Audit in OPNsense:" -Verbose:$VerbosePreference

        # Raw Output
        if ([bool]::Parse($Raw)) { Return $log }

        # Parse Output
        $AuditPattern = '(?i)(.*):\n(.*)\n((CVE: .*\n)*)WWW: (.*)\n\n'
        $cves = Select-String -InputObject $log -Pattern $AuditPattern -AllMatches
        $result = @()
        foreach ($cve in $cves.matches) {
            $cvenrs = Select-String -InputObject $cve.groups[3].value -Pattern 'CVE: (.*)' -AllMatches | Select-Object -expand matches | ForEach-Object { $_.groups[1].value }
            $argHash = @{
                CVE   = $cvenrs;
                Issue = $cve.groups[1].value -join ',';
                Title = $cve.groups[2].value;
                Url   = $cve.groups[5].value
            }
            $result += New-Object PSObject -Property $argHash
        }
    } else {
        Write-Error "Failed to audit OPNsense"
    }
    return $result | Add-ObjectDetail -TypeName 'OPNsense.Firmware.Audit'
}