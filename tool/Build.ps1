using module ./Cmdlets.psm1

"Building the project..."
Invoke-TypeScript "$PSScriptRoot/../src/tsconfig.json"
