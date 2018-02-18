## Connect to OPNsense first
# See Connect-OPNsense.ps1 script for an example of how to connect to OPNsense

$beVerbose = $false

# Objects to be created are defined in the script below
# They could also be imported from a file, database, other script, ...

# Create 10 Backend servers
$webservers = 1..10 | foreach-Object {
    [pscustomobject]@{
        'name'        = ("web" + $_.tostring("000"));
        'address'     = "10.1.0.$_";
        'port'        = '80';
        'description' = "Created {0}" -f [DateTime]::now
    }
}
Write-Host -ForegroundColor Green ("Creating {0} {1}" -f $webservers.count, "webservers")

# Create the servers and capture the generated UUIDs
$webservers = $webservers | New-OPNsenseHAProxyServer -Verbose:$beVerbose
# Display the result
$webservers | Format-Table *

# Create Custom Errors
$errorfiles = 200, 400, 403, 405, 408, 429, 500, 502, 503, 504 | foreach-Object {
    [pscustomobject]@{
        'name'        = ("err" + $_.tostring("000"));
        'description' = "Errorfile $_";
        'code'        = $_;
        'content'     = '### Error template {0}' -f $_
    }
}
Write-Host -ForegroundColor Green ("Creating {0} {1}" -f $errorfiles.count, "errorfiles")

# Create the errorfiles and capture the generated UUIDs
$errorfiles = $errorfiles | New-OPNsenseHAProxyErrorfile -Verbose:$beVerbose    # Capture the UUIDs
# Display the result
$errorfiles | Format-Table *

# Add Lua Scripts
$luascripts = 1..5 | foreach-Object {
    [pscustomobject]@{
        'name'        = ("lua" + $_.tostring("000"));
        'enabled'     = $_ % 2; # Enable every other script
        'content'     = '-- placeholder script';
        'description' = "Created {0}" -f [DateTime]::now
    }
}
Write-Host -ForegroundColor Green ("Creating {0} {1}" -f $luascripts.count, "luascripts")

# Create the luascripts and capture the generated UUIDs
$luascripts = $luascripts | New-OPNsenseHAProxyLuaScript -Verbose:$beVerbose    # Capture the UUIDs
# Display the result
$luascripts | Format-Table *

# Create Backend pool

# Create Frontend service



Write-Host -ForegroundColor Green ("Checking configuration...")
Test-OPNsenseService -Name HAProxy | Format-List

Write-Host -ForegroundColor Green ("Applying configuration...")
Update-OPNsenseService -Name HAProxy | Format-List


# Remove the created objects, request confirmation
$webservers | Remove-OPNsenseHAProxyServer    -Confirm
$errorfiles | Remove-OPNsenseHAProxyErrorfile -Confirm
$luascripts | Remove-OPNsenseHAProxyLuaScript -Confirm


## Disconnect from OPNsense server
#Disconnect-OPNsense -Verbose:$beVerbose
