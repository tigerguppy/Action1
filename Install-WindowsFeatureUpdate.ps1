[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

# Log file location
$LogFilePath = "$env:SystemDrive\Temp"

# If $LogFilePath doesn't exist, create it
if (!(Test-Path $LogFilePath)) {
    
    try {
    
        mkdir $LogFilePath -Force -ErrorAction Stop
    
    } catch {
    
        Write-Output "Unable to create $LogFilePath, exiting"

    }

}


try {

    Write-Output "$(Get-Date -Format O) : Starting feature update install."
    Start-Process -FilePath '.\setup.exe' -ArgumentList "/auto upgrade /quiet /copylogs $LogFilePath /noreboot /eula accept /showoobe none"

} catch {

    Write-Output 'Feature update failed. Exiting script.'
    
}

do {
    Write-Output "$(Get-Date -Format O) : Installing feature update."
    Start-Sleep -Seconds 300
} while (
    $(Get-Process | Where-Object Path -Like '*action1*setup*' | Measure-Object).Count -ge 1
)

Write-Output "$(Get-Date -Format O) : Feature update install completed."