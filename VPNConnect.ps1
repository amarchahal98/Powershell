# achahal

Param(
    [Parameter(Mandatory = $true)][string]$CertPW
)


$connectcmd = 'test.com'
$username = 'testuser'
$CertPWEncrypted = $CertPW | ConvertTo-SecureString -AsPlainText -Force
$VPNAccept = 'y'

# Import Cert
Get-ChildItem -Path "Powershell_Encryption.pfx" | Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -Password $CertPWEncrypted
$Cert = Get-ChildItem -path Cert:\LocalMachine\My |Where {$_.Subject -eq 'CN=Powershell Automation'}

# Decrypt Password
$Cms = get-content "cms.txt" | Out-String
$VPNPassword = Unprotect-CmsMessage -To $Cert -Content $Cms

# Create Dat File

try {
New-item c:\VPNConnect.dat -ErrorAction SilentlyContinue
}
catch {
Write-Warning "VPN Dat file already exists, overwriting"
}

set-content -path c:\vpnconnect.dat -value $connectcmd, $username, $VPNPassword, $VPNAccept


if ((get-process vpnui -ErrorAction SilentlyContinue) -ne $null) {
Stop-Process -name vpnui -Force
}

if ((get-process vpncli -ErrorAction SilentlyContinue) -ne $null) {
Stop-Process -name vpncli -Force
}


# Connect to VPN
$j = start-job -ScriptBlock {
cmd.exe /c '"c:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\vpncli.exe" -s < c:\vpnconnect.dat'
}

wait-job $j -Timeout 45 | Out-Null
if ($j.State -eq "Completed") {"VPN Connection successful."}
elseif ($j.State -eq "Running") {"VPN Timeout"}
else {"Unknown Error"}
remove-job -Force $j

#Cleanup
remove-item C:\VPNConnect.dat
Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -eq "CN=Powershell Automation"} | Remove-Item
