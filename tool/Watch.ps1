Write-Output "Watching for file changes..."
npx tsc --build src/tsconfig.json --preserveWatchOutput --sourceMap --watch
