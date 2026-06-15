# Local Chrome debug with writable profile (avoids Windows Temp permission errors).
$AppRoot = Split-Path -Parent $PSScriptRoot
$ChromeProfile = Join-Path $AppRoot ".chrome-dev"
$FlutterTmp = Join-Path $AppRoot ".flutter-tmp"

New-Item -ItemType Directory -Force -Path $ChromeProfile | Out-Null
New-Item -ItemType Directory -Force -Path $FlutterTmp | Out-Null

$env:TMP = $FlutterTmp
$env:TEMP = $FlutterTmp

Set-Location $AppRoot
flutter run -d chrome `
  --web-browser-flag "--user-data-dir=$ChromeProfile" `
  --web-browser-flag "--no-first-run"