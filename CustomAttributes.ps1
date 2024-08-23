## Get Chassis Type
Function Get-ChassisType() {

    $ChassisTypes = @{
        Name       = 'ChassisType'
        Expression = {
            # property is an array, so process all values
            $result = foreach ($value in $_.ChassisTypes) {
                switch ([int]$value) {
                    1 { 'Other' } # Other
                    2 { 'Unknown' } # Unknown
                    3 { 'Desktop' } # Desktop
                    4 { 'Desktop' } # Low Profile Desktop
                    5 { 'Desktop' } # Pizza Box
                    6 { 'Desktop' } # Mini Tower
                    7 { 'Desktop' } # Tower
                    8 { 'Laptop' } # Portable
                    9 { 'Laptop' } # Laptop
                    10 { 'Laptop' } # Notebook
                    11 { 'Laptop' } # Hand Held
                    12 { 'Laptop' } # Docking Station
                    13 { 'All in One' } # All in One
                    14 { 'Laptop' } # Sub Notebook
                    15 { 'Desktop' } # Space-Saving
                    16 { 'Desktop' } # Lunch Box
                    17 { 'Server' } # Main System Chassis
                    18 { 'Laptop' } # Expansion Chassis
                    19 { 'Other' } # SubChassis
                    20 { 'Other' } # Bus Expansion Chassis
                    21 { 'Laptop' } # Peripheral Chassis
                    22 { 'Storage' } # Storage Chassis
                    23 { 'Server' } # Rack Mount Chassis
                    24 { 'Other' } # Sealed-Case PC
                    30 { 'Tablet' } # Tablet
                    31 { 'Laptop' } # Convertible
                    32 { 'Laptop' } # Detachable
                    33 { 'Other' } # IoT Gateway
                    34 { 'Other' } # Embedded PC
                    35 { 'Desktop' } # Mini PC
                    36 { 'Other' } # Stick PC
                    default { "$value" }                
                }
            }
            $result
        }
    }
    return (Get-CimInstance -ClassName Win32_SystemEnclosure | Select-Object -Property $ChassisTypes).ChassisType
}


## Get Display Infos
# Define a function to convert an array of integers to characters
Function ConvertTo-Char ($Array) {
    if ($null -eq $Array -or $Array.Length -eq 0) {
        return ''
    } else {
        return ([System.Text.Encoding]::ASCII.GetString($Array)).TrimEnd("`0")
    }
}


