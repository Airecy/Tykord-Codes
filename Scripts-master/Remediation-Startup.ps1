Install-Module MSOnline -Force
Install-Module AzureADPreview -Force
#Install-Module -Name ExchangeOnlineManagement -Force

$Credential = Get-Credential

Import-PSSession (New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $Credential -Authentication Basic -AllowRedirection)

Connect-MsolService -Credential $Credential
Connect-AzureAD -Credential $Credential

.\Remediate-Breached -UPN kacyannkn@clmiss.ca -NoPasswordReset -nomfa