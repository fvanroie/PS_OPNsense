Function Get-OPNsensePackage {
    $packages = Invoke-OPNsenseCommand core firmware info
    return $packages.package
}

Function Lock-OPNsensePackage {
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
    $packages = Invoke-OPNsenseCommand core firmware info
    return $packages.plugin
}
