# Add -Force to it when you need to update EXO V1.
Install-Module -Name ExchangeOnlineManagement -Force
Install-Module -Name ExchangePowershell -Force


Connect-ExchangeOnline 
Connect-IPPSSession -UserPrincipalName clmcio@clmiss.ca

New-ComplianceSearch -Name "Identity" -ExchangeLocation all -ContentMatchQuery 'subject:"For allstaff/clmiss"'
Start-ComplianceSearch -Identity Identity
Get-ComplianceSearch -Identity Identity
Get-ComplianceSearch -Identity Identity| Format-List *
New-ComplianceSearchAction -SearchName Identity -Purge -PurgeType SoftDelete
Get-ComplianceSearchAction -Identity Identity_Purge | Export-Csv C:\DATA\CLM.csv