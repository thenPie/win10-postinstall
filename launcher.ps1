$command = @"
irm https://raw.githubusercontent.com/thenPie/win10-postinstall/refs/heads/main/Removal.ps1 | iex
"@

Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command $command" -Verb RunAs
