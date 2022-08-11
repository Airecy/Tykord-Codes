$max_jobs = 8
$tstart = get-date
$src = Read-Host "Enter the source (eg: C:\data\)"
$dest = Read-Host "Enter the destination (eg: g:\data\)"
$Alog = Read-Host "Enter the location for log files (eg: c:\RClog)"
$LDate = ""
$LDate += "\logs-$(get-date -f dd-MM-yy-hh-mm)"
$log = "$Alog" + "$Ldate"
New-Item -Path $log -ItemType Directory
if (Test-Path $Alog) {
   
    Write-Host "Log Folder Exists"
    # Perform Delete file from folder operation
}
else
{
  
    #PowerShell Create directory if not exists
    New-Item $Alog -ItemType Directory
    Write-Host "LogFolder Created successfully"
}

$files = Get-ChildItem $src
$files | ForEach-Object{
$ScriptBlock = {
param($name, $src, $dest, $log)
$log += "\$name.log"
robocopy $src$name $dest$name /mir /nfl /np /mt:8 /ndl /zb /r:1 /w:3 /sec > $log
 }
$j = Get-Job -State "Running"
while ($j.count -ge $max_jobs) 
{
 Start-Sleep -Milliseconds 500
 $j = Get-Job -State "Running"
}
 Get-job -State "Completed" | Receive-job
 Remove-job -State "Completed"
Start-Job $ScriptBlock -ArgumentList $_,$src,$dest,$log
 }


While (Get-Job -State "Running") { Start-Sleep 2 }
Remove-Job -State "Completed" 
  Get-Job | Write-host

$tend = get-date

new-timespan -start $tstart -end $tend
Get-ChildItem -Path $log -r -Include *.log | Where-Object {$_.PSIsContainer -eq $false}  | Select-Object fullname,name | export-csv -Path c:\rclog\temp.csv -NoTypeInformation

