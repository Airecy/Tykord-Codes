#Requires -Version 4

<#
	.SYNOPSIS
		This script exports mailbox calendar publishing settings

	.DESCRIPTION
	    Iterates through mailboxes and dumps calender folder permissions, shows publishing permissions.

        This script is useful for highlighting users that have anonymous calendar sharing turned on.

    .PARAMETER  OutCSV
        Will export the results to a CSV File in the script root called Get-CalendarPublishInfo.csv

	.EXAMPLE
		PS C:\> .\Get-CalendarPublishInfo.ps1

	.EXAMPLE
		PS C:\> .\Get-CalendarPublishInfo.ps1 -OutCSV

	.NOTES
		Cam Murray
		Field Engineer - Microsoft
		cam.murray@microsoft.com
		
		For updates, and more scripts, visit https://github.com/O365AES/Scripts
		
		Last update: 29 March 2017

	.LINK
		about_functions_advanced

#>

Param(
     [switch]$OutCSV
)

$cfs = @()

ForEach($mailbox in (Get-Mailbox -ResultSize Unlimited | select Identity,UserPrincipalName)) {
    Write-Verbose "Checking $($mailbox.Identity)"

    # Get users calendar folder settings for their default Calendar folder
    $cf=Get-MailboxCalendarFolder -Identity "$($mailbox.Identity):\Calendar" 
    
    # If publishing is turned on, add to the result set
    if($cf.PublishEnabled -eq $true) {
        $cfs += New-Object -TypeName psobject -Property @{
            UserPrincipalName=$mailbox.UserPrincipalName
            PublishEnabled=$cf.PublishEnabled
            DetailLevel=$cf.DetailLevel
            PublishedCalendarUrl=$cf.PublishedCalendarUrl
            PublishedICalUrl=$cf.PublishedICalUrl
        }
    }
}

# Export to csv if required
if($cfs.Count -gt 0) {
    if($OutCSV) {
        $cfs | export-csv -Path "$PSScriptRoot\Get-CalendarPublishInfo.csv" -NoTypeInformation -NoClobber
    } else {
        return $cfs
    }
} else {
    Write-Host "No users with publishing enabled"
}
