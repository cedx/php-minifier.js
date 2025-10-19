#!/usr/bin/env pwsh
param ([Parameter(Position = 0)] [string] $Command = "Default")
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
. $PSScriptRoot/tool/$Command.ps1
