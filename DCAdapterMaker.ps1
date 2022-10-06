#Create a new task called DCAdapter
$action = New-ScheduledTaskAction -Execute 'C:\ProgramData\DC\Scripts\DairycompAdapter.bat' -Argument /qn #Specify the script to run
$trigger = New-ScheduledTaskTrigger -AtLogon #Specify the trigger to run the script
$Principal = New-ScheduledTaskPrincipal -UserID "$env:USERDOMAIN\$env:USERNAME" -LogonType ServiceAccount -RunLevel Highest
md C:\\ProgramData\DC\ | Out-Null
md C:\\ProgramData\DC\Scripts | Out-Null
cd C:\\ProgramData\DC\Scripts | Out-Null
Invoke-WebRequest -Uri https://raw.githubusercontent.com/bschirk/dczt/main/DairycompAdapter.bat -OutFile C:\\ProgramData\DC\Scripts\DairycompAdapter.bat | Out-Null
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "DCAdapter" -Description "Names DairyComp Adapter." -Principal $Principal | Out-Null
.\DairycompAdapter.bat \qn | Out-Null
netsh interface ip show addresses "DairyComp"
