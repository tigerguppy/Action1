mkdir C:\Temp -force
Invoke-WebRequest -Uri 'https://app.action1.com/agent/145f8984-a01b-11ed-a35e-dd162913d97c/Windows/agent(Elcor).msi' -OutFile 'C:\Temp\action1_agent.msi'
msiexec /i 'C:\Temp\action1_agent.msi' /quiet
Start-Sleep -Seconds 15
Remove-Item -Path 'C:\Temp\action1_agent.msi' -Force