Import-Module PS_OPNsense -force

. ..\..\..\Wiki\PS_OPNsense.wiki\Test-Module.ps1

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
            $result.product_name | Should Be 'opnsense'
        }
        It 'Has a Get-Help entry' {
            (Get-Help -Name Get-OPNsense).synopsis | Should Not Be ''
        }

    }
}
