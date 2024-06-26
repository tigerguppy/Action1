# Variables

$DownloadUrl = 'https://app.action1.com/agent/145f8984-a01b-11ed-a35e-dd162913d97c/Windows/agent(Elcor).msi' # This URL can be found here: https://app.action1.com/console/endpoints/add/step-1

$VerboseOutput = $true # Set to false to hide all outputs except for errors and completion notice.

# You shouldn't need to edit anything below this line.

$ProgressPreference_Original = $ProgressPreference
$ProgressPreference = 'SilentlyContinue'

$TempFolder = "$env:SystemDrive\Temp"
$InstallerFilename = 'action1_agent.msi'
$InstallerCommonName = 'Action1 Agent'

$RemoveInstallerWhenDone = $true
$RemoveInstallerMaxRetries = 10

# Starting script

if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : Enabling TLS 1.2 and 1.3 in case it isn't already enabled." }
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls13

if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : Checking URL." }
if (($($DownloadUrl.Length) -gt 65) -and ($DownloadUrl -notcontains ' ')) {

    if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : Deployment URL appears to be correct, continuing." }

} else {

    Read-Host -Prompt "$(Get-Date -Format O) : The deployment URL ($DownloadUrl) does not appear to be correct."
    throw "$DownloadUrl is incorrect."
    exit

}

if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : Checking if $InstallerCommonName is already installed." }
$CheckIfInstalled = Get-WmiObject -Class Win32_Product | Where-Object Name -Like "*$InstallerCommonName*"

if ($null -ne $CheckIfInstalled) {

    $CheckIfInstalled | Format-Table Name, Version
    Read-Host -Prompt "$(Get-Date -Format O) : Already installed. Press enter to exit."
    throw "$($CheckifInstalled.Name) already installed."
    exit

} else {

    if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : $InstallerCommonName is not installed, continuing." }

}

if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : Checking if temp folder ($TempFolder) exists." }
if (Test-Path -Path "$TempFolder") {

    if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : $TempFolder exists, continuing." }

} else {

    if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : $TempFolder does not exist, creating." }
    New-Item -ItemType Directory -Path "$TempFolder" -Force -ErrorAction Stop | Out-Null

}

if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : Checking if $TempFolder\$InstallerFilename already exists." }
if (Test-Path -Path "$TempFolder\$InstallerFilename") {

    Read-Host -Prompt "$(Get-Date -Format O) : File already exists. Press enter to exit."
    throw "$TempFolder\$InstallerFilename already exists."
    exit

} else {
    if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : File does not exist, continuing." }
}

if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : Downloading file $InstallerFilename" }
Invoke-WebRequest -Uri "$DownloadUrl" -OutFile "$TempFolder\$InstallerFilename"

if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : Installing $InstallerFilename" }
msiexec /i "$TempFolder\$InstallerFilename" /quiet

if ($RemoveInstallerWhenDone) {

    $LoopCounter = 0
    $ContinueLooping = $true

    do {

        $LoopCounter ++

        if (Test-Path -Path "$TempFolder\$InstallerFilename") {
            
            if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : Attempt $LoopCounter to remove downloaded file." }
            Start-Sleep -Seconds 5 # Give the installer a few seconds to wrap up before attempting to remove it.
            Remove-Item -Path "$TempFolder\$InstallerFilename" -Force -ErrorAction SilentlyContinue
            $ContinueLooping = $true
            
        } else {

            if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : File removed." }
            $ContinueLooping = $false

        }

        if ($LoopCounter -ge $RemoveInstallerMaxRetries) {

            if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : Unable to remove file. Please manually remove the file." }
            if ($VerboseOutput) { Write-Output "$(Get-Date -Format O) : $TempFolder\$InstallerFilename" }
            $ContinueLooping = $false

        }

    } while ($ContinueLooping)

}

$ProgressPreference = $ProgressPreference_Original

#Read-Host "$(Get-Date -Format O) : Press enter to exit."
