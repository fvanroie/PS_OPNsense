Import-Module PS_OPNsense

InModuleScope PS_OPNsense {
    $ModulePath = Split-Path -Parent (Get-Module PS_OPNsense).Path
    $FullPath = ("{0}/{1}" -f $ModulePath, 'Data/opnsense.json')
    $OPNsenseOpenApi = Import-OpenApiData -FilePath $FullPath

    $Modules = $OPNsenseOpenApi.Keys | Sort-Object

    Describe "New-OPNsenseItem" -Tags Items {
        foreach ($Module in $modules) {
    
            $testcases = foreach ($action in $OPNsenseOpenApi.$Module.keys) {
                foreach ($object in $OPNsenseOpenApi.$Module.$Action.keys) {
                    # CRUD items implement search action
                    if ($action -eq 'search') {
                        $testcase = @{ 'Module' = $module; 'Item' = $object}
                        Write-Output $testcase
                    }
                }        
            }

            if ($testcases.count -eq 0) { Continue }

            Context "Module $Module" {
            
                It "New <module> <item>" -TestCases $testcases {
                    param($module, $item)
                    if ($module -eq 'relayd') {
                        #Set-TestInconclusive "$Module is under development"
                    }
                    #$Splat = @{ "$Module" = "$Item"}
                    $Splat = @{ 'Module' = $module; 'Item' = $item}

                    #{
                    #    $result = Get-OPNsenseItem @Splat
                    #}  | should Not Throw
                    {
                        $result = New-OPNsenseItem @Splat
                    }  | should Not Throw
                }
            }
        }

    }
}