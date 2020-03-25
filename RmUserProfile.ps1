# Purge User Profile

$users = "user1","user2","user3","user4","user5"

foreach ($user in $users) {

    $path = "c:\users\$user"


    takeown /f $path /a /r /d y
    icacls $path /remove:d Everyone /T /C
    icacls $path /T /Q /C /RESET
    $folders = get-childitem -force $path 

        foreach ($folder in $folders) {

        remove-item $folder.FullName -force -recurse

        }
}
