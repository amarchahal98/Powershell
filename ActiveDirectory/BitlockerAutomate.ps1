#achahal
Write-Output "Enter AD Domain Join Credentials:"
$DomCreds = Get-Credential
Clear-DnsClientCache
$PingResult = Test-NetConnection  -ComputerName "compname"
if ($PingResult.PingSucceeded -eq $False) {
    Write-Warning "No access to domain.dns. Confirm the VPN is connected"
    exit

}
    
try {
        Add-Computer -DomainName domain.dns -Credential $DomCreds
    }
       
catch {
        Write-Warning "Something went wrong with domain join: $_"
        exit
    }

gpupdate /force
enable-bitlocker -mountpoint 'C:' -RecoveryPasswordProtector -UsedSpaceOnly -SkipHardwareTest

$bitid = (Get-BitLockerVolume -MountPoint C).Keyprotector |Where-Object {$_.KeyProtectorType -eq "RecoveryPassword"} | Select-Object -ExpandProperty KeyProtectorId
manage-bde -protectors -adbackup c: -id $bitid

# --- BITLOCKER ONLY ---

gpupdate /force

try {
enable-bitlocker -mountpoint 'C:' -RecoveryPasswordProtector -UsedSpaceOnly -SkipHardwareTest

$bitid = (Get-BitLockerVolume -MountPoint C).Keyprotector |Where-Object {$_.KeyProtectorType -eq "RecoveryPassword"} | Select-Object -ExpandProperty KeyProtectorId
manage-bde -protectors -adbackup c: -id $bitid
}

catch {
Write-warning "Error with Bitlocker process."
}