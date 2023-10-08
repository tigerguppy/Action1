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

$Objects = Get-ChassisType;

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
