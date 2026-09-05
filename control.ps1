# ============================================================
# NEMESIS — LIVING FIELD INTERFACE
# ============================================================
# Jarvis Interaction. Ultron Execution. Self-Evolving.
# ============================================================

. .\mycelium\core.ps1
. .\aether\core.ps1
. .\veritas\core.ps1
. .\kronos\core.ps1
. .\chronos\core.ps1
. .\oneway\core.ps1

$config = Get-Content "config.json" | ConvertFrom-Json
$webhook = $config.c2.primary

Write-Host "🟢 Nemesis Online." -ForegroundColor Cyan
Write-Host "Commands: help, status, deploy, run, exit" -ForegroundColor Gray

function Show-Help {
    Write-Host "`nAvailable Commands:" -ForegroundColor Yellow
    Write-Host "  help              - Show this help menu" -ForegroundColor Gray
    Write-Host "  status            - Show system status" -ForegroundColor Gray
    Write-Host "  deploy <component>- Deploy a specific component (e.g., deploy aether)" -ForegroundColor Gray
    Write-Host "  run <target>      - Run a full operation against a target" -ForegroundColor Gray
    Write-Host "  exit              - Shut down Nemesis" -ForegroundColor Gray
}

while ($true) {
    $input = Read-Host "`n> "
    
    switch -Wildcard ($input) {
        "exit" {
            Write-Host "🟢 Nemesis: Shutting down." -ForegroundColor Red
            break
        }
        "help" {
            Show-Help
        }
        "status" {
            Write-Host "`n🟢 Nemesis: All systems operational." -ForegroundColor Green
            Write-Host "  Mycelium  : [🟢] Active" -ForegroundColor Gray
            Write-Host "  Aether    : [🟢] Active" -ForegroundColor Gray
            Write-Host "  Veritas   : [🟢] Active" -ForegroundColor Gray
            Write-Host "  Kronos    : [🟢] Active" -ForegroundColor Gray
            Write-Host "  Chronos   : [🟢] Active" -ForegroundColor Gray
            Write-Host "  OneWay    : [🟢] Active" -ForegroundColor Gray
            Write-Host "  Aegis     : [🟢] Active" -ForegroundColor Gray
            Write-Host "  C2        : [🟢] Connected to Discord" -ForegroundColor Gray
            Write-Host "  Targets   : [🟡] 0 active" -ForegroundColor Gray
        }
        "deploy aether" {
            Write-Host "🟢 Nemesis: Deploying Aether..." -ForegroundColor Magenta
            & ".\aether\deploy.ps1"
        }
        "deploy veritas" {
            Write-Host "🟢 Nemesis: Deploying Veritas..." -ForegroundColor Magenta
            & ".\veritas\deploy.ps1"
        }
        "run *" {
            $target = $input -replace "run ",""
            Write-Host "🟢 Nemesis: Initiating full operation on $target..." -ForegroundColor Cyan
            Invoke-Mycelium -target $target
            Invoke-Aether -target $target
            Invoke-Veritas -target $target
            Invoke-Kronos -target $target
            Invoke-Chronos -target $target
            Invoke-OneWay -target $target
            Write-Host "🟢 Nemesis: Operation on $target complete." -ForegroundColor Green
        }
        default {
            Write-Host "🟢 Nemesis: Command not recognised. Type 'help' for a list of commands." -ForegroundColor Red
        }
    }
}
