$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')

$scriptUrl = "https://raw.githubusercontent.com/thenPie/win10-postinstall/refs/heads/main/Removal.ps1"

if ($isAdmin) {
    irm $scriptUrl | iex
}
else {
    $command = "irm $scriptUrl | iex"
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command $command" -Verb RunAs
}
