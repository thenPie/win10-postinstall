$appxs = Get-Content -Path '.\to_delete_appxs.txt'

ForEach ($appx in $appxs) {
    Get-AppxPackage $appx | Remove-AppxPackage
}