"Updating the dependencies..."
(Import-PowerShellDataFile PSModules.psd1).Keys | Update-PSResource -TrustRepository
npm update
