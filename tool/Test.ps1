using module ./Cmdlets.psm1

"Running the test suite..."
Invoke-TypeScript src/tsconfig.json -SourceMap
Invoke-NodeTest
