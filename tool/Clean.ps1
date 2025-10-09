Write-Output "Deleting all generated files..."
if (Test-Path "lib") { Remove-Item "lib" -Force -Recurse }
Remove-Item "var/*" -Exclude ".gitkeep" -Force -Recurse
