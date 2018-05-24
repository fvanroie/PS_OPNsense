Import-Module PS_OPNsense -force

# Define connection parameters
$apiKey = $env:OPNkey
$apiPwd = $env:OPNpwd | ConvertTo-SecureString -AsPlainText -Force
$Url = $env:OPNurl

# Convert the connection parameters into a PowerShell Credentials Object
$apiCred = New-Object System.Management.Automation.PSCredential -ArgumentList $apiKey, $apiPwd

# Connect to OPNsense server
$conn = Connect-OPNsense -Url $Url -Credential $apiCred -SkipCertificateCheck -Verbose:$beVerbose  #-WebCredential $webCred

Function Compare-Json ($value, $expected) {
    [String]::Compare(($value | ConvertTo-Json -Depth 15), ($expected | ConvertTo-Json -Depth 15), $true)
}

Function Test-ObjectType ($obj) {
    return ($obj | Get-Member | Select-Object -ExpandProperty TypeName -First 1)
}

<# Describe "Check Help" {
    Context "Public Cmdlets should have a Get-Help:" {
        $cmdlets = @()
        Get-Command -Module PS_OPNsense | ForEach-Object {
            $cmdlets += @{'name' = $_.name}
        }
        it "<name> has a Get-Help entry" -TestCases $cmdlets {
            param ($name)
            (Get-Help -Name $name).synopsis -ne '' -And (Get-Help -Name $name).description -ne $null | Should Be $true
        }
    }
} #>


InModuleScope PS_OPNsense {

    Describe "Connect-OPNsense" {
        $result = Get-OPNsense

        It "Connection succeeded" {
            $result.connection | Should Be 'ok'
        }
        It "Check productname" {
            if ($result.product_name -ne 'opnsense-devel') {
                $result.product_name | Should Be 'opnsense'
            } else {
                Set-TestInconclusive
            }
        }
        It 'Has a Get-Help entry' {
            (Get-Help -Name Get-OPNsense).synopsis | Should Not Be ''
        }

    }
}
