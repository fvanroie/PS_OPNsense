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

<# 
    The items in this hashtable describe additional paths in the OPNsenseDrive tree
    The key is the parent path and the value is an array of childitems below that folder

    Only items that don't exist in the actual opnsense menu tree need to be listed
#>

@{
    '/Routing/BGPv4/'                          = @(
        'AS Path Lists'
        'Neighbors'
        'Prefix Lists'
        'Route Maps'
    )
    '/Routing/OSPF/'                           = @(
        'Interfaces'
        'Networks'
        'Prefix Lists'
    )
    '/Routing/OSPFv3/'                         = @(
        'Interfaces'
    )

    '/Services/Bind/Configuration/'            = @(
        'General'
        'Blocklists'
        'ACLs'
    )
    '/Services/Captive Portal/Administration/' = @(
        'Templates'
        'Zones'
    )
    '/Services/Lldpd/'                         = @(
        'General'
        'Neighbors'
    )
    '/Services/Monit/Settings/'                = @(
        'General'
        'Alert'
        'Service'
        'Service Tests'
    )
    '/Services/Net-SNMP/'                      = @(
        'SNMPv3 Users'
    )
    '/Services/Nginx/Configuration/'           = @(
        'Access'
        'HTTP(S)'
    )
    '/Services/Nginx/Configuration/Access/'    = @(
        'Connection Limits'
        'Limit Zone'
    )
    '/Services/Nginx/Configuration/HTTP(S)/'   = @(
        'Credential'
        'HTTP Server'
        'Location'
        'Naxsi WAF Policy'
        'Naxsi WAF Rule'
        'Security Headers'
        'Upstream'
        'Upstream Server'
        'URL Rewriting'
        'User List'
    )
    '/Services/Relayd/Settings/'               = @(
        'Backend Hosts'
        'Protocols'
        'Tables'
        'Table Checks'
        'Virtual Servers'
    )
    '/Services/Siproxd/'                       = @(
        'Outbound Domains'
        'Users'
    )
    '/Services/Telegraf/General/'              = @(
        'Tags'
    )
    '/Services/Tor/Configuration/'             = @(
        'Exit Node ACL'
        'Onion Services'
        'Onion Service Authentication'
        'Onion Service Routing'
        'SOCKS Proxy ACL'
    )
    '/Services/VnStat/'                        = @(
        'Settings'
        'Statistics'
    )
    '/Services/VnStat/Settings/'               = @(
        'General'
    )
    '/Services/VnStat/Statistics/'             = @(
        'Hourly'
        'Daily'
        'Weekly'
        'Monthly'
    )
    '/Services/Wake on LAN/'                   = @(
        'Hosts'
    )

    '/System/Firmware/'                        = @(
        'Mirrors'
    )
    '/System/Settings/Cron/'                   = @(
        'Jobs'
    )

    '/VPN/Tinc/Configuration/'                 = @(
        'Hosts'
        'Networks'
    )
    '/VPN/Wireguard/'                          = @(
        'Endpoints'
        'Servers'
    )
    '/VPN/Zerotier/Settings/'                  = @(
        'Networks'
    )

}