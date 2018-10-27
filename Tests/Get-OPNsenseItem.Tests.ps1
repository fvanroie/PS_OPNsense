Import-Module PS_OPNsense

InModuleScope PS_OPNsense {
    $ModulePath = Split-Path -Parent (Get-Module PS_OPNsense).Path
    $FullPath = ("{0}/{1}" -f $ModulePath, 'Data/opnsense.json')
    $OPNsenseOpenApi = Import-OpenApiData -FilePath $FullPath

    $Modules = $OPNsenseOpenApi.Keys | Sort-Object

    Describe "Get-OPNsenseItem" -Tags Items {
        foreach ($Module in $modules) {
            
            $testcases = @()

            foreach ($action in $OPNsenseOpenApi.$Module.keys) {
                foreach ($object in $OPNsenseOpenApi.$Module.$Action.keys) {
                    # CRUD items implement search action
                    if ($action -eq 'search') {
                        $testcase = @{
                            'Module'   = $module
                            'Item'     = $object
                            'TypeName' = $OPNsenseOpenApi.$Module.'get'.$Object.ResponseType
                        }
                        Write-Output $testcase
                        $testcases += $testcase
                    }
                }    
            }

            if ($testcases.count -eq 0) { Continue }

            Context "Module $Module" {
            
                It "Get <module> <item>" -TestCases $testcases {
                    param($module, $item, $TypeName)
                    if ($module -eq 'relayd') {
                        #Set-TestInconclusive "$Module is under development"
                    }
                    $Splat = @{ 'Module' = $module; 'Item' = $item}
                    # Test without filter
                    {
                        $result = Get-OPNsenseItem @Splat
                    }  | should Not Throw
                    # Test with filter
                    {
                        $result = Get-OPNsenseItem @Splat -Filter 'this_is_a_test_filter_text'
                    }  | should Not Throw
                    #{
                    #    $result = New-OPNsenseItem @Splat
                    #}  | should Not Throw

                }

                It "<typename> has a View:" -TestCases $testcases {
                    param($module, $item, $typename)
                    (Get-FormatData | ? { $_.TypeNames -eq $typename} | Measure-Object).Count | Should be 1
                }


            }
        }

    }
}