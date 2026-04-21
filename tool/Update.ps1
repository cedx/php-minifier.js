using module ./Cmdlets.psm1

"Updating the dependencies..."
(Import-PowerShellDataFile PSModules.psd1).Keys | Update-PSResource -TrustRepository
Update-NpmPackage
