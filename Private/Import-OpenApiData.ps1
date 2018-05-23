Function Import-OpenApiData {
    param (
        [String]$FilePath
    )
    $OpenApiData = Get-Content -Path $FilePath | ConvertFrom-Json
    $OpenApiHash = @{}
    foreach ($path in $OpenApiData.paths.psobject.properties) {
        $Module = $path.name.split('/')[1]

        foreach ($prop in $path.value.PSObject.properties) {
            if ($prop.value.operationId) {
                if ($prop.value.operationId -match "(.*?)$Module(.*)") {
       
                    $Action = $matches[1]
                    $Object = $matches[2]
       
                    if (-Not $OpenApiHash.containskey($Module)) {
                        $OpenApiHash.Add($module, @{})
                    }
                    if (-Not $OpenApiHash.$Module.containskey($Action)) {
                        $OpenApiHash.$Module.Add($Action, @{})
                    }
                    if (-Not $OpenApiHash.$Module.$Action.containskey($Object)) {
                        $OpenApiHash.$Module.$Action.Add($Object, @{})
                    }

                    $NamespaceIn = $prop.value.requestBody.content.'application/json'.schema.'$ref'
                    $NamespaceOut = $prop.value.responses.'200'.content.'application/json'.schema.'$ref'

                    # Find parameter objects from the schema based on the schema name in the path
                    $parameters = $OPNsenseOpenApi.components.parameters.psobject.Properties |
                        Where-Object { ( '#/components/parameters/{0}' -f $_.Name) -in $prop.value.parameters.'$ref' }

                    $OpenApiHash.$Module.$Action.$Object =
                    [PSCustomObject]@{
                        #    Module        = $Module
                        #    Action        = $Action
                        #    Object        = $Object
                        Method        = $Prop.name
                        Path          = $Path.Name
                        Parameters    = $Parameters
                        NameSpaceIn   = $NamespaceIn
                        NamespoaceOut = $NamespaceOut
                    }
    
                } else {
                    #Write-Warning $prop.name
                }
            }
        }
    }
    return $OpenApiHash
}