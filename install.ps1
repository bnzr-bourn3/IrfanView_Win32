$ErrorActionPreference = "Stop"

$base = Split-Path -Parent $MyInvocation.MyCommand.Path

$ivExe = Join-Path $base "iview473g_x64_setup.exe"
$plExe = Join-Path $base "iview473_plugins_x64_setup.exe"

# Logging
$logDir = "C:\ProgramData\IrfanView"
New-Item -ItemType Directory -Path $logDir -Force | Out-Null
Start-Transcript -Path (Join-Path $logDir "install.log") -Force

if (-not (Test-Path $ivExe)) { throw "Missing IrfanView installer in package: $ivExe" }

Write-Output "Installing IrfanView..."
$proc = Start-Process -FilePath $ivExe -ArgumentList "/silent /allusers" -Wait -PassThru
if ($proc.ExitCode -ne 0) { throw "IrfanView installer failed. ExitCode=$($proc.ExitCode)" }

if (Test-Path $plExe) {
    Write-Output "Installing IrfanView Plugins..."
    $proc2 = Start-Process -FilePath $plExe -ArgumentList "/silent /allusers" -Wait -PassThru
    if ($proc2.ExitCode -ne 0) { throw "Plugins installer failed. ExitCode=$($proc2.ExitCode)" }
}
# Create shortcuts (Desktop + Start Menu)

$exePath = "C:\Program Files\IrfanView\i_view64.exe"
if (-not (Test-Path $exePath)) {
    throw "IrfanView executable not found at expected path"
}

$wsh = New-Object -ComObject WScript.Shell

# Desktop shortcut (All Users)
$desktop = "$env:Public\Desktop\IrfanView.lnk"
$sc = $wsh.CreateShortcut($desktop)
$sc.TargetPath = $exePath
$sc.WorkingDirectory = "C:\Program Files\IrfanView"
$sc.IconLocation = "$exePath,0"
$sc.Save()

# Start Menu shortcut (All Users)
$startMenuDir = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
$startMenu = Join-Path $startMenuDir "IrfanView.lnk"
$sc2 = $wsh.CreateShortcut($startMenu)
$sc2.TargetPath = $exePath
$sc2.WorkingDirectory = "C:\Program Files\IrfanView"
$sc2.IconLocation = "$exePath,0"
$sc2.Save()


Write-Output "Install completed successfully."
Stop-Transcript
exit 0
