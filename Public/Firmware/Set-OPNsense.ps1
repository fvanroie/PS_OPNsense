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


Function Set-OPNsense {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false, ParameterSetName = "FirmwareOptions")]
        [String]$Mirror,
        [parameter(Mandatory = $false, ParameterSetName = "FirmwareOptions")]
        [String]$Flavour,
        [parameter(Mandatory = $false, ParameterSetName = "FirmwareOptions")]
        [String]$Subscription
    )

    $changed = 0
    $FirmwareOptions = Invoke-OPNsenseCommand core firmware getFirmwareConfig -AddProperty @{ Subscription = '' }
    if ($PSBoundParameters.ContainsKey('Mirror')) {
        $changed++
        $FirmwareOptions.Mirror = $Mirror
    }
    if ($PSBoundParameters.ContainsKey('Flavour')) {
        $changed++
        $FirmwareOptions.Flavour = $Flavour
    }
    if ($PSBoundParameters.ContainsKey('Subscription')) {
        $changed++
        $FirmwareOptions.Subscription = $Subscription
    }

    if ($changed -gt 0) {
        Write-Verbose "$changed setting(s) have changed"
        $result = Invoke-OPNsenseCommand core firmware setFirmwareConfig `
            -Json @{ mirror = $FirmwareOptions.Mirror; flavour = $FirmwareOptions.Flavour; subscription = $FirmwareOptions.Subscription }
        if ($Result.status -eq 'ok') {
            return $FirmwareOptions | Add-ObjectDetail -TypeName 'OPNsense.Firmware.Options'
        } else {
            Throw 'Failed to set the firmware options.'
        }
    } else {
        Write-Warning 'No settings have changed, skipping.'
        return $FirmwareOptions | Add-ObjectDetail -TypeName 'OPNsense.Firmware.Options'
    }
}
