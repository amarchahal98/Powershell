# Check Msol module installed and imported
If ((Get-Module -Name MSOnline)[0] -eq $null) {
    Install-Module -Name MSOnline -Force -AllowClobber
}
else
{
    Import-Module -Name MSOnline
}

$creds = Get-Credential
$user = $creds.Username
$MobileNumber = "+1 604 111 1111"

Connect-MsolService -Credential $creds
$mf = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$mf.RelyingParty = "*"
$mfa = @($mf)
Set-MsolUser -UserPrincipalName $user -StrongAuthenticationRequirements $mfa
if ((Get-MsolUser -userprincipalname $user).strongauthenticationrequirements.State -eq "enabled" ) {

$SAM1 = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
$SAM2 = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod

$SAM1.IsDefault = $false
$SAM1.MethodType = "PhoneAppOTP"

$SAM2.IsDefault = $false
$SAM2.MethodType = "OneWaySMS"

$SAMethods = @($SAM1, $SAM2)


Set-MsolUser -UserPrincipalName $user -StrongAuthenticationMethods $SAMethods -MobilePhone $MobileNumber
Write-Output "Done"

}
