$textfiles = Get-ChildItem "L:\Directory\" | where-object {$_.Extension -eq ".txt"}

foreach ($textfile in $textfiles) {
$lines = (Get-Content $textfile.FullName| Measure-Object Length -Line).lines
$lines = $lines - 2
$string = get-content $textfile.FullName
$index = 6
$hostname = $textfile.Name -replace ".{11}$"

$users = @(foreach ($line in 6..$lines) {
$user = $string[$index]
$obj = @{
    Hostname = $hostname
    Username = $user
    }

New-Object psobject -Property $obj
write-host $hostname, $user

$index += 1
})

$users | Export-Csv -path C:\Users\Achahal\Documents\Client.csv -delimiter "," -NoTypeInformation -Append

}