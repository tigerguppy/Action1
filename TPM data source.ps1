$TpmInfo = Get-Tpm;

$result = New-Object System.Collections.ArrayList;
$numerator = 0;

$TpmInfo | ForEach-Object {
    $CurrentOutput = '' | Select-Object TpmPresent, TpmReady, TpmEnabled, TpmActivated, TpmOwned, RestartPending, ManufacturerId, ManufacturerIdTxt, ManufacturerVersion, ManufacturerVersionFull20, ManagedAuthLevel, OwnerAuth:, OwnerClearDisabled, AutoProvisioning, LockedOut, LockoutHealTime, LockoutCount, LockoutMax, SelfTest, A1_Key;
    $currentOutput.TpmPresent = $_.TpmPresent
    $currentOutput.TpmReady = $_.TpmReady
    $currentOutput.TpmEnabled = $_.TpmEnabled
    $currentOutput.TpmActivated = $_.TpmActivated
    $currentOutput.TpmOwned = $_.TpmOwned
    $currentOutput.RestartPending = $_.RestartPending
    $currentOutput.ManufacturerId = $_.ManufacturerId
    $currentOutput.ManufacturerIdTxt = $_.ManufacturerIdTxt
    $currentOutput.ManufacturerVersion = $_.ManufacturerVersion
    $currentOutput.ManufacturerVersionFull20 = $_.ManufacturerVersionFull20
    $currentOutput.ManagedAuthLevel = $_.ManagedAuthLevel
    $currentOutput.OwnerClearDisabled = $_.OwnerClearDisabled
    $currentOutput.AutoProvisioning = $_.AutoProvisioning
    $currentOutput.LockedOut = $_.LockedOut
    $currentOutput.LockoutHealTime = $_.LockoutHealTime
    $currentOutput.LockoutCount = $_.LockoutCount
    $currentOutput.LockoutMax = $_.LockoutMax
    $currentOutput.A1_Key = [string]$numerator + ':' + [string]$_.SID;

    $result.Add($currentOutput) | Out-Null;
    $numerator = ($numerator + 1) 
}

$result;