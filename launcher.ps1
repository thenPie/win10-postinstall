$scriptUrl = "https://raw.githubusercontent.com/thenPie/win10-postinstall/main/Removal.ps1"

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')

if (-not $isAdmin) {
    $proc = Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"iwr -useb $scriptUrl | iex`"" -Verb RunAs
    Write-Host "`nAdmin rights are required to run this script." -ForegroundColor Yellow
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}
else {
    . { iwr -useb $scriptUrl } | iex
}
