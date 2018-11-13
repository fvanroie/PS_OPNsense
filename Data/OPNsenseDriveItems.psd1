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

<#  Purpose

    The items in this hashtable describe OPNsense CRUD item that gets listed for a specific path
    The key is the OPNsenseDrive path and the value cosists of the splat parameters that get
    passed to the cmdlet Get-OPNsenseItem
#>

@{
 
    '/Firewall/Aliases/'                                        = @{
        'Module' = 'Firewall'
        'Item'   = 'Alias'
    }

    '/Firewall/Shaper/Settings/Pipes/'                          = @{
        'Module' = 'TrafficShaper'
        'Item'   = 'Pipe'
    }

    '/Firewall/Shaper/Settings/Queues/'                         = @{
        'Module' = 'TrafficShaper'
        'Item'   = 'Queue'
    }

    '/Firewall/Shaper/Settings/Rules/'                          = @{
        'Module' = 'TrafficShaper'
        'Item'   = 'Rule'
    }

    '/Routing/BGPv4/AS Path Lists/'                             = @{
        'Module' = 'Quagga'
        'Item'   = ''
    }

    '/Routing/BGPv4/Neighbors/'                                 = @{
        'Module' = 'Quagga'
        'Item'   = ''
    }

    '/Routing/BGPv4/Prefix Lists/'                              = @{
        'Module' = 'Quagga'
        'Item'   = ''
    }

    '/Routing/BGPv4/Route Maps/'                                = @{
        'Module' = 'Quagga'
        'Item'   = ''
    }

    '/Routing/OSPF/Interfaces/'                                 = @{
        'Module' = 'Quagga'
        'Item'   = ''
    }

    '/Routing/OSPF/Networks/'                                   = @{
        'Module' = 'Quagga'
        'Item'   = ''
    }

    '/Routing/OSPF/Prefix Lists/'                               = @{
        'Module' = 'Quagga'
        'Item'   = ''
    }

    '/Routing/OSPFv3/Interfaces/'                               = @{
        'Module' = 'Quagga'
        'Item'   = ''
    }

    '/Services/Bind/Configuration/ACLs/'                        = @{
        'Module' = 'Bind'
        'Item'   = 'Acl'
    }

    '/Services/Captive Portal/Administration/Templates/'        = @{
        'Module' = 'Captiveportal'
        'Item'   = 'Template'
    }

    '/Services/Captive Portal/Administration/Zones/'            = @{
        'Module' = 'Captiveportal'
        'Item'   = 'Zone'
    }

    '/Services/Freeradius/Clients/'                             = @{
        'Module' = 'Freeradius'
        'Item'   = 'Client'
    }

    '/Services/Freeradius/Users/'                               = @{
        'Module' = 'Freeradius'
        'Item'   = 'User'
    }

    '/Services/FTP Proxy/'                                      = @{
        'Module' = 'FtpProxy'
        'Item'   = 'Proxy'
    }

    '/Services/HAProxy/Settings/ACLs/'                          = @{
        'Module' = 'HAProxy'
        'Item'   = 'Acl'
    }

    '/Services/HAProxy/Settings/Actions/'                       = @{
        'Module' = 'HAProxy'
        'Item'   = 'Action'
    }

    '/Services/HAProxy/Settings/Backends/'                      = @{
        'Module' = 'HAProxy'
        'Item'   = 'Backend'
    }

    '/Services/HAProxy/Settings/Error Files/'                   = @{
        'Module' = 'HAProxy'
        'Item'   = 'ErrorFile'
    }

    '/Services/HAProxy/Settings/Frontends/'                     = @{
        'Module' = 'HAProxy'
        'Item'   = 'Frontend'
    }

    '/Services/HAProxy/Settings/Health Checks/'                 = @{
        'Module' = 'HAProxy'
        'Item'   = 'Healthcheck'
    }

    '/Services/HAProxy/Settings/Lua Scripts/'                   = @{
        'Module' = 'HAProxy'
        'Item'   = 'LuaScript'
    }

    '/Services/HAProxy/Settings/Map Files/'                     = @{
        'Module' = 'HAProxy'
        'Item'   = 'MapFile'
    }

    '/Services/HAProxy/Settings/Servers/'                       = @{
        'Module' = 'HAProxy'
        'Item'   = 'Server'
    }

    '/Services/Let''s Encrypt/Accounts/'                        = @{
        'Module' = 'AcmeClient'
        'Item'   = 'Account'
    }

    '/Services/Let''s Encrypt/Certificates/'                    = @{
        'Module' = 'AcmeClient'
        'Item'   = 'Certificate'
    }

    '/Services/Let''s Encrypt/Restart Actions/'                 = @{
        'Module' = 'AcmeClient'
        'Item'   = 'Action'
    }

    '/Services/Let''s Encrypt/Validation Methods/'              = @{
        'Module' = 'AcmeClient'
        'Item'   = 'Validation'
    }

    '/Services/Monit/Settings/Alert/'                           = @{
        'Module' = 'Monit'
        'Item'   = 'Alert'
    }

    '/Services/Monit/Settings/Service Tests/'                   = @{
        'Module' = 'Monit'
        'Item'   = 'Test'
    }

    '/Services/Monit/Settings/Service/'                         = @{
        'Module' = 'Monit'
        'Item'   = 'Service'
    }

    '/Services/Net-SNMP/SNMPv3 Users/'                          = @{
        'Module' = 'NetSNMP'
        'Item'   = 'User'
    }

    '/Services/Nginx/Configuration/Access/Connection Limits/'   = @{
        'Module' = 'Nginx'
        'Item'   = 'LimitRequestConnection'
    }

    '/Services/Nginx/Configuration/Access/Limit Zone/'          = @{
        'Module' = 'Nginx'
        'Item'   = 'LimitZone'
    }

    '/Services/Nginx/Configuration/HTTP(S)/Credential/'         = @{
        'Module' = 'Nginx'
        'Item'   = 'Credential'
    }

    '/Services/Nginx/Configuration/HTTP(S)/HTTP Server/'        = @{
        'Module' = 'Nginx'
        'Item'   = 'HttpServer'
    }

    '/Services/Nginx/Configuration/HTTP(S)/Location/'           = @{
        'Module' = 'Nginx'
        'Item'   = 'Location'
    }

    '/Services/Nginx/Configuration/HTTP(S)/Naxsi WAF Policy/'   = @{
        'Module' = 'Nginx'
        'Item'   = 'CustomPolicy'
    }

    '/Services/Nginx/Configuration/HTTP(S)/Naxsi WAF Rule/'     = @{
        'Module' = 'Nginx'
        'Item'   = 'NaxsiRule'
    }

    '/Services/Nginx/Configuration/HTTP(S)/Security Headers/'   = @{
        'Module' = 'Nginx'
        'Item'   = 'SecurityHeader'
    }

    '/Services/Nginx/Configuration/HTTP(S)/Upstream Server/'    = @{
        'Module' = 'Nginx'
        'Item'   = 'UpstreamServer'
    }

    '/Services/Nginx/Configuration/HTTP(S)/Upstream/'           = @{
        'Module' = 'Nginx'
        'Item'   = 'Upstream'
    }

    '/Services/Nginx/Configuration/HTTP(S)/URL Rewriting/'      = @{
        'Module' = 'Nginx'
        'Item'   = 'HttpRewrite'
    }

    '/Services/Nginx/Configuration/HTTP(S)/User List/'          = @{
        'Module' = 'Nginx'
        'Item'   = 'UserList'
    }

    '/Services/Postfix/Domains/'                                = @{
        'Module' = 'Postfix'
        'Item'   = 'Domain'
    }

    '/Services/Postfix/Recipients/'                             = @{
        'Module' = 'Postfix'
        'Item'   = 'Recipient'
    }

    '/Services/Postfix/Senders/'                                = @{
        'Module' = 'Postfix'
        'Item'   = 'Senders'
    }

    '/Services/Relayd/Settings/Backend Hosts/'                  = @{
        'Module' = 'Relayd'
        'Item'   = 'Host'
    }

    '/Services/Relayd/Settings/Protocols/'                      = @{
        'Module' = 'Relayd'
        'Item'   = 'Protocol'
    }

    '/Services/Relayd/Settings/Table Checks/'                   = @{
        'Module' = 'Relayd'
        'Item'   = 'TableCheck'
    }

    '/Services/Relayd/Settings/Tables/'                         = @{
        'Module' = 'Relayd'
        'Item'   = 'Table'
    }

    '/Services/Relayd/Settings/Virtual Servers/'                = @{
        'Module' = 'Relayd'
        'Item'   = 'VirtualServer'
    }

    '/Services/Siproxd/Outbound Domains/'                       = @{
        'Module' = 'Siproxd'
        'Item'   = 'Domain'
    }

    '/Services/Siproxd/Users/'                                  = @{
        'Module' = 'Siproxd'
        'Item'   = 'User'
    }

    '/Services/Telegraf/General/Tags/'                          = @{
        'Module' = 'Telegraf'
        'Item'   = 'Key'
    }

    '/Services/Tor/Configuration/Exit Node ACL/'                = @{
        'Module' = 'Tor'
        'Item'   = 'ExitAcl'
    }

    '/Services/Tor/Configuration/Onion Service Authentication/' = @{
        'Module' = 'Tor'
        'Item'   = 'HiddenServiceACL'
    }

    '/Services/Tor/Configuration/Onion Service Routing/'        = @{
        'Module' = 'Tor'
        'Item'   = ''
    }

    '/Services/Tor/Configuration/Onion Services/'               = @{
        'Module' = 'Tor'
        'Item'   = 'HiddenService'
    }

    '/Services/Tor/Configuration/SOCKS Proxy ACL/'              = @{
        'Module' = 'Tor'
        'Item'   = 'SocksACL'
    }

    '/Services/Wake on LAN/Hosts/'                              = @{
        'Module' = 'Wol'
        'Item'   = 'Host'
    }

    '/Services/Web Proxy/Administration/PAC Matches/'           = @{
        'Module' = 'Proxy'
        'Item'   = 'PacMatch'
    }

    '/Services/Web Proxy/Administration/PAC Proxies/'           = @{
        'Module' = 'Proxy'
        'Item'   = 'PacProxy'
    }

    '/Services/Web Proxy/Administration/PAC Rules/'             = @{
        'Module' = 'Proxy'
        'Item'   = 'PacRule'
    }

    '/Services/Web Proxy/Administration/Remote ACL/'            = @{
        'Module' = 'Proxy'
        'Item'   = 'RemoteBlacklist'
    }

    '/Services/Web Proxy/Groups and Users/'                     = @{
        'Module' = 'ProxyUserACL'
        'Item'   = 'UserAcl'
    }

    '/System/Routes/Configuration/'                             = @{
        'Module' = 'Routes'
        'Item'   = 'Route'
    }

    '/System/Settings/Cron/Jobs/'                               = @{
        'Module' = 'Cron'
        'Item'   = 'Job'
    }

    '/VPN/Tinc/Configuration/Hosts/'                            = @{
        'Module' = 'Tinc'
        'Item'   = 'Host'
    }

    '/VPN/Tinc/Configuration/Networks/'                         = @{
        'Module' = 'Tinc'
        'Item'   = 'Network'
    }

    '/VPN/Wireguard/Endpoints/'                                 = @{
        'Module' = 'Wireguard'
        'Item'   = 'Client'
    }

    '/VPN/Wireguard/Servers/'                                   = @{
        'Module' = 'Wireguard'
        'Item'   = 'Server'
    }

    '/VPN/Zerotier/Settings/Networks/'                          = @{
        'Module' = 'Zerotier'
        'Item'   = 'Network'
    }
}