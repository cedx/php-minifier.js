#!/usr/bin/env pwsh
param (
	[Parameter(Position = 0)]
	[ArgumentCompleter({
		param ($commandName, $parameterName, $wordToComplete)
		(Get-Item "$PSScriptRoot/tool/$wordToComplete*.ps1").BaseName
	})]
	[string] $Command = "Default",

	[Parameter()]
	[switch] $Release
)

begin {
	$ErrorActionPreference = "Stop"
	$PSNativeCommandUseErrorActionPreference = $true
	Set-StrictMode -Version Latest
}

end {
	. $PSScriptRoot/tool/$Command.ps1
}
