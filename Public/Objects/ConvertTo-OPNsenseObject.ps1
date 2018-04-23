<#	MIT License
	
	Copyright (c) 2018 fvanroie, NetwiZe.be
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
#>

Function ConvertTo-OPNsenseObject {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [OutputType([Object[]])]
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $true, position = 0)][String]$Module, # Name
        [parameter(Mandatory = $true, position = 1)][String]$Object, # Name
        [parameter(Mandatory = $true, position = 2)][Object[]]$InputObject # Object
    )

    $typename = $OPNsenseObjectMap.$Module.$Object.objecttype

    $ref = $null
    try {
        # Create a reference object to get a list of all the property names
        $ref = New-Object -TypeName $TypeName
    } catch {
        Write-Error ("Failed to get an instance of object '{0}'" -f $typename)
        return $InputObject
    }

    # Reference Property List of an empty object
    $refprop = Get-Member -InputObject $ref -MemberType Properties

    foreach ($obj in $InputObject) {
        # Property List of the InputObject
        $objprop = Get-Member -InputObject $obj -MemberType NoteProperty

        # Check if the needed reference parameters exist in the input object, add missing properties with default values
        $diff = Compare-Object $objprop.name $refprop.name | Where-Object { $_.SideIndicator -eq '=>' }
        foreach ($item in $diff) {
            Write-Error ("Property '{0}' was expected but not found. Using the default value instead." -f $item.inputObject)
            $obj | Add-Member -MemberType NoteProperty -Name $item.inputObject -Value $ref.($item.inputObject)
        }
 
        # Build argument list collection
        $arglist = New-Object System.Collections.Generic.List[System.Object]
        $refprop.name | Foreach-Object {
            Write-Verbose ("{0} : {1}" -f $_, $obj.$_)
            $arglist.Add($obj.$_)
            # WARNING: Cannot use += here because you can't do ( $arglist += $null ) to add values that are NULL!!
            # Using += when the value is $null would result in the property being skipped and the Contructor will fail
        }
        try {
            # Create the object with the proper arguments in the order as they appear in the reference object
            $newobj = New-Object -TypeName $TypeName -ArgumentList $arglist
        } catch {
            Write-Error ("Failed to instantiate an object of type '{0}' :`nError: {1}" -f $typename, $_)
            Continue # with next item
        }

        # Verify the object is not NULL
        if (!$newobj) {
            Write-Error ("The '{0}' object is undefined. Unable to process it." -f $typename)
            Continue # with next item
        }

        # Add extra properties as custom NoteProperty
        $diff = Compare-Object $objprop.name $refprop.name | Where-Object { $_.SideIndicator -eq '<=' }
        foreach ($item in $diff) {
            $newobj | Add-Member -MemberType NoteProperty -Name $item.inputObject -Value $obj.($item.inputObject)
        }
 
        return $newobj       
    }
}