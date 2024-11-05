$scriptUrl = "https://raw.githubusercontent.com/thenPie/win10-postinstall/main/Removal.ps1"

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')

if (-not $isAdmin) {
    try {
        $command = "irm $scriptUrl | iex"
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command $command" -Verb RunAs -ErrorAction Stop
    }
    catch {
        Write-Host "`nElevation denied. Admin rights are required to run this script." -ForegroundColor Red
        Write-Host "Press any key to exit..."
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    }
}
else {
    . { iwr -useb $scriptUrl } | iex
}
