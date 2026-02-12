& "$PSScriptRoot/Default.ps1"

"Publishing the package..."
$version = Get-Content package.json | ConvertFrom-Json | Select-Object -ExpandProperty version
git tag "v$version"
git push origin "v$version"
npm login
npm publish
