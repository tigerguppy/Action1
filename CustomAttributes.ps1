Function Get-ChassisType() {
    <#
    .SYNOPSIS
    Get the chassis type for a computer.
    
    .DESCRIPTION
    Get the chassis type for a computer.
    
    .EXAMPLE
    Get-ChassisType
    #>

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

Function ConvertTo-Char ($Array) {
    <#
    .SYNOPSIS
    Convert an array of integers to characters.
    
    .DESCRIPTION
    Convert an array of integers to characters.
    
    .PARAMETER Array
    Array of integers.
    #>

    if ($null -eq $Array -or $Array.Length -eq 0) {
        return ''
    } else {
        return ([System.Text.Encoding]::ASCII.GetString($Array)).TrimEnd("`0")
    }
}

Function ConvertTo-Manufacturer ($Code) {
    <#
    .SYNOPSIS
    Convert manufacturer codes to manufacturer names.
    
    .DESCRIPTION
    Convert manufacturer codes to manufacturer names
    
    .PARAMETER Code
    Short code of the monitor manufacturer.
    
    .EXAMPLE
    ConvertTo-Manufacturer 'ACI'
    #>

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

function Get-Win11Readiness {
    #=============================================================================================================================

    # https://aka.ms/HWReadinessScript

    # Script Name:     HardwareReadiness.ps1
    # Description:     Verifies the hardware compliance. Return code 0 for success. 
    #                  In case of failure, returns non zero error code along with error message.

    # This script is not supported under any Microsoft standard support program or service and is distributed under the MIT license

    # Copyright (C) 2021 Microsoft Corporation

    # Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
    # files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
    # modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
    # is furnished to do so, subject to the following conditions:

    # The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
    # WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    # COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
    # ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

    #=============================================================================================================================

    $exitCode = 0

    [int]$MinOSDiskSizeGB = 64
    [int]$MinMemoryGB = 4
    [Uint32]$MinClockSpeedMHz = 1000
    [Uint32]$MinLogicalCores = 2
    [Uint16]$RequiredAddressWidth = 64

    $PASS_STRING = 'PASS'
    $FAIL_STRING = 'FAIL'
    $FAILED_TO_RUN_STRING = 'FAILED TO RUN'
    $UNDETERMINED_CAPS_STRING = 'UNDETERMINED'
    $UNDETERMINED_STRING = 'Undetermined'
    $CAPABLE_STRING = 'Capable'
    $NOT_CAPABLE_STRING = 'Not capable'
    $CAPABLE_CAPS_STRING = 'CAPABLE'
    $NOT_CAPABLE_CAPS_STRING = 'NOT CAPABLE'
    $STORAGE_STRING = 'Storage'
    $OS_STRING = 'OS'
    $OS_DISK_SIZE_STRING = 'OSDiskSize'
    $MEMORY_STRING = 'Memory'
    $SYSTEM_MEMORY_STRING = 'System_Memory'
    $GB_UNIT_STRING = 'GB'
    $TPM_STRING = 'TPM'
    $TPM_VERSION_STRING = 'TPMVersion'
    $PROCESSOR_STRING = 'Processor'
    $SECUREBOOT_STRING = 'SecureBoot'
    $I7_7820HQ_CPU_STRING = 'i7-7820hq CPU'

    # 0=name of check, 1=attribute checked, 2=value, 3=PASS/FAIL/UNDETERMINED
    $logFormat = '{0}: {1}={2}. {3}; '

    # 0=name of check, 1=attribute checked, 2=value, 3=unit of the value, 4=PASS/FAIL/UNDETERMINED
    $logFormatWithUnit = '{0}: {1}={2}{3}. {4}; '

    # 0=name of check.
    $logFormatReturnReason = '{0}, '

    # 0=exception.
    $logFormatException = '{0}; '

    # 0=name of check, 1= attribute checked and its value, 2=PASS/FAIL/UNDETERMINED
    $logFormatWithBlob = '{0}: {1}. {2}; '

    # return returnCode is -1 when an exception is thrown. 1 if the value does not meet requirements. 0 if successful. -2 default, script didn't run.
    $outObject = @{ returnCode = -2; returnResult = $FAILED_TO_RUN_STRING; returnReason = ''; logging = '' }

    # NOT CAPABLE(1) state takes precedence over UNDETERMINED(-1) state
    function Private:UpdateReturnCode {
        param(
            [Parameter(Mandatory = $true)]
            [ValidateRange(-2, 1)]
            [int] $ReturnCode
        )

        Switch ($ReturnCode) {

            0 {
                if ($outObject.returnCode -eq -2) {
                    $outObject.returnCode = $ReturnCode
                }
            }
            1 {
                $outObject.returnCode = $ReturnCode
            }
            -1 {
                if ($outObject.returnCode -ne 1) {
                    $outObject.returnCode = $ReturnCode
                }
            }
        }
    }

    $Source = @'
using Microsoft.Win32;
using System;
using System.Runtime.InteropServices;

    public class CpuFamilyResult
    {
        public bool IsValid { get; set; }
        public string Message { get; set; }
    }

    public class CpuFamily
    {
        [StructLayout(LayoutKind.Sequential)]
        public struct SYSTEM_INFO
        {
            public ushort ProcessorArchitecture;
            ushort Reserved;
            public uint PageSize;
            public IntPtr MinimumApplicationAddress;
            public IntPtr MaximumApplicationAddress;
            public IntPtr ActiveProcessorMask;
            public uint NumberOfProcessors;
            public uint ProcessorType;
            public uint AllocationGranularity;
            public ushort ProcessorLevel;
            public ushort ProcessorRevision;
        }

        [DllImport("kernel32.dll")]
        internal static extern void GetNativeSystemInfo(ref SYSTEM_INFO lpSystemInfo);

        public enum ProcessorFeature : uint
        {
            ARM_SUPPORTED_INSTRUCTIONS = 34
        }

        [DllImport("kernel32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        static extern bool IsProcessorFeaturePresent(ProcessorFeature processorFeature);

        private const ushort PROCESSOR_ARCHITECTURE_X86 = 0;
        private const ushort PROCESSOR_ARCHITECTURE_ARM64 = 12;
        private const ushort PROCESSOR_ARCHITECTURE_X64 = 9;

        private const string INTEL_MANUFACTURER = "GenuineIntel";
        private const string AMD_MANUFACTURER = "AuthenticAMD";
        private const string QUALCOMM_MANUFACTURER = "Qualcomm Technologies Inc";

        public static CpuFamilyResult Validate(string manufacturer, ushort processorArchitecture)
        {
            CpuFamilyResult cpuFamilyResult = new CpuFamilyResult();

            if (string.IsNullOrWhiteSpace(manufacturer))
            {
                cpuFamilyResult.IsValid = false;
                cpuFamilyResult.Message = "Manufacturer is null or empty";
                return cpuFamilyResult;
            }

            string registryPath = "HKEY_LOCAL_MACHINE\\Hardware\\Description\\System\\CentralProcessor\\0";
            SYSTEM_INFO sysInfo = new SYSTEM_INFO();
            GetNativeSystemInfo(ref sysInfo);

            switch (processorArchitecture)
            {
                case PROCESSOR_ARCHITECTURE_ARM64:

                    if (manufacturer.Equals(QUALCOMM_MANUFACTURER, StringComparison.OrdinalIgnoreCase))
                    {
                        bool isArmv81Supported = IsProcessorFeaturePresent(ProcessorFeature.ARM_SUPPORTED_INSTRUCTIONS);

                        if (!isArmv81Supported)
                        {
                            string registryName = "CP 4030";
                            long registryValue = (long)Registry.GetValue(registryPath, registryName, -1);
                            long atomicResult = (registryValue >> 20) & 0xF;

                            if (atomicResult >= 2)
                            {
                                isArmv81Supported = true;
                            }
                        }

                        cpuFamilyResult.IsValid = isArmv81Supported;
                        cpuFamilyResult.Message = isArmv81Supported ? "" : "Processor does not implement ARM v8.1 atomic instruction";
                    }
                    else
                    {
                        cpuFamilyResult.IsValid = false;
                        cpuFamilyResult.Message = "The processor isn't currently supported for Windows 11";
                    }

                    break;

                case PROCESSOR_ARCHITECTURE_X64:
                case PROCESSOR_ARCHITECTURE_X86:

                    int cpuFamily = sysInfo.ProcessorLevel;
                    int cpuModel = (sysInfo.ProcessorRevision >> 8) & 0xFF;
                    int cpuStepping = sysInfo.ProcessorRevision & 0xFF;

                    if (manufacturer.Equals(INTEL_MANUFACTURER, StringComparison.OrdinalIgnoreCase))
                    {
                        try
                        {
                            cpuFamilyResult.IsValid = true;
                            cpuFamilyResult.Message = "";

                            if (cpuFamily >= 6 && cpuModel <= 95 && !(cpuFamily == 6 && cpuModel == 85))
                            {
                                cpuFamilyResult.IsValid = false;
                                cpuFamilyResult.Message = "";
                            }
                            else if (cpuFamily == 6 && (cpuModel == 142 || cpuModel == 158) && cpuStepping == 9)
                            {
                                string registryName = "Platform Specific Field 1";
                                int registryValue = (int)Registry.GetValue(registryPath, registryName, -1);

                                if ((cpuModel == 142 && registryValue != 16) || (cpuModel == 158 && registryValue != 8))
                                {
                                    cpuFamilyResult.IsValid = false;
                                }
                                cpuFamilyResult.Message = "PlatformId " + registryValue;
                            }
                        }
                        catch (Exception ex)
                        {
                            cpuFamilyResult.IsValid = false;
                            cpuFamilyResult.Message = "Exception:" + ex.GetType().Name;
                        }
                    }
                    else if (manufacturer.Equals(AMD_MANUFACTURER, StringComparison.OrdinalIgnoreCase))
                    {
                        cpuFamilyResult.IsValid = true;
                        cpuFamilyResult.Message = "";

                        if (cpuFamily < 23 || (cpuFamily == 23 && (cpuModel == 1 || cpuModel == 17)))
                        {
                            cpuFamilyResult.IsValid = false;
                        }
                    }
                    else
                    {
                        cpuFamilyResult.IsValid = false;
                        cpuFamilyResult.Message = "Unsupported Manufacturer: " + manufacturer + ", Architecture: " + processorArchitecture + ", CPUFamily: " + sysInfo.ProcessorLevel + ", ProcessorRevision: " + sysInfo.ProcessorRevision;
                    }

                    break;

                default:
                    cpuFamilyResult.IsValid = false;
                    cpuFamilyResult.Message = "Unsupported CPU category. Manufacturer: " + manufacturer + ", Architecture: " + processorArchitecture + ", CPUFamily: " + sysInfo.ProcessorLevel + ", ProcessorRevision: " + sysInfo.ProcessorRevision;
                    break;
            }
            return cpuFamilyResult;
        }
    }
'@

    # Current OS
    try {
        $currentOs = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property Caption

        if ($null -eq $currentOs.Caption) {
            UpdateReturnCode -ReturnCode 1
            $outObject.returnReason += $logFormatReturnReason -f $OS_STRING
            $outObject.logging += $logFormatWithBlob -f $OS_STRING, 'OS is null', $FAIL_STRING
            $exitCode = 1
        } elseif ($currentOs.Caption -like '*Server*') {
            UpdateReturnCode -ReturnCode 1
            $outObject.returnReason += $logFormatReturnReason -f $OS_STRING
            $outObject.logging += $logFormatWithBlob -f $OS_STRING, $currentOs.Caption, $FAIL_STRING
            $exitCode = 1
        } else {
            $outObject.logging += $logFormatWithBlob -f $OS_STRING, $currentOs.Caption, $PASS_STRING
            UpdateReturnCode -ReturnCode 0
        }
    } catch {
        UpdateReturnCode -ReturnCode -1
        $outObject.logging += $logFormat -f $OS_STRING, $currentOs.Caption, $UNDETERMINED_STRING, $UNDETERMINED_CAPS_STRING
        $outObject.logging += $logFormatException -f "$($_.Exception.GetType().Name) $($_.Exception.Message)"
        $exitCode = 1
    }

    # Storage
    try {
        $osDrive = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property SystemDrive
        $osDriveSize = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='$($osDrive.SystemDrive)'" | Select-Object @{Name = 'SizeGB'; Expression = { $_.Size / 1GB -as [int] } }  

        if ($null -eq $osDriveSize) {
            UpdateReturnCode -ReturnCode 1
            $outObject.returnReason += $logFormatReturnReason -f $STORAGE_STRING
            $outObject.logging += $logFormatWithBlob -f $STORAGE_STRING, 'Storage is null', $FAIL_STRING
            $exitCode = 1
        } elseif ($osDriveSize.SizeGB -lt $MinOSDiskSizeGB) {
            UpdateReturnCode -ReturnCode 1
            $outObject.returnReason += $logFormatReturnReason -f $STORAGE_STRING
            $outObject.logging += $logFormatWithUnit -f $STORAGE_STRING, $OS_DISK_SIZE_STRING, ($osDriveSize.SizeGB), $GB_UNIT_STRING, $FAIL_STRING
            $exitCode = 1
        } else {
            $outObject.logging += $logFormatWithUnit -f $STORAGE_STRING, $OS_DISK_SIZE_STRING, ($osDriveSize.SizeGB), $GB_UNIT_STRING, $PASS_STRING
            UpdateReturnCode -ReturnCode 0
        }
    } catch {
        UpdateReturnCode -ReturnCode -1
        $outObject.logging += $logFormat -f $STORAGE_STRING, $OS_DISK_SIZE_STRING, $UNDETERMINED_STRING, $UNDETERMINED_CAPS_STRING
        $outObject.logging += $logFormatException -f "$($_.Exception.GetType().Name) $($_.Exception.Message)"
        $exitCode = 1
    }

    # Memory (bytes)
    try {
        $memory = Get-WmiObject Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | Select-Object @{Name = 'SizeGB'; Expression = { $_.Sum / 1GB -as [int] } }

        if ($null -eq $memory) {
            UpdateReturnCode -ReturnCode 1
            $outObject.returnReason += $logFormatReturnReason -f $MEMORY_STRING
            $outObject.logging += $logFormatWithBlob -f $MEMORY_STRING, 'Memory is null', $FAIL_STRING
            $exitCode = 1
        } elseif ($memory.SizeGB -lt $MinMemoryGB) {
            UpdateReturnCode -ReturnCode 1
            $outObject.returnReason += $logFormatReturnReason -f $MEMORY_STRING
            $outObject.logging += $logFormatWithUnit -f $MEMORY_STRING, $SYSTEM_MEMORY_STRING, ($memory.SizeGB), $GB_UNIT_STRING, $FAIL_STRING
            $exitCode = 1
        } else {
            $outObject.logging += $logFormatWithUnit -f $MEMORY_STRING, $SYSTEM_MEMORY_STRING, ($memory.SizeGB), $GB_UNIT_STRING, $PASS_STRING
            UpdateReturnCode -ReturnCode 0
        }
    } catch {
        UpdateReturnCode -ReturnCode -1
        $outObject.logging += $logFormat -f $MEMORY_STRING, $SYSTEM_MEMORY_STRING, $UNDETERMINED_STRING, $UNDETERMINED_CAPS_STRING
        $outObject.logging += $logFormatException -f "$($_.Exception.GetType().Name) $($_.Exception.Message)"
        $exitCode = 1
    }

    # TPM
    try {
        $tpm = Get-Tpm

        if ($null -eq $tpm) {
            UpdateReturnCode -ReturnCode 1
            $outObject.returnReason += $logFormatReturnReason -f $TPM_STRING
            $outObject.logging += $logFormatWithBlob -f $TPM_STRING, 'TPM is null', $FAIL_STRING
            $exitCode = 1
        } elseif ($tpm.TpmPresent) {
            $tpmVersion = Get-WmiObject -Class Win32_Tpm -Namespace root\CIMV2\Security\MicrosoftTpm | Select-Object -Property SpecVersion

            if ($null -eq $tpmVersion.SpecVersion) {
                UpdateReturnCode -ReturnCode 1
                $outObject.returnReason += $logFormatReturnReason -f $TPM_STRING
                $outObject.logging += $logFormat -f $TPM_STRING, $TPM_VERSION_STRING, 'null', $FAIL_STRING
                $exitCode = 1
            }

            $majorVersion = $tpmVersion.SpecVersion.Split(',')[0] -as [int]
            if ($majorVersion -lt 2) {
                UpdateReturnCode -ReturnCode 1
                $outObject.returnReason += $logFormatReturnReason -f $TPM_STRING
                $outObject.logging += $logFormat -f $TPM_STRING, $TPM_VERSION_STRING, ($tpmVersion.SpecVersion), $FAIL_STRING
                $exitCode = 1
            } else {
                $outObject.logging += $logFormat -f $TPM_STRING, $TPM_VERSION_STRING, ($tpmVersion.SpecVersion), $PASS_STRING
                UpdateReturnCode -ReturnCode 0
            }
        } else {
            if ($tpm.GetType().Name -eq 'String') {
                UpdateReturnCode -ReturnCode -1
                $outObject.logging += $logFormat -f $TPM_STRING, $TPM_VERSION_STRING, $UNDETERMINED_STRING, $UNDETERMINED_CAPS_STRING
                $outObject.logging += $logFormatException -f $tpm
            } else {
                UpdateReturnCode -ReturnCode 1
                $outObject.returnReason += $logFormatReturnReason -f $TPM_STRING
                $outObject.logging += $logFormat -f $TPM_STRING, $TPM_VERSION_STRING, ($tpm.TpmPresent), $FAIL_STRING
            }
            $exitCode = 1
        }
    } catch {
        UpdateReturnCode -ReturnCode -1
        $outObject.logging += $logFormat -f $TPM_STRING, $TPM_VERSION_STRING, $UNDETERMINED_STRING, $UNDETERMINED_CAPS_STRING
        $outObject.logging += $logFormatException -f "$($_.Exception.GetType().Name) $($_.Exception.Message)"
        $exitCode = 1
    }

    # SecureBooot
    try {
        $isSecureBootEnabled = Confirm-SecureBootUEFI
        $outObject.logging += $logFormatWithBlob -f $SECUREBOOT_STRING, $CAPABLE_STRING, $PASS_STRING
        UpdateReturnCode -ReturnCode 0
    } catch [System.PlatformNotSupportedException] {
        # PlatformNotSupportedException "Cmdlet not supported on this platform." - SecureBoot is not supported or is non-UEFI computer.
        UpdateReturnCode -ReturnCode 1
        $outObject.returnReason += $logFormatReturnReason -f $SECUREBOOT_STRING
        $outObject.logging += $logFormatWithBlob -f $SECUREBOOT_STRING, $NOT_CAPABLE_STRING, $FAIL_STRING
        $exitCode = 1
    } catch [System.UnauthorizedAccessException] {
        UpdateReturnCode -ReturnCode -1
        $outObject.logging += $logFormatWithBlob -f $SECUREBOOT_STRING, $UNDETERMINED_STRING, $UNDETERMINED_CAPS_STRING
        $outObject.logging += $logFormatException -f "$($_.Exception.GetType().Name) $($_.Exception.Message)"
        $exitCode = 1
    } catch {
        UpdateReturnCode -ReturnCode -1
        $outObject.logging += $logFormatWithBlob -f $SECUREBOOT_STRING, $UNDETERMINED_STRING, $UNDETERMINED_CAPS_STRING
        $outObject.logging += $logFormatException -f "$($_.Exception.GetType().Name) $($_.Exception.Message)"
        $exitCode = 1
    }

    # CPU Details
    $cpuDetails;
    try {
        $cpuDetails = @(Get-WmiObject -Class Win32_Processor)[0]

        if ($null -eq $cpuDetails) {
            UpdateReturnCode -ReturnCode 1
            $exitCode = 1
            $outObject.returnReason += $logFormatReturnReason -f $PROCESSOR_STRING
            $outObject.logging += $logFormatWithBlob -f $PROCESSOR_STRING, 'CpuDetails is null', $FAIL_STRING
        } else {
            $processorCheckFailed = $false

            # AddressWidth
            if ($null -eq $cpuDetails.AddressWidth -or $cpuDetails.AddressWidth -ne $RequiredAddressWidth) {
                UpdateReturnCode -ReturnCode 1
                $processorCheckFailed = $true
                $exitCode = 1
            }

            # ClockSpeed is in MHz
            if ($null -eq $cpuDetails.MaxClockSpeed -or $cpuDetails.MaxClockSpeed -le $MinClockSpeedMHz) {
                UpdateReturnCode -ReturnCode 1;
                $processorCheckFailed = $true
                $exitCode = 1
            }

            # Number of Logical Cores
            if ($null -eq $cpuDetails.NumberOfLogicalProcessors -or $cpuDetails.NumberOfLogicalProcessors -lt $MinLogicalCores) {
                UpdateReturnCode -ReturnCode 1
                $processorCheckFailed = $true
                $exitCode = 1
            }

            # CPU Family
            Add-Type -TypeDefinition $Source
            $cpuFamilyResult = [CpuFamily]::Validate([String]$cpuDetails.Manufacturer, [uint16]$cpuDetails.Architecture)

            $cpuDetailsLog = "{Bit=$($cpuDetails.AddressWidth); MaxClock=$($cpuDetails.MaxClockSpeed); Cores=$($cpuDetails.NumberOfLogicalProcessors); Mfg=$($cpuDetails.Manufacturer); Caption=$($cpuDetails.Caption); $($cpuFamilyResult.Message)}"

            if (!$cpuFamilyResult.IsValid) {
                UpdateReturnCode -ReturnCode 1
                $processorCheckFailed = $true
                $exitCode = 1
            }

            if ($processorCheckFailed) {
                $outObject.returnReason += $logFormatReturnReason -f $PROCESSOR_STRING
                $outObject.logging += $logFormatWithBlob -f $PROCESSOR_STRING, ($cpuDetailsLog), $FAIL_STRING
            } else {
                $outObject.logging += $logFormatWithBlob -f $PROCESSOR_STRING, ($cpuDetailsLog), $PASS_STRING
                UpdateReturnCode -ReturnCode 0
            }
        }
    } catch {
        UpdateReturnCode -ReturnCode -1
        $outObject.logging += $logFormat -f $PROCESSOR_STRING, $PROCESSOR_STRING, $UNDETERMINED_STRING, $UNDETERMINED_CAPS_STRING
        $outObject.logging += $logFormatException -f "$($_.Exception.GetType().Name) $($_.Exception.Message)"
        $exitCode = 1
    }

    # i7-7820hq CPU
    try {
        $supportedDevices = @('surface studio 2', 'precision 5520')
        $systemInfo = @(Get-WmiObject -Class Win32_ComputerSystem)[0]

        if ($null -ne $cpuDetails) {
            if ($cpuDetails.Name -match 'i7-7820hq cpu @ 2.90ghz') {
                $modelOrSKUCheckLog = $systemInfo.Model.Trim()
                if ($supportedDevices -contains $modelOrSKUCheckLog) {
                    $outObject.logging += $logFormatWithBlob -f $I7_7820HQ_CPU_STRING, $modelOrSKUCheckLog, $PASS_STRING
                    $outObject.returnCode = 0
                    $exitCode = 0
                }
            }
        }
    } catch {
        if ($outObject.returnCode -ne 0) {
            UpdateReturnCode -ReturnCode -1
            $outObject.logging += $logFormatWithBlob -f $I7_7820HQ_CPU_STRING, $UNDETERMINED_STRING, $UNDETERMINED_CAPS_STRING
            $outObject.logging += $logFormatException -f "$($_.Exception.GetType().Name) $($_.Exception.Message)"
            $exitCode = 1
        }
    }

    Switch ($outObject.returnCode) {

        0 { $outObject.returnResult = $CAPABLE_CAPS_STRING }
        1 { $outObject.returnResult = $NOT_CAPABLE_CAPS_STRING }
        -1 { $outObject.returnResult = $UNDETERMINED_CAPS_STRING }
        -2 { $outObject.returnResult = $FAILED_TO_RUN_STRING }
    }

    Return $outObject
}

<# # Start Get Monitor Info
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
# End Get Monitor Info #>


<# # Start Get Windows Key
# Query the Original Product Key via WMI
$originalProductKey = (Get-WmiObject -Query 'select * from SoftwareLicensingService').OA3xOriginalProductKey

# Check if the Original Product Key is empty
if ([string]::IsNullOrEmpty($originalProductKey)) {
    # If the Original Product Key is empty, query the registry key
    $registryProductKey = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform' -Name 'BackupProductKeyDefault'
  
    # Output the Registry Product Key
    $KeyOutput = "$($registryProductKey.BackupProductKeyDefault) [Registry Backup Key]"
} else {
    # If the Original Product Key is not empty, output it
    $KeyOutput = "$originalProductKey [OEM BIOS Key]"
}

# Output the result string
Action1-Set-CustomAttribute 'Windows Key' $KeyOutput
# End Get Windows Key #>


<# # Start Calculate the average stability index
# Define the number of days to measure
$lastDays = 30

# Calculate the date
$days = (Get-Date).AddDays(-$lastDays)

# Get all stability metrics for the past days
$allMetrics = Get-CimInstance -ClassName win32_reliabilitystabilitymetrics | Where-Object { $_.TimeGenerated -ge $days }

# Calculate the average stability index
$counter = 0
$sum = 0
foreach ($metric in $allMetrics) {
    $sum += $metric.SystemStabilityIndex
    $counter++
}
$averageMetric = [Math]::Round(($sum / $counter), 2)

# Output the result string
Action1-Set-CustomAttribute 'System Reliability' "$averageMetric of 10 [average past $lastDays days]"
# End Calculate the average stability index #>

<# # Start Get Battery Infos
# Query the EstimatedChargeRemaining property of the Win32_Battery class
if ((Get-CimInstance -ClassName Win32_Battery).Availability -gt 0) {
    # Get Battery info
    $BattAssembly = [Windows.Devices.Power.Battery, Windows.Devices.Power.Battery, ContentType = WindowsRuntime] 
    $Report = [Windows.Devices.Power.Battery]::AggregateBattery.GetReport() 

    # Create Battery Report
    $RemainingCapacity = [Math]::Round([int64]$Report.FullChargeCapacityInMilliwattHours * 100 / [int64]$Report.DesignCapacityInMilliwattHours, 2)
} Else {
    # Create Report if no battery found
    $RemainingCapacity = 0
}

# Get power plan settings
$powerSettings = (Get-CimInstance -Name root\cimv2\power -Class Win32_PowerPlan | Where-Object -FilterScript { $_.IsActive -eq 'true' }).ElementName

if ($RemainingCapacity -eq '0') {
    $OutputEnergy = "Power Plan: $powerSettings"
} Else {
    $OutputEnergy = "Power Plan: $powerSettings | Battery Capacity [%]: $RemainingCapacity"
}

# Output the result string
Action1-Set-CustomAttribute 'Energy Infos' $OutputEnergy
# End Get Battery Infos #>

# Start Get Bitlocker Infos
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
# End Get Bitlocker Infos

# Start Get drive volume info
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
# End Get drive volume info

# Start Chassis Type
$OutputChassis = ''

try {
    $OutputChassis = Get-ChassisType
} catch {
    $OutputChassis = 'Unable to get chassis type'
}

Action1-Set-CustomAttribute 'Chassis Type' $OutputChassis
# End  Chassis Type

# Start Get public IP
$OutputPublicIP = ''
try {
    $OutputPublicIP = $(Invoke-WebRequest -Uri 'http://ifconfig.me/ip' -UseBasicParsing ).Content
} catch {
    $OutputPublicIP = 'Unable to get public IP address'
}

Action1-Set-CustomAttribute 'Public IP Address' $OutputPublicIP
# End Get public IP


# Start Win 11 Readiness

Action1-Set-CustomAttribute 'Win 11 Readiness' $((Get-Win11Readiness).returnResult)

# End Win 11 Readiness
