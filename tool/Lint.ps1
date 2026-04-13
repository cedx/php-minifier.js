Import-Module PSScriptAnalyzer

"Performing the static analysis of source code..."
Invoke-ScriptAnalyzer $PSScriptRoot -ExcludeRule PSAvoidUsingPositionalParameters -Recurse
npx tsc --build src/tsconfig.json --noEmit
npx eslint --cache --cache-location var --config etc/ESLint.js src test
