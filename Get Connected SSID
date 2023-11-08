function Get-ConnectedSsid {
    $SSID = $((netsh wlan show interfaces | Select-String -Pattern 'SSID' | Select-String -NotMatch 'BSSID') -replace '    SSID                   : ', '')
    if ($null -eq $SSID) {
        $SSID = 'No WiFi Connection'
    }
    
    return $SSID
}

$Objects = Get-ConnectedSsid

$result = New-Object System.Collections.ArrayList;
$numerator = 0;

$Objects | ForEach-Object {
    $currentOutput = '' | Select-Object Result, A1_Key;
    $currentOutput.Result = $_;
    $currentOutput.A1_Key = [string]$numerator + ':' + [string]$_.SID;

    $result.Add($currentOutput) | Out-Null;
    $numerator = ($numerator + 1);
}

$result;
