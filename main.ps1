<#
.SYNOPSIS
Ammattimainen ylläpitotyökalu.

.DESCRIPTION
Tämä skripti suorittaa ylläpitotehtävät:
1) Tarkistaa C-aseman levytilan
2) Tekee varmuuskopion käyttäjän määrittämästä kansiosta
3) Puhdistaa TEMP-kansion
4) Kirjaa kaikki vaiheet lokiin ja raporttiin
Skripti on parametrisoitu ja vikasietoinen, sisältää admin-tarkistuksen.

.PARAMETER VarmuuskopioKansio
Kansio, joka halutaan varmuuskopioida. Jos parametriä ei anneta, käytetään oletuskansiota "testikansio".

.NOTES
Tekijä: Aaron S23ÄTIV
#>

# ==========================================
# Parametri: Varmuuskopioitava kansio
# ==========================================
param(
    [string]$VarmuuskopioKansio
)
# param-lohko mahdollistaa sen, että skriptiin voidaan syöttää argumentteja komentoriviltä.
# Esim: .\main.ps1 -VarmuuskopioKansio "C:\testi"

# ==========================================
# 1) Admin-tarkistus
# ==========================================
# Tämä tarkistus varmistaa, että skripti suoritetaan järjestelmänvalvojana
# Tarvitaan, koska TEMP-kansion puhdistus ja jotkin tiedostot voivat vaatia admin-oikeuksia
$admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

if (-not $admin) {
    # Jos käyttäjä ei ole admin, tulostetaan varoitus ruudulle ja kirjataan lokiin
    Write-Host "HUOM! Suorita skripti järjestelmänvalvojana (Admin)." -ForegroundColor Red
    Loki "Skripti ei suoritettu adminina!"
    exit 1  # Lopetetaan skripti turvallisesti
}

# ==========================================
# 2) Dot-source moduulit (lataa funktiot)
# ==========================================
# Dot-source tarkoittaa: suoritetaan toisen tiedoston skripti nykyisessä istunnossa
# Näin pääskripti voi käyttää moduulin funktioita, esim. Levytila(), Varmuuskopio(), Puhdistus(), Loki()
. .\yhteinen.ps1       # Sisältää Loki() ja Raportti() funktiot
. .\levytila.ps1       # Levytilan tarkistus
. .\varmuuskopio.ps1   # Varmuuskopiointi
. .\puhdistus.ps1      # TEMP-kansion puhdistus

# ==========================================
# 3) Alkuviestit
# ==========================================
Write-Host "=== Yllapitotyokalu kaynnistyy ===" -ForegroundColor Cyan
# Write-Host tulostaa tekstin ruudulle, ForegroundColor tekee siitä värillisen
Loki "=== Skripti kaynnistyi ==="
# Loki kirjoittaa aikaleiman ja viestin lokitiedostoon log.txt

# ==========================================
# 4) Levytilan tarkistus
# ==========================================
Write-Host "Tarkistetaan levytila..." -ForegroundColor Yellow
try {
    # Kutsutaan levytilan tarkistuksen funktiota
    Levytila
} catch {
    # Jos Levytila-funktio epäonnistuu, kirjataan virhe lokiin
    Loki "Virhe levytilan tarkistuksessa: $_"
    # $_ sisältää virheilmoituksen
}

# ==========================================
# 5) Varmuuskopioitavan kansion tarkistus / oletus
# ==========================================
if (-not $VarmuuskopioKansio) {
    # Jos käyttäjä ei anna parametria, käytetään oletuskansiota "testikansio"
    $VarmuuskopioKansio = "testikansio"
    Write-Host "Käytetään oletuskansiota: $VarmuuskopioKansio"
    Loki "Käytettiin oletuskansiota"
}

# ==========================================
# 6) Varmuuskopiointi
# ==========================================
Write-Host "Aloitetaan varmuuskopiointi..." -ForegroundColor Yellow
try {
    # Kutsutaan Varmuuskopio-funktiota parametrilla
    Varmuuskopio $VarmuuskopioKansio
} catch {
    # Jos varmuuskopiointi epäonnistuu, lokiin kirjataan virhe
    Loki "Virhe varmuuskopioinnissa: $_"
}

# ==========================================
# 7) TEMP-kansion puhdistus
# ==========================================
Write-Host "Suoritetaan TEMP-kansion puhdistus..." -ForegroundColor Yellow
try {
    # Kutsutaan Puhdistus-funktiota
    Puhdistus
} catch {
    # Jos puhdistus epäonnistuu, kirjataan lokiin
    Loki "Virhe TEMP-kansion puhdistuksessa: $_"
}

# ==========================================
# 8) Lopetusviestit
# ==========================================
Write-Host "=== Yllapitotyokalu valmis ===" -ForegroundColor Cyan
Loki "=== Skripti valmis ==="
# Tämä lopetusviesti merkitsee, että kaikki vaiheet on suoritettu onnistuneesti