# Define a function to convert manufacturer codes to manufacturer names
Function ConvertTo-Manufacturer ($Code) {
    $Output = ''
    # Initialize monitor manufacturers
    $Manufacturer = @(
        [pscustomobject]@{'Monitor Manufacturer Code' = 'ACI'; 'Monitor Manufacturer' = 'Asus (ASUSTeK Computer Inc.)' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'ACR'; 'Monitor Manufacturer' = 'Acer America Corp.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'ACT'; 'Monitor Manufacturer' = 'Targa' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'ADI'; 'Monitor Manufacturer' = 'ADI Corporation' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'AMW'; 'Monitor Manufacturer' = 'AMW' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'AOC'; 'Monitor Manufacturer' = 'AOC International (USA) Ltd.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'API'; 'Monitor Manufacturer' = 'Acer America Corp.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'APP'; 'Monitor Manufacturer' = 'Apple Computer, Inc.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'ART'; 'Monitor Manufacturer' = 'ArtMedia' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'AST'; 'Monitor Manufacturer' = 'AST Research' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'AUO'; 'Monitor Manufacturer' = 'AU Optronics' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'BMM'; 'Monitor Manufacturer' = 'BMM' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'BNQ'; 'Monitor Manufacturer' = 'BenQ Corporation' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'BOE'; 'Monitor Manufacturer' = 'BOE Display Technology' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'CPL'; 'Monitor Manufacturer' = 'Compal Electronics, Inc. / ALFA' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'CPQ'; 'Monitor Manufacturer' = 'COMPAQ Computer Corp.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'CMN'; 'Monitor Manufacturer' = 'Chi Mei Innolux' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'CTX'; 'Monitor Manufacturer' = 'CTX - Chuntex Electronic Co.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'DEC'; 'Monitor Manufacturer' = 'Digital Equipment Corporation' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'DEL'; 'Monitor Manufacturer' = 'Dell Computer Corp.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'DPC'; 'Monitor Manufacturer' = 'Delta Electronics, Inc.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'DWE'; 'Monitor Manufacturer' = 'Daewoo Telecom Ltd' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'ECS'; 'Monitor Manufacturer' = 'ELITEGROUP Computer Systems' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'EIZ'; 'Monitor Manufacturer' = 'EIZO' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'ENC'; 'Monitor Manufacturer' = 'EIZO' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'EPI'; 'Monitor Manufacturer' = 'Envision Peripherals, Inc.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'FCM'; 'Monitor Manufacturer' = 'Funai Electric Company of Taiwan' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'FUS'; 'Monitor Manufacturer' = 'Fujitsu Siemens' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'GSM'; 'Monitor Manufacturer' = 'LG Electronics Inc. (GoldStar Technology, Inc.)' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'GWY'; 'Monitor Manufacturer' = 'Gateway 2000' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'HEI'; 'Monitor Manufacturer' = 'Hyundai Electronics Industries Co., Ltd.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'HIQ'; 'Monitor Manufacturer' = 'Hyundai ImageQuest' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'HIT'; 'Monitor Manufacturer' = 'Hitachi' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'HSD'; 'Monitor Manufacturer' = 'Hannspree Inc' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'HSL'; 'Monitor Manufacturer' = 'Hansol Electronics' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'HTC'; 'Monitor Manufacturer' = 'Hitachi Ltd. / Nissei Sangyo America Ltd.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'HWP'; 'Monitor Manufacturer' = 'Hewlett Packard (HP)' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'HPN'; 'Monitor Manufacturer' = 'Hewlett Packard (HP)' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'IBM'; 'Monitor Manufacturer' = 'IBM PC Company' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'ICL'; 'Monitor Manufacturer' = 'Fujitsu ICL' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'IFS'; 'Monitor Manufacturer' = 'InFocus' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'IQT'; 'Monitor Manufacturer' = 'Hyundai' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'IVM'; 'Monitor Manufacturer' = 'Idek Iiyama North America, Inc.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'KDS'; 'Monitor Manufacturer' = 'KDS USA' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'KFC'; 'Monitor Manufacturer' = 'KFC Computek' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'LEN'; 'Monitor Manufacturer' = 'Lenovo' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'LGD'; 'Monitor Manufacturer' = 'LG Display' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'LKM'; 'Monitor Manufacturer' = 'ADLAS / AZALEA' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'LNK'; 'Monitor Manufacturer' = 'LINK Technologies, Inc.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'LPL'; 'Monitor Manufacturer' = 'LG Philips' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'LTN'; 'Monitor Manufacturer' = 'Lite-On' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'MAG'; 'Monitor Manufacturer' = 'MAG InnoVision' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'MAX'; 'Monitor Manufacturer' = 'Maxdata Computer GmbH' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'MEI'; 'Monitor Manufacturer' = 'Panasonic Comm. & Systems Co.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'MEL'; 'Monitor Manufacturer' = 'Mitsubishi Electronics' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'MIR'; 'Monitor Manufacturer' = 'miro Computer Products AG' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'MTC'; 'Monitor Manufacturer' = 'MITAC' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'MSH'; 'Monitor Manufacturer' = 'Microsoft Hyper-V' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'NAN'; 'Monitor Manufacturer' = 'NANAO' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'NEC'; 'Monitor Manufacturer' = 'NEC Technologies, Inc.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'NOK'; 'Monitor Manufacturer' = 'Nokia' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'NVD'; 'Monitor Manufacturer' = 'Nvidia' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'OQI'; 'Monitor Manufacturer' = 'OPTIQUEST' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'PBN'; 'Monitor Manufacturer' = 'Packard Bell' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'PCK'; 'Monitor Manufacturer' = 'Daewoo' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'PDC'; 'Monitor Manufacturer' = 'Polaroid' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'PGS'; 'Monitor Manufacturer' = 'Princeton Graphic Systems' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'PHL'; 'Monitor Manufacturer' = 'Philips Consumer Electronics Co' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'PRT'; 'Monitor Manufacturer' = 'Princeton' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'REL'; 'Monitor Manufacturer' = 'Relisys' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'SAM'; 'Monitor Manufacturer' = 'Samsung' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'SEC'; 'Monitor Manufacturer' = 'Seiko Epson Corporation' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'SDC'; 'Monitor Manufacturer' = 'Smart Display Company' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'SMC'; 'Monitor Manufacturer' = 'Samtron' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'SMI'; 'Monitor Manufacturer' = 'Smile' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'SNI'; 'Monitor Manufacturer' = 'Siemens Nixdorf' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'SNY'; 'Monitor Manufacturer' = 'Sony Corporation' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'SPT'; 'Monitor Manufacturer' = 'Sceptre' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'SRC'; 'Monitor Manufacturer' = 'Shamrock Technology' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'STN'; 'Monitor Manufacturer' = 'Samtron' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'STP'; 'Monitor Manufacturer' = 'Sceptre' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'TAT'; 'Monitor Manufacturer' = 'Tatung Co. of America, Inc.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'TRL'; 'Monitor Manufacturer' = 'Royal Information Company' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'TSB'; 'Monitor Manufacturer' = 'Toshiba, Inc.' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'UNM'; 'Monitor Manufacturer' = 'Unisys Corporation' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'VSC'; 'Monitor Manufacturer' = 'ViewSonic Corporation' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'WTC'; 'Monitor Manufacturer' = 'Wen Technology' }
        [pscustomobject]@{'Monitor Manufacturer Code' = 'ZCM'; 'Monitor Manufacturer' = 'Zenith Data Systems' }
    )
    # Retrieve the manufacturer name based on the code
    $Output = $Manufacturer | Where-Object { $_.'Monitor Manufacturer Code' -eq $Code } | Select-Object -ExpandProperty 'Monitor Manufacturer'
    # Return the manufacturer name if found, otherwise return the code
    If (!$Output) {
        Return $Code
    } else {
        Return $Output
    }
}

