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

Function Disable-OPNsenseOspfPrefixlist {
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]
    Param(
        [parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyname = $true, ParameterSetName = "AsParam")]
        [AllowEmptyCollection()]
        [String[]]$Uuid
    )
    BEGIN {
        $uuids = @()
    }
    PROCESS {
        $uuids += $uuid
    }
    END {
        if ($false) { $PSCmdlet.ShouldProcess() }         # Hide PSScriptAlalyzer warning
        return Enable-OPNsenseObject quagga ospfsettings prefixlist "Ospf Prefixlist" -Uuid $uuids -Enable $False
    }
}
