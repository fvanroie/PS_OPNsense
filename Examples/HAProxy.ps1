## Connection Variables
#$key = '<myKey>'
#$SecurePassword = '<mySecret>' | ConvertTo-SecureString -AsPlainText -Force
#$url = 'https://opnsense.localdomain'
$beVerbose = $false

## Build Creddentials
#$apiCred = New-Object System.Management.Automation.PSCredential -ArgumentList $Key, $SecurePassword

## Connect to OPNsense
#$opnsense = Connect-OPNsense -Url $url -Credential $apiCred -SkipCertificateCheck -Verbose:$beVerbose
#$opnsense | Format-Table


# Create 10 Backend servers
$webservers = @()
1..10 | foreach-Object {
    $server = [pscustomobject]@{
        'name'        = ("web" + $_.tostring("000"));
        'address'     = "10.1.0.$_";
        'port'        = '80';
        'description' = "Created {0}" -f [DateTime]::now
    }
    $webservers += $server
}
Write-Host -ForegroundColor Green ("Creating {0} {1}" -f $webservers.count, "webservers")
$webservers = $webservers | New-OPNsenseHAProxyServer -Verbose:$beVerbose    # Capture the UUIDs
$webservers | Format-Table *

# Create Custom Errors
$errorfiles = @()
200, 400, 403, 405, 408, 429, 500, 502, 503, 504 | foreach-Object {
    $err = [pscustomobject]@{
        'name'        = ("err" + $_.tostring("000"));
        'description' = "Errorfile $_";
        'code'        = $_;
        'content'     = '### Error template {0}' -f $_
    }
    $errorfiles += $err
}
Write-Host -ForegroundColor Green ("Creating {0} {1}" -f $errorfiles.count, "errorfiles")
$errorfiles = $errorfiles | New-OPNsenseHAProxyErrorfile -Verbose:$beVerbose    # Capture the UUIDs
$errorfiles | Format-Table *

# Add Lua Scripts
$luascripts = @()
1..5 | foreach-Object {
    $script = [pscustomobject]@{
        'name'        = ("lua" + $_.tostring("000"));
        'enabled'     = $_ % 2; # Enable every other script
        'content'     = '-- placeholder script';
        'description' = "Created {0}" -f [DateTime]::now
    }
    $luascripts += $script
}
Write-Host -ForegroundColor Green ("Creating {0} {1}" -f $luascripts.count, "luascripts")
$luascripts = $luascripts | New-OPNsenseHAProxyLuaScript -Verbose:$beVerbose    # Capture the UUIDs
$luascripts | Format-Table *

# Create Backend pool

# Create Frontend service


## Disconnect from OPNsense server
#Disconnect-OPNsense -Verbose:$beVerbose