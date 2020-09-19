# Testing VPN Connection
$pingtest = Test-NetConnection -ComputerName SERVER
if ($pingtest.PingSucceeded -ne $True) {
Write-Output "No Network access, exiting script."
Exit
}


$users = Get-ChildItem C:\Users\

Foreach ($user in $users) {
$username = $user.Name
$userexist = Test-Path "C:\Users\$username\AppData\Roaming\Microsoft\Templates\"
if ($userexist -ne $True) {
Write-Output "$username does not have a Templates folder, skipping user."
continue
}

$hashcheck = Get-FileHash "C:\Users\$username\AppData\Roaming\Microsoft\Templates\Normal.dotm"
$hashcompare = Get-FileHash "\\SERVER\Data\Corporate\Templates\Normal.dotm"

if ($hashcheck.Hash -eq $hashcompare.Hash) {
Write-Output "Correct Template is already installed for $username. Skipping user."
continue
}
else {
Copy-Item "\\SERVER\Data\Corporate\Templates\Normal.dotm" "C:\Users\$username\AppData\Roaming\Microsoft\Templates\Normal.dotm"
Write-Output "Copied Template file for $username."
}

}