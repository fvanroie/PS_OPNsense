#Requires -Modules PS_OPNsense

# # #   W A R N I N G   # # # # # # # # # # # # # # # # # # # # # # # #
#
#  This script makes changes on your OPNsense appliance,
#  do NOT run this script against a production machine !
#
# New objects to be created are defined in the script below
# They can also be imported from a file, database, other script, ...
#
# Note: Connect to OPNsense first
#       See Connect.Example.ps1 file for an example of how to connect

$beVerbose = $false

# Make sure HAproxy is installed
$haproxy = Get-OPNsensePackage 'os-haproxy'
If (-Not $haproxy.installed) {
    $haproxy | Install-OPNsensePackage -Verbose:$beVerbose
} else {
    Write-Host -ForegroundColor Cyan "HAProxy plugin-in is already installed!"
}

# Create some Backend server objects
$webservers = 1..3 | foreach-Object {
    [PSCustomObject]@{
        'name'        = ("web" + $_.tostring("000"))
        'address'     = "192.168.0.$_"
        'port'        = '80'
        'description' = "Created {0}" -f [DateTime]::now
    }
}
Write-Host -ForegroundColor Green ("Creating {0} webservers..." -f $webservers.count)

# Actually create these Servers in OPNsense and capture the generated UUIDs
$webservers = $webservers | New-OPNsenseHAProxyServer -Verbose:$beVerbose
# Display the result
$webservers | Format-Table *


# Create Custom Error objects
$errorfiles = 200, 400, 403, 405, 408, 429, 500, 502, 503, 504 | foreach-Object {
    [PSCustomObject]@{
        'name'        = ("err" + $_.tostring("000"))
        'description' = "Errorfile $_"
        'code'        = $_
        'content'     = '### Error template {0}' -f $_
    }
}
Write-Host -ForegroundColor Green ("Creating {0} errorfiles..." -f $errorfiles.count)

# Actually create these ErrorFiles in OPNsense and capture the generated UUIDs
$errorfiles = $errorfiles | New-OPNsenseHAProxyErrorfile -Verbose:$beVerbose
# Display the result
$errorfiles | Format-Table *


# Add Lua Scripts
$luascripts = 1..2 | foreach-Object {
    [PSCustomObject]@{
        'name'        = ("lua" + $_.tostring("000"))
        'enabled'     = $_ % 2 # Enable every other script
        'content'     = '-- placeholder script'
        'description' = "Created {0}" -f [DateTime]::now
    }
}
Write-Host -ForegroundColor Green ("Creating {0} luascripts..." -f $luascripts.count)

# Actually create these LuaScripts in OPNsense and capture the generated UUIDs
$luascripts = $luascripts | New-OPNsenseHAProxyLuaScript -Verbose:$beVerbose
# Display the result
$luascripts | Format-Table *



# Add Backend pool
$backends = 1..2 | foreach-Object {
    [PSCustomObject]@{
        'name'             = ("pool" + $_.tostring("00"))
        'enabled'          = $_ % 2 # Enable every other script
        'description'      = "Created {0}" -f [DateTime]::now
        'mode'             = 'http'
        'algorithm'        = 'static-rr'
        'linkedServers'    = $webservers.uuid | Select-Object -First $_  # pick some servers
        'linkedErrorfiles' = $errorfiles.uuid | Select-Object -Last $_  # pick some errorfiles
    }
}
Write-Host -ForegroundColor Green ("Creating {0} backends..." -f $backends.count)

# Actually create these Backends in OPNsense and capture the generated UUIDs
$backends = $backends | New-OPNsenseHAProxyBackend -Verbose:$beVerbose
# Display the result
$backends | Format-Table *


# Create Frontend service
$frontends = 1..2 | foreach-Object {
    [PSCustomObject]@{
        'name'                = ("public" + $_.tostring("00"))
        'enabled'             = $_ % 2 # Enable every other script
        'description'         = "Created {0}" -f [DateTime]::now
        'bind'                = ('127.0.0.1:8{0},10.1.1.{0}:80' -f $_)
        'mode'                = 'http'
        'defaultBackend'      = $backends[0].uuid
        'connectionBehaviour' = 'http-keep-alive'
        'linkedErrorfiles'    = $errorfiles.uuid | Select-Object -Last $_  # pick some errorfiles
    }
}
Write-Host -ForegroundColor Green ("Creating {0} frontends..." -f $frontends.count)

# Actually create these Frontends in OPNsense and capture the generated UUIDs
$frontends = $frontends | New-OPNsenseHAProxyFrontend -Verbose #:$beVerbose
# Display the result
$frontends | Format-Table *


# Test and Apply the new configuration
Write-Host -ForegroundColor Green ("Checking configuration...")
Test-OPNsenseService -Name HAProxy | Select-Object -ExpandProperty Result

Write-Host -ForegroundColor Green ("Applying the configuration...")
Update-OPNsenseService -Name HAProxy | Select-Object -Property Status | Format-List

Get-OPNsenseService haproxy

# Optionally remove the created objects, request confirmation
Write-Host -ForegroundColor Green ("Removing test objects...")
$frontends | Remove-OPNsenseHAProxyFrontend -Confirm -Verbose:$beVerbose
$backends | Remove-OPNsenseHAProxyBackend -Confirm -Verbose:$beVerbose
$webservers | Remove-OPNsenseHAProxyServer -Confirm -Verbose:$beVerbose
$errorfiles | Remove-OPNsenseHAProxyErrorfile -Confirm -Verbose:$beVerbose
$luascripts | Remove-OPNsenseHAProxyLuaScript -Confirm -Verbose:$beVerbose


## Disconnect from OPNsense server
#Disconnect-OPNsense -Verbose:$beVerbose