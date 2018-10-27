using namespace Microsoft.PowerShell.SHiPS

[SHiPSProvider(UseCache = $true)]
class OPNsenseDrive : SHiPSDirectory {

    static [PSCredential] $Credential
    static [String] $Url = 'http://opnsense.localdomain'
    static [Boolean] $SkipCertificateCheck = $true

    OPNsenseDrive([string]$name): base($name) {

        $apiCred = [OPNsenseDrive]::Credential

        if (!$apiCred -Or !$apiCred.Username) {
            Throw "Please specify the api credentials."
        }


        try {
            $context = Connect-OPNsense -Url $([OPNsenseDrive]::Url) -Credential $([OPNsenseDrive]::Credential) -SkipCertificateCheck:$([OPNsenseDrive]::SkipCertificateCheck) -WarningAction 'SilentlyContinue' -erroraction Stop
        } catch {
            throw ("Unable to Connect to OPNsense server '{0}' using api key '{1}'" -f $([OPNsenseDrive]::Url), $([OPNsenseDrive]::credential).username)
        }

        $context = Get-OPNsense
        if ([String]::IsNullOrEmpty($context)) {
            throw "Unable to get the OPNsense status info"
        }
    } 

    [object[]] GetChildItem() {
        $obj = @()  
        
        $menuItems = Invoke-OPNsenseCommand core menu tree
        foreach ($item in $menuItems) {   
            #if ($item.isVisible) {
            $obj += [OPNsenseMenuItem]::new($item.VisibleName, $item.Id, '/', $item.Children)
            #}
        }
        
        return $obj;
    }
}

[SHiPSProvider(UseCache = $false)]
class OPNsenseMenuItem : SHiPSDirectory {
    [string] $id
    [string] $parent
    [Object[]]$children

    OPNsenseMenuItem([string]$name, [string]$id, [string]$parent, [Object[]]$children): base($name) {
        $this.name = $name
        $this.id = $id
        $this.parent = $parent
        $this.children = $children
    }

    [object[]] GetChildItem() {
        
        $obj = @()
        $FullPath = $this.parent + $this.name + '/'

        $SubMenuItems = @{
            '/Services/Bind/Configuration/'            = @(
                'General', 'Blocklists', 'ACLs'
            )
            '/Services/Captive Portal/Administration/' = @(
                'Zones', 'Templates'
            )
            '/Services/Lldpd/'                         = @(
                'General', 'Neighbors'
            )
            '/Services/Monit/Settings'                 = @(
                'General', 'Alert', 'Service', 'Service Tests'
            )
            '/Services/VnStat/'                        = @(
                'Settings', 'Statistics'
            )
            '/Services/VnStat/Settings/'               = @(
                'General'
            )
            '/Services/VnStat/Statistics/'             = @(
                'Hourly', 'Daily', 'Weekly', 'Monthly'
            )
            '/Services/Wake on LAN/'                   = @(
                'Hosts'
            )

            '/System/Firmware/'                        = @(
                'Mirrors'
            )
        }

        $GetItems = @{
            #region Firewall
            '/Firewall/Shaper/Pipes/'                 = @{
                'Module' = 'TrafficShaper'
                'Item'   = 'Pipe'
            }
            '/Firewall/Shaper/Queues/'                = @{
                'Module' = 'TrafficShaper'
                'Item'   = 'Queue'
            }
            '/Firewall/Shaper/Rules/'                 = @{
                'Module' = 'TrafficShaper'
                'Item'   = 'Rule'
            }
            #endregion
            
            #region Bind
            '/Services/Bind/Configuration/ACLs/'      = @{
                'Module' = 'Bind'
                'Item'   = 'Acl'
            }
            #endregion
            #region Freeradius
            '/Services/Freeradius/Clients/'           = @{
                'Module' = 'Freeradius'
                'Item'   = 'Client'
            }
            '/Services/Freeradius/Users/'             = @{
                'Module' = 'Freeradius'
                'Item'   = 'User'
            }
            #endregion
            #region Monit
            '/Services/Monit/Settings/Alert/'         = @{
                'Module' = 'Monit'
                'Item'   = 'Alert'
            }
            '/Services/Monit/Settings/Service/'       = @{
                'Module' = 'Monit'
                'Item'   = 'Service'
            }
            '/Services/Monit/Settings/Service Tests/' = @{
                'Module' = 'Monit'
                'Item'   = 'Test'
            }
            #endregion
            #region Postfix
            '/Services/Postfix/Domains/'              = @{
                'Module' = 'Postfix'
                'Item'   = 'Domain'
            }
            '/Services/Postfix/Recipients/'           = @{
                'Module' = 'Postfix'
                'Item'   = 'Recipient'
            }
            '/Services/Postfix/Senders/'              = @{
                'Module' = 'Postfix'
                'Item'   = 'Sender'
            }
            #endregion
            #region Wake on LAN
            '/Services/Wake on LAN/Hosts/'            = @{
                'Module' = 'Wol'
                'Item'   = 'Host'
            }
            #endregion
        }


        if ($SubMenuItems.keys -contains $Fullpath) {
            foreach ($item in $SubMenuItems.$Fullpath) {
                $obj += [OPNsenseMenuItem]::new($item, $item, $FullPath, $null)
            }
        }

                
        if ($GetItems.keys -contains $Fullpath) {
            $Splat = $GetItems.$FullPath
            $obj += Get-OPNsenseItem @Splat
        }

        Switch ($fullPath) {

            '/Lobby/HelloWorld/' {
                $obj += Get-OPNsenseSetting -Module HelloWorld -Setting General
            }

            '/Services/Bind/Configuration/General/' {
                $obj += Get-OPNsenseSetting -Module Bind General
            }
            '/Services/Bind/Configuration/DNSBL/' {
                $obj += Get-OPNsenseSetting -Module Bind DNSBL
            }
            '/Services/BIND/Configuration/ACLs/' {
                $obj += Get-OPNsenseItem -Module Bind -Item Acl
            }

            '/Services/Captive Portal/Administration/Zones/' {
                $obj += Get-OPNsenseItem -Module CaptivePortal -Item Zone
            }
            '/Services/Captive Portal/Administration/Templates/' {
                $obj += Get-OPNsenseItem -Module CaptivePortal -Item Template
            }

            '/Services/VnStat/Statistics/Hourly/' {
                $obj += Invoke-OPNsenseCommand vnstat service hourly -Property Response
            }
            '/Services/VnStat/Statistics/Daily/' {
                $obj += Invoke-OPNsenseCommand vnstat service daily -Property Response
            }
            '/Services/VnStat/Statistics/Weekly/' {
                $obj += Invoke-OPNsenseCommand vnstat service weekly -Property Response
            }
            '/Services/VnStat/Statistics/Monthly/' {
                $obj += Invoke-OPNsenseCommand vnstat service monthly -Property Response
            }

            '/System/Firmware/Updates/' {
                $obj += Get-OPNsenseUpdate
            }
            '/System/Firmware/Packages/' {
                $obj += Get-OPNsensePackage -Package
            }
            '/System/Firmware/Plugins/' {
                $obj += Get-OPNsensePackage -Plugin
            }
            '/System/Firmware/Mirrors/' {
                $obj += Get-OPNsense -Mirror
            }
            '/System/Firmware/Settings/' {
                $obj += Invoke-OPNsenseCommand core firmware getfirmwareconfig
            }

            '/Routing/General/' {
                $obj += Get-OPNsenseSetting -Module Quagga -Setting General
            }
            '/Routing/RIP/' {
                $obj += Get-OPNsenseSetting -Module Quagga -Setting RIP
            }
            '/Routing/OSPF/General/' {
                $obj += Get-OPNsenseSetting -Module Quagga -Setting Ospf
            }

            '/System/Routes/Configuration/' {
                $obj += Get-OPNsenseItem -Routes Route
            }
            '/System/Routes/Status/' {
                $obj += Get-OPNsenseRouteTable
            }

            default {
                foreach ($item in $this.children) {         
                    #$obj += $pkg
                    if ($item.isVisible -and $item.url -notlike '*.php*') {
                        $newParent = '{0}{1}/' -f $this.parent, $this.name
                        $obj += [OPNsenseMenuItem]::new($item.VisibleName, $item.Id, $newParent, $item.Children)
                    }
                    
                }
            }
        }

        return $obj;
    }

}