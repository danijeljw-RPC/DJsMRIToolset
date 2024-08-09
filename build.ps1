Push-Location

Set-Location $PSScriptRoot

dotnet clean

dotnet build -c Release

.\BuildInstaller.ps1

Pop-Location
