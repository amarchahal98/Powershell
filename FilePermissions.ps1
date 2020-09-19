# Tourplan Template Copy

Copy-Item -path "" -Destination "C:\Program Files (x86)\" -recurse
Copy-Item -path "" -Destination "C:\Program Files (x86)" -recurse
$hostname = hostname

$user = "Users"
$rights = "Read, ReadAndExecute, Modify, Write, ListDirectory"

$path = "C:\Program Files (x86)\"
$acl = get-acl $path
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$user", "$rights", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($rule)
$acl | set-acl -path $path

$path2 = "C:\Program Files (x86)"

$acl = get-acl $path2
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$user", "$rights", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($rule)
$acl | set-acl -path $path2


$target = "C:\Program Files (x86)"
$ShortcutFile = "$env:Public\Desktop\Help Files.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $target
$Shortcut.Save()
