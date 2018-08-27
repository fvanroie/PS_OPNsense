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
    Enable, Disable, Switch or Remove
#>

Function Invoke-OPNsenseItem {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [OutputType([Object[]])]
    [CmdletBinding(
    )]
    Param(
        [PSObject]$Call,
        [PSObject]$InputObject,
        [Switch]$PassThru,
        [String]$Verb,
        [parameter(Mandatory = $false)][Boolean]$Enabled
    )
    # Check if an api command was found for this TypeName
    if (!$Call) {
        Write-Warning ("Unable to {0} object of type {1}" -f $Verb.toLower(), $Obj.gettype().FullName)
        Return
    } # no call

    # The OPNsense Object needs a UUID property
    if (!$InputObject.UUID) {
        Write-Warning ("Unable to {0} object {1}. No UUID found." -f $Verb.toLower(), $Call.Object)
        Return
    } # no uuid

    # Be Verbose about this action
    Write-Verbose ("{0} {1} with UUID {{{2}}}" -f $Verb, $Call.Object, $InputObject.UUID)

    # Execute the api call
    $Splat = @{
        'Module' = $Call.Module
        'Action' = $Call.Action
        'Object' = $Call.Object
        'Uuid'   = $InputObject.UUID
    }
    if ($PSBoundParameters.ContainsKey('Enabled')) {
        $Splat.Add('Enabled', $Enabled)
    }
    if ($Verb -eq 'set') {
        $body = @{}
        $body[$Call.Object.toLower()] = ConvertTo-OPNsenseItem $InputObject #| Select-Object -ExcludeProperty 'Uuid'
        $Splat.Add('Body', $body)
    }

    $Result = Invoke-OPNsenseOpenApiPath @Splat

    if (-Not (Test-OPnsenseApiResult $Result)) {
        Write-Warning ("Failed to {0} {1} {{{2}}}" -f $Verb.toLower(), $Call.Object, $InputObject.UUID)
        Continue # With next object
    }

    # Also Output results
    if ($PassThru) {
        if ($Verb -ne 'Remove') {
            Invoke-OPNsenseOpenApiPath -Module $Call.Module -Action 'get' -Object $Call.Object -Uuid $InputObject.UUID
        } else {
            $InputObject
        }
    } # PassThru
}