using module ./Cmdlets.psm1
& "$PSScriptRoot/Default.ps1"

"Publishing the package..."
$version = (Get-Content package.json | ConvertFrom-Json).version
New-GitTag "v$version"
Publish-NpmPackage
