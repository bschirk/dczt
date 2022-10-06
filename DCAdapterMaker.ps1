#Create a new task called DCAdapter
$action = New-ScheduledTaskAction -Execute 'C:\ProgramData\DC\Scripts\DairycompAdapter.bat' -Argument /qn #Specify the script to run
$trigger = New-ScheduledTaskTrigger -AtLogon #Specify the trigger to run the script
$Principal = New-ScheduledTaskPrincipal -UserID "$env:USERDOMAIN\$env:USERNAME" -LogonType ServiceAccount -RunLevel Highest
md C:\\ProgramData\DC\
md C:\\ProgramData\DC\Scripts
cd C:\\ProgramData\DC\Scripts
Invoke-WebRequest -Uri https://raw.githubusercontent.com/bschirk/dczt/main/DairycompAdapter.bat -OutFile C:\\ProgramData\DC\Scripts\DairycompAdapter.bat
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "DCAdapter" -Description "Names DairyComp Adapter." -Principal $Principal
.\DairycompAdapter.bat \qn
netsh interface ip show addresses "DairyComp"
