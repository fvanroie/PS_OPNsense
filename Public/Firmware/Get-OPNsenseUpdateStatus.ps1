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

Function New-HttpClientHelper {
    param (
        [string]$uri ,
        $key = '/DIgoRS//BlEy/ja0uD3plAAM3lMdV4pyDZ8dCHMZaGl2Q3M3lorvDDob8F3dJmS0nvqcIuRMWrgTHYd',
        $secret = 'oLUek7OBDlLdopSwNjFJ7W+UMvhK5MyLqAOBB5PaDrmFPWPZWxOTOghdILBmB2LDw894dhn4sugJnmnY'
    )

    Add-Type -AssemblyName System.Net.Http
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($key + ":" + $secret)

    $httpClientHandler = New-Object System.Net.Http.HttpClientHandler
    $networkCredential = New-Object System.Net.NetworkCredential @($key, $secret)
    $httpClientHandler.Credentials = $networkCredential

    $client = New-Object System.Net.Http.Httpclient $httpClientHandler

    [Net.ServicePointManager]::DnsRefreshTimeout = 1000
    [Net.ServicePointManager]::FindServicePoint($uri).ConnectionLeaseTimeout = 1000
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    [System.Net.ServicePointManager]::Expect100Continue = $false

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

    $client.DefaultRequestHeaders.Add("Authorization", ("Basic {0}" -f [System.Convert]::ToBase64String($bytes)) )
    return $client
}

Function Get-HttpClientStringASync {
    param (
        [System.Net.Http.Httpclient]$client,
        [string]$uri
    )

    # Get the web content.
    $task = $client.GetStringAsync($uri)

    # Wait for the async call to finish
    $task.wait(15000)

    # Use the result
    if ($task.IsCompleted) {
        return $task.GetAwaiter().GetResult() | ConvertFrom-json
    } else {
        Write-Warning ("Something went wrong: " + $task.Exception)
    }
}

Function Get-OPNsenseUpdateStatus {
    [CmdletBinding()]
    Param(
        [String]$Title = 'Busy',
        [String]$Status = 'This can take a while',
        [double]$Seconds = 1
    )

    $uri = "https://10.1.0.169/api/core/firmware/upgradestatus"
    $client = New-HttpClientHelper -uri $uri

    # Progress status
    $start = 0              # Characters received
    $done = 0               # Iterations done
    $todo = 0               # Iterations todo
    $reties = 0             # Connection retry
    $elipsis = ''
    $msg = 'One moment please'

    $ProgressSplat = @{
        'Activity'         = $Title
        'Status'           = $Status
        'CurrentOperation' = 'One moment please'
    }

    Write-Verbose ''
    Write-Verbose 'This can take a while...'
    Write-Verbose ''

    Do {
        try {
            # TO DO : Check why sometimes Invoke-RestMethod takes 110 seconds to complete
            Write-Debug 'Getting Firmware Upgrade Status ...'
            #$prevLimit = [System.Net.ServicePointManager]::DefaultConnectionLimit
            #[System.Net.ServicePointManager]::DefaultConnectionLimit = 1024
            #$result = Invoke-OPNsenseCommand core firmware upgradestatus -Verbose:$false
            #[System.Net.ServicePointManager]::DefaultConnectionLimit = $prevLimit
            $result = Get-HttpClientStringASync -client $client -Uri $uri
            Write-Debug ('Firmware Upgrade Status : {0}' -f $result.status)
            $retries = 0
        } catch {
            $retries += 1
            if ($retries -gt 4) {
                Write-Warning "Retries : $reties"
                break
            }
        }

        # Write-Verbose buffer, starting where we left off the previous itteration
        if ($result.log.length -ge $start) {
            $log = $result.log.substring($start)
            $lines = $log.Split("`n")
            
            if ($elipsis -in '', ' ') {
                $elipsis += ' '
            } else {
                $elipsis = $elipsis.trim() + '.'
            }

            # Write-Verbose buffer, except last line as it can be incomplete
            for ($i = 1; $i -lt $lines.length; $i++) {
                $elipsis = ''
                $start += $lines[$i - 1].length + 1
                $line = $lines[$i - 1]
                Write-Verbose ([System.Web.HttpUtility]::HtmlDecode('   ' + $line))

                if ($line -match '! (.*) !') {
                    $ProgressSplat.Status = $matches[1]
                    continue # with next line
                }

                # Check for progress marker [xx/yy] Completed...
                if ($line -match '\[([0-9]+)/([0-9]+)\] (.*)\.+\.\. ?( done)?') {
                    # Save matches because the next check overwrites it
                    $m = $matches

                    # Check for progress marker is: [xx/yy] Extracting or Deleting: ... (skip these lines as they are duplicates)
                    if ($line -match '\[([0-9]+)/([0-9]+)\] (Extracting|Deleting) .*: \.\.\.') {
                        continue # without updating Progress
                    }

                    # in an iterative loop, show progressbar and progress text
                    $done = $m[1]
                    $todo = $m[2]
                    $msg = $m[3].trimend('.').trimend(' ').trimend(':')

                } else {

                    if ($done -eq $todo) {
                        # not in a loop anymore, clear progressbar
                        $todo = 0
                        $done = 0
                        # Update progress text
                        if ($line -match '^([A-Z].*)\.*\.') {
                            $msg = $matches[1].trimend('.').trimend(' ').trimend(':')
                        }
                    }

                }
            }

            # Update Splat
            if ([int16]$todo -gt 0) {
                $complete = [Math]::Round([int16]$done * 100 / [Int16]$todo)
                if ($ProgressSplat.PercentComplete) {
                    $ProgressSplat.PercentComplete = $complete
                } else {
                    $ProgressSplat.add('PercentComplete', $complete)
                }
            } else {
                $ProgressSplat.remove('PercentComplete')                        
            }
            $ProgressSplat.CurrentOperation = '{0} {1}' -f $msg.trim(), $elipsis.trim()
            if ($elipsis -eq '.....') {
                $elipsis = ' '
            }

            Write-Progress @ProgressSplat
        }

        # Sleep if still running
        if ($result.status -eq 'running') {
            Start-Sleep -Seconds $Seconds
        } elseif ($result.status -eq 'error' -or $result.status -eq 'failed') {
            $retries += 1
            Write-Warning ("Unexpected Error encountered: {0}" -f $result.status)
        }
        
    } Until ($result.status -eq 'reboot' -or $result.status -eq 'done')

    # Write-Verbose remaining Buffer
    if ($result.log.length -ge $start) {

        $log = $result.log.substring($start)
        $lines = $log.Split("`n")

        # Write-Verbose buffer, including last line as it is complete
        for ($i = 0; $i -lt $lines.length; $i++) {
            Write-Verbose ([System.Web.HttpUtility]::HtmlDecode('   ' + $lines[$i]))
            $start += $lines[$i].length + 1
        }
    }
    Write-Verbose ($result.status)
    return $Result
}