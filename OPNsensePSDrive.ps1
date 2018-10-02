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

[SHiPSProvider(UseCache = $true)]
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
            '/Services/Freeradius/Clients/' {
                $obj += Get-OPNsenseItem -Freeradius Client
            }
            '/Services/Freeradius/Users/' {
                $obj += Get-OPNsenseItem -Freeradius User
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