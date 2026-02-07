Write-Host "=== Remote PC Connection Info ===" -ForegroundColor Cyan

# 1. Get Local LAN IP
$localIP = Get-NetIPAddress -AddressFamily IPv4 -Type Unicast | Where-Object { 
    $_.InterfaceAlias -notlike "*Loopback*" -and $_.InterfaceAlias -notlike "*Tailscale*" 
} | Select-Object -ExpandProperty IPAddress -First 1

if ($localIP) {
    Write-Host "`n[HOME/LAN Connection]" -ForegroundColor Green
    Write-Host "Connect via Wi-Fi using this IP: $localIP"
} else {
    Write-Warning "Could not detect a local LAN IP. Are you connected to Wi-Fi/Ethernet?"
}

# 2. Get Tailscale IP
$tailscaleIP = Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "*Tailscale*" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty IPAddress
# Fallback check using tailscale CLI if installed
if (-not $tailscaleIP) {
    if (Get-Command tailscale -ErrorAction SilentlyContinue) {
        $tailscaleIP = tailscale ip -4
    }
}

if ($tailscaleIP) {
    Write-Host "`n[REMOTE/WAN Connection]" -ForegroundColor Magenta
    Write-Host "Connect from anywhere using this Tailscale IP: $tailscaleIP"
} else {
    Write-Host "`n[REMOTE/WAN Connection]" -ForegroundColor Gray
    Write-Warning "Tailscale IP not found. Is Tailscale installed and logged in?"
}

# 3. Check Spacedesk Status
Write-Host "`n[System Status]" -ForegroundColor Yellow
$spacedeskService = Get-Service "spacedeskService" -ErrorAction SilentlyContinue
if ($spacedeskService) {
    if ($spacedeskService.Status -eq 'Running') {
        Write-Host "Spacedesk Service: RUNNING (Ready to connect)" -ForegroundColor Green
    } else {
        Write-Host "Spacedesk Service: STOPPED (Please start 'spacedeskService')" -ForegroundColor Red
        Write-Host "Attempting to start..."
        Start-Service "spacedeskService" -ErrorAction SilentlyContinue
    }
} else {
    Write-Warning "Spacedesk Service not found. Is the driver installed?"
}

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
