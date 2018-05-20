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


##### GET Functions #####
function Get-OPNsenseHAProxyDetail {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, position = 0)]
        [ValidateSet('Server', 'Backend', 'Frontend', 'Healthcheck', 'Errorfile', 'Lua', 'Acl', 'Action', 'Healthcheck')]
        [String]$ObjectType,
        [parameter(Mandatory = $true)][string]$Uuid
    )
    Switch ($ObjectType) {
        'Server' { Get-OPNsenseItem HAProxy Server -Uuid $Uuid }    
        'Backend' { Get-OPNsenseItem HAProxy Backend -Uuid $Uuid }    
        'Frontend' { Get-OPNsenseItem HAProxy Frontend -Uuid $Uuid }    
        'Healthcheck' { Get-OPNsenseItem HAProxy HealthCheck -Uuid $Uuid }    
        'Errorfile' { Get-OPNsenseItem HAProxy Errorfile -Uuid $Uuid }    
        'Lua' { Get-OPNsenseItem HAProxy LuaScript -Uuid $Uuid }    
        'Acl' { Get-OPNsenseItem HAProxy Acl -Uuid $Uuid }    
        'Action' { Get-OPNsenseItem HAProxy Action -Uuid $Uuid }    
        default { }
    }
}
