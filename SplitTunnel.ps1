$Subnet1 = '192.168.0.0/23'
$Subnet2 = '192.168.0.0/24'


try {
    Add-VpnConnection -Name '@ConnectionName@' -ServerAddress '@ServerAddress@' -AllUserConnection -AuthenticationMethod Pap -DnsSuffix '@DnsSuffix@' -EncryptionLevel Optional -L2tpPsk '@PSK@' -Force -TunnelType L2tp -SplitTunneling $true
}
catch {
    Set-VpnConnection -Name '@ConnectionName@' -ServerAddress '@ServerAddress@' -AllUserConnection -AuthenticationMethod Pap -DnsSuffix '@DnsSuffix@' -EncryptionLevel Optional -L2tpPsk '@PSK@' -Force -TunnelType L2tp -SplitTunneling $true
}
finally {

    if(Get-VpnConnection $Name -AllUserConnection -ErrorAction Ignore) {
        try {
            
            Add-VpnConnectionRoute -ConnectionName '@ConnectionName@' -DestinationPrefix $Subnet1  -AllUserConnection -PassThru
            Add-VpnConnectionRoute -ConnectionName '@ConnectionName@' -DestinationPrefix $Subnet2  -AllUserConnection -PassThru 
        }
        catch {
            Write-Warning "Unable to add VPN routes" 
        }
    }
}