# Initialize the result string and counter
$Results = ''

# Attempt to retrieve monitor information using WMI
Try {
    $Query = Get-WmiObject -Query 'Select * FROM WMIMonitorID' -Namespace root\wmi -ErrorAction Stop
	
    # Determine the total number of monitors connected
    $totalMonitors = $Query.Count
    if (($totalMonitors -eq 0) -or (!$totalMonitors)) {
        $totalMonitors = 1
    }

    # Construct the total monitors information
    $Results += "Total: $($totalMonitors), "

    # Iterate through each monitor retrieved
    $p = 1
    ForEach ($Monitor in $Query) {
        # Retrieve connection type information
        $QueryConn = Get-WmiObject -Query 'Select * from WmiMonitorConnectionParams' -Namespace root\wmi -ErrorAction Stop | Where-Object { $_.InstanceName -eq $Monitor.InstanceName }
        Switch ($QueryConn.VideoOutputTechnology) {
            -2 { $Connectiontype = 'UNINITIALIZED' }
            -1 { $Connectiontype = 'OTHER' }
            0 { $Connectiontype = 'HD15 (VGA)' }
            1 { $Connectiontype = 'SVIDEO' }
            2 { $Connectiontype = 'COMPOSITE_VIDEO' }
            3 { $Connectiontype = 'COMPOSITE_VIDEO' }
            4 { $Connectiontype = 'DVI' }
            5 { $Connectiontype = 'HDMI' }
            6 { $Connectiontype = 'LVDS' }
            9 { $Connectiontype = 'LDI' }
            10 { $Connectiontype = 'Displayport' }
            11 { $Connectiontype = 'Displayport Embedded' }
            14 { $Connectiontype = 'SDTVDONGLE' }
            15 { $Connectiontype = 'Miracast' }
            4294967295 { $Connectiontype = 'Remote Desktop Console' }
            Default { $Connectiontype = 'Notebook or unknown' }
        }
		
        
        # Retrieve preferred display mode
        $QuerySourceMode = Get-WmiObject -Query 'SELECT * FROM WmiMonitorListedSupportedSourceModes' -Namespace root\wmi -ErrorAction Stop | Where-Object { $_.InstanceName -eq $Monitor.InstanceName }
        $preferredMode = "$($QuerySourceMode.MonitorSourceModes[$QuerySourceMode.PreferredMonitorSourceModeIndex].HorizontalActivePixels)x$($QuerySourceMode.MonitorSourceModes[$QuerySourceMode.PreferredMonitorSourceModeIndex].VerticalActivePixels)"

        # Construct the result object for the current monitor
        $Results += "Port [$p]: $($ConnectionType) - $(ConvertTo-Manufacturer(ConvertTo-Char($Monitor.ManufacturerName))) $(ConvertTo-Char $Monitor.userfriendlyname) - Native: $preferredMode"
        if ($p -lt $Query.Count) {
            $Results += ' | '
        }
        $p++
    }
} Catch {
    # Handle exceptions gracefully and construct an error result object
    $totalMonitors = 0
    $Results = "Total: $($totalMonitors), possibly no monitors connected - $($Error[0])"
}

# Output the result string
Action1-Set-CustomAttribute 'Connected Displays' $Results

# ## Get Windows Key
# # Query the Original Product Key via WMI
# $originalProductKey = (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey

# # Check if the Original Product Key is empty
# if ([string]::IsNullOrEmpty($originalProductKey)) {
#     # If the Original Product Key is empty, query the registry key
#     $registryProductKey = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" -Name "BackupProductKeyDefault"
    
#     # Output the Registry Product Key
#     $KeyOutput = "$($registryProductKey.BackupProductKeyDefault) [Registry Backup Key]"
# } else {
#     # If the Original Product Key is not empty, output it
#     $KeyOutput = "$originalProductKey [OEM BIOS Key]"
# }

# # Output the result string
# Action1-Set-CustomAttribute 'Windows Key' $KeyOutput


