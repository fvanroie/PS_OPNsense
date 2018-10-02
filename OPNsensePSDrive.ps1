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
                $obj += [OPNsenseDrivePackages]::new($item.Id, $item.VisibleName, $item.Children)
            #}
        }
        
        return $obj;
    }
}

[SHiPSProvider(UseCache = $true)]
class OPNsenseDrivePackages : SHiPSDirectory {
    [string] $item
    [Object[]]$children

    OPNsenseDrivePackages([string]$id, [string]$item, [Object[]]$children): base($name) {
        $this.name = $id
        $this.item = $item
        $this.children = $children
    }

    [object[]] GetChildItem() {
        $obj = @()  
        
        foreach ($item in $this.children) {         
            
            #$obj += $pkg
            #if ($item.isVisible) {
                $obj += [OPNsenseDrivePackages]::new($item.Id, $item.VisibleName, $item.Children)
            #}
            
        }

        return $obj;
    }
}