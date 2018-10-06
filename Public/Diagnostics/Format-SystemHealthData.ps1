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

Function Format-SystemHealthData {
    Param (
        [ValidateNotNullOrEmpty()]
        $data
    )
    $rawdata = $data | Select-Object -ExpandProperty d3 | Select-Object -ExpandProperty data
    $table = @()
    $rows = $rawdata[0].values.Count
    for ($i = 0; $i -lt $rows; $i++) {
        $unixdt = Convert-UnixSecondstoLocal ($rawdata.values[$i][0] / 1000)
        $row = New-Object PSObject -Property @{ timestamp = $Unixdt }
        foreach ($column in $rawdata) {
            $row | Add-Member -NotePropertyName $column.key -NotePropertyValue $column.values[$i][1]
        }
        $table += $row
    }

    return $table
}