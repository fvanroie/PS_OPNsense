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

Function ValidateSystemHealthOptions {
    Param (
        [ValidateSet("packets", "system", "traffic")]
        [String]$type,
        [String]$data,
        [String]$collection
    )

    $result = Invoke-OPNsenseCommand diagnostics systemhealth getRRDlist
    switch ($type) {
        'packets' { $options = $result.data.packets }
        'system' { $options = $result.data.system }
        'traffic' { $options = $result.data.traffic }
        default { Throw "Invalid SystemHealthOptions type: $type" }
    }
    if ($options -NotContains $data) {
        $choices = $options | ConvertTo-Json -compress
        Throw """$data"" is not a valid $type $collection option. ""$data"" needs to be in $choices"
    }
}
