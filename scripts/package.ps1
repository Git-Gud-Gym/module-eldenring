# Packages bin\eldenring\ into dist\: the files the launcher downloads, plus a zip for manual installs.
#   ./scripts/package.ps1 [-Version x.y.z]   (CI passes the tag's version; it must match module.json)
param([string]$Version)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$manifest = Get-Content "$root\module.json" -Raw | ConvertFrom-Json
if ($Version -and $Version -ne $manifest.version) {
    throw "Tag version $Version doesn't match module.json version $($manifest.version). Bump it before tagging."
}
$built = Join-Path $root "bin\$($manifest.id)"
$dist = Join-Path $root 'dist'
Remove-Item -Recurse -Force $dist -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force "$dist\stage\$($manifest.id)" | Out-Null
foreach ($file in $manifest.files) {
    Copy-Item (Join-Path $built $file) $dist
    Copy-Item (Join-Path $built $file) "$dist\stage\$($manifest.id)"
}
$name = ($manifest.name -replace '[^A-Za-z0-9]', '')
Compress-Archive -Path "$dist\stage\$($manifest.id)" -DestinationPath "$dist\GitGudGym-$name-module-v$($manifest.version).zip"
Remove-Item -Recurse -Force "$dist\stage"
Write-Host "Packaged $($manifest.name) module $($manifest.version)"
