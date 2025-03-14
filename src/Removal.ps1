$appxs = [System.Collections.Generic.List[string]]::new()

$appxs.Add("Microsoft.549981C3F5F10*")
$appxs.Add("Microsoft.WindowsCamera*")
$appxs.Add("Microsoft.WindowsAlarms*")
$appxs.Add("Microsoft.SkypeApp*")
$appxs.Add("Microsoft.ZuneVideo*")
$appxs.Add("Microsoft.ZuneMusic*")
$appxs.Add("Microsoft.YourPhone*")
$appxs.Add("Microsoft.WindowsSoundRecorder*")
$appxs.Add("Microsoft.WindowsMaps*")
$appxs.Add("Microsoft.WindowsFeedbackHub*")
$appxs.Add("Microsoft.Wallet*")
$appxs.Add("Microsoft.People*")
$appxs.Add("Microsoft.Office.OneNote*")
$appxs.Add("Microsoft.MixedReality.Portal*")
$appxs.Add("Microsoft.MicrosoftStickyNotes*")
$appxs.Add("Microsoft.MicrosoftSolitaireCollection*")
$appxs.Add("Microsoft.MicrosoftOfficeHub*")
$appxs.Add("Microsoft.Microsoft3DViewer*")
$appxs.Add("Microsoft.Getstarted*")
$appxs.Add("Microsoft.GetHelp*")
$appxs.Add("microsoft.windowscommunicationsapps*")
$appxs.Add("Microsoft.BingWeather*")

ForEach ($appx in $appxs) {
    Get-AppxPackage $appx | Remove-AppxPackage
}
