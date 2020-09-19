$locations = get-content C:\users\achahal\Documents\ClientFiles\File.txt

foreach ($location in $locations) {
$str = $location | Out-String
$str = $str -replace "`n",""
$str + ','
}