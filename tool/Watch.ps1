using module ./Cmdlets.psm1

"Watching for file changes..."
Invoke-TypeScript "$PSScriptRoot/../src/tsconfig.json" -SourceMap -Watch
