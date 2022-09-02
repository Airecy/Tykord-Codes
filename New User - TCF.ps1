$user = Read-Host "Enter First and Last name. (eg. John Smith)"
$UsernameArray = $user.Trim().Replace("'","") -split ' '
$UserName = $UsernameArray[0] + $UsernameArray[1].Substring(0,1)
$UPName = $UsernameArray[0] + $UsernameArray[1].Substring(0,1) + "@terracottafoods.com"
$email = $UsernameArray[0] + $UsernameArray[1].Substring(0,1) + "@terracottafoods.com"
$SMTP1 = "SMTP:" + $email
$ProxyAD = @($SMTP1)
$OUofUser = "OU=TCF Users,DC=terracottafoods,DC=com"
New-ADUser -UserPrincipalName $UPName -Name $user.Trim().Replace("'","") -Surname $UsernameArray[1] -OtherAttributes @{'proxyAddresses'=$ProxyAd;'mail'= $email} -Accountpassword (Read-Host -AsSecureString "AccountPassword") -Enabled $true -ChangePasswordAtLogon $false -DisplayName $user.Trim().Replace("'","") -GivenName $UsernameArray[0] -SamAccountName $UserName -Path $OUofUser
Write-Host "Please add" $UserName "to appropriate groups."
Pause
Start-ADSyncSyncCycle -PolicyType Delta