$scriptUrl = "https://raw.githubusercontent.com/thenPie/win10-postinstall/main/Removal.ps1"

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')

if (-not $isAdmin) {
    $arguments = "& {iwr -useb $scriptUrl | iex}"
    $encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($arguments))
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile", "-EncodedCommand", $encodedCommand -Verb RunAs
}
else {
    . { iwr -useb $scriptUrl } | iex
}
