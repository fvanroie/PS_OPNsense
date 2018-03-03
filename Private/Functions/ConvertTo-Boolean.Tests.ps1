Import-Module PS_OPNsense -force

InModuleScope PS_OPNsense {

    Describe "Private Functions" {

        Context "ConvertTo-Boolean" {
            
            It "ConvertTo-Boolean '1'" {
                ConvertTo-Boolean "1" | should Be '1'
            }
            It "ConvertTo-Boolean 1" {
                ConvertTo-Boolean 1 | should Be '1'
            }
            It "ConvertTo-Boolean `$true" {
                ConvertTo-Boolean $true | should Be '1'
            }
            It "ConvertTo-Boolean '0'" {
                ConvertTo-Boolean "0" | should Be '0'
            }
            It "ConvertTo-Boolean 0" {
                ConvertTo-Boolean 0 | should Be '0'
            }
            It "ConvertTo-Boolean `$false" {
                ConvertTo-Boolean $false | should Be '0'
            }
            It "ConvertTo-Boolean True" {
                { ConvertTo-Boolean True } | should Throw
            }
            It "ConvertTo-Boolean False" {
                { ConvertTo-Boolean False } | should Throw
            }

        }

    }

}
