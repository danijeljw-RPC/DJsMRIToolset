# Define paths
$nsisScriptPath = ".\DJsMRIToolsetInstaller.nsi"
$nsisExePath = "C:\Program Files (x86)\NSIS\makensis.exe"
$outputDirectory = ".\output"

# Ensure output directory exists
if (-not (Test-Path -Path $outputDirectory)) {
    New-Item -Path $outputDirectory -ItemType Directory
}

# Set working directory to the script location
Set-Location -Path (Split-Path -Path $nsisScriptPath -Parent)

# Run NSIS compiler
Start-Process -FilePath $nsisExePath -ArgumentList "/DOUTPUTDIR=$outputDirectory `"$nsisScriptPath`"" -NoNewWindow -Wait

Write-Output "Installer created successfully in $outputDirectory"
