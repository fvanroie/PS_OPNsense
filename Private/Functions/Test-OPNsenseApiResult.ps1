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

Function Test-OPNsenseApiResult {
    [CmdletBinding()]
    param (
        [psobject]$result
    )
    # Check .result and .status
    switch ($result.result) {
        'saved' { return $True; Break }
        'deleted' { return $True; Break }
        'failed' { 
            if ($result.validations) {
                $fields = $result | Select-Object -ExpandProperty validations | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
                foreach ($field in $fields) {
                    $host.UI.WriteErrorLine($("{0} : {1}" -f $field, $result.validations.($field)))
                }
            } else {
                $host.UI.WriteErrorLine("failed")
            }            
            return $false
            Break
        }
        'not found' {
            $host.UI.WriteErrorLine("not found")
            return $False
            Break
        }
        Default {
            switch ($result.status) {
                'ok' { return $True; Break }
                'failure' {
                    $host.UI.WriteErrorLine("failure")
                    return $False
                    Break
                }
                Default {
                    Write-Warning ("Unknown resultcode '{0}'" -f $result.result)
                }
            }        
        } # default
    }
}
