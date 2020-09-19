if (get-package "Unitrends Agent*" -ErrorAction SilentlyContinue) {
$app = get-package "Unitrends Agent*"
Write-Output "Package exists: $app.Name. Uninstalling now."
msiexec /x $app.FastPackageReference /qn /norestart

}

else {
Write-Warning "Application does not exist."
}
