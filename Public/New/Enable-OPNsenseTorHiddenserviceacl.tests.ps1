Import-Module PS_OPNsense

InModuleScope PS_OPNsense {
    $objects = @{
        function = "Enable-OPNsenseTorHiddenserviceacl";
        module = "tor";
        controller = "hiddenserviceacl"
    }
    switch ("Enable-OPNsenseTorHiddenserviceacl".Substring(0,6)) {
        "Enable"  {
            $objects.add('state','1')
        }
        default {
            $objects.add('state','0')
        }
    }
    switch ("tor") {
        { @("AcmeClient", "Freeradius", "IDS", "Monit", "Postfix", "ProxyUserACL", "Quagga", "Routes", "Siproxd", "Tinc", "Tor", "Zerotier") -Contains $_ } {           
            $objects.add('command',"searchacl")
        }
        default {           
            $objects.add('command',"searchacls")
        }
    }

    Describe -Tag "tor" "Enable-OPNsenseTorHiddenserviceacl" {
        $uuid = @()

        Context "Get UUIDs" {
                
            It "Get the UUID" -TestCases $objects {
                param($function, $module, $controller, $command, $state)
                {
                    $result = Invoke-OPNsenseCommand $module $controller $command | Select-Object -ExpandProperty rows | Select-Object -ExpandProperty uuid
                    $uuid += $result
                } | should Not Throw
                $uuid.count | Should BeGreaterThan 0
            }

            It "<module> : <function>" -TestCases $objects {
                param($function, $module, $controller, $command, $state)
                { Enable-OPNsenseTorHiddenserviceacl -Uuid $uuid } | should Not Throw
            }

            It "Check <function> is <state>" -TestCases $objects {
                param($function, $module, $controller, $command, $state)
                $statecount = $( Invoke-OPNsenseCommand $module $controller $command | Select-Object -ExpandProperty rows | where-object { $_.uuid -in $uuid -and $_.enabled -eq $state } ).count

                $statecount | Should be $uuid.count
                $uuid.count | Should BeGreaterThan 0
            }

        }
    }
}
