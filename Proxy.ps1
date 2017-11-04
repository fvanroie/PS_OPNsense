Function New-OPNsenseProxyRemoteBlacklist {
    param (
        [Parameter(Mandatory=$true)][String]$Filename,
        [Parameter(Mandatory=$true)][String]$Url,
        [Parameter(Mandatory=$true)][String]$Description,
        [Parameter(Mandatory=$false)][Boolean]$Enabled,
        [Parameter(Mandatory=$false)][String]$Username,
        [Parameter(Mandatory=$false)][String]$Password,
        [Parameter(Mandatory=$false)][String]$Filter,
        [Parameter(Mandatory=$false)][Boolean]$SslNoVerify

    )
    $opnBlacklist = @{
        blacklist = @{ filename = $Filename ; url = $Url ; description = $Description }
    }

    if ($Enabled) {
        $opnBlacklist.blacklist
    }

    return Invoke-OPNsenseCommand proxy settings addremoteblacklist -Json $opnBlacklist
}
