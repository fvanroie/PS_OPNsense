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

Function Remove-OPNsenseItem {
    # .EXTERNALHELP ../../PS_OPNsense.psd1-Help.xml
    [OutputType([Object[]])]
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]
    Param(
        [parameter(Mandatory = $true, position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Object[]]$InputObject,

        [parameter(Mandatory = $false)]
        [Switch]$Force,

        [parameter(Mandatory = $false)]
        [Switch]$PassThru
    )
    BEGIN {
        # Get the Verb of this cmdlet
        $Verb, $null = $MyInvocation.MyCommand -split "-", 2
        $Action = 'delete'
        #$Enabled = ($verb -eq "Enable")
        
        # Pre-filter all matching api calls for this action
        $Commands = $OPNsenseOpenApi.values.values.values | Where-Object { $_.action -eq $action }
    }
    PROCESS {
        foreach ($Obj in $InputObject) {

            # Check if an api command was found for this action and returntype
            $Call = $Commands | Where-Object { $_.RequestType -eq $Obj.gettype().FullName }

            # Ask confirmation before performing action, if needed
            if ($Force -Or $PSCmdlet.ShouldProcess(
                    ("{{{0}}}" -f $Obj.Uuid) ,
                    ("{0} {1}" -f $Verb, $Call.Object)
                ) ) {

                Invoke-OPNsenseItem -Call $Call -InputObject $Obj -Verb $Verb -PassThru:$PassThru
                
            } # ShouldProcess

        }
    }
    END {
    }
}