"Deleting all generated files..."
Remove-Item "lib" -ErrorAction Ignore -Force -Recurse
Remove-Item "var/*" -Exclude ".gitkeep" -Force -Recurse
