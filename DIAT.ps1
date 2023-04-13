mkdir C:\Temp -force
Invoke-WebRequest -Uri 'https://app.action1.com/agent/67ef53e4-9e55-11ed-ad89-8326ab1592bc/Windows/agent(DIAT).msi' -OutFile 'C:\Temp\action1_agent.msi'
msiexec /i 'C:\Temp\action1_agent.msi' /quiet
Start-Sleep -Seconds 15
Remove-Item -Path 'C:\Temp\action1_agent.msi' -Force