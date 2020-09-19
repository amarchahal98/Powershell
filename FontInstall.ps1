#achahal, new script to install fonts

$fonts = @()
$fontFolder = '\\server\Data\Installs\Fonts'
$fonts += Get-ChildItem $fontFolder *.ttf -Recurse
$fonts += Get-ChildItem $fontFolder *.otf -Recurse
$fonts += Get-ChildItem $fontFolder *.pfm -Recurse


foreach ($font in $fonts) {
    if ((Test-Path "c:\windows\fonts\$($font.name)") -eq $True) {
        Write-Output "$($font.name) Already exists"
    }
    Else {
        try {
            Write-Output "Installing $($font.name)"
            copy-item ($font.fullname) C:\Windows\Fonts\
            new-itemproperty -name $font.fullname -path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -property string -Value $font
        }
        catch {
            Write-Warning "Something went wrong installing $($font.name):  $_"
        }
    }
}
