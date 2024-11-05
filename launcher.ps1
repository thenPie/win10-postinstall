$scriptUrl = "https://raw.githubusercontent.com/thenPie/win10-postinstall/main/Removal.ps1"

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')

if (-not $isAdmin) {
    try {
        # Need elevation, create new elevated process
        $command = "irm $scriptUrl | iex"
        $proc = Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command $command" -Verb RunAs -ErrorAction Stop -PassThru
        
        # Exit without error if user cancelled UAC
        exit 0
    }
    catch [System.InvalidOperationException] {
        Write-Host "`nOperation cancelled by user. Admin rights are required to run this script." -ForegroundColor Yellow
        Write-Host "Press any key to exit..."
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        exit 0
    }
    catch {
        Write-Host "`nAn error occurred: $_" -ForegroundColor Red
        Write-Host "Press any key to exit..."
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        exit 1
    }
}
else {
    # Already running as admin, execute directly in current window
    . { iwr -useb $scriptUrl } | iex
}
