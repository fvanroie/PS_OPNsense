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
    Given a list of objects with UUID property, filter based on given UUIDs, names and/or descriptions
    Return the subset of objects matching the given criteria.
#>
function Select-OPNsenseObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [AllowNull()]$InputObject,

        [parameter(Mandatory = $false)]
        [AllowEmptyCollection()][string[]]$Uuid,

        [parameter(Mandatory = $false)]
        [AllowEmptyCollection()][string[]]$Name,

        [parameter(Mandatory = $false)]
        [AllowEmptyCollection()][string[]]$Description 
    )
    
    Write-Verbose "Select:`t- UUID : $Uuid`n`t- Name : $Name`n`t- Description : $Description"
    $result = @()

    # Test if the InputObject is defined
    if (-Not $InputObject) {
        return $result
    }

    # UUID filter
    If ($Uuid) {
        # Only iterate the UUIDs requested
        $ids = $Uuid
    } else {
        # Iterate all UUIDs of the InputObject
        $ids = Get-NoteProperty $InputObject
    }

    ForEach ($id in $ids) {
        # The UUID exists in the object
        if ($InputObject.$id) {
            # Skip objects that do not satisfy the filters passed
            If (Skip-OPNsenseObject -Value $InputObject.$id.Name -Like $Name) { continue }
            If (Skip-OPNsenseObject -Value $InputObject.$id.Description -Like $Description) { continue }

            # PassThru is needed to capture the object
            $result += $InputObject.$id | Add-Member -MemberType NoteProperty -Name 'Uuid' -Value $id -PassThru
        } else {
            Write-Verbose "$id does not exist."
        }
    }

    return $result
}