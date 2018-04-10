Import-Module PS_OPNsense

InModuleScope PS_OPNsense {

    Describe "Private Functions" {

        Context "ConvertTo-Boolean '1'" {
            
            It "ConvertTo-Boolean '1'" {
                ConvertTo-Boolean "1" | should Be '1'
            }
            It "ConvertTo-Boolean 1" {
                ConvertTo-Boolean 1 | should Be '1'
            }
            It "ConvertTo-Boolean `$true" {
                ConvertTo-Boolean $true | should Be '1'
            }
            It "ConvertTo-Boolean True" {
                ConvertTo-Boolean True | should Be '1'
            }
        }

        Context "ConvertTo-Boolean '0'" {

            It "ConvertTo-Boolean '0'" {
                ConvertTo-Boolean "0" | should Be '0'
            }
            It "ConvertTo-Boolean 0" {
                ConvertTo-Boolean 0 | should Be '0'
            }
            It "ConvertTo-Boolean `$false" {
                ConvertTo-Boolean $false | should Be '0'
            }
            It "ConvertTo-Boolean False" {
                ConvertTo-Boolean False | should Be '0'
            }
        }

        Context "ConvertTo-Boolean Throws" {

            It "ConvertTo-Boolean `$null Throws" {
                { ConvertTo-Boolean $null } | should Throw
            }
            It "ConvertTo-Boolean String Throws" {
                { ConvertTo-Boolean String } | should Throw
            }
            It "ConvertTo-Boolean 5 Throws" {
                { ConvertTo-Boolean 5 } | should Throw
            }

        }

    }

}
