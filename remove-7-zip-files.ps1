.SYNOPSIS
    Removes 7-Zip program files that create a high-level vulnerability on Windows Server 2019.
    Please test thoroughly in a non-production environment before deploying widely.
    Make sure to run as Administrator or with appropriate privileges.

.NOTES
    Author        : Laura White
    Date Created  : 2025-02-02
    Last Modified : 2025-02-02
    Version       : 1.0

.TESTED ON
    Date(s) Tested  : 2025-02-02
    Tested By       : Laura
    Systems Tested  : Windows Server 2019 Datacenter, Build 1809
    PowerShell Ver. : 5.1.17763.6766

.USAGE
    Example syntax:
    PS C:\> .\remove-7-zip.ps1
#>

# Define the default installation path of 7-Zip
$sevenZipPath = "C:\Program Files\7-Zip"
$uninstaller = Join-Path $sevenZipPath "Uninstall.exe"

# Check if the 7-Zip directory exists and take action
if (Test-Path $sevenZipPath) {
    if (Test-Path $uninstaller) {
        # Run the silent uninstall if the uninstaller is present
        Write-Host "Running 7-Zip uninstaller..." -ForegroundColor Yellow
        & $uninstaller /S
        Start-Sleep -Seconds 10
    }
    
    # Whether uninstall works or not, delete the directory
    Write-Host "Cleaning up 7-Zip directory..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $sevenZipPath
    
    Write-Host "7-Zip has been successfully removed." -ForegroundColor Green
} else {
    Write-Host "7-Zip is not installed." -ForegroundColor Red
}