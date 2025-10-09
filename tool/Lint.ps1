Write-Output "Performing the static analysis of source code..."
Invoke-ScriptAnalyzer $PSScriptRoot -ExcludeRule PSAvoidUsingPositionalParameters -Recurse
npx tsc --build tsconfig.json --noEmit
npx eslint --cache --cache-location=var --config=etc/ESLint.js bin example src test
