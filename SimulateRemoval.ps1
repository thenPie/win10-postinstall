# Apps we specifically want to remove
$AppsToRemove = @(
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

Write-Host "`n=== Apps Found and Would be Removed ===`n" -ForegroundColor Yellow

# Get all currently installed apps
$InstalledApps = Get-AppxPackage -AllUsers

# Track which apps were found and not found
$FoundApps = @()
$NotFoundApps = @()

foreach ($AppToRemove in $AppsToRemove) {
    $Found = $InstalledApps | Where-Object {$_.Name -eq $AppToRemove}
    if ($Found) {
        Write-Host "Would remove: $AppToRemove" -ForegroundColor Red
        $FoundApps += $AppToRemove
    } else {
        $NotFoundApps += $AppToRemove
    }
}

Write-Host "`n=== Apps Not Found on System ===`n" -ForegroundColor Cyan
foreach ($App in $NotFoundApps) {
    Write-Host "Not found: $App" -ForegroundColor Gray
}

Write-Host "`nSummary:" -ForegroundColor Yellow
Write-Host "Found apps: $($FoundApps.Count)" -ForegroundColor Red
Write-Host "Not found apps: $($NotFoundApps.Count)" -ForegroundColor Cyan
Write-Host "`nThis was just a test - no apps were actually removed.`n" -ForegroundColor Yellow
