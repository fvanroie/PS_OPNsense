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

Function Get-OPNsenseCronJob {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $false, position = 1)][String]$uuid
    )
    if ($uuid) {
        $job = Invoke-OPNsenseCommand cron settings "getjob/$uuid"
        if ($job) {
            $result = $job | Select-Object -ExpandProperty Job

            $commandlist = $result.command | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
            $commanddesc = ''
            foreach ($command in $commandlist) {
                if ($result.command.$command.Selected -eq 1) {
                    $commanddesc += $result.command.$command.Value
                }
            }
            $result.command = $commanddesc

            Add-Member 'uuid' $uuid -InputObject $result
        } else {
            Write-Error "Unable to get CronJob $uuid"
            return
        }

    } else {
        $result = $(Invoke-OPNsenseCommand cron settings searchjobs).rows
    }
    return $result  | Add-ObjectDetail -TypeName 'OPNsense.Service.Cron.Job'
}

# Private helper function
Function ToggleOPNsenseCronJob {
    param (
        [Parameter(Mandatory = $true, position = 1)][String]$uuid
    )
    $result = Invoke-OPNsenseCommand cron settings "togglejob/$uuid" -Form toggle
    return $result
}

Function New-OPNsenseCronJob {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $true, position = 1)][String]$uuid,
        [Parameter(Mandatory = $true, position = 2)]
        [ValidateSet('True', 'False', '0', '1', $true, $false)]
        $enabled
    )

    $job = Get-OPNsenseCronJob -Id $uuid
    if ($job.enabled -ne $enabled) {
        $result = ToggleOPNsenseCronJob -id $uuid
    }
    return Get-OPNsenseCronJob -uuid $uuid
}

Function Set-OPNsenseCronJob {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory = $true, position = 1)][String]$uuid,
        [Parameter(Mandatory = $true, position = 2)]
        [ValidateSet('True', 'False', '0', '1', $true, $false)]
        $enabled
    )

    $job = Get-OPNsenseCronJob -uuid $uuid
    if ([System.Convert]::ToBoolean($job.enabled) -ne [System.Convert]::ToBoolean($Enabled)) {
        $result = ToggleOPNsenseCronJob -uuid $uuid
    }
    return Get-OPNsenseCronJob -uuid $uuid
}
