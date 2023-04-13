mkdir C:\Temp -force
Invoke-WebRequest -Uri 'https://app.action1.com/agent/277841e4-c115-11ed-882d-ad61a2da98b9/Windows/agent(RCL).msi' -OutFile 'C:\Temp\action1_agent.msi'
msiexec /i 'C:\Temp\action1_agent.msi' /quiet
Start-Sleep -Seconds 15
Remove-Item -Path 'C:\Temp\action1_agent.msi' -Force