Write-Output "Running the test suite..."
npx tsc --build src/tsconfig.json --sourceMap
node --enable-source-maps --test