# ## Calculate the average stability index
# # Define the number of days to measure
# $lastDays=30

# # Calculate the date
# $days = (get-date).AddDays(-$lastDays)

# # Get all stability metrics for the past days
# $allMetrics = Get-CimInstance -ClassName win32_reliabilitystabilitymetrics | Where-Object { $_.TimeGenerated -ge $days}

# # Calculate the average stability index
# $counter=0
# $sum=0
# foreach ($metric in $allMetrics)
# {
#     $sum += $metric.SystemStabilityIndex
#     $counter++
# }
# $averageMetric = [Math]::Round(($sum/$counter),2)

# # Output the result string
# Action1-Set-CustomAttribute 'System Reliability' "$averageMetric of 10 [average past $lastDays days]"

# ## Get Battery Infos
# # Query the EstimatedChargeRemaining property of the Win32_Battery class
# if ((Get-CimInstance -ClassName Win32_Battery).Availability -gt 0)
# {
#     # Get Battery info
#     $BattAssembly = [Windows.Devices.Power.Battery,Windows.Devices.Power.Battery,ContentType=WindowsRuntime] 
#     $Report = [Windows.Devices.Power.Battery]::AggregateBattery.GetReport() 

#     # Create Battery Report
#     $RemainingCapacity = [Math]::Round([int64]$Report.FullChargeCapacityInMilliwattHours * 100 / [int64]$Report.DesignCapacityInMilliwattHours, 2)
# }
# Else
# {
#     # Create Report if no battery found
#     $RemainingCapacity = 0
# }

# # Get power plan settings
# $powerSettings = (Get-CimInstance -Name root\cimv2\power -Class Win32_PowerPlan | Where-Object -FilterScript {$_.IsActive -eq 'true'}).ElementName

# if ($RemainingCapacity -eq "0")
# {
# 	$OutputEnergy = "Power Plan: $powerSettings"
# }
# Else
# {
# 	$OutputEnergy = "Power Plan: $powerSettings | Battery Capacity [%]: $RemainingCapacity"
# }

# # Output the result string
# Action1-Set-CustomAttribute 'Energy Infos' $OutputEnergy

## Get Bitlocker Infos
try {
    $BitlockerVolumes = Get-BitLockerVolume -ErrorAction Stop

    $Output = $BitlockerVolumes | ForEach-Object {
        $Volume = $_
        $MountPoint = $Volume.MountPoint
        $RecoveryKey = ($Volume.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }).RecoveryPassword

        if ($RecoveryKey.Length -gt 5) {
            Write-Output "Drive $MountPoint $RecoveryKey"
        }
    }

    $OutputAsString = $Output -join ' | '
} catch {
    $OutputAsString = 'Bitlocker inactive!'
}
# Output the result string
Action1-Set-CustomAttribute 'Bitlocker Recovery Keys' $OutputAsString

## Get drive volume info
$Output = ''
try {
    $VolumeInfo = Get-Volume | Sort-Object DriveLetter | Where-Object DriveLetter -NE $null

    $Output = $VolumeInfo | ForEach-Object {

        $DriveLetter = $_.DriveLetter
        $FileSystemLabel = $_.FileSystemLabel
        $FileSystemType = $_.FileSystemType
        $DriveType = $_.DriveType
        $HealthStatus = $_.HealthStatus
        $OperationalStatus = $_.OperationalStatus 
        $SizeRemaining = [math]::Round($_.SizeRemaining / 1GB)
        $SizeInUse = [math]::Round($($_.Size - $_.SizeRemaining) / 1GB)
        $SizeTotal = [math]::Round($_.Size / 1GB)
        
        Write-Output "Letter: $DriveLetter Name: $FileSystemLabel Format: $FileSystemType Type: $DriveType Health: $HealthStatus Status: $OperationalStatus Remaining(GB): $SizeRemaining In Use(GB): $SizeInUse Total(GB): $SizeTotal"

    }
    
    $OutputAsString = $Output -join ' | '
    
} catch {
    $OutputAsString = 'Unable to get disk volume information.'
}

Action1-Set-CustomAttribute 'Disk Volume Info' $OutputAsString

## Chassis Type
$OutputChassis = ''

try {
    $OutputChassis = Get-ChassisType
} catch {
    $OutputChassis = 'Unable to get chassis type'
}

Action1-Set-CustomAttribute 'Chassis Type' $OutputChassis

## Get public IP
$OutputPublicIP = ''
try {
    $OutputPublicIP = $(Invoke-WebRequest -Uri 'http://ifconfig.me/ip' -UseBasicParsing ).Content
} catch {
    $OutputPublicIP = 'Unable to get public IP address'
}

Action1-Set-CustomAttribute 'Public IP Address' $OutputPublicIP
