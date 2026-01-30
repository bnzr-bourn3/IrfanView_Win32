$ErrorActionPreference = "Stop"

$logDir = "C:\ProgramData\IrfanView"
New-Item -ItemType Directory -Path $logDir -Force | Out-Null
Start-Transcript -Path (Join-Path $logDir "uninstall.log") -Force

$uninstaller = "C:\Program Files\IrfanView\iv_uninstall.exe"

if (-not (Test-Path $uninstaller)) {
    Write-Output "Uninstaller not found at $uninstaller. Trying fallback paths..."

    $uninstaller = @(
        "$env:ProgramFiles\IrfanView\iv_uninstall.exe",
        "$env:ProgramFiles(x86)\IrfanView\iv_uninstall.exe"
    ) | Where-Object { Test-Path $_ } | Select-Object -First 1
}

if (-not $uninstaller) {
    Write-Output "IrfanView uninstaller not found. Nothing to uninstall."
    Stop-Transcript
    exit 0
}

Write-Output "Running IrfanView uninstaller: $uninstaller"
$proc = Start-Process -FilePath $uninstaller -ArgumentList "/silent" -Wait -PassThru
if ($proc.ExitCode -ne 0) { throw "Uninstall failed. ExitCode=$($proc.ExitCode)" }

# Remove shortcuts we created (if you added them)
$publicDesktop = "$env:Public\Desktop\IrfanView.lnk"
$startMenu = Join-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs" "IrfanView.lnk"
Remove-Item $publicDesktop -Force -ErrorAction SilentlyContinue
Remove-Item $startMenu -Force -ErrorAction SilentlyContinue

# Optional: remove registry detection marker (if you add one)
Remove-ItemProperty -Path "HKLM:\Software\DIPF\Apps" -Name "IrfanView" -ErrorAction SilentlyContinue

Write-Output "Uninstall completed successfully."
Stop-Transcript
exit 0
