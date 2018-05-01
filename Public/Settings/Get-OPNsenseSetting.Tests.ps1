Import-Module PS_OPNsense



InModuleScope PS_OPNsense {
    $settingsmap = get-content .\data\settings.json | ConvertFrom-Json

    $testcases = @()
    $modules = $settingsmap.settings | Get-Member -MemberType NoteProperty
    foreach ($module in $modules.name) {
        $settings = $settingsmap.settings.$module | Get-Member -MemberType NoteProperty | Where-Object { $_.name -ne 'plugin'}
        foreach ($setting in $settings.name) {
            $testcases += @{ 'Module' = $module; 'Setting' = $Setting}
        }
    }

    Describe "Getting All Settings" {
        Context "Get-OPNsenseSetting" {
            
            It "<module> <setting> Settings do not throw" -TestCases $testcases {
                param($module, $setting)
                {
                    $r = Get-OPNsenseSetting -Module $module -Setting $setting 
                }  | should Not Throw
            }
        }
    }
}