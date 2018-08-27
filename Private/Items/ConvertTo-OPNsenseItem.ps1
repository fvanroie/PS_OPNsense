<#  MIT License

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

<#
    Enable, Disable, Switch or Remove
#>

Function ConvertTo-OPNsenseItem {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [OutputType([Object[]])]
    [CmdletBinding(
    )]
    Param(
        [PSObject]$InputObject
    )

    $newobject = @{}
    foreach ($prop in $InputObject.PSObject.Properties) {
        if ($prop.Name -eq 'UUID') { Continue } 
        
        switch ($prop.TypeNameOfValue) {
            'System.Boolean' {
                if ($Prop.Value) {
                    $newobject.Add($prop.Name, 1)
                } else {
                    $newobject.Add($prop.Name, 0)
                }
            }
            {@('System.Object', 'System.Management.Automation.PSObject') -contains $_ } {
                foreach ($key in $InputObject.($prop.Name).keys) {
                    if ($InputObject.($prop.Name)[$key].selected -eq 1) {
                        $newobject.Add($prop.Name, $key)
                    } else {
                        # Write-Verbose $InputObject.($prop.Name)[$key].selected
                    }
                }
            }
            <#'System.Object' {
                    $newobject.Add($prop.Name, $($prop.Value -join ','))
            } #>
            default {
                $newobject.Add($prop.Name, $prop.Value)
            }
        }
    }

    New-Object -TypeName PSObject -Property $newobject
}