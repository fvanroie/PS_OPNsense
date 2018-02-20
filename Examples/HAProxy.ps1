### Do not remove the next line
#Requires -Modules PS_OPNsense

## Connect to OPNsense first
# See Connect-OPNsense.ps1 script for an example of how to connect to OPNsense

$beVerbose = $false

# Objects to be created are defined in the script below
# They could also be imported from a file, database, other script, ...


# Create 10 Backend server objects
$webservers = 1..3 | foreach-Object {
    [PSCustomObject]@{
        'name'        = ("web" + $_.tostring("000"));
        'address'     = "10.1.0.$_";
        'port'        = '80';
        'description' = "Created {0}" -f [DateTime]::now
    }
}
Write-Host -ForegroundColor Green ("Creating {0} {1}..." -f $webservers.count, "webservers")

# Actually create these Servers in OPNsense and capture the generated UUIDs
$webservers = $webservers | New-OPNsenseHAProxyServer -Verbose:$beVerbose
# Display the result
$webservers | Format-Table *


# Create Custom Error objects
$errorfiles = 200, 400, 403, 405, 408, 429, 500, 502, 503, 504 | foreach-Object {
    [PSCustomObject]@{
        'name'        = ("err" + $_.tostring("000"));
        'description' = "Errorfile $_";
        'code'        = $_;
        'content'     = '### Error template {0}' -f $_
    }
}
Write-Host -ForegroundColor Green ("Creating {0} {1}..." -f $errorfiles.count, "errorfiles")

# Actually create these ErrorFiles in OPNsense and capture the generated UUIDs
$errorfiles = $errorfiles | New-OPNsenseHAProxyErrorfile -Verbose:$beVerbose    # Capture the UUIDs
# Display the result
$errorfiles | Format-Table *


# Add Lua Scripts
$luascripts = 1..2 | foreach-Object {
    [PSCustomObject]@{
        'name'        = ("lua" + $_.tostring("000"));
        'enabled'     = $_ % 2; # Enable every other script
        'content'     = '-- placeholder script';
        'description' = "Created {0}" -f [DateTime]::now
    }
}
Write-Host -ForegroundColor Green ("Creating {0} {1}..." -f $luascripts.count, "luascripts")

# Actually create these LuaScripts in OPNsense and capture the generated UUIDs
$luascripts = $luascripts | New-OPNsenseHAProxyLuaScript -Verbose:$beVerbose    # Capture the UUIDs
# Display the result
$luascripts | Format-Table *

# Create Backend pool

# Create Frontend service



Write-Host -ForegroundColor Green ("Checking configuration...")
Test-OPNsenseService -Name HAProxy | Select-Object -ExpandProperty Result

Write-Host -ForegroundColor Green ("Applying configuration...")
Update-OPNsenseService -Name HAProxy | Select-Object -Property Status | Format-List


# Remove the created objects, request confirmation
$webservers | Remove-OPNsenseHAProxyServer -Confirm -Verbose:$beVerbose
$errorfiles | Remove-OPNsenseHAProxyErrorfile -Confirm -Verbose:$beVerbose
$luascripts | Remove-OPNsenseHAProxyLuaScript -Confirm -Verbose:$beVerbose


## Disconnect from OPNsense server
#Disconnect-OPNsense -Verbose:$beVerbose
