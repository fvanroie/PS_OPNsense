Function Find-OpenApiRef ($schema, $levels = @()) {
    $ref = ''
    #$levels = @()

    if ($schema.'$ref') {
        Write-Verbose ('Found $ref at level {0}' -f $levels.count) 
        return $levels, $schema.'$ref'.replace('#/components/schemas/', '')
    } else {
        if ($levels.count -eq 0 -And $schema.properties) {
            Write-Verbose 'Found properties at level 0'
            return Find-OpenApiRef $schema.properties ($levels)
        } else {
            foreach ($item in $schema.psobject.properties) {
                Write-Verbose ('checking {0}' -f $item.name)
                $levels, $result = Find-OpenApiRef $item.value ($levels + $item.name)
                if ($result) {
                    return $levels, $result
                }
            }
        }
    }
    return $null, $null # $ref not found
}

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

                    # NameSpace of the data object
                    $NamespaceIn = $prop.value.requestBody.content.'application/json'.schema.'$ref'
                    $NamespaceOut = $prop.value.responses.'200'.content.'application/json'.schema.'$ref'

                    # Names of the Sublevel keys in the JSON to get to the data object
                    $levelsOut, $NamespaceOut = Find-OpenApiRef $prop.value.responses.'200'.content.'application/json'.schema
                    $levelsIn, $NamespaceIn = Find-OpenApiRef $prop.value.requestBody.content.'application/json'.schema

                    # Find parameter objects from the schema based on the parameter reference in the path
                    $param = $OpenApiData.components.parameters.psobject.Properties |
                        Where-Object { 
                        ( '#/components/parameters/{0}' -f $_.Name) -in $prop.value.parameters.'$ref'
                    }

                    $OpenApiHash.$Module.$Action.$Object = [PSCustomObject]@{
                        Module       = $Module
                        Action       = $Action
                        Object       = $Object
                        Method       = $Prop.name
                        Path         = $Path.Name
                        Parameters   = $Param
                        NameSpaceIn  = $NamespaceIn
                        NamespaceOut = $NamespaceOut
                        LevelsIn     = $LevelsIn
                        LevelsOut    = $LevelsOut
                    }
    
                } else {
                    #Write-Warning $prop.name
                }
            }
        }
    }
    return $OpenApiHash
}