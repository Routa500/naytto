# main.ps1
# Tämä on pääohjelma, joka käynnistää koko ylläpitotyökalun

# ==========================================
# 1) Tarvittavien skriptien lataaminen
# ==========================================
# . (dot-sourcing) tuo toisen PowerShell-skriptin sisällön nykyiseen skriptiin,
# jotta sen funktiot ja muuttujat ovat käytettävissä
. .\levytila.ps1       # Skripti levytilan tarkistukseen
. .\varmuuskopio.ps1   # Skripti varmuuskopiointiin

# ==========================================
# 2) Alkuviestit
# ==========================================
# Write-Host tulostaa viestin PowerShell-ikkunaan (vain visuaalista)
Write-Host "=== Yllapitotyokalu kaynnistyy ===" -ForegroundColor Cyan

# Loki() on oma funktio, joka kirjoittaa lokiin
Loki "=== Skripti kaynnistyi ==="

# ==========================================
# 3) Levytilan tarkistus
# ==========================================
Write-Host "Tarkistetaan levytila..." -ForegroundColor Yellow
# Levytila() on funktio levytilan tarkistamiseen levytila.ps1:stä
Levytila

# ==========================================
# 4) Kysy käyttäjältä varmuuskopioitava kansio
# ==========================================
# Tarkistetaan, onko skripti ajettu interaktiivisesti vai ajastettuna
if ($Host.Name -eq "ConsoleHost") {
    # ConsoleHost tarkoittaa PowerShell-konsolia → manuaalinen ajo
    # Read-Host pysäyttää skriptin ja odottaa käyttäjän syötettä
    $kansio = Read-Host "Anna varmuuskopioitava kansio (Enter = testikansio)"
}

# Jos kansiota ei annettu (tyhjä syöte) tai skripti ajettiin ajastettuna
if (-not $kansio) {
    # Käytetään oletuskansiota
    $kansio = "testikansio"
    Write-Host "Käytetään oletuskansiota: $kansio"
    Loki "Ajastettu ajo tai tyhjä syöte → käytettiin oletuskansiota"
}

# HUOM! Tämä on varmistus, ettei $kansio ole tyhjä (turvatoimi)
if (!$kansio) {
    # ! = EI, jos $kansio on tyhjä
    $kansio = "testikansio"
    Loki "Kaytettiin oletuskansiota testikansio"
}

# ==========================================
# 5) Varmuuskopiointi
# ==========================================
Write-Host "Aloitetaan varmuuskopiointi..." -ForegroundColor Yellow
# Varmuuskopio() ottaa parametrina kansion ja tekee varmuuskopion
Varmuuskopio $kansio

# ==========================================
# 6) Lopetusviestit
# ==========================================
Write-Host "=== Yllapitotyokalu valmis ===" -ForegroundColor Cyan
Loki "=== Skripti valmis ==="
