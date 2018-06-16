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


Function Get-OPNsenseUpdateStatus {
    [CmdletBinding()]
    Param(
        [String]$Title = 'Busy',
        [String]$Status = 'This can take a while',
        [double]$Seconds = 0.8
    )

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
            $result = Invoke-OPNsenseCommand core firmware upgradestatus -Verbose:$false
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
                Write-Verbose ('   ' + $line)

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
            Write-Verbose ('   ' + $lines[$i])
            $start += $lines[$i].length + 1
        }
    }
    return $Result
}