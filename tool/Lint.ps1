using module PSScriptAnalyzer
using module ./Cmdlets.psm1

"Performing the static analysis of source code..."
Invoke-ScriptAnalyzer $PSScriptRoot -ExcludeRule PSUseShouldProcessForStateChangingFunctions -Recurse
Invoke-TypeScript src/tsconfig.json -NoEmit
Invoke-ESLint src, test -Configuration etc/ESLint.js
