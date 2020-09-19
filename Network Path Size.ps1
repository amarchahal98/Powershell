$users = get-aduser -filter * -properties homedirectory | Where-Object {$_.homedirectory -ne $Null}

$out  = foreach ($user in $users) {
    
                
    $directorysize = ((get-childitem $user.homedirectory -recurse | measure-object -Property length -sum).sum / 1MB)
    $obj = @{
                Username = $user.Name
                HomeDir = $user.HomeDirectory
                DirSize = $directorysize
            }
    
    New-Object psobject -Property $obj
    write-host $user.Name $user.HomeDirectory $directorysize
}
#write-host $out
$out |export-csv -Path C:\temp\HomeDirectorySize.csv -Delimiter "," -NoTypeInformation