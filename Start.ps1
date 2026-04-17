#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

$package = Get-Content "$PSScriptRoot/package.json" | ConvertFrom-Json
node $package.bin.PhpMinifier @args
