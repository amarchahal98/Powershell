$hostnames = "computer1, computer2"
$tags = "tag1, tag2"
$hostname = $env:COMPUTERNAME

if ([array]::indexof($hostnames,"$hostname") -ne -1) {
$index = [array]::indexof($hostnames,"$hostname")
$tag = $tags[$index]
$arg = "--asset=$tag"
start-process "C:\Program Files (x86)\Dell\Command Configure\X86_64\cctk.exe" -ArgumentList $arg

}


