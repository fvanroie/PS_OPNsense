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


# Custom function with additional test that the TypeName can/should be created
Function Import-Type {
    [CmdletBinding()]
    Param(
        [System.IO.FileInfo]$Path,
        [String[]]$TypeName
    )

    # Check Module Debug Variable
    if (-not $Debug) {
        try {
            # In production, check if the TypeName already exists. Only Add TypeDefinition when needed
            New-Object $Path.basename | Out-Null
            # Object creation succeeded, no need to add the Type again
            return
        } catch {
            # Failed to load the type, it does not exist yet so go ahead and add the TypeDefinition
        }
    } else {
        # In debug, always load the new TypeDefinition
    }

    # Call Add-Type with Path to the definition file
    $Type = Add-Type -Path $Path.fullname -PassThru

    # Test the TypeName(s) are available
    foreach ($name in $typename) {
        Try {
            # Check if the creation of a new custom object succeeds
            New-Object -TypeName $name | Out-Null
            if ($Debug) {
                $count = [AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.ExportedTypes.fullname -like $Type.FullName } | Measure-Object | Select-Object -ExpandProperty Count
                Write-Host "Type [$Type] Loaded $count time(s)"
            }
        } Catch {
            Throw ("Unable to create Custom Data Type '{0}'" -f $name)
        }
    }
}