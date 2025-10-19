"Performing the static analysis of source code..."
Import-Module PSScriptAnalyzer
Invoke-ScriptAnalyzer $PSScriptRoot -Recurse
npx tsc --build tsconfig.json --noEmit
npx eslint --cache --cache-location var --config etc/ESLint.js bin example src test
