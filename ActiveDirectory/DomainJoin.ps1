# achahal

Param(
    [Parameter(Mandatory = $true)][string]$DomainUser,
    [Parameter(Mandatory = $true)][string]$DomainCert,
    [Parameter(Mandatory = $true)][string]$Domain
)

$DomainCertSec = $DomainCert | ConvertTo-SecureString -AsPlainText -Force
Get-ChildItem -Path "Powershell_Encryption.pfx" | Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\My -Password $DomainCertSec
$Cert = Get-ChildItem -path Cert:\LocalMachine\My |Where {$_.Subject -eq 'CN=Powershell Automation'}
$Cms = Get-Content "DomainInfo.txt" | Out-String
$DomainPass = Unprotect-CmsMessage -To $Cert -Content $Cms

$SecDomainPass = ConvertTo-SecureString $DomainPass -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential ($DomainUser, $SecDomainPass)

try {
Add-Computer -DomainName $Domain -Credential $Credentials
}
catch {
Write-Warning "Something went wrong with the Domain Join."
}

Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -eq "CN=Powershell Automation"} | Remove-Item