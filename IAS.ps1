# Check the instructions here on how to use it https://github.com/lstprjct/IDM-Activation-Script/wiki

$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

# Primary download URL
$DownloadURL = 'https://raw.githubusercontent.com/Blindsinner/IDM-ACTIVATION-SCRIPT/refs/heads/main/IAS.cmd'
# Optional fallback URL (if needed)
# $DownloadURL2 = 'https://raw.githubusercontent.com/lstprjct/IDM-Activation-Script/main/IAS.cmd'

# Generate a random filename
$rand = Get-Random -Maximum 99999999
# Determine if running as Administrator
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\IAS_$rand.cmd" } else { "$env:TEMP\IAS_$rand.cmd" }

# Download the script content
try {
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
} catch {
    Write-Warning "Primary URL failed, attempting fallback..."
    $response = Invoke-WebRequest -Uri $DownloadURL2 -UseBasicParsing
}

# Prepend a REM comment to avoid detection issues
$prefix = "@REM Generated $rand`r`n"
$content = $prefix + $response.Content

# Save to temporary file
Set-Content -Path $FilePath -Value $content -Encoding ASCII

# Execute the downloaded batch script with original arguments
Start-Process -FilePath $FilePath -ArgumentList $args -Wait -NoNewWindow

# Clean up any temporary files matching pattern
Get-ChildItem -Path $env:TEMP, "$env:SystemRoot\Temp" -Filter 'IAS_*.cmd' -ErrorAction SilentlyContinue | Remove-Item -Force
