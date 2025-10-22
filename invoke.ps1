#!/usr/bin/env pwsh
param (
	[Parameter(Position = 0)]
	[ArgumentCompleter({
		param ($commandName, $parameterName, $wordToComplete)
		(Get-Item "$PSScriptRoot/tool/$wordToComplete*.ps1").BaseName
	})]
	[string] $Command = "Default"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
. $PSScriptRoot/tool/$Command.ps1
