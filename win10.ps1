##### SAVE ##########
##### SAVE ##########
##### SAVE ##########

## vars ##
$hostname = hostname

##########

# Install Chrome browser
$Path = $env:TEMP; $Installer = "chrome_installer.exe"; `
    Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" `
    -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" `
    -Verb RunAs -Wait; Remove-Item $Path\$Installer
    
# Install Firefox browser
$Path = $env:TEMP; $Installer = "Firefox Setup 51.0.1.exe"; `
    Invoke-WebRequest "https://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US" `
    -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" `
    -Verb RunAs -Wait; Remove-Item $Path\$Installer



# Install Adobe Reader
$Path = $env:TEMP; $Installer = "adobeDC.exe"; `
    Invoke-WebRequest "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/1502320053/AcroRdrDC1502320053_en_US.exe" `
    -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" `
    -Verb RunAs -Wait; Remove-Item $Path\$Installer


# Uninstall Unnecessary Packages
$useless = "Microsoft.BingNews"


foreach ($i in $useless)
{
get-appxpackage $i | remove-appxpackage
}

# Reduce Cortana Search bar size
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
$Name = "SearchboxTaskbarMode"
$value = "1"
New-ItemProperty -Path $regPath -Name $Name -Value $Value -PropertyType DWORD -Force

# Remove People taskbar icon
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0
stop-process -name explorer

# Set Hostname
Rename-Computer $hostname

# Set Timezone to Pacific
Set-Timezone "Pacific Standard Time"



$username = "test"
$password = "test123"

$ie = New-object -com Internetexplorer.application
$ie.visible=$true
$ie.navigate("login.live.com")
while($ie.ReadyState -ne 4) {start-sleep -m 100}

$ie.document.getelementbyid("i0116").value="$username"
$ie.document.getelementbyid("idSIButton9").click()
$ie.document.getelementbyid("i0118").value = "$password"
$ie.document.getelementbyid("idSIButton9").click()
