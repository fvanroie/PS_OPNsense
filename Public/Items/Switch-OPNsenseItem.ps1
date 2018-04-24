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

<#
    Toggles the enabled/disabled status of an OPNsense Object
    or switches it to the desired state if explicitly specified.
#>
Function Switch-OPNsenseItem {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [OutputType([Object[]])]
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]
    Param(
        [parameter(Mandatory = $true, position = 0)][String]$Module,
        [parameter(Mandatory = $true, position = 2)][String]$Object,

        [Parameter(Mandatory = $true, position = 3)]
        [AllowEmptyCollection()]
        [String[]]$Uuid,

        [Parameter(Mandatory = $false, position = 4)]
        [Boolean]$Enable,
        
        [Parameter(Mandatory = $false, position = 5)]
        [Switch]$Passthru
    )
    BEGIN {
        $results = @()
        $ObjectName = Get-OPNsenseItemType $Module $Object -Name

        # Get object list to match uuid to object name
        #$metadata = Search-OPNsenseItem $Module $Controller $Command
        $metadata = Invoke-OPNsenseFunction $Module search $Object

        if ($Enable -eq $true) {
            $Toggle = 'Enable'
            $newStatus = '1'
        } else {
            $Toggle = 'Disable'
            $newStatus = '0'
        }

    }
    PROCESS {
        foreach ($id in $Uuid) {
            #$item = $metadata | Where-Object { $_.Uuid -eq $id }
            $item = Select-OPNsenseItem -InputObject $metadata -Uuid $id

            # Check if the object was found
            if (-not $item) {
                Write-Warning ('{2} "{{{0}}}" can not be {1}d because it cannot be found.' -f $id, $Toggle.ToLower(), $ObjectName)
                Continue # with next item
            }

            # Get the current state of the object
            if ($item.enabled) {
                $currentStatus = $item.enabled
            } elseif ($item.disabled) {
                $currentStatus = 1 - $item.disabled
            } else {
                $currentStatus = $null  # Unknown
                Write-Warning "Unable to determine the status of $ObjectName"
            }

            # Only Change if needed
            if ($newStatus -ne $CurrentStatus) {
                # Request confirmation if needed
                if ($PSCmdlet.ShouldProcess(("{0} {{{1}}}" -f $item.name, $id), "$Toggle $ObjectName")) {
                    #$result = Invoke-OPNsenseCommand $Module $Controller $("toggle{0}/{1}/{2}" -f $Command.ToLower(), $id, $newStatus) -Form $Command.ToLower() -AddProperty @{ 'Uuid' = "$id"; 'Name' = "{0}" -f $item.Name }
                    $result = Invoke-OPNsenseFunction $Module "toggle" $Object -Uuid $id -Enable $Enable #-AddProperty @{ 'Uuid' = "$id"; 'Name' = "{0}" -f $item.Name }
                    if (Test-OPNsenseApiResult $result) {
                    } else {
                        Write-Warning ('Failed to {2} {3} "{0} {{{1}}}"!' -f $item.name, $id, $Toggle.ToLower(), $ObjectName)
                        Continue # with next item
                    }
                }    
            } else {
                # Already in the requested state
                Write-Verbose ('{3} "{0} {{{1}}}" is already {2}d.' -f $item.name, $id, $Toggle.ToLower(), $ObjectName)
            }

            # Successfully changed item or no change was needed, push item to the results stack
            # Note: this item still has the initial status set!
            $results += $item

        }
    }    
    END {
        if ($Passthru) {
            # Get the details of the UUIDs in the list
            return $results
        }
    }
}