$appxs = Get-Content -Path '.\to_delete_appxs.txt'

ForEach ($appx in $appxs) {
    Get-AppxPackage $appx | Remove-AppxPackage
}

$provisioned_appxs = Get-Content -Path '.\provisioned_appxs_to_stop.txt'

ForEach ($provisioned_appx in $provisioned_appxs) {
    Remove-AppxProvisionedPackage -Online -PackageName $provisioned_appx
}
