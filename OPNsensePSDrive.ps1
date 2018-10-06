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
            $obj += [OPNsenseMenuItem]::new($item.Id, $item.VisibleName, '/', $item.Children)
            #}
        }
        
        return $obj;
    }
}

[SHiPSProvider(UseCache = $false)]
class OPNsenseMenuItem : SHiPSDirectory {
    [string] $item
    [string] $parent
    [Object[]]$children

    OPNsenseMenuItem([string]$id, [string]$item, [string]$parent, [Object[]]$children): base($name) {
        $this.name = $id
        $this.item = $item
        $this.parent = $parent
        $this.children = $children
    }

    [object[]] GetChildItem() {
        
        $obj = @()
        $fullPath = $this.parent + $this.name + '/'

        Switch ($fullPath) {
            '/Firewall/Shaper/Pipes/' {
                $obj += Get-OPNsenseItem -TrafficShaper Pipe
            }
            '/Firewall/Shaper/Queues/' {
                $obj += Get-OPNsenseItem -TrafficShaper Queue
            }
            '/Firewall/Shaper/Rules/' {
                $obj += Get-OPNsenseItem -TrafficShaper Rule
            }

            '/Lobby/HelloWorld/' {
                $obj += Get-OPNsenseSetting -Module HelloWorld -Setting General
            }

            '/Services/Freeradius/Clients/' {
                $obj += Get-OPNsenseItem -Freeradius Client
            }
            '/Services/Freeradius/Users/' {
                $obj += Get-OPNsenseItem -Freeradius User
            }

            '/Services/Lldpd/' {
                $newParent = '{0}{1}/' -f $this.parent, $this.name
                $obj += [OPNsenseMenuItem]::new('General', 'General', $newParent, $null)
                $obj += [OPNsenseMenuItem]::new('Neighbors', 'Neighbors', $newParent, $null)
            }

            '/Services/CaptivePortal/Administration/' {
                $newParent = '{0}{1}/' -f $this.parent, $this.name
                $obj += [OPNsenseMenuItem]::new('Zones', 'Zones', $newParent, $null)
                $obj += [OPNsenseMenuItem]::new('Templates', 'Templates', $newParent, $null)
            }
            '/Services/CaptivePortal/Administration/Zones/' {
                $obj += Get-OPNsenseItem -Module CaptivePortal -Item Zone
            }
            '/Services/CaptivePortal/Administration/Templates/' {
                $obj += Get-OPNsenseItem -Module CaptivePortal -Item Template
            }

            '/Services/Bind/Configuration/' {
                $newParent = '{0}{1}/' -f $this.parent, $this.name
                $obj += [OPNsenseMenuItem]::new('General', 'General', $newParent, $null)
                $obj += [OPNsenseMenuItem]::new('DNSBL', 'DNSBL', $newParent, $null)
                $obj += [OPNsenseMenuItem]::new('ACLs', 'ACLs', $newParent, $null)
            }
            '/Services/Bind/Configuration/General/' {
                $obj += Get-OPNsenseSetting -Module Bind General
            }
            '/Services/Bind/Configuration/DNSBL/' {
                $obj += Get-OPNsenseSetting -Module Bind DNSBL
            }
            '/Services/Bind/Configuration/ACLs/' {
                $obj += Get-OPNsenseItem -Module Bind -Item Acl
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
                        $obj += [OPNsenseMenuItem]::new($item.Id, $item.VisibleName, $newParent, $item.Children)
                    }
                    
                }
            }
        }

        return $obj;
    }

}