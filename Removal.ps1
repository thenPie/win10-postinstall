Clear-Host
Start-Sleep -Milliseconds 500

Write-Host "Windows 10 App Removal Script" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Function to handle the app checking/removal
Function Process-BloatwareApps {
    param (
        [bool]$SimulateOnly = $true
    )

    $AppsToRemove = @(
        "Microsoft.Office.OneNote"
        "Microsoft.MSPaint"
        "Microsoft.SkypeApp"
        "Microsoft.WindowsCamera"
        "Microsoft.WindowsTerminal"
        "MicrosoftWindows.Client.WebExperience"
        "Microsoft.WindowsAlarms"
        "Microsoft.WindowsMaps"
        "Microsoft.MicrosoftStickyNotes"
        "Microsoft.ScreenSketch"
        "microsoft.windowscommunicationsapps"
        "Microsoft.People"
        "Microsoft.BingNews"
        "Microsoft.BingWeather"
        "Microsoft.MicrosoftSolitaireCollection"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.Todos"
        "Microsoft.PowerAutomateDesktop"
        "Microsoft.549981C3F5F10"
        "MicrosoftCorporationII.QuickAssist"
        "MicrosoftCorporationII.MicrosoftFamily"
        "Clipchamp.Clipchamp"
        "Microsoft.OutlookForWindows"
        "MicrosoftTeams"
        "Microsoft.Windows.DevHome"
        "Microsoft.BingSearch"
        "MicrosoftWindows.CrossDevice"
        "MSTeams"
        "Microsoft.MicrosoftPCManager"
        "Microsoft.StartExperiencesApp"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"
        "Microsoft.YourPhone"
        "Microsoft.WindowsSoundRecorder"
    )

    $ActionText = if ($SimulateOnly) { "Would remove" } else { "Removing" }
    Write-Host "`n=== $ActionText Apps ===`n" -ForegroundColor Yellow

    $InstalledApps = Get-AppxPackage -AllUsers
    $FoundApps = @()
    $NotFoundApps = @()
    $SuccessfullyRemoved = @()
    $FailedToRemove = @()

    foreach ($AppToRemove in $AppsToRemove) {
        $Found = $InstalledApps | Where-Object {$_.Name -eq $AppToRemove}
        if ($Found) {
            $FoundApps += $AppToRemove
            
            if ($SimulateOnly) {
                Write-Host "Would remove: $AppToRemove" -ForegroundColor Yellow
            } else {
                Write-Host "Attempting to remove: $AppToRemove" -ForegroundColor Yellow
                try {
                    Get-AppxPackage -AllUsers -Name $AppToRemove | Remove-AppxPackage -ErrorAction Stop
                    Get-AppxProvisionedPackage -Online | 
                        Where-Object {$_.DisplayName -eq $AppToRemove} | 
                        Remove-AppxProvisionedPackage -Online -ErrorAction Stop
                    
                    Write-Host "Successfully removed: $AppToRemove" -ForegroundColor Green
                    $SuccessfullyRemoved += $AppToRemove
                }
                catch {
                    Write-Host "Failed to remove: $AppToRemove" -ForegroundColor Red
                    Write-Host "Error: $_" -ForegroundColor Red
                    $FailedToRemove += $AppToRemove
                }
            }
        } else {
            $NotFoundApps += $AppToRemove
        }
    }

    Write-Host "`n=== Apps Not Found on System ===`n" -ForegroundColor Cyan
    foreach ($App in $NotFoundApps) {
        Write-Host "Not found: $App" -ForegroundColor Gray
    }

    Write-Host "`n=== Summary ===" -ForegroundColor Yellow
    Write-Host "Found apps: $($FoundApps.Count)" -ForegroundColor Blue
    if (!$SimulateOnly) {
        Write-Host "Successfully removed: $($SuccessfullyRemoved.Count)" -ForegroundColor Green
        Write-Host "Failed to remove: $($FailedToRemove.Count)" -ForegroundColor Red
    }
    Write-Host "Not found apps: $($NotFoundApps.Count)" -ForegroundColor Cyan

    if (!$SimulateOnly -and $FailedToRemove.Count -gt 0) {
        Write-Host "`nApps that failed to remove:" -ForegroundColor Red
        $FailedToRemove | ForEach-Object { Write-Host $_ -ForegroundColor Red }
    }

    Write-Host "`nOperation completed.`n" -ForegroundColor Yellow
}

# Main menu
Function Show-Menu {
    do {
        Write-Host "`n=== Options ===" -ForegroundColor Yellow
        Write-Host "1: Simulate App Removal (Test Run)" -ForegroundColor Green
        Write-Host "2: Remove Bloatware Apps" -ForegroundColor Red
        Write-Host "Q: Quit" -ForegroundColor Cyan
        
        $choice = Read-Host "`nEnter your choice"
        
        Switch ($choice) {
            "1" { Process-BloatwareApps -SimulateOnly $true }
            "2" { 
                $confirm = Read-Host "Are you sure you want to remove these apps? (Y/N)"
                if ($confirm -eq 'Y' -or $confirm -eq 'y') {
                    Process-BloatwareApps -SimulateOnly $false
                }
            }
            "Q" { return }
            "q" { return }
            Default { Write-Host "Invalid choice" -ForegroundColor Red }
        }
    } while ($true)
}

# Run the menu
Show-Menu

# Keep console open at the end
Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
