Connect-MsolService
$user = Read-Host "Enter First and Last name. (eg. John Smith)"
$Union = Read-Host "Union or Non-Union (eg. Non-Union)"
$UsernameArray = $user.Trim().Replace("'","") -split ' '
$UserName = $UsernameArray[0].Substring(0,1) + $UsernameArray[1]
$UPName = $UsernameArray[0].Substring(0,1) + $UsernameArray[1] + "@cwsds.local"
$email = $UsernameArray[0].Substring(0,1) + $UsernameArray[1] + "@cwsds.ca"
$Homedir = "\\192.168.0.235\users\" + $UserName
$HomeLetter = "Z:"
$SMTP1 = "SMTP:" + $email
$OUofUser = "OU=" + $Union + ",OU=CWSDS,OU=Users,OU=User Accounts,DC=cwsds,DC=local"
$ScriptPath = "Logon.bat"
New-ADUser -UserPrincipalName $UPName -Name $user.Trim().Replace("'","") -Surname $UsernameArray[1] -OtherAttributes @{'proxyAddresses'=$SMTP1;'mail'= $email; 'scriptPath'= $ScriptPath} -Accountpassword (Read-Host -AsSecureString "AccountPassword") -Enabled $true -ChangePasswordAtLogon $false -DisplayName $user.Trim().Replace("'","") -GivenName $UsernameArray[0] -HomeDirectory $Homedir -HomeDrive $HomeLetter -SamAccountName $UserName -Path $OUofUser
New-MsolUser -DisplayName $user.Trim().Replace("'","") -FirstName $UsernameArray[0] -LastName $UsernameArray[1] -UserPrincipalName $email -UsageLocation CA -LicenseAssignment cwsds:STANDARDWOFFPACK -Password (Read-Host -AsSecureString "EmailPassword")