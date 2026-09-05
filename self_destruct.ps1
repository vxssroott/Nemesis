# ============================================================
# NEMESIS — SELF-DESTRUCT
# ============================================================

function Invoke-NemesisSelfDestruct {
    Write-Host "🟢 Nemesis: Self-destruct initiated." -ForegroundColor Red

    # Remove persistence
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
    Remove-ItemProperty -Path $regPath -Name "Nemesis" -Force -ErrorAction SilentlyContinue

    $taskName = "NemesisUpdate"
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue

    # Delete all Nemesis files
    $nemesisPath = "C:\Users\user\Desktop\Nemesis"
    Remove-Item -Path $nemesisPath -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host "🟢 Nemesis: Removed." -ForegroundColor Red
}
