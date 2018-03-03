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

Function Skip-OPNsenseObject {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [String]$value,

        [parameter(Mandatory = $true, ParameterSetName = "Like")]
        [AllowEmptyString()][AllowNull()][AllowEmptyCollection()]
        [String[]]$Like,
        
        [parameter(Mandatory = $true, ParameterSetName = "In")]
        [AllowEmptyString()][AllowNull()][AllowEmptyCollection()]
        [Array]$In
    )

    switch ($PSCmdlet.ParameterSetName) {
        "In" {        
            If ($Value -in $in) {
                # Value passes the IN filter
                return $false
            }
        }
        "Like" {
            if ($Like.Count -eq 0) { return $false }
            # Filter on LIKE Parameter
            Foreach ($filter in $Like) {
                Write-Verbose ('{0} -like {1}' -f $value, $filter)
                If ($Value -like $filter) {
                    # Value passes the LIKE filter
                    return $false
                }
            }
        }
        default {}
    }
 
    # Value fails all test filters, Skip it!
    return $true
}