# ============================================================
# NEMESIS — ENCRYPTION ENGINE (AES-256)
# ============================================================

Add-Type -AssemblyName System.Security

function Encrypt-NemesisData {
    param($data, $key = "voss_nemesis_secret")
    $sha = [System.Security.Cryptography.SHA256]::Create()
    $keyBytes = $sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($key))
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $keyBytes
    $aes.GenerateIV()
    $encryptor = $aes.CreateEncryptor()
    $ms = New-Object System.IO.MemoryStream
    $ms.Write($aes.IV, 0, $aes.IV.Length)
    $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $encryptor, [System.Security.Cryptography.CryptoStreamMode]::Write)
    $sw = New-Object System.IO.StreamWriter($cs)
    $sw.Write($data)
    $sw.Close()
    $cs.Close()
    return [Convert]::ToBase64String($ms.ToArray())
}

function Decrypt-NemesisData {
    param($cipherText, $key = "voss_nemesis_secret")
    $fullCipher = [Convert]::FromBase64String($cipherText)
    $iv = $fullCipher[0..15]
    $cipherBytes = $fullCipher[16..($fullCipher.Length-1)]
    $sha = [System.Security.Cryptography.SHA256]::Create()
    $keyBytes = $sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($key))
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $keyBytes
    $aes.IV = $iv
    $decryptor = $aes.CreateDecryptor()
    $ms = New-Object System.IO.MemoryStream($cipherBytes)
    $cs = New-Object System.Security.Cryptography.CryptoStream($ms, $decryptor, [System.Security.Cryptography.CryptoStreamMode]::Read)
    $sr = New-Object System.IO.StreamReader($cs)
    return $sr.ReadToEnd()
}
