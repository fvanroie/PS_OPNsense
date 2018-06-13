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

Function Get-OPNsensePackage {
    # .EXTERNALHELP ../../../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "Packages")]
    param (
        [SupportsWildcards()]    
        [Parameter(Mandatory = $false, position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [String[]]$Name,
        
        [Parameter(Mandatory = $false, ParameterSetName = 'Packages')]
        [Switch]$Package = $false,
        [Parameter(Mandatory = $true, ParameterSetName = 'Plugins')]
        [Switch]$Plugin = $false,
        
        [Switch]$Installed = $false,
        [Switch]$Locked = $false
    )
    BEGIN {
        # Get all packages
        $info = Invoke-OPNsenseCommand core firmware info

        # Set both switchparameters to the correct values
        if ($PSBoundParameters.ContainsKey('Package')) {
            $Plugin = -Not $Package
        } else {
            if ($PSBoundParameters.ContainsKey('Plugin')) {
                $Package = -Not $Plugin
            } else {
                $Package = $True
                $Plugin = $True
            }
        }

        # Select the requested packages only
        if ($Plugin -eq $Package) {
            Write-Verbose "Searching Packages and Plugins"
            $packages = $info.package
        } else {
            if ($Plugin) {
                Write-Verbose "Searching plugins only"
                $packages = $info.plugin
            } else {
                Write-Verbose "Searching packages only"
                $packages = Compare-Object $info.package $info.plugin -Property name -PassThru | Select-Object -Property * -ExcludeProperty SideIndicator
            }
        }

        #foreach ($package in $packages) {
        #    $package.installed = $package.installed -eq 1
        #    $package.locked = $package.locked -eq 1
        #    $package.provided = $package.provided -eq 1
        #}
        if ($PSBoundParameters.ContainsKey('Installed')) {
            $packages = $packages | where-Object { $_.Installed -eq [byte][bool]$Installed }
        }

        if ($PSBoundParameters.ContainsKey('Locked')) {
            $packages = $packages | where-Object { $_.Locked -eq [byte][bool]$Locked }
        }

        # No Name was passed
        if (-Not $PSBoundParameters.ContainsKey('Name')) { $Name = '*' }

        $allpackages = @()
    }
    PROCESS {
        # Multiple Names can be passed
        foreach ($pkgname in $Name) {
            # Filter packages based on possible wildcards
            $temppkgs = $packages | where-Object { $_.Name -like $pkgname }
            foreach ($temppkg in $temppkgs) {
                # Check if packege is already included
                if ($allpackages -notcontains $temppkg) {
                    $allpackages += $temppkg
                }
            }
        }
    }
    END {
        return $allpackages | Add-ObjectDetail -TypeName 'OPNsense.Package'
    }
}
