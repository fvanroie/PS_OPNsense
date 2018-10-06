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

Function Get-Services {
    param (
        [Parameter(Mandatory = $true, position = 1)][String]$Action
    )
    switch ($action) {
        'status' {
            Return @(
                'acmeclient',
                'cicap',
                'clamav',
                'collectd',
                'freeradius',
                'haproxy',
                'ids',
                'lldpd',
                'mdnsrepeater',
                'monit',
                #'postfix',
                'proxy',
                'quagga',
                'siproxd',
                'telegraf',
                #'tinc',
                #'tor',
                #'trafficshaper',
                'zabbixagent'
                #'zabbixproxy',
                #'zerotier'
            )
        }
        'reconfigure' {
            Return @(
                'acmeclient',
                'cicap',
                'clamav',
                'collectd',
                'cron',
                'freeradius',
                'haproxy',
                'ids',
                'postfix',
                'proxy',
                'quagga',
                'siproxd',
                'telegraf',
                'tor',
                'trafficshaper',
                'zabbixagent',
                'zabbixproxy'
            )
        }
        'start' {
            Return @(
                'acmeclient',
                'arpscanner',
                'clamav',
                'collectd',
                'diagnostics',
                'freeradius',
                'ftpproxy',
                'haproxy',
                'mdnsrepeater',
                'monit',
                'proxy',
                'quagga',
                'rspamd',
                'siproxd',
                'telegraf',
                'tinc',
                'tor',
                'zabbixagent',
                'zabbixproxy'
            )
        }
        'restart' {
            Return @(
                'acmeclient',
                'arpscanner',
                'clamav',
                'collectd',
                'ftpproxy',
                'haproxy',
                'helloworld',
                'ids',
                'mdnsrepeater',
                'monit',
                'postfix',
                'proxy',
                'quagga',
                'rspamd',
                'siproxd',
                'telegraf',
                'tinc',
                'zabbixagent'
            )
        }
        'stop' {
            Return @(
                'acmeclient',
                'arpscanner',
                'captiveportal',
                'clamav',
                'collectd',
                'freeradius',
                'ftpproxy',
                'haproxy',
                'ids',
                'mdnsrepeater',
                'monit',
                'proxy',
                'quagga',
                'rspamd',
                'siproxd',
                'telegraf',
                'tinc',
                'tor',
                'zabbixagent',
                'zabbixproxy'
            )
        }
        'testconfig' {
            Return @(
                'acmeclient',
                'haproxy',
                'monit'
            )
        }
    }
}
