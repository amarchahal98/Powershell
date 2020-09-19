$csv = import-csv "C:\Users\Administrator\Documents\book1.csv"

foreach ($user in $csv) {
$email = $user."User Email Address"
$username = $email.split("@",2)
$username = $username[0]
$personaltitle = $user.Pronouns
$mobile = $user.'Cell Phone'
$company = $user.'User Department'
get-aduser $username | set-aduser -replace @{'personalTitle'=$personaltitle}
get-aduser $username | set-aduser -replace @{'mobile'="$mobile"}
get-aduser $username | set-aduser -replace @{'personalTitle'="$company"}

}
