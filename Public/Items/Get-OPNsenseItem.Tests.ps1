Import-Module PS_OPNsense



InModuleScope PS_OPNsense {
    $itemsmap = get-content .\data\items.json | ConvertFrom-Json

    $testcases = @()
    $modules = $itemsmap | Get-Member -MemberType NoteProperty
    foreach ($module in $modules.name) {
        $items = $itemsmap.$module | Get-Member -MemberType NoteProperty | Where-Object { $_.name -ne 'plugin'}
        foreach ($item in $items.name) {
            $testcases += @{ 'Module' = $module; 'Item' = $item}
        }
    }

    Describe "Getting All Items" {
        Context "Get-OPNsenseItem" {
            
            It "<module> <item> Item should not throw" -TestCases $testcases {
                param($module, $item)
                {
                    $r = Get-OPNsenseItem -Module $module -Item $item 
                }  | should Not Throw
            }
        }
    }
}