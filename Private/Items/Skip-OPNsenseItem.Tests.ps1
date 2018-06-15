Import-Module PS_OPNsense

InModuleScope PS_OPNsense {

    Describe "Skip-OPNsenseItem" {
        $value = "ABCdefGEH"

        Context "LIKE Test Macthes" {
            It "Multiple Like tests with wildcards" {
                Skip-OPNsenseItem $value -Like '*cdef*', 'test2' | should Be $false
            }
            It "Single Like test with wildcard" {
                Skip-OPNsenseItem $value -Like '*cdef*' | should Be $false
            }
            It "Like Empty Array" {
                Skip-OPNsenseItem $value -Like @() | should Be $false
            }
            It "Like Null" {
                Skip-OPNsenseItem $value -Like $null | should Be $false
            }
        }
        Context "LIKE Test No Macthes" {
            It "Multiple Like tests with wildcards, no match" {
                Skip-OPNsenseItem $value -Like '*xyz*', '*test*' | should Be $true
            }
            It "Single Like test with wildcard, no match" {
                Skip-OPNsenseItem $value -Like '*xyz*' | should Be $true
            }
            It "Like Empty String, no match" {
                Skip-OPNsenseItem $value -Like '' | should Be $true
            }
        }
        Context "LIKE Tests that Should Throw" {
            It "Bad Paramset" {
                { Skip-OPNsenseItem $value } | should Throw
            }
        }
    }

}
