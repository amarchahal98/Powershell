$domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$PDC = ($domainObj.PdcRoleOwner).Name
$SearchString = "LDAP://"
$SearchString += $PDC + "/"
$DistinguishedName = "DC=$($domainObj.Name.Replace('.', ',DC='))"
$SearchString += $DistinguishedName
$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)
$objDomain = New-Object System.DirectoryServices.DirectoryEntry
$Searcher.SearchRoot = $objDomain
$Searcher.filter="(name=Secret_Group)"
$Result = $Searcher.FindAll()
Foreach($obj in $Result)

{
$isgroup = 0
DO {
$members = $obj.Properties.member
$members
$membername = ($members.substring(3) -split ',')[0]
$Searcher.filter="(name=$membername)"
$memberobject = $Searcher.FindAll()
$memberobjectclass = $memberobject.Properties.objectclass
if ($memberobjectclass -notcontains "group") {
$isgroup = 1
}
$obj = $memberobject
} Until ($isgroup -eq 1)
}
