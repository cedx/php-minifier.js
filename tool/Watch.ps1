using module ./Cmdlets.psm1

"Watching for file changes..."
Invoke-TypeScript src/tsconfig.json -SourceMap -Watch
