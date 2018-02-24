Import-Module PS_OPNsense -force

InModuleScope PS_OPNsense {

    Describe "Skip-OPNsenseObject" {
        $value = "ABCdefGEH"

        Context "LIKE Test Macthes" {
            It "Multiple Like tests with wildcards" {
                Skip-OPNsenseObject $value -Like '*cdef*', 'test2' | should Be $false
            }
            It "Single Like test with wildcard" {
                Skip-OPNsenseObject $value -Like '*cdef*' | should Be $false
            }
            It "Like Empty Array" {
                Skip-OPNsenseObject $value -Like @() | should Be $false
            }
            It "Like Null" {
                Skip-OPNsenseObject $value -Like $null | should Be $false
            }
        }
        Context "LIKE Test No Macthes" {
            It "Multiple Like tests with wildcards, no match" {
                Skip-OPNsenseObject $value -Like '*xyz*', '*test*' | should Be $true
            }
            It "Single Like test with wildcard, no match" {
                Skip-OPNsenseObject $value -Like '*xyz*' | should Be $true
            }
            It "Like Empty String, no match" {
                Skip-OPNsenseObject $value -Like '' | should Be $true
            }
        }
        Context "LIKE Tests that Should Throw" {
            It "Bad Paramset" {
                { Skip-OPNsenseObject $value } | should Throw
            }
        }
    }

}
