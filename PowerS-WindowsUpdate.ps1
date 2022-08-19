Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Install-Module -Name PSWindowsUpdate -Force
Import-Module PSWindowsUpdate
Get-Command -Module PSWindowsUpdate
Install-WindowsUpdate -AcceptAll -AutoReboot
