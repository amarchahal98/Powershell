# achahal
# Modify the first 2 lines
# Password will be prompted after running
$firstname = "John"
$lastname = "Smith"
$username = $firstname.ToLower() + "." + $lastname.tolower()
$email = $username + "@domain.com"
$password = Read-Host -AsSecureString "Type Password for User"
$DisplayName = $firstname + " " + $lastname + " (Contractor)"

new-aduser -Name "$firstname $lastname" -GivenName "$firstname" -DisplayName $DisplayName -Surname "$lastname" -SamAccountName $username -UserPrincipalName $email -Path "OU=Contractors,OU=sites - Vancouver,DC=ad,DC=domain,DC=com" -AccountPassword $password -Enabled $true

set-aduser -Identity $username -EmailAddress $email