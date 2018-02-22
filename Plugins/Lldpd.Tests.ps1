InModuleScope PS_OPNsense {


    Describe "LLDP plugin" {
        Context "Get-OPNsenseLlpd" {

            $expected = [ordered]@{enabled = "1"; cdp = "1"; fdp = "1"; edp = "1"; sonmp = "1"}
            $result = Get-OPNsenseLldp
            It 'Get-OPNsenseLlpd values' {
                Compare-Json $result $expected | Should Be 0
            }
            It 'Has Custom OPNsense ObjectType' {
                Test-ObjectType $result | Should Match 'OPNsense.'
            }

            $result = Get-OPNsenseLldp -Neighbor
            It 'Get-OPNsenseLlpd -Neighbor contains "LLDP neighbors"' {
                $result | Should Match 'LLDP neighbors:'

            }
            It 'Has Custom OPNsense ObjectType' {
                Test-ObjectType $result | Should Match 'OPNsense.'
            }

            It 'Cmdlet has a Get-Help entry' {
                (Get-Help -Name Get-OPNsenseLldp).synopsis | Should Not Be ''
            }
        }

        Context "Get- & Set-OPNsenseLlpd" {

            $expected0 = [ordered]@{enabled = "0"; cdp = "0"; fdp = "0"; edp = "0"; sonmp = "0"}
            $expected1 = [ordered]@{enabled = "1"; cdp = "1"; fdp = "1"; edp = "1"; sonmp = "1"}
            
            $result = Set-OPNsenseLldp -Enable:$false -EnableCdp:$false -EnableFdp:$false -EnableEdp:$tfalse -EnableSonmp:$false
            It 'Set-OPNsenseLlpd values to 0' {
                $result.result | Should Be 'saved'
            }

            $result = Get-OPNsenseLldp
            It 'Get-OPNsenseLlpd values are 0' {
                Compare-Json $result $expected0 | Should Be 0
            }

            $result = Set-OPNsenseLldp -Enable:$true -EnableCdp:$true -EnableFdp:$true -EnableEdp:$true -EnableSonmp:$true
            It 'Set-OPNsenseLlpd values to 1' {
                $result.result | Should Be 'saved'
            }
            
            $result = Get-OPNsenseLldp
            It 'Get-OPNsenseLlpd values are 1' {
                Compare-Json $result $expected1 | Should Be 0
            }

            It 'Has Custom OPNsense ObjectType' {
                Test-ObjectType $result | Should Match 'OPNsense.'
            }

            $result = Get-OPNsenseLldp -Neighbor
            It 'Get-OPNsenseLlpd -Neighbor contains "LLDP neighbors"' {
                $result | Should Match 'LLDP neighbors:'

            }
            It 'Has Custom OPNsense ObjectType' {
                Test-ObjectType $result | Should Match 'OPNsense.'
            }

            It 'Set-OPNsenseLldp has a Get-Help entry' {
                (Get-Help -Name Set-OPNsenseLldp).synopsis | Should Not Be ''
            }
        }


    }

}