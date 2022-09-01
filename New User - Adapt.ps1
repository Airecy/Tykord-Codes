$user = Read-Host "Enter First and Last name. (eg. John Smith)"
$OU = Read-Host "Enter OU. (Admininistration, Adult, ASH, CALED, Community Justice, Concurrent Disorder, CWMS, DaysAhead, Gambling, Opiate, PHAST, Students, TAY, or Youth)"
$UsernameArray = $user.Trim().Replace("'","") -split ' '
$UserName = $UsernameArray[0].Substring(0,1) + $UsernameArray[1]
$UPName = $UsernameArray[0].Substring(0,1) + $UsernameArray[1] + "@adaptho.local"
$email = $UsernameArray[0].Substring(0,1) + $UsernameArray[1] + "@haltonadapt.org"
$Homedir = "\\192.168.0.235\users\" + $UserName
$HomeLetter = "Z:"
$SMTP1 = "'SMTP:" + $email + "'"
$ProxyAD = @($SMTP1)
$OUofUser = "OU=" + $OU + ",OU=SBSUsers,OU=Users,OU=MyBusiness,DC=ADAPTHO,DC=local"
$ScriptPath = "adapt.bat"
New-ADUser -UserPrincipalName $UPName -Name $user.Trim().Replace("'","") -Surname $UsernameArray[1] -OtherAttributes @{'proxyAddresses'=$ProxyAd;'mail'= $email; 'scriptPath'= $ScriptPath} -Accountpassword (Read-Host -AsSecureString "AccountPassword") -Enabled $true -ChangePasswordAtLogon $false -DisplayName $user.Trim().Replace("'","") -GivenName $UsernameArray[0] -HomeDirectory $Homedir -HomeDrive $HomeLetter -SamAccountName $UserName -Path $OUofUser
Write-Host "Please add" $UserName "to appropriate groups."
Pause
Start-ADSyncSyncCycle -PolicyType Delta