Param (
	[Parameter(Mandatory=$true)][string]$username
)

$user = Get-ADUser -Identity $username -Properties pwdlastset

If ($user) {
	$user.pwdlastset = 0
	Set-ADUser -Instance $user
	$user.pwdlastset = -1
	Set-ADUser -Instance $user

	Write-Host "Done"
}

Pause
