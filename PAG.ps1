mkdir C:\Temp -force
Invoke-WebRequest -Uri 'https://app.action1.com/agent/c7ef8374-a01a-11ed-a35e-dd162913d97c/Windows/agent(PAG).msi' -OutFile 'C:\Temp\action1_agent.msi'
msiexec /i 'C:\Temp\action1_agent.msi' /quiet
Start-Sleep -Seconds 15
Remove-Item -Path 'C:\Temp\action1_agent.msi' -Force