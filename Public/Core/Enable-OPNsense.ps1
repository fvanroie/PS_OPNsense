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


Function Enable-OPNsense {
    # .EXTERNALHELP PS_OPNsense.psd1-Help.xml
    [CmdletBinding(DefaultParameterSetName = "CaptivePortalZone")]
    Param(
        [parameter(ParameterSetName = "CaptivePortalZone")]
        [Alias('Zone')]
        [Switch]$CaptivePortalZone,
        [parameter(ParameterSetName = "CronJob")]
        [Alias('Job')]
        [Switch]$CronJob,
        [parameter(ParameterSetName = "FtpProxy")]
        [Switch]$FtpProxy,
        [parameter(ParameterSetName = "IdsRule")]
        [Alias('Rule')]
        [Switch]$IdsRule,
        [parameter(ParameterSetName = "IdsRuleSet")]
        [Alias('RuleSet')]
        [Switch]$IdsRuleSet,
        [parameter(ParameterSetName = "IdsUserRule")]
        [Alias('UserRule')]
        [Switch]$IdsUserRule,
        [parameter(ParameterSetName = "ProxyRemoteBlackList")]
        [Alias('Blacklist')]
        [Alias('RemoteBlacklist')]
        [Switch]$ProxyRemoteBlackList,
        [parameter(ParameterSetName = "Route")]
        [Switch]$Route,
        [parameter(ParameterSetName = "TrafficShaperPipe")]
        [Alias('Pipe')]
        [Switch]$TrafficShaperPipe,
        [parameter(ParameterSetName = "TrafficShaperQueue")]
        [Alias('Queue')]
        [Switch]$TrafficShaperQueue
    )

    DynamicParam {
        # Create the dictionary 
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        if ($CaptivePortalZone) {
            $options = $(Invoke-OPNsenseCommand captiveportal settings searchzones).rows
        }
        if ($CronJob) {
            $options = $(Invoke-OPNsenseCommand cron settings searchjobs).rows
        }
        if ($FtpProxy) {
            $options = $(Invoke-OPNsenseCommand ftpproxy settings searchproxy).rows
        }
        if ($ProxyRemoteBlacklist) {
            $options = $(Invoke-OPNsenseCommand proxy settings searchremoteblacklists).rows
        }
        if ($Route) {
            $options = $(Invoke-OPNsenseCommand routes routes searchroute).rows
        }
        if ($TrafficShaperPipe) {
            $options = $(Invoke-OPNsenseCommand trafficshaper settings searchpipes).rows
        }
        if ($TrafficShaperQueue) {
            $options = $(Invoke-OPNsenseCommand trafficshaper settings searchqueues).rows
        }

        if ($options) {
            $options = $options | Select-Object -ExpandProperty Uuid
            $dynParam = New-ValidationDynamicParam -Name Uuid -Type '[String[]]' -Mandatory -ValidateSetOptions $options -Position 0 -ValueFromPipelineByPropertyName -ValueFromPipeline
            $RuntimeParameterDictionary.Add('Uuid', $dynParam)
        }
        return $RuntimeParameterDictionary
    }

    BEGIN {

    }

    PROCESS {
        foreach ($myuuid in $PSBoundParameters.Uuid) {
            if ($CaptivePortalZone) {
                $result += Invoke-OPNsenseCommand captiveportal settings "togglezone/$myuuid/1" -Form 'toggle'
            }
            if ($CronJob) {
                # Warning, CronJobs can only be toggled and not set directly.
                # It is needed to check the status first and toggle only when needed !!
                $result += Enable-OPNsenseCronJob -uuid $myuuid
            }
            if ($FtpProxy) {
                # Warning, FtpProxy can only be toggled and not set directly.
                # It is needed to check the status first and toggle only when needed !!
                $result += Invoke-OPNsenseCommand ftpproxy settings "toggleproxy/$myuuid" -Form 'toggle'
            }
            if ($IdsRule) {
                $result += Invoke-OPNsenseCommand ids settings "togglerule/$myuuid/1" -Form 'toggle'
            }
            if ($IdsRuleSet) {
                $result += Invoke-OPNsenseCommand ids settings "toggleruleset/$myuuid/1" -Form 'toggle'
            }
            if ($IdsUserRule) {
                $result += Invoke-OPNsenseCommand ids settings "toggleuserrule/$myuuid/1" -Form 'toggle'
            }
            if ($ProxyRemoteBlacklist) {
                # Warning, RemoteBlackLists can only be toggled and not set directly.
                # It is needed to check the status first and toggle only when needed !!
                $result += Invoke-OPNsenseCommand proxy settings "toggleremoteblacklist/$myuuid" -Form 'toggle'
            }
            if ($Route) {
                $result += Invoke-OPNsenseCommand routes routes "toggleRoute/$myuuid/0" -Form 'toggle' # 0 = enabled
            }
            if ($TrafficShaperPipe) {
                $result += Invoke-OPNsenseCommand trafficshaper settings "togglepipe/$myuuid/1" -Form 'toggle'
            }
            if ($TrafficShaperQueue) {
                $result += Invoke-OPNsenseCommand trafficshaper settings "togglequeue/$myuuid/1" -Form 'toggle'
            }
        }
    }

    END {
        return $result
    }
}