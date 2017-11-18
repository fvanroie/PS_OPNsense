<#
    MIT License

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

Function Get-OPNsensePackage {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    $packages = Invoke-OPNsenseCommand core firmware info
    return $packages.package
}

Function Lock-OPNsensePackage {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true,position=1,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)][String[]]$Name
    )
    BEGIN {
        $pkg = Get-OPNsensePackage
    }
    PROCESS {
        $thispkg = $pkg | Where-Object { $_.Name -eq $Name }
        If ($thispkg.installed -eq 0) {
            Write-Warning ($thispkg.Name + " is not installed and cannot be locked.")
        } else {
            Invoke-OPNsenseCommand core firmware "lock/$Name" -Form lock -addProperty @{ name = $Name.tolower()}
        }
    }
    END {
        #return $results
    }
}

Function Unlock-OPNsensePackage {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true,position=1,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)][String[]]$Name
    )
    BEGIN {
        $pkg = Get-OPNsensePackage
    }
    PROCESS {
        $thispkg = $pkg | Where-Object { $_.Name -eq $Name }
        If ($thispkg.locked -eq 0) {
            Write-Warning ($thispkg.Name + " is not locked and cannot be unlocked.")
        } else {
            Invoke-OPNsenseCommand core firmware "unlock/$Name" -Form unlock -addProperty @{ name = $Name.tolower()}
        }
    }
    END {
        #return $results
    }
}

Function Install-OPNsensePackage {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true,position=1,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)][String[]]$Name
    )
    BEGIN {
        $pkg = Get-OPNsensePackage
    }
    PROCESS {
        $thispkg = $pkg | Where-Object { $_.Name -eq $Name }
        If ($thispkg.installed -eq 1) {
            Write-Warning ($thispkg.Name + " is already installed. Use -Force to reinstall the package.")
        } else {
            Invoke-OPNsenseCommand core firmware "install/$Name" -Form install -addProperty @{ name = $Name.tolower()}
        }
    }
    END {
        #return $results
    }
}

Function Remove-OPNsensePackage {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    param (
        [Parameter(Mandatory=$true,position=1,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)][String[]]$Name
    )
    BEGIN {
        $pkg = Get-OPNsensePackage
    }
    PROCESS {
        $thispkg = $pkg | Where-Object { $_.Name -eq $Name }
        If ($thispkg.installed -eq 0) {
            Write-Warning ($thispkg.Name + " is not installed and cannot be removed.")
        } else {
            Invoke-OPNsenseCommand core firmware "remove/$Name" -Form remove -addProperty @{ name = $Name.tolower()}
        }
    }
    END {
        #return $results
    }
}

Function Get-OPNsensePlugin {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml

    $packages = Invoke-OPNsenseCommand core firmware info
    return $packages.plugin
}
