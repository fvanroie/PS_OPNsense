Import-Module PS_OPNsense

InModuleScope PS_OPNsense {
    $objects = @{
        function = "Disable-OPNsensePostfixRecipient";
        module = "postfix";
        controller = "recipient"
    }
    switch ("Disable-OPNsensePostfixRecipient".Substring(0,6)) {
        "Enable"  {
            $objects.add('state','1')
        }
        default {
            $objects.add('state','0')
        }
    }
    switch ("postfix") {
        { @("AcmeClient", "Freeradius", "IDS", "Monit", "Postfix", "ProxyUserACL", "Quagga", "Routes", "Siproxd", "Tinc", "Tor", "Zerotier") -Contains $_ } {           
            $objects.add('command',"searchrecipient")
        }
        default {           
            $objects.add('command',"searchrecipients")
        }
    }

    Describe -Tag "postfix" "Disable-OPNsensePostfixRecipient" {
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
                { Disable-OPNsensePostfixRecipient -Uuid $uuid } | should Not Throw
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
