mkdir C:\Temp -force
Invoke-WebRequest -Uri 'https://app.action1.com/agent/f7ee2ee4-d35b-11ed-b4ef-8d8d0a2c5b75/Windows/agent(Misc).msi' -OutFile 'C:\Temp\action1_agent.msi'
msiexec /i 'C:\Temp\action1_agent.msi' /quiet
Start-Sleep -Seconds 15
Remove-Item -Path 'C:\Temp\action1_agent.msi' -Force