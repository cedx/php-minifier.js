using module ./Cmdlets.psm1

"Running the test suite..."
Invoke-TypeScript "$PSScriptRoot/../src/tsconfig.json" -SourceMap
Invoke-NodeTest
