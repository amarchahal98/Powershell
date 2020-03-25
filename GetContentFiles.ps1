# Checking for Remote Desktop enabled Machines in LT Uploads

$files = Get-Item -Path 'L:\Company\*\RDPTrue.txt'

foreach ($file in $files)
{
    $content = get-content -path $file.FullName

    $path = get-item $file |select-object FullName
    $computer = $path.FullName.Split('\')[3]
    $computer = $computer -split "(-)"
    $computer = $computer.Split('-')[0]

    if ($content -eq "1") {
    write-host "RDP is disabled on: $computer"
    }
}