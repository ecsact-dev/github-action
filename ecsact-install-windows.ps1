#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

$InstallDir = "$Home\.ecsact"
$BinDirectory = "$Home\.ecsact\bin"

if (!(Test-Path $InstallDir))
{
	New-Item $InstallDir -ItemType Directory | Out-Null
}

$EcsactLatestRelease =  gh -R ecsact-dev/ecsact_sdk release view --json tagName --jq .tagName

$EcsactReleaseZip = "ecsact_sdk_${EcsactLatestRelease}_windows_x64.zip"

Write-Output "Latest Release: $EcsactLatestRelease"

gh -R ecsact-dev/ecsact_sdk release download -p $EcsactReleaseZip

Expand-Archive -Path $ecsactReleaseZip -DestinationPath $InstallDir

$User = [EnvironmentVariableTarget]::User
$Path = [Environment]::GetEnvironmentVariable('Path', $User)
if (!(";$Path;".ToLower() -like "*;$BinDirectory;*".ToLower()))
{
	Write-Output "Adding bin directory ($BinDirectory) to Environment path..."
	[Environment]::SetEnvironmentVariable('Path', "$Path;$BinDirectory", $User)
	$Env:Path += ";$BinDirectory"
}

