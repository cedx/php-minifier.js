"Updating the dependencies..."
Import-PowerShellDataFile PSModules.psd1 | Select-Object -ExpandProperty Keys | Update-PSResource -TrustRepository
npm update
