"Updating the dependencies..."
(Import-PowerShellDataFile PSModules.psd1).Keys | ForEach-Object { Update-PSResource $_ -TrustRepository }
npm update
