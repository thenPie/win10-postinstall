$scriptUrl = "https://raw.githubusercontent.com/thenPie/win10-postinstall/main/Removal.ps1"

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')

if (-not $isAdmin) {
    $command = "irm $scriptUrl | iex"
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command $command" -Verb RunAs
}
else {
    . { iwr -useb $scriptUrl } | iex
}
