. $PSScriptRoot/Default.ps1

Write-Host "Publishing the package..."
$version = (Get-Content "package.json" | ConvertFrom-Json).version
git tag "v$version"
git push origin "v$version"
npm publish --registry=https://registry.npmjs.org
npm publish --registry=https://npm.pkg.github.com
