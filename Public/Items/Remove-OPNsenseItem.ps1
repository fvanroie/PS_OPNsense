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
    # .EXTERNALHELP ../PS_OPNsense.psd1-Help.xml
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]
    Param(
        [parameter(Mandatory = $true, position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Object[]]$InputObject,

        [parameter(Mandatory = $false)]
        [Switch]$PassThru
    )
    BEGIN {
        # Get the Verb of the cmdlet
        $verb, $null = $MyInvocation.MyCommand -split "-", 2
        $command = "remove"
        $commands = Get-OPNsenseItemMap | Where-Object { $_.command -eq 'remove' }
    }
    PROCESS {
        foreach ($obj in $InputObject) {
            $cmd = $commands | Where-Object { $_.returntype -eq $obj.gettype().FullName }

            # Check if an api command was found for this TypeName
            if (!$cmd) {
                Write-Warning ("Unable to process object of type {0}" -f $obj.gettype().FullName)
                Continue # With next object
            }

            # Ask confirmation before removal, if needed
            if ($pscmdlet.ShouldProcess( ("{{{0}}}" -f $obj.Uuid) , ("{0} {1}" -f $verb, $cmd.ObjectName) ) ) {

                # Be Verbose
                Write-Verbose ("{0} {1} {{{2}}}" -f $verb, $cmd.ObjectName, $obj.Uuid)

                $result = Invoke-OPNsenseFunction -Module $cmd.Module -Command $command -Object $cmd.Object -Uuid $obj.Uuid -Enable $false

                # Output results
                if ($PassThru) {
                    [PSCustomObject]@{ 'Uuid' = $obj.Uuid; 'Result' = $result }
                }
            } # ShouldProcess

        }
    }
    END {
    }
}