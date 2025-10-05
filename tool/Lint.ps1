Write-Host "Performing the static analysis of source code..."
npx tsc --build tsconfig.json --noEmit
npx eslint --cache --cache-location=var --config=etc/ESLint.js example src test
