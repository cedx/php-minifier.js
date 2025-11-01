#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Set-StrictMode -Version Latest

$commandPath = Get-Item $PSCommandPath
$scriptRoot = $commandPath.LinkType ? (Split-Path $commandPath.LinkTarget) : $PSScriptRoot
node $scriptRoot/bin/PhpMinifier.js @args
