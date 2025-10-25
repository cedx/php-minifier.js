"Installing the dependencies..."
Install-PSResource -RequiredResourceFile PSModules.psd1 -TrustRepository -WarningAction SilentlyContinue
npm install
