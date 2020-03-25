### Purge Profile ###
# Clear Recycle Bin
Clear-recyclebin -Force
# Clear Downloads
Remove-Item ~\Downloads\*
$ChromeH = "$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default\history"
remove-item $ChromeH
# Clear Autodesk Licensing Data
remove-item C:\programdata\Autodesk\CLM\LGS\* -Recurse -Force

# Enable site to site
 Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses ("10.1.103.200")

 # Disable site to site
 set-dnsclientserveraddress -InterfaceAlias ethernet -ResetServerAddresses

 # Import App Defaults
 dism /online /Import-DefaultAppAssociations:"C:\Users\tduke\Documents\Nucleus Remote Support\Files\AppAssociations.xml"

 # Profile Setup
 powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
 ICACLS C:\Users\Public\Desktop /grant Users:(OI)(CI)(X,RD,RA,REA,WD,AD,WA,WEA,DE,RC)

 Add-VpnConnection -Name "RATIO VPN" -ServerAddress vancouver-zggpdjktrp.dynamic-m.com -AllUserConnection -AuthenticationMethod Pap -DnsSuffix ratio.internal -EncryptionLevel Optional -L2tpPsk "Klasnotam" -Force -TunnelType L2tp


Ninitepro.exe /select "Reader" /silent /disableshortcuts
.\Applications\Ninite\


Add-VpnConnection -Name "Corp VPN" -ServerAddress main-office-nhkjrkjprv.dynamic-m.com -AllUserConnection -AuthenticationMethod Pap -DnsSuffix Mondivan.local -EncryptionLevel Optional -L2tpPsk "M0nd1v4n" -Force -TunnelType L2tp

Add-VpnConnection -Name "Corp VPN" -ServerAddress gbl-main-nqzwhwtpvc.dynamic-m.com -AllUserConnection -AuthenticationMethod Pap -DnsSuffix gbllan.local -EncryptionLevel Optional -L2tpPsk "gbl123.vpn" -Force -TunnelType L2tp

Add-VpnConnection -Name "Corp VPN" -ServerAddress luna-gold-zjjbkqmprp.dynamic-m.com -AllUserConnection -AuthenticationMethod Pap -DnsSuffix trek.internal -EncryptionLevel Optional -L2tpPsk "ASONGoffire%&766" -Force -TunnelType L2tp