#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Set-StrictMode -Version Latest

$package = Get-Content "$PSScriptRoot/package.json" | ConvertFrom-Json
node $package.bin.PhpMinifier @args
