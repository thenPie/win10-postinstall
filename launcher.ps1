$scriptUrl = "https://raw.githubusercontent.com/thenPie/win10-postinstall/main/Removal.ps1"

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')

if (-not $isAdmin) {
    Write-Host "`nRequesting administrative privileges..." -ForegroundColor Yellow
    $proc = Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"& {iwr -useb $scriptUrl | iex}`"" -Verb RunAs -WindowStyle Normal
    # Exit quietly without throwing an error
    break
}
else {
    # Already running as admin, execute directly in current window
    . { iwr -useb $scriptUrl } | iex
}
