# main.ps1
# Tämä on pääohjelma, joka käynnistää koko ylläpitotyökalun

# ==========================================
# 1) Tarvittavien skriptien lataaminen
# ==========================================
. .\yhteinen.ps1       # Funktiot Loki(), Raportti(), Puhdistus()
. .\levytila.ps1       # Levytilan tarkistus
. .\varmuuskopio.ps1   # Varmuuskopiointi

# ==========================================
# 2) Alkuviestit
# ==========================================
Write-Host "=== Yllapitotyokalu kaynnistyy ===" -ForegroundColor Cyan
Loki "=== Skripti kaynnistyi ==="

# ==========================================
# 3) Levytilan tarkistus
# ==========================================
Write-Host "Tarkistetaan levytila..." -ForegroundColor Yellow
Levytila

# ==========================================
# 4) Kysy käyttäjältä varmuuskopioitava kansio
# ==========================================
if ($Host.Name -eq "ConsoleHost") {
    $kansio = Read-Host "Anna varmuuskopioitava kansio (Enter = testikansio)"
}
if (-not $kansio) {
    $kansio = "testikansio"
    Write-Host "Käytetään oletuskansiota: $kansio"
    Loki "Ajastettu ajo tai tyhjä syöte → käytettiin oletuskansiota"
}

# ==========================================
# 5) Varmuuskopiointi
# ==========================================
Write-Host "Aloitetaan varmuuskopiointi..." -ForegroundColor Yellow
Varmuuskopio $kansio

# ==========================================
# 6) TEMP-kansion puhdistus
# ==========================================
Write-Host "Suoritetaan TEMP-kansion puhdistus..." -ForegroundColor Yellow
Puhdistus

# ==========================================
# 7) Lopetusviestit
# ==========================================
Write-Host "=== Yllapitotyokalu valmis ===" -ForegroundColor Cyan
Loki "=== Skripti valmis ==="

