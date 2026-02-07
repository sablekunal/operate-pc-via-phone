Write-Host "Checking for winget..."
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "Winget is not installed or not in your PATH. Please install App Installer from the Microsoft Store."
    exit 1
}

Write-Host "Installing Tailscale..."
winget install -e --id Tailscale.Tailscale
if ($LASTEXITCODE -eq 0) {
    Write-Host "Tailscale installed successfully." -ForegroundColor Green
} else {
    Write-Warning "Tailscale installation might have failed or was cancelled."
}

Write-Host "Installing Spacedesk Driver..."
winget install -e --id Datronicsoft.spacedeskDriver.Server
if ($LASTEXITCODE -eq 0) {
    Write-Host "Spacedesk Driver installed successfully. A REBOOT IS LIKELY REQUIRED." -ForegroundColor Green
} else {
    Write-Warning "Spacedesk installation might have failed or was cancelled."
}

Write-Host "`nInstallation process finished."
Write-Host "Please REBOOT your computer to ensure drivers are loaded." -ForegroundColor Yellow
Pause
