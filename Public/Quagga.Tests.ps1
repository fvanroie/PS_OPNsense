Import-Module PS_OPNsense


InModuleScope PS_OPNsense {
    $objects = @{ object = "BgpAspath"; command = "searchAsPath"}, `
    @{ object = "BgpNeighbor"; command = "searchNeighbor"}, `
    @{ object = "BgpPrefixList"; command = "searchPrefixList"}, `
    @{ object = "BgpRoutemap"; command = "searchRouteMap"}

    Describe "Quagga Functions" {
        $uuid = @{}

        Context "Get-OPNsenseQuagga*" {
            
            It "Get-OPNsenseQuagga<object>" -TestCases $objects {
                param($object, $command)
                {
                    $result = Invoke-OPNsenseCommand quagga bgp $command | Select-Object -ExpandProperty rows | Select-Object -ExpandProperty uuid
                    $uuid.Add($object, $result)
                } | should Not Throw
            }
 
        }
        <#
        Context "Enable-OPNsenseQuagga*" {

            It "Enable-OPNsenseQuagga<object>" -TestCases $objects {
                param($object, $command)
                { &"Enable-OPNsense$object" -Uuid $uuid[$object] } | should Not Throw
            }

            It "Check <object> is enabled" -TestCases $objects {
                param($object, $command)
                $( Invoke-OPNsenseCommand quagga bgp $command | Select-Object -ExpandProperty rows | Select-Object -ExpandProperty enabled ) | should be '1'
            }

            It "Disable-OPNsenseQuagga<object>" -TestCases $objects {
                param($object, $command)
                { &"Disable-OPNsense$object" -Uuid $uuid[$object] } | should Not Throw
            }

            It "Check <object> is disabled" -TestCases $objects {
                param($object, $command)
                $( Invoke-OPNsenseCommand quagga bgp $command | Select-Object -ExpandProperty rows | Select-Object -ExpandProperty enabled ) | should be '0'
            }

        }
#>
    }

}