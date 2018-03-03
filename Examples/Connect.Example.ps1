#Requires -Modules PS_OPNsense

$beVerbose = $false

# Import the PS_OPNsense PowerShell Module
Import-Module -Name PS_OPNsense -Verbose:$beVerbose

# Define connection parameters
$apiKey = '<my OPNsense api key>'
$apiPwd = '<my OPNsense api secret>' | ConvertTo-SecureString -AsPlainText -Force
$Url = 'https://opnsense.localdomain:443'

# Convert the connection parameters into a PowerShell Credentials Object
$apiCred = New-Object System.Management.Automation.PSCredential -ArgumentList $apiKey, $apiPwd

# Specify webcredentials only if you need to use legacy web commands
# $webCred = Get-Credential -Username 'admin' -Message 'Enter the password for the WebUI:'

# Connect to OPNsense server
# Note: Use -SkipCertificateCheck if you are using a self-signed certificate
$conn = Connect-OPNsense -Url $Url -Credential $apiCred -SkipCertificateCheck -Verbose:$beVerbose  #-WebCredential $webCred

# Display the version
$conn | Format-Table

# Run security audit and display the result
Invoke-OPNsenseAudit -Raw -Verbose:$beVerbose | Format-List


# # #   DO OTHER STUFF HERE   . . .


## Disconnect from OPNsense server
# Disconnect-OPNsense -Verbose:$beVerbose