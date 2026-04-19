#!/usr/bin/env pwsh
param (
	# The name of the task to invoke.
	[Parameter(Position = 0)]
	[ArgumentCompleter({
		param ([string] $commandName, [string] $parameterName, [string] $wordToComplete)
		(Get-Item "$PSScriptRoot/tool/$wordToComplete*.ps1").BaseName
	})]
	[ValidateScript({ Test-Path "$PSScriptRoot/tool/$_.ps1" -PathType Leaf }, ErrorMessage = "The specified command does not exist.")]
	[string] $Command = "Default"
)

$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
& "$PSScriptRoot/tool/$Command.ps1"
