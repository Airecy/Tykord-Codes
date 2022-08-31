Connect-MsolService
$user = Read-Host "Enter First and Last name. (eg. John Smith)"
$OU = Read-Host "Enter OU. (Admin, AHH, Contractors, Grace House, Housing, Justice, Management, North Halton Supports, Part Time, PHTS, South Halton Supports Students, Teach, Volunteers, or Youth)"
$UsernameArray = $user.Trim().Replace("'","") -split ' '
$UserName = $UsernameArray[0].Substring(0,1) + $UsernameArray[1]
$UPName = $UsernameArray[0].Substring(0,1) + $UsernameArray[1] + "@shh.local"
$email = $UsernameArray[0] + $UsernameArray[1].Substring(0,1) + "@supporthouse.ca"
$Homedir = "\\192.168.0.235\users\" + $UserName
$HomeLetter = "Z:"
$SMTP1 = "'SMTP:" + $email + "'"
$SMTP2 = "'smtp:" + $UserName + "@shhalton.org'"
$SMTP3 = "'smtp:" + $UserName + "@shhalton.mail.onmicrosoft.com'"
$SMTP4 = "'smtp:" + $UserName + "@supporthouse.ca'"
$ProxyAD = @($SMTP1, $SMTP2, $SMTP3, $SMTP4)
$OUofUser = "OU=" + $OU + ",OU=Users,OU=MyBusiness,DC=SHH,DC=local"
$ScriptPath = "shh.bat"
New-ADUser -UserPrincipalName $UPName -Name $user.Trim().Replace("'","") -Surname $UsernameArray[1] -OtherAttributes @{'proxyAddresses'=$ProxyAd;'mail'= $email; 'scriptPath'= $ScriptPath} -Accountpassword (Read-Host -AsSecureString "AccountPassword") -Enabled $true -ChangePasswordAtLogon $false -DisplayName $user.Trim().Replace("'","") -GivenName $UsernameArray[0] -HomeDirectory $Homedir -HomeDrive $HomeLetter -SamAccountName $UserName -Path $OUofUser
Write-Host "Please add" $UserName "to appropriate groups."
Pause