# achahal
gpupdate /force
try {

if ((Get-BitLockerVolume -MountPoint "C:").VolumeStatus -eq "FullyDecrypted") {

enable-bitlocker -mountpoint 'C:' -RecoveryPasswordProtector -UsedSpaceOnly -SkipHardwareTest

}

$bitid = (Get-BitLockerVolume -MountPoint C).Keyprotector |Where-Object {$_.KeyProtectorType -eq "RecoveryPassword"} | Select-Object -ExpandProperty KeyProtectorId
manage-bde -protectors -adbackup c: -id $bitid
}

catch {
Write-warning "Error with Bitlocker process." 
}