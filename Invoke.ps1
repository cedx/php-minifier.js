#!/usr/bin/env pwsh
param (
	[Parameter(Position = 0)]
	[ArgumentCompleter({
		param ($commandName, $parameterName, $wordToComplete)
		(Get-Item "$PSScriptRoot/tool/$wordToComplete*.ps1").BaseName
	})]
	[string] $Command = "Default"
)

$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Set-StrictMode -Version Latest
& "$PSScriptRoot/tool/$Command.ps1"
