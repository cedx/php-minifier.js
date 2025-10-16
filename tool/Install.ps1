"Installing the dependencies..."
if (-not (Get-InstalledPSResource PSScriptAnalyzer)) { Install-PSResource PSScriptAnalyzer }
npm install
