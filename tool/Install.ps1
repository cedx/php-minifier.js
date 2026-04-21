using module ./Cmdlets.psm1

"Installing the dependencies..."
Install-PSResource -RequiredResourceFile PSModules.psd1 -TrustRepository -WarningAction Ignore
Install-NpmPackage
