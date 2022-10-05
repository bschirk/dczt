#Create a new task called DCAdapter
$action = New-ScheduledTaskAction -Execute 'C:\DC\scripts\DairycompAdapter.bat' -Argument /qn #Specify the script to run
$trigger = New-ScheduledTaskTrigger -AtLogon #Specify the trigger to run the script
$Principal = New-ScheduledTaskPrincipal -UserID "$env:USERDOMAIN\$env:USERNAME" -LogonType ServiceAccount -RunLevel Highest
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "DCAdapter" -Description "Names DairyComp Adapter." -Principal $Principal
