# http://www.enowsoftware.com/solutions-engine/bid/185867/Powershell-Upping-your-Parameter-Validation-Game-with-Dynamic-Parameters-Part-II

function New-ValidationDynamicParam {
    [CmdletBinding()]
    [OutputType('System.Management.Automation.RuntimeDefinedParameter')]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [String]$Type,
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory)]
        [array]$ValidateSetOptions,
        [Parameter()]
        [switch]$Mandatory = $false,
        [Parameter()]
        [string]$ParameterSetName = '__AllParameterSets',
        [Parameter()]
        [switch]$ValueFromPipeline = $false,
        [Parameter()]
        [switch]$ValueFromPipelineByPropertyName = $false,
        [Parameter()]
        [int]$Position
    )
    $AttribColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParamAttrib = New-Object System.Management.Automation.ParameterAttribute
    $ParamAttrib.Mandatory = $Mandatory.IsPresent
    if ($Position -ne $null) {
        $ParamAttrib.Position = $Position
    }
    if ($ValueFromPipelineByPropertyName) {
        $ParamAttrib.ValueFromPipelineByPropertyName = $True
    }
    $ParamAttrib.ParameterSetName = $ParameterSetName
    $ParamAttrib.ValueFromPipeline = $ValueFromPipeline.IsPresent
    $ParamAttrib.ValueFromPipelineByPropertyName = $ValueFromPipelineByPropertyName.IsPresent
    $AttribColl.Add($ParamAttrib)
    $opts = New-Object System.Management.Automation.ValidateSetAttribute($ValidateSetOptions)
    $AttribColl.Add($opts)
    Switch ($Type) {
        '[String[]]' {
            $RuntimeParam = New-Object System.Management.Automation.RuntimeDefinedParameter($Name, [String[]], $AttribColl)
        }
        default {
            $RuntimeParam = New-Object System.Management.Automation.RuntimeDefinedParameter($Name, [String], $AttribColl)
        }
    }
    $RuntimeParam
}

function New-SwitchDynamicParam {
    [CmdletBinding()]
    [OutputType('System.Management.Automation.RuntimeDefinedParameter')]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter()]
        [switch]$Mandatory = $false,
        [Parameter()]
        [string]$ParameterSetName = '__AllParameterSets',
        [Parameter()]
        [switch]$ValueFromPipeline = $false,
        [Parameter()]
        [switch]$ValueFromPipelineByPropertyName = $false
    )
    $AttribColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $ParamAttrib = New-Object System.Management.Automation.ParameterAttribute
    $ParamAttrib.Mandatory = $Mandatory.IsPresent
    $ParamAttrib.ParameterSetName = $ParameterSetName
    $ParamAttrib.ValueFromPipeline = $ValueFromPipeline.IsPresent
    $ParamAttrib.ValueFromPipelineByPropertyName = $ValueFromPipelineByPropertyName.IsPresent
    $AttribColl.Add($ParamAttrib)
    $RuntimeParam = New-Object System.Management.Automation.RuntimeDefinedParameter($Name, [Switch], $AttribColl)
    $RuntimeParam
}