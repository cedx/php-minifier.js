"Deleting all generated files..."
Remove-Item lib, obj -ErrorAction Ignore -Force -Recurse
Remove-Item var/* -Exclude .gitkeep -Force -Recurse
