#Requires -Modules PS_OPNsense

$beVerbose = $false

# Import the PS_OPNsense PowerShell Module
Import-Module -Name PS_OPNsense -Verbose:$beVerbose

# Define connection parameters
$key = '<my OPNsense api key>'
$SecurePassword = '<my OPNsense api secret>' | ConvertTo-SecureString -AsPlainText -Force
$url = 'https://opnsense.localdomain:80'

# Convert the connection parameters into a PowerShell Credentials Object
$apiCred = New-Object System.Management.Automation.PSCredential -ArgumentList $Key, $SecurePassword

# Specify webcredentials only if you need to use legacy web commands
# $webCred = Get-Credential -Username 'admin' -Message 'Enter the password for the WebUI:'

# Connect to OPNsense server
# Note: Use -SkipCertificateCheck if you are using a self-signed certificate
$conn = Connect-OPNsense -Url $url -Credential $apiCred -SkipCertificateCheck  -Verbose:$beVerbose # -WebCredential $webCred

# Display the version
$conn | Format-Table

# Run the security audit and display the result
Invoke-OPNsenseAudit -Raw -Verbose:$beVerbose | Format-List


# # #   DO OTHER STUFF HERE   . . .


## Disconnect from OPNsense server
Disconnect-OPNsense -Verbose:$beVerbose