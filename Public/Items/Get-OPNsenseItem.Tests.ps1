Import-Module PS_OPNsense



InModuleScope PS_OPNsense {
    $ModulePath = Split-Path -Parent (Get-Module PS_OPNsense).Path
    $FullPath = ("{0}/{1}" -f $ModulePath, 'Data/opnsense.json')
    $OPNsenseOpenApi = Import-OpenApiData -FilePath $FullPath

    #$modules = $itemsmap | Get-Member -MemberType NoteProperty
    $Modules = $OPNsenseOpenApi.Keys | Sort-Object

    Describe "OPNsense Items" {
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

            Context "Module $Module" {
            
                It "Get <item> should not throw" -TestCases $testcases {
                    param($module, $item)
                    if ($module -eq 'relayd') {
                    Set-TestInconclusive "$Module is under development"
                    } 
                    {
                        $result = Get-OPNsenseItem -Module $module -Item $item 
                    }  | should Not Throw
                }
            }
        }

    }
}