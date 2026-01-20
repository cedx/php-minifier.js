"Updating the dependencies..."
Import-PowerShellDataFile PSModules.psd1 | Select-Object -ExpandProperty Keys | ForEach-Object { Update-PSResource $_ -TrustRepository }
npm update
