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

# Public Function that abscracts the API calls
Function Invoke-OPNsenseFunction {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $true, position = 0)][String]$Module,
        [parameter(Mandatory = $true, position = 1)][String]$Object,
        [parameter(Mandatory = $true, position = 2)][String]$Command,
        [parameter(Mandatory = $false)][String]$Uuid
    )

    $list = $Functionmap.$Module.$Object.commands.$Command
    $splat = @{};
    $list | Get-Member -MemberType NoteProperty | ForEach-Object { $splat.add($_.name, $list.($_.name))}

    if ($uuid) {
        $splat.command = $splat.command.Replace("<uuid>", $uuid)
    }

    $result = Invoke-OPNsenseCommand @splat
    return $result
}