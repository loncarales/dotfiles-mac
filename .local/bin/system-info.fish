#!/usr/bin/env fish

# Display hostname with figlet + lolcat
figlet "  "(hostname -s) | lolcat

# System info
set osName (sw_vers -productName)
set osVersion (sw_vers -productVersion)
set osbuildVersion (sw_vers -buildVersion)
set kernelVersion (sysctl -n kern.version | awk '{print $1" "$4}' | sed 's/.$//')
set processorName (sysctl -n machdep.cpu.brand_string)
set processorCores (sysctl -n machdep.cpu.core_count)
set memorySize (sysctl -n hw.memsize)
set memoryType (system_profiler SPMemoryDataType | grep -e "Type" | uniq | awk '{print $2}')
set memorySpeed (system_profiler SPMemoryDataType | grep -e "Speed" | uniq | awk '{print $2" "$3}')

# Temperatures
set warnDiskTemperature 50
set criticalDiskTemperature 61
set warnCpuTemperature 60
set criticalCpuTemperature 80

set diskTemperature (smartctl -a /dev/disk1s1 | grep Temperature | awk '{print $2}')
set cpuTemperature (osx-cpu-temp -C -c)
set cpuTemperatureInt (echo $cpuTemperature | awk '{print int($1)}')
set gpuTemperature (osx-cpu-temp -C -g)
set gpuTemperatureInt (echo $gpuTemperature | awk '{print int($1)}')

# ANSI Colors
set fontColor \e\[97m
set clear \e\[0m

# Disk Temp Color
if test "$diskTemperature" -gt "$criticalDiskTemperature"
    set diskColor \e\[1\;41m
else if test "$diskTemperature" -gt "$warnDiskTemperature"
    set diskColor \e\[1\;43m
else
    set diskColor \e\[1\;42m
end

# CPU Temp Color
if test "$cpuTemperatureInt" -gt "$criticalCpuTemperature"
    set cpuColor \e\[1\;41m
else if test "$cpuTemperatureInt" -gt "$warnCpuTemperature"
    set cpuColor \e\[1\;43m
else
    set cpuColor \e\[1\;42m
end

# GPU Temp Color
if test "$gpuTemperatureInt" -gt "$criticalCpuTemperature"
    set gpuColor \e\[1\;41m
else if test "$gpuTemperatureInt" -gt "$warnCpuTemperature"
    set gpuColor \e\[1\;43m
else
    set gpuColor \e\[1\;42m
end

# Print system info
echo -e "\e[1mSystem Information\e[0m
* OS Version.: $osName $osVersion $osbuildVersion $kernelVersion
* Processor..: $processorName $processorCores Cores
* Memory.....: "(math "$memorySize / (1024^3)")" GB $memorySpeed $memoryType
* Disk Temp..: $fontColor$diskColor $diskTemperature.0°C $clear
* CPU Temp...: $fontColor$cpuColor $cpuTemperature $clear
* GPU Temp...: $fontColor$gpuColor $gpuTemperature $clear
"

# Disk usage (original Bash logic, preserved)
set diskSize (diskutil info /dev/disk1s1 | grep Total | awk '{ print int($4) }')
set diskFree (diskutil info /dev/disk1s1 | grep Free | awk '{ print int($4) }')

# Guard against missing values
if test -n "$diskSize" -a -n "$diskFree"
    set diskUsage (math "$diskSize - $diskFree")
    set diskUsagePercent (math "($diskUsage / $diskSize) * 100")
    set diskUsagePercent (printf "%.0f" $diskUsagePercent)
else
    set diskUsage 0
    set diskSize 1
    set diskUsagePercent 0
end

# Bar settings
set barWidth 50
set warnDiskUsage 90
set barClear \e\[0m
set barColor \e\[33m

if test $diskUsagePercent -ge $warnDiskUsage
    set barColor \e\[31m
end

set barUsageWidth (math "($diskUsagePercent * $barWidth) / 100")
set barUsageWidth (printf "%.0f" $barUsageWidth)

# Build usage bar
set barContent "[$barColor"
for i in (seq $barUsageWidth)
    set barContent "$barContent|"
end
set barContent "$barContent$barClear"

# Free bar
set barUsageLeft (math "$barWidth - $barUsageWidth")
set barUsageLeft (printf "%.0f" $barUsageLeft)

if test $barUsageLeft -gt 0
    for i in (seq $barUsageLeft)
        set barContent "$barContent-"
    end
end

set barContent "$barContent]"

# Output
echo -e "\e[1m* Startup disk usage..:\e[0m $diskUsage GB out of $diskSize G"
echo -e $barContent
echo ""
#
# External Disk Usage: /dev/disk3s1
#
set extDiskSize (diskutil info /dev/disk3s1 | grep Total | awk '{ print int($4) }')
set extDiskFree (diskutil info /dev/disk3s1 | grep Free | awk '{ print int($4) }')

# Guard against missing values
if test -n "$extDiskSize" -a -n "$extDiskFree"
    set extDiskUsage (math "$extDiskSize - $extDiskFree")
    set extDiskUsagePercent (math "($extDiskUsage / $extDiskSize) * 100")
    set extDiskUsagePercent (printf "%.0f" $extDiskUsagePercent)
else
    set extDiskUsage 0
    set extDiskSize 1
    set extDiskUsagePercent 0
end

# Bar settings for external disk
set extBarWidth 50
set extBarColor \e\[33m
set extBarClear \e\[0m

if test $extDiskUsagePercent -ge $warnDiskUsage
    set extBarColor \e\[31m
end

set extBarUsageWidth (math "($extDiskUsagePercent * $extBarWidth) / 100")
set extBarUsageWidth (printf "%.0f" $extBarUsageWidth)

# Build external usage bar
set extBarContent "[$extBarColor"
for i in (seq $extBarUsageWidth)
    set extBarContent "$extBarContent|"
end
set extBarContent "$extBarContent$extBarClear"

# Add free space part
set extBarUsageLeft (math "$extBarWidth - $extBarUsageWidth")
set extBarUsageLeft (printf "%.0f" $extBarUsageLeft)

if test $extBarUsageLeft -gt 0
    for i in (seq $extBarUsageLeft)
        set extBarContent "$extBarContent-"
    end
end

set extBarContent "$extBarContent]"

# Output external disk usage
echo -e "\e[1m* External disk usage.:\e[0m $extDiskUsage GB out of $extDiskSize G"
echo -e $extBarContent
echo ""
