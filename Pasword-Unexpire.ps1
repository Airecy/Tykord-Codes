Param (
	[Parameter(Mandatory=$true)][string]$Username
)

$user = Get-ADUser -Identity $Username -Properties pwdlastset

If ($user) {
	$user.pwdlastset = 0
	Set-ADUser -Instance $user
	$user.pwdlastset = -1
	Set-ADUser -Instance $user

	Write-Host "Done"
}

Pause